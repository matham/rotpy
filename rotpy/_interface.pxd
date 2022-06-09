from libc.stdint cimport int64_t, uint64_t, uint8_t, uint32_t
from libcpp cimport bool as cbool
from libcpp.string cimport string as cstr
from libcpp.cast cimport dynamic_cast

# include "includes/SpinnakerDefsC.pxi"
# include "includes/CameraDefsC.pxi"
# include "includes/ChunkDataDefC.pxi"
# include "includes/SpinnakerGenApiDefsC.pxi"
# include "includes/SpinnakerGenApiC.pxi"
# include "includes/QuickSpinDefsC.pxi"
# include "includes/TransportLayerDefsC.pxi"
# include "includes/TransportLayerInterfaceC.pxi"
# include "includes/TransportLayerSystemC.pxi"
# include "includes/TransportLayerDeviceC.pxi"
# include "includes/TransportLayerStreamC.pxi"
# include "includes/QuickSpinC.pxi"
# include "includes/SpinnakerC.pxi"


include "includes/Types.pxi"
include "includes/SpinnakerDefs.pxi"
include "includes/CameraDefs.pxi"
include "includes/spinnaker.pxi"

include "includes/compat.pxi"


ctypedef IBase* IBasePointer
ctypedef IValue* IValuePointer
ctypedef IInteger* IIntegerPointer
ctypedef IBoolean* IBooleanPointer
ctypedef ICommand* ICommandPointer
ctypedef IFloat* IFloatPointer
ctypedef IString* IStringPointer
ctypedef IRegister* IRegisterPointer
ctypedef ICategory* ICategoryPointer
ctypedef IEnumEntry* IEnumEntryPointer
ctypedef IPort* IPortPointer
ctypedef ISelector* ISelectorPointer
ctypedef IEnumReference* IEnumReferencePointer
ctypedef INode* INodePointer
