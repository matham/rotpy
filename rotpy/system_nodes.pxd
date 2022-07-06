from ._interface cimport *
cimport rotpy.system


cdef class SystemNodes:

    cdef rotpy.system.SpinSystem _system
    cdef dict _nodes

    cdef clear_system(self)

    cdef public list bool_nodes
    """A list of all the names of the bool nodes.
    """
    cdef public list int_nodes
    """A list of all the names of the integer nodes.
    """
    cdef public list float_nodes
    """A list of all the names of the float nodes.
    """
    cdef public list str_nodes
    """A list of all the names of the string nodes.
    """
    cdef public list enum_nodes
    """A list of all the names of the enum nodes.
    """
    cdef public list command_nodes
    """A list of all the names of the command nodes.
    """
    cdef public list register_nodes
    """A list of all the names of the register nodes.
    """


cdef class InterfaceNodes:

    cdef rotpy.system.InterfaceDevice _interface
    cdef dict _nodes

    cdef clear_interface(self)

    cdef public list bool_nodes
    """A list of all the names of the bool nodes.
    """
    cdef public list int_nodes
    """A list of all the names of the integer nodes.
    """
    cdef public list float_nodes
    """A list of all the names of the float nodes.
    """
    cdef public list str_nodes
    """A list of all the names of the string nodes.
    """
    cdef public list enum_nodes
    """A list of all the names of the enum nodes.
    """
    cdef public list command_nodes
    """A list of all the names of the command nodes.
    """
    cdef public list register_nodes
    """A list of all the names of the register nodes.
    """
