import os
from pyinfra.operations import brew
from states.utils import recursive_relative_symlink


def apply() -> None:
    recursive_relative_symlink(
        src="states/common/home/",
        dest=f"{os.environ['HOME']}/",
    )
    recursive_relative_symlink(
        src="states/macos/home/",
        dest=f"{os.environ['HOME']}/",
    )

    brew.packages(
        name="Brew packages",
        packages=[
            # common utilities
            "coreutils",
            "fd",
            "fish",
            "fzf",
            "ipcalc",
            "jj",
            "just",
            "lsd",
            "podman",
            "procs",
            "ripgrep",
            "rustup",
            "shellcheck",
            "tokei",
            "yq",
            "git-delta",
            "netcat",
            "mtr",
            # mise
            "mise",
            "usage",
            # neovim
            "neovim",
            "tree-sitter",
            # tiling wm
            "borders",
            # general lsps
            "bash-language-server",
            "yaml-language-server",
            "lua-language-server",
            "terraform-ls",
        ],
    )

    brew.casks(
        name="Brew casks",
        casks=[
            "1password",
            "aerospace",
            "font-iosevka-term-nerd-font",
            "kitty",
            "ghostty",
            "font-noto-sans-cjk",
            "podman-desktop",
            "spotify",
        ],
    )
