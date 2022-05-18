from ._interface cimport *

cdef class SpinError:

    cpdef spinError get_last_error(self)
    cpdef str get_last_message(self)
    cpdef str get_last_build_date(self)
    cpdef str get_last_build_time(self)
    cpdef str get_last_filename(self)
    cpdef str get_last_full_message(self)
    cpdef str get_last_function(self)
    cpdef int64_t get_last_line_num(self)
    cpdef dict get_error_data(self)


cdef class SpinSystem:

    cdef spinSystem _system
    cdef int _system_set

    cpdef set_logging_level(self, str level)
    cpdef str get_logging_level(self)
    cpdef str detach_all_log_handlers(self)
    cpdef object get_in_use(self)
    cpdef object refresh_camera_list(self, int update_interfaces=*)
    cpdef tuple get_library_version(self)


cdef class InterfaceDeviceList:

    cdef SpinSystem system
    cdef spinInterfaceList _interface_list
    cdef int _list_set

    cpdef refresh_interfaces(self)
    cpdef int get_size(self)
    cpdef InterfaceDevice create_interface(self, int index)


cdef class InterfaceDevice:

    cdef spinInterface _interface
    cdef int _interface_set

    cdef object set_interface(self, InterfaceDeviceList dev_list, int index)
