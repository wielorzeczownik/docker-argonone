import sys
import types
from unittest.mock import MagicMock

# Mock argon hardware modules before argononed.py is imported.
# The module runs argonregister_initializebusobj() at import time, so
# argonregister must expose that name before the module is loaded.

_argonregister = types.ModuleType("argonregister")
_argonregister.argonregister_initializebusobj = MagicMock(
    return_value=MagicMock()
)
_argonregister.argonregister_checksupport = MagicMock()
_argonregister.argonregister_setfanspeed = MagicMock()
_argonregister.argonregister_signalpoweroff = MagicMock()

_argonsysinfo = types.ModuleType("argonsysinfo")
_argonsysinfo.argonsysinfo_getcputemp = MagicMock(return_value=50.0)
_argonsysinfo.argonsysinfo_getmaxhddtemp = MagicMock(return_value=0)

_argonpowerbutton = types.ModuleType("argonpowerbutton")
_argonpowerbutton.argonpowerbutton_monitor = MagicMock()
_argonpowerbutton.argonpowerbutton_monitorswitch = MagicMock()

sys.modules["argonsysinfo"] = _argonsysinfo
sys.modules["argonregister"] = _argonregister
sys.modules["argonpowerbutton"] = _argonpowerbutton
