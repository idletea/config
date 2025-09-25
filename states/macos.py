import os
from pyinfra.operations import files, pacman, systemd
from states.utils import Machine, recursive_relative_symlink


def apply() -> None:
    recursive_relative_symlink(
        src="states/common/home/",
        dest=f"{os.environ['HOME']}/",
    )
    recursive_relative_symlink(
        src="states/macos/home/",
        dest=f"{os.environ['HOME']}/",
    )
