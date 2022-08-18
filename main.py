import os
import shutil
import fire

DOT_FILES = [
    "~/.xinitrc",
    "~/.i3/config",
    "~/.config/i3status.toml",
    "~/.vimrc",
    "~/.config/nvim/init.vim",
    "~/.bashrc",
    "~/.zshrc",
    "~/.config/alacritty/alacritty.yml",
    "~/.config/kitty/kitty.conf",
    "~/.config/kitty/current-theme.conf",
]

def save(save_folder: str, dry_run: bool = True, is_backup: bool = False) -> None:
    """Searches for a dot files, and backs them up to the given directory."""

    for src in DOT_FILES:

        if src.startswith("~/"):
            src = src[2:]

        home = os.environ.get("HOME")
        full_src = os.path.join(home, src)
        if not os.path.exists(full_src):
            if not is_backup:
                print(f"DOT file not found at {full_src}")
            continue


        dst = os.path.join(
            save_folder,
            src,
        )

        if is_backup:
            print(f"DOT file found at {full_src}, backing up")

        if dry_run:
            print(f"[DRY RUN] Copying file from {full_src} -> {dst}")
        else:
            print(f"Copying file from {full_src} -> {dst}")
            containing_dir, _ = os.path.split(dst)
            os.makedirs(containing_dir, exist_ok=True)
            shutil.copyfile(full_src, dst)

def deploy(saved_folder: str, backup_folder: str, dry_run: bool = True) -> None:
    """Deploys dot files from the save folder. Backs up existing files to the backup folder"""

    if backup_folder:
        # before writing any files, we save any existing files as backup
        save(save_folder=backup_folder, dry_run=dry_run, is_backup=True)

    for src in DOT_FILES:
        if src.startswith("~/"):
            src = src[2:]
        full_src = os.path.join(saved_folder, src)
        home = os.environ.get("HOME")
        full_dst = os.path.join(home, src)

        if not os.path.exists(full_src):
            print(f"Saved dot file not found at {full_src}, skipping...")
            continue

        try:
            print(f"Copying file from {full_src} -> {full_dst}")
            if not dry_run:
                shutil.copy(full_src, full_dst)
        except Exception as exc:
            print(f"Failed to copy file from {full_src} -> {full_dst}")


if __name__ == "__main__":
    fire.Fire()

