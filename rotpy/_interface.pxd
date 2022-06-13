from libc.stdint cimport int64_t, uint64_t, uint8_t, uint32_t, int8_t, \
    int16_t, uint16_t, uint8_t
from libcpp cimport bool as cbool
from libcpp.string cimport string as cstr
from libcpp.cast cimport dynamic_cast


include "includes/Types.pxi"
include "includes/SpinnakerDefs.pxi"
include "includes/TransportLayerDefs.pxi"
include "includes/CameraDefs.pxi"
include "includes/spinnaker.pxi"


cdef extern from "rotpy_event.h" nogil:
    cdef cppclass RotpyDeviceEventHandler(CDeviceEventHandler):
        RotpyDeviceEventHandler() except +
        void SetCallback(
            void * callback_data, void (*callback_f)(void *, const gcstring*),
                gcstring &eventName
        ) except +

    cdef cppclass RotpyLoggingEventHandler(CLoggingEventHandler):
        RotpyLoggingEventHandler() except +
        void SetCallback(
            void * callback_data, void (*callback_f)(void *, const LoggingEventDataPtr)
        ) except +

    cdef cppclass RotpyImageEventHandler(CImageEventHandler):
        RotpyImageEventHandler() except +
        void SetCallback(
            void * callback_data, void (*callback_f)(void *, ImagePtr)
        ) except +

    cdef cppclass RotpyInterfaceEventHandler(CInterfaceEventHandler):
        RotpyInterfaceEventHandler() except +
        void SetCallback(
            void * callback_data, void (*callback_f_arrival)(void *, uint64_t),
            void (*callback_f_removal)(void *, uint64_t)
        ) except +

    cdef cppclass RotpySystemEventHandler(CSystemEventHandler):
        RotpySystemEventHandler() except +
        void SetCallback(
            void * callback_data, void (*callback_f_arrival)(void *, cstr),
            void (*callback_f_removal)(void *, cstr)
        ) except +


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
ctypedef IEnumeration* IEnumerationPointer
ctypedef IPort* IPortPointer
ctypedef ISelector* ISelectorPointer
ctypedef IEnumerationT[int]* IEnumerationTPointer
ctypedef INode* INodePointer
