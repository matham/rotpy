from ._interface cimport *


cdef class NodeMap:

    cdef spinNodeMapHandle _handle
    cdef dict node_cls_map

    cdef void set_handle(self, spinNodeMapHandle handle)
    cpdef get_num_nodes(self)
    cpdef poll(self, int64_t timestamp)
    cpdef get_node_by_name(self, str name)
    cpdef get_node_by_index(self, size_t index)



cdef class SpinBaseNode:

    cdef spinNodeHandle _handle
    cdef NodeMap _map

    cdef void set_handle(self, NodeMap map, spinNodeHandle handle)
    cpdef is_implemented(self)
    cpdef is_readable(self)
    cpdef is_writable(self)
    cpdef is_available(self)
    cpdef is_equal(self, SpinBaseNode other)
    cpdef str get_access_mode(self)
    cpdef str get_name(self)
    cpdef str get_namespace(self)
    cpdef str get_visibility(self)
    cpdef invalidate(self)
    cpdef str get_caching_mode(self)
    cpdef str get_short_description(self)
    cpdef str get_description(self)
    cpdef str get_display_name(self)
    cpdef str get_node_type(self)
    cpdef get_polling_time(self)
    cpdef str get_node_value_as_str(self, int verify)
    cpdef set_node_value_from_str(self, str value, int verify)


cdef class SpinIntNode(SpinBaseNode):
    pass


cdef class SpinFloatNode(SpinBaseNode):
    pass


cdef class SpinBoolNode(SpinBaseNode):
    pass


cdef class SpinStrNode(SpinBaseNode):

    cpdef str get_node_value(self, int verify)
    cpdef set_node_value(self, str value, int verify)


cdef class SpinCommandNode(SpinBaseNode):
    pass


cdef class SpinRegisterNode(SpinBaseNode):
    pass


cdef class SpinEnumClsNode(SpinBaseNode):
    pass


cdef class SpinEnumItemNode(SpinBaseNode):
    pass


cdef class SpinCategoryNode(SpinBaseNode):
    pass


cdef class SpinPortNode(SpinBaseNode):
    pass
