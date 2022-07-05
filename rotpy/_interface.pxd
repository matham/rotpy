from libc.stdint cimport int64_t, uint64_t, uint8_t, uint32_t, int8_t, \
    int16_t, uint16_t, uint8_t
from libcpp cimport bool as cbool
from libcpp.string cimport string as cstr
from libcpp.cast cimport dynamic_cast

from ._cam_defs._cam_defs1 cimport *
from ._cam_defs._cam_defs2 cimport *
from ._cam_defs._cam_defs3 cimport *
from ._cam_defs._cam_defs4 cimport *
from ._cam_defs._cam_defs5 cimport *


cdef int raise_spin_exc() except*


include "includes/Types.pxi"
include "includes/SpinnakerDefs.pxi"
include "includes/TransportLayerDefs.pxi"
include "includes/spinnaker.pxi"


cdef extern from "spinnaker_exception.h" nogil:
    void get_spinnaker_exception(
        cstr& what, cstr& full_msg, cstr& msg, cstr& file_name,
        cstr& func_name, cstr& build_date, cstr& build_time,
        int* line_num, int* err, cbool* is_spinnaker) except +


cdef extern from "rotpy_event.h" nogil:
    cdef cppclass RotpyDeviceEventHandler(CDeviceEventHandler):
        RotpyDeviceEventHandler() except +raise_spin_exc
        void SetCallback(
            void * callback_data, void (*callback_f)(void *, const gcstring*),
                gcstring &eventName
        ) except +

    cdef cppclass RotpyLoggingEventHandler(CLoggingEventHandler):
        RotpyLoggingEventHandler() except +raise_spin_exc
        void SetCallback(
            void * callback_data, void (*callback_f)(void *, const LoggingEventDataPtr)
        ) except +

    cdef cppclass RotpyImageEventHandler(CImageEventHandler):
        RotpyImageEventHandler() except +raise_spin_exc
        void SetCallback(
            void * callback_data, void (*callback_f)(void *, ImagePtr)
        ) except +

    cdef cppclass RotpyInterfaceEventHandler(CInterfaceEventHandler):
        RotpyInterfaceEventHandler() except +raise_spin_exc
        void SetCallback(
            void * callback_data, void (*callback_f_arrival)(void *, uint64_t),
            void (*callback_f_removal)(void *, uint64_t)
        ) except +

    cdef cppclass RotpySystemEventHandler(CSystemEventHandler):
        RotpySystemEventHandler() except +raise_spin_exc
        void SetCallback(
            void * callback_data, void (*callback_f_arrival)(void *, cstr),
            void (*callback_f_removal)(void *, cstr)
        ) except +


cdef extern from "rotpy_enum_wrapper.h" nogil:
    cdef cppclass RotPyEnumWrapper:
        void SetValue(int Value, cbool Verify) except +raise_spin_exc
        int GetValue(cbool Verify, cbool IgnoreCache) except +raise_spin_exc
        IEnumEntry * GetEntry(int Value) except +raise_spin_exc
        void SetEnumReference(int Index, gcstring Name) except +raise_spin_exc
        void SetNumEnums(int NumEnums) except +raise_spin_exc

    cdef cppclass RotPyEnumWrapperT[SpinnakerEnumT]:
        RotPyEnumWrapperT(IEnumerationT[SpinnakerEnumT]* handle) except+


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
ctypedef INode* INodePointer
ctypedef RotPyEnumWrapper* RotPyEnumWrapperPointer
