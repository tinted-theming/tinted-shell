use anyhow::{Context, Result};
use clap::{Parser, Subcommand};
use std::env;
use std::fs::{self, File};
use std::io::Read;
use std::os::unix::fs as unix_fs;
use std::path::{Path, PathBuf};
use std::process::Command;

#[derive(Debug, Subcommand)]
enum Commands {
    List,
    Set { theme_name: String },
}

#[derive(Parser)]
struct Cli {
    #[clap(subcommand)]
    commands: Commands,
}

// Create a directory if it does not already exist
fn ensure_directory_exists<P: AsRef<Path>>(dir_path: P) -> Result<()> {
    let path = dir_path.as_ref();

    if !path.exists() {
        fs::create_dir_all(path)
            .with_context(|| format!("Failed to create directory at {:?}", path))?;
    }

    Ok(())
}

// Create a file if it does not already exist
fn ensure_file_exists<P: AsRef<Path>>(file_path: P) -> Result<()> {
    let path = file_path.as_ref();

    if !path.exists() {
        File::create(path).with_context(|| format!("Failed to create file at {:?}", path))?;
    };

    Ok(())
}

// Create config files if they don't already exist
fn ensure_config_files_exist(
    base16_config_path: &Path,
    base16_shell_theme_name_path: &Path,
) -> Result<()> {
    ensure_directory_exists(base16_config_path).with_context(|| {
        format!(
            "Failed to create config directory at {:?}",
            base16_config_path
        )
    })?;
    ensure_file_exists(base16_shell_theme_name_path).with_context(|| {
        format!(
            "Failed to create config file at {:?}",
            base16_shell_theme_name_path
        )
    })?;

    Ok(())
}

// Convert file contents to string
fn read_file_to_string(path: &Path) -> Result<String> {
    let mut file = File::open(path)?;
    let mut contents = String::new();

    file.read_to_string(&mut contents)?;

    Ok(contents)
}

fn set_colorscheme(
    theme_name: &String,
    base16_shell_path: &Path,
    base16_shell_colorscheme_path: &Path,
    base16_shell_theme_name_path: &Path,
) -> Result<()> {
    let theme_script_path = base16_shell_path.join(format!("scripts/base16-{}.sh", theme_name));
    if !theme_script_path.exists() {
        anyhow::bail!(
            "Theme \"{}\" does not exist, try a different theme",
            theme_name
        )
    }

    // Read value from file
    let current_theme_name =
        read_file_to_string(base16_shell_theme_name_path).context("Failed to read from file")?;

    if theme_name.as_str() == current_theme_name {
        anyhow::bail!("Theme \"{}\" is already set", theme_name)
    }

    // Remove symlink file and create colorscheme symlink
    if base16_shell_colorscheme_path.exists() {
        fs::remove_file(base16_shell_colorscheme_path)?;
    }

    unix_fs::symlink(theme_script_path, base16_shell_colorscheme_path)?;

    // Write theme name to file
    fs::write(base16_shell_theme_name_path, theme_name)?;

    // Source colorscheme script
    // Wait for script to fully execute before continuing
    let mut child = Command::new("/bin/bash")
        .arg(base16_shell_colorscheme_path)
        .spawn()
        .with_context(|| {
            format!(
                "Failed to execute script: {:?}",
                base16_shell_colorscheme_path
            )
        })?;
    let status = child.wait().context("Failed to wait on bash status")?;
    if !status.success() {
        anyhow::bail!("Command finished with a non-zero status: {}", status)
    }

    Ok(())
}

// Set env variables for hooks and then execute .sh hooks
fn run_hooks(
    base16_config_path: &Path,
    base16_shell_path: &Path,
    base16_shell_theme_name_path: &Path,
) -> Result<()> {
    let mut base16_shell_hooks_path =
        env::var("BASE16_SHELL_HOOKS_PATH").unwrap_or_else(|_| "".to_string());
    if base16_shell_hooks_path.is_empty() || !Path::new(&base16_shell_hooks_path).is_dir() {
        base16_shell_hooks_path = format!("{}/hooks", base16_shell_path.display());

        env::set_var("BASE16_SHELL_HOOKS_PATH", &base16_shell_hooks_path);
    }

    env::set_var("BASE16_SHELL_THEME_NAME_PATH", base16_shell_theme_name_path);
    env::set_var("BASE16_CONFIG_PATH", base16_config_path);

    let base16_shell_hooks_path = base16_shell_path.join("hooks");
    if base16_shell_hooks_path.is_dir() {
        for entry in fs::read_dir(base16_shell_hooks_path)? {
            let entry = entry?;
            let path = entry.path();

            // Check if the file name ends with .sh
            if path.extension().and_then(|ext| ext.to_str()) == Some("sh") {
                Command::new("/bin/bash")
                    .arg(&path)
                    .status()
                    .with_context(|| format!("Failed to execute shell hook script: {:?}", path))?;
            }
        }
    }

    Ok(())
}

fn set_command(
    theme_name: &String,
    base16_config_path: &Path,
    base16_shell_path: &Path,
    base16_shell_colorscheme_path: &Path,
    base16_shell_theme_name_path: &Path,
) -> Result<()> {
    set_colorscheme(
        theme_name,
        base16_shell_path,
        base16_shell_colorscheme_path,
        base16_shell_theme_name_path,
    )
    .with_context(|| format!("Failed to set colorscheme \"{:?}\"", theme_name))?;

    run_hooks(
        base16_config_path,
        base16_shell_path,
        base16_shell_theme_name_path,
    )
    .context("Failed to run hooks")?;

    Ok(())
}

fn main() -> Result<()> {
    let cli = Cli::parse();
    let config_path: PathBuf = env::var("XDG_CONFIG_HOME")
        .map(PathBuf::from)
        .or_else(|_| {
            env::var("HOME")
                .map_err(anyhow::Error::new)
                .and_then(|home| Ok(PathBuf::from(home).join(".config")))
                .context("HOME environment variable not set")
        })?;
    let config_path_something = config_path.as_path();
    let base16_config_path = config_path_something.join("tinted-theming");
    let base16_shell_path: PathBuf = env::current_dir().expect("Failed to get current directory");
    let base16_shell_colorscheme_path = base16_config_path.join("base16_shell_theme");
    let base16_shell_theme_name_path = base16_config_path.join("theme_name");

    ensure_config_files_exist(
        base16_config_path.as_path(),
        base16_shell_theme_name_path.as_path(),
    )
    .context("Error creating config files")?;

    match cli.commands {
        Commands::Set { theme_name } => {
            set_command(
                &theme_name,
                base16_config_path.as_path(),
                base16_shell_path.as_path(),
                base16_shell_colorscheme_path.as_path(),
                base16_shell_theme_name_path.as_path(),
            )
            .with_context(|| format!("Failed to set theme \"{:?}\"", theme_name,))?;

            println!("Theme set to: {}", theme_name);
        }
        Commands::List => {
            let scripts_path = base16_shell_path.join("scripts");

            if !scripts_path.is_dir() {
                anyhow::bail!(
                    "Scripts directory does not exist or is not a directory: {:?}",
                    scripts_path
                );
            }

            let themes: Vec<String> = fs::read_dir(&scripts_path)
                .with_context(|| format!("Failed to read directory: {:?}", &scripts_path))?
                .filter_map(|entry| {
                    let entry = entry.ok()?;
                    let path = entry.path();

                    if path.is_file() {
                        return path
                            .file_stem()
                            .and_then(|name| name.to_str())
                            .and_then(|name| name.strip_prefix("base16-"))
                            .map(|name| name.to_string());
                    }

                    None
                })
                .collect();

            if themes.is_empty() {
                println!("No themes found in the scripts directory.");
            } else {
                for theme in themes {
                    println!("{}", theme);
                }
            }
        }
    }

    Ok(())
}
