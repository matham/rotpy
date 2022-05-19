from ._interface cimport *


cdef class NodeMap:

    cdef spinNodeMapHandle _handle

    cdef void set_handle(self, spinNodeMapHandle handle) nogil


cdef class Node:

    cdef spinNodeHandle _handle
    cdef NodeMap _map
