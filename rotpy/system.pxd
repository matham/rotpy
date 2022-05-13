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
