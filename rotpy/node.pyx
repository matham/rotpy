

cdef class NodeMap:
    """Provides access to nodes of a camera or system.
    """

    def __cinit__(self):
        self._handle = NULL

    cdef void set_handle(self, spinNodeMapHandle handle) nogil:
        self._handle = handle


cdef class Node:
    pass
