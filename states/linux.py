import os
from pyinfra.operations import files, pacman, systemd
from states.utils import Machine, recursive_relative_symlink


XDG_BASHRC_LINE = " ".join(
    [
        """XDG_BASHRC="${HOME}/.config/bash/bashrc";""",
        """if [[ -f "${XDG_BASHRC}" ]];""",
        """then source "${XDG_BASHRC}"; fi""",
    ]
)


def sys_files():
    """System configuration (/etc/* edits)."""
    files.line(
        name="XDG config for bashrc",
        path="/etc/bash.bashrc",
        line="XDG_BASHRC.*",
        replace=XDG_BASHRC_LINE,
        ensure_newline=True,
        _sudo=True,
    )
    files.put(
        name="XDG env profile",
        dest="/etc/profile.d/xdg.sh",
        src="states/linux/sys-files/xdg.sh",
        user="root",
        group="root",
        mode=644,
        _sudo=True,
    )
    files.put(
        name="Pacman config file",
        dest="/etc/pacman.conf",
        src="states/linux/sys-files/pacman.conf",
        user="root",
        group="root",
        mode=644,
        _sudo=True,
    )


def packages(machine: Machine):
    packages = [
        # basic utilities
        "base-devel",
        "man-db",
        "openssh",
        "acpi",
        "bash-completion",
        "fish",
        "unzip",
        "usage",
        "brightnessctl",
        "bind",
        "neovim",
        "ripgrep",
        "jq",
        "fzf",
        "yq",
        "fd",
        "git",
        "git-delta",
        "procs",
        "podman",
        "ipcalc",
        "shellcheck",
        # fonts
        "ttf-liberation",
        "otf-font-awesome",
        "noto-fonts",
        "noto-fonts-emoji",
        "noto-fonts-extra",
        "noto-fonts-cjk",
        "ttf-iosevka-nerd",
        # audio
        "pipewire-pulse",
        "pavucontrol",
        # applications
        "firefox",
        "kitty",
        "kitty-terminfo",
        "wl-clipboard",
        # bluetooth
        "bluez",
        "bluez-utils",
        "blueberry",
    ]

    if machine == Machine.LORKHAN:
        packages.extend(
            [
                # sway / desktop
                "sway",
                "swaybg",
                "waybar",
                "xorg-xwayland",
                "wofi",
                "xdg-desktop-portal-wlr",
                "xdg-desktop-portal-gtk",
            ]
        )

    pacman.packages(
        name="Pacman packages",
        packages=packages,
        _sudo=True,
    )


def services():
    systemd.service(
        name="User ssh agent",
        service="ssh-agent.service",
        running=True,
        user_mode=True,
        enabled=True,
    )
    systemd.service(
        name="Bluetooth service",
        service="bluetooth.service",
        running=True,
        enabled=True,
        _sudo=True,
    )


def home_dir():
    for dir in ["downloads", "documents", "images", ".local/bin"]:
        files.directory(
            name=f"Home {dir} directory",
            path=f"{os.environ['HOME']}/{dir}",
        )
    for file in [".bash_history", ".bash_logout", ".bash_profile", ".bashrc"]:
        files.file(
            name=f"Clean up {file}",
            path=f"{os.environ['HOME']}/{file}",
            present=False,
        )
    files.directory(
        name="GPG data directory",
        path=f"{os.environ['HOME']}/.local/share/gnupg",
        mode=700,
    )


def sway():
    recursive_relative_symlink(
        src="states/linux-sway/home/",
        dest=f"{os.environ['HOME']}/",
    )


def apply(machine: Machine) -> None:
    sys_files()
    packages(machine)
    services()
    home_dir()
    recursive_relative_symlink(
        src="states/common/home/",
        dest=f"{os.environ['HOME']}/",
    )
    recursive_relative_symlink(
        src="states/linux/home/",
        dest=f"{os.environ['HOME']}/",
    )

    if machine == Machine.LORKHAN:
        recursive_relative_symlink(
            src="states/linux-sway/home/",
            dest=f"{os.environ['HOME']}/",
        )
