from ._interface cimport *
cimport rotpy.camera


cdef class CameraNodes:

    cdef rotpy.camera.Camera _camera
    cdef dict _nodes

    cdef public list bool_nodes
    cdef public list int_nodes
    cdef public list float_nodes
    cdef public list str_nodes
    cdef public list enum_nodes
    cdef public list command_nodes
    cdef public list register_nodes


cdef class TLDevNodes:

    cdef rotpy.camera.Camera _camera
    cdef dict _nodes

    cdef public list bool_nodes
    cdef public list int_nodes
    cdef public list float_nodes
    cdef public list str_nodes
    cdef public list enum_nodes
    cdef public list command_nodes
    cdef public list register_nodes


cdef class TLStreamNodes:

    cdef rotpy.camera.Camera _camera
    cdef dict _nodes

    cdef public list bool_nodes
    cdef public list int_nodes
    cdef public list float_nodes
    cdef public list str_nodes
    cdef public list enum_nodes
    cdef public list command_nodes
    cdef public list register_nodes
