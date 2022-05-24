from ._interface cimport *


cdef class NodeMap:

    cdef spinNodeMapHandle _handle

    cdef void set_handle(self, spinNodeMapHandle handle)
    cpdef get_nodes(self)
    cpdef get_num_nodes(self)
    cpdef poll(self, int64_t timestamp)
    cpdef get_node_by_name(self, str name)
    cpdef get_node_by_index(self, size_t index)



cdef class SpinBaseNode:

    cdef spinNodeHandle _handle
    cdef NodeMap _map
    cdef SpinTreeNode _tree

    cdef void set_handle(self, NodeMap map, spinNodeHandle handle)
    cdef void set_handle_from_tree(self, SpinTreeNode tree, spinNodeHandle handle)
    cpdef dict get_metadata(self, include_value=*)
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
    cpdef str get_node_value_as_str(self, int verify=*)
    cpdef set_node_value_from_str(self, str value, int verify=*)


cdef class SpinIntNode(SpinBaseNode):

    cpdef int64_t get_node_value(self, int verify=*)
    cpdef set_node_value(self, int64_t value, int verify=*)
    cpdef int64_t get_min_value(self)
    cpdef int64_t get_max_value(self)
    cpdef int64_t get_increment(self)
    cpdef str get_representation(self)


cdef class SpinFloatNode(SpinBaseNode):

    cpdef double get_node_value(self, int verify=*)
    cpdef set_node_value(self, double value, int verify=*)
    cpdef double get_min_value(self)
    cpdef double get_max_value(self)
    cpdef str get_representation(self)
    cpdef str get_unit(self)


cdef class SpinBoolNode(SpinBaseNode):

    cpdef get_node_value(self)
    cpdef set_node_value(self, bool8_t value)


cdef class SpinStrNode(SpinBaseNode):

    cpdef str get_node_value(self, int verify=*)
    cpdef set_node_value(self, str value, int verify=*)


cdef class SpinCommandNode(SpinBaseNode):

    cpdef is_done(self)
    cpdef execute_node(self)


cdef class SpinRegisterNode(SpinBaseNode):

    cpdef get_address(self)
    cpdef bytes get_node_value(self, int verify=*, int allow_cache=*)
    cpdef set_node_value(self, object buffer, int verify=*)
    cpdef set_ref(self, SpinBaseNode ref)


cdef class SpinEnumClsNode(SpinBaseNode):

    cpdef get_items(self)
    cpdef get_num_items(self)
    cpdef SpinEnumItemNode get_item_by_index(self, size_t index)
    cpdef SpinEnumItemNode get_item_by_name(self, str name)
    cpdef SpinEnumItemNode get_node_value(self)
    cpdef set_node_value(self, SpinEnumItemNode item)
    cpdef set_node_value_by_int(self, int64_t value)
    cpdef set_node_value_by_enum(self, size_t value)


cdef class SpinEnumItemNode(SpinBaseNode):

    cdef SpinEnumClsNode _enum_cls

    cdef void set_handle_from_cls(self, SpinEnumClsNode cls, spinNodeHandle handle)
    cpdef get_node_int_value(self)
    cpdef get_node_enum_value(self)
    cpdef str get_node_str_value(self)


cdef class SpinTreeNode(SpinBaseNode):

    cpdef get_children(self)
    cpdef get_num_nodes(self)
    cpdef get_node_by_index(self, size_t index)
