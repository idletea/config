from typing import assert_never

from states import linux, macos
from states.utils import Machine


match machine := Machine.determine():
    case Machine.MACK:
        macos.apply()
    case Machine.LORKHAN | Machine.DWEMER:
        linux.apply(machine)
    case _unreachable:
        assert_never(_unreachable)
