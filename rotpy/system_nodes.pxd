from ._interface cimport *
cimport rotpy.system


cdef class SystemNodes:

    cdef rotpy.system.SpinSystem _system
    cdef dict _nodes

    cdef public list bool_nodes
    cdef public list int_nodes
    cdef public list float_nodes
    cdef public list str_nodes
    cdef public list enum_nodes
    cdef public list command_nodes
    cdef public list register_nodes


cdef class InterfaceNodes:

    cdef rotpy.system.InterfaceDevice _interface
    cdef dict _nodes

    cdef public list bool_nodes
    cdef public list int_nodes
    cdef public list float_nodes
    cdef public list str_nodes
    cdef public list enum_nodes
    cdef public list command_nodes
    cdef public list register_nodes
