from pathlib import Path
from pyinfra.operations import files, pacman, systemd
import common


def desktop():
    pacman.packages(
        name="Desktop packages",
        packages=[
            # sway
            "sway",
            "swaybg",
            "swayidle",
            "swaylock",
            "xorg-xwayland",
            "xdg-desktop-portal-wlr",
            "wl-clipboard",
            "waybar",
            "brightnessctl",
            # audio
            "pipewire",
            "pipewire-pulse",
            "pavucontrol",
            # apps
            "fish",
            "kitty",
            "fuzzel",
            "blueberry",
            "swaync",
        ],
        _sudo=True,
    )


def apply():
    common.linux_and_macos.apply()
    common.linux.apply()

    desktop()


apply()
