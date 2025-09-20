from typing import assert_never

from states import linux
from states.utils import Machine


match machine := Machine.determine():
    case Machine.MACK:
        raise NotImplementedError()
    case Machine.LORKHAN:
        linux.apply(machine)
    case _unreachable:
        assert_never(_unreachable)
