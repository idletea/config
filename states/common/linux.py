import os
from pathlib import Path
from pyinfra.operations import files, pacman, systemd
from common.utils import recursive_relative_symlink


def sys_files():
    # psuedo-XDG support for user's bashrc
    bashrc_snippet = Path("static/linux/snippet-bash.bashrc").read_text().strip()
    files.block(
        name="XDG config for bashrc",
        path="/etc/bash.bashrc",
        content=bashrc_snippet,
        _sudo=True,
    )

    # psuedo-XDG support for miscellaneous apps
    files.put(
        name="XDG env profile",
        dest="/etc/profile.d/xdg.sh",
        src="static/linux/xdg.sh",
        user="root",
        group="root",
        mode=644,
        _sudo=True,
    )

    files.put(
        name="Pacman config file",
        dest="/etc/pacman.conf",
        src="static/linux/pacman.conf",
        user="root",
        group="root",
        mode=644,
        _sudo=True,
    )


def symlinks():
    recursive_relative_symlink(
        src="symlink/linux/",
        dest=str(Path.home()),
    )


def packages():
    packages = [
        # utilities
        "acpi",
        "bash-completion",
        "bind",
        "fzf",
        "git",
        "git-delta",
        "ipcalc",
        "just",
        "lsd",
        "man-db",
        "neovim",
        "openssh",
        "procs",
        "ripgrep",
        "unzip",
        "usage",
        # fonts
        "ttf-liberation",
        "otf-font-awesome",
        "noto-fonts",
        "noto-fonts-emoji",
        "noto-fonts-extra",
        "noto-fonts-cjk",
        "ttf-zed-mono-nerd",
        # bluetooth
        "bluez",
        "bluetui",
        # language tools
        "uv",
        "rustup",
    ]
    pacman.packages(
        name="Linux utilities",
        packages=packages,
        _sudo=True,
    )


def services():
    systemd.service(
        name="Bluetooth daemon",
        service="bluetooth.service",
        running=True,
        enabled=True,
        _sudo=True,
    )


def home_dir():
    for dir in ["downloads", "documents", "images", ".local/bin"]:
        files.directory(
            name=f"~/{dir} directory",
            path=str(Path.home() / dir),
        )
    for dir in ["Downloads"]:
        files.directory(
            name=f"Clean up {dir}",
            path=str(Path.home() / dir),
            present=False,
        )
    for file in [".bash_history", ".bash_logout", ".bash_profile", ".bashrc"]:
        files.file(
            name=f"Clean up {file}",
            path=str(Path.home() / file),
            present=False,
        )
    files.directory(
        name="GPG data directory",
        path=str(Path.home() / ".local/share/gnupg"),
        mode=700,
    )


def apply():
    sys_files()
    symlinks()
    packages()
    services()
    home_dir()
