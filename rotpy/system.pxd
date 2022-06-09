from ._interface cimport *
from .node cimport NodeMap

# cdef class SpinError:
#
#     cpdef spinError get_last_error(self)
#     cpdef str get_last_message(self)
#     cpdef str get_last_build_date(self)
#     cpdef str get_last_build_time(self)
#     cpdef str get_last_filename(self)
#     cpdef str get_last_full_message(self)
#     cpdef str get_last_function(self)
#     cpdef int64_t get_last_line_num(self)
#     cpdef dict get_error_data(self)


cdef class SpinSystem:

    cdef SystemPtr _system
    cdef int _system_set

    cpdef set_logging_level(self, str level)
    cpdef get_logging_level(self)
    cpdef detach_all_log_handlers(self)
    cpdef get_in_use(self)
    cpdef refresh_camera_list(self, cbool update_interfaces=*)
    cpdef get_library_version(self)
    cpdef get_tl_node_map(self)


cdef class InterfaceDeviceList:

    cdef SpinSystem system
    cdef CInterfaceList _interface_list
    cdef int _list_set

    cpdef refresh_interfaces(self)
    cpdef get_size(self)
    cpdef InterfaceDevice create_interface(self, unsigned int index)
    cpdef extend(self, InterfaceDeviceList other)


cdef class InterfaceDevice:

    cdef InterfacePtr _interface
    cdef int _interface_set
    cdef InterfaceDeviceList _dev_list

    cdef object set_interface(self, InterfaceDeviceList dev_list, unsigned int index)
    cpdef get_in_use(self)
#     cpdef NodeMap get_tl_node_map(self)
