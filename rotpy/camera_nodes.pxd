from ._interface cimport *
from .camera cimport Camera


cdef class CameraNodes:

    cdef Camera _camera
    cdef dict _nodes


cdef class TLDevNodes:

    cdef Camera _camera
    cdef dict _nodes


cdef class TLStreamNodes:

    cdef Camera _camera
    cdef dict _nodes
