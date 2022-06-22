from ._interface cimport *
from .node cimport NodeMap
cimport rotpy.system_nodes


cdef class EventHandlerBase:
    pass


cdef class LoggingEventHandler(EventHandlerBase):

    cdef object _callback
    cdef SpinSystem _system
    cdef RotpyLoggingEventHandler _handler

    cdef set_callback(self, SpinSystem system, callback)
    cdef void handler_callback(self, const LoggingEventDataPtr event) nogil except*


cdef class SystemEventHandler(EventHandlerBase):

    cdef object _callback_arrival
    cdef object _callback_removal
    cdef SpinSystem _system
    cdef RotpySystemEventHandler _handler

    cdef set_callback(self, SpinSystem system, callback_arrival, callback_removal)
    cdef void handler_callback_arrival(self, cstr interface) nogil except*
    cdef void handler_callback_removal(self, cstr interface) nogil except*


cdef class InterfaceEventHandler(EventHandlerBase):

    cdef object _callback_arrival
    cdef object _callback_removal
    cdef object _interface_or_sys
    cdef RotpyInterfaceEventHandler _handler

    cdef set_callback(self, object interface_or_sys, callback_arrival, callback_removal)
    cdef void handler_callback_arrival(self, uint64_t serial) nogil except*
    cdef void handler_callback_removal(self, uint64_t serial) nogil except*


cdef class SpinSystem:

    cdef SystemPtr _system
    cdef int _system_set
    cdef set _sys_handlers
    cdef set _interface_handlers
    cdef set _log_handlers

    cdef public rotpy.system_nodes.SystemNodes system_nodes

    cpdef set_logging_level(self, str level)
    cpdef get_logging_level(self)
    cpdef detach_all_log_handlers(self)
    cpdef get_in_use(self)
    cpdef get_library_version(self)
    cpdef get_tl_node_map(self)
    cpdef attach_event_handler(self, callback_arrival=*, callback_removal=*)
    cpdef detach_event_handler(self, SystemEventHandler handler)
    cpdef attach_interface_event_handler(
            self, callback_arrival=*, callback_removal=*, cbool update=*)
    cpdef detach_interface_event_handler(self, InterfaceEventHandler handler)
    cpdef attach_log_event_handler(self, callback)
    cpdef detach_log_event_handler(self, LoggingEventHandler handler)
    cpdef send_command(
            self, unsigned int device_key, unsigned int group_key,
            unsigned int group_mask, unsigned long long action_time=*,
            unsigned int num_results=*)
    cpdef create_interface_list(self, cbool update_interfaces=*)
    cpdef update_interface_list(self)
    cpdef update_camera_list(self, cbool update_interfaces=*)


cdef class InterfaceDeviceList:

    cdef SpinSystem system
    cdef CInterfaceList _interface_list
    cdef int _list_set

    cdef void set_system(self, SpinSystem system, CInterfaceList interface_list)
    cpdef get_size(self)
    cpdef create_interface(self, unsigned int index)
    cpdef extend(self, InterfaceDeviceList other)


cdef class InterfaceDevice:

    cdef InterfacePtr _interface
    cdef int _interface_set
    cdef InterfaceDeviceList _dev_list
    cdef set _event_handlers

    cdef public rotpy.system_nodes.InterfaceNodes interface_nodes

    cdef object set_interface(self, InterfaceDeviceList dev_list, unsigned int index)
    cpdef attach_event_handler(self, callback_arrival=*, callback_removal=*)
    cpdef detach_event_handler(self, InterfaceEventHandler handler)
    cpdef get_in_use(self)
    cpdef send_command(
            self, unsigned int device_key, unsigned int group_key,
            unsigned int group_mask, unsigned long long action_time=*,
            unsigned int num_results=*)
    cpdef get_is_valid(self)
    cpdef update_camera_list(self)
    cpdef get_tl_node_map(self)
