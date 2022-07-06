from ._interface cimport *


cdef class NodeMap:

    cdef INodeMap* _handle

    cdef void set_handle(self, INodeMap* handle)
    cpdef get_nodes(self)
    cpdef get_num_nodes(self)
    cpdef poll(self, int64_t elapsed)
    cpdef get_node_by_name(self, str name)
    cpdef get_node_by_index(self, size_t index)
    cpdef invalidate_nodes(self)
    cpdef get_dev_name(self)
    cpdef connect_port(self, SpinPortNode node, str name=*)


cdef class SpinBaseNode:

    cdef IBase* _base_handle
    cdef object _handle_src

    cdef void set_handle(self, object source, IBase* handle) except *
    cpdef get_access_mode(self)
    cpdef is_readable(self)
    cpdef is_writable(self)
    cpdef is_implemented(self)
    cpdef is_available(self)
    cpdef is_visible(self, str visibility, str max_visibility)
    cdef clear_handle(self)


cdef class SpinSelectorNode(SpinBaseNode):

    cdef ISelector* _sel_handle

    cpdef is_selector(self)
    cpdef get_selected_nodes(self)
    cpdef get_selecting_nodes(self)


cdef class SpinNode(SpinSelectorNode):

    cdef INode* _node_handle

    cpdef dict get_metadata(self)
    cpdef is_cachable(self)
    cpdef is_access_cachable(self)
    cpdef is_streamable(self)
    cpdef is_deprecated(self)
    cpdef is_feature(self)
    cpdef get_dev_name(self)
    cpdef get_event_id(self)
    cpdef get_name(self, cbool fully_qualified=*)
    cpdef get_namespace(self)
    cpdef get_visibility(self)
    cpdef invalidate(self)
    cpdef get_caching_mode(self)
    cpdef get_short_description(self)
    cpdef get_description(self)
    cpdef get_display_name(self)
    cpdef get_doc_url(self)
    cpdef get_property_names(self)
    cpdef get_property(self, str name)
    cpdef get_node_type(self)
    cpdef get_polling_time(self)
    cpdef set_access_mode(self, str mode)
    cpdef set_visibility(self, str visibility)
    cpdef get_alias_node(self)
    cpdef get_cast_alias_node(self)
    cpdef set_ref(self, SpinNode node)


cdef class SpinValueNode(SpinNode):

    cdef IValue* _value_handle

    cpdef get_node_value_as_str(self, cbool verify=*, cbool ignore_cache=*)
    cpdef set_node_value_from_str(self, str value, cbool verify=*)
    cpdef is_value_cached(self)


cdef class SpinIntNode(SpinValueNode):

    cdef IInteger* _handle

    cpdef get_node_value(self, cbool verify=*, cbool ignore_cache=*)
    cpdef set_node_value(self, int64_t value, cbool verify=*)
    cpdef get_min_value(self)
    cpdef get_max_value(self)
    cpdef set_min_value(self, int64_t value)
    cpdef set_max_value(self, int64_t value)
    cpdef get_increment_mode(self)
    cpdef get_increment(self)
    cpdef get_valid_values(self, cbool bounded=*)
    cpdef get_representation(self)
    cpdef get_unit(self)


cdef class SpinFloatNode(SpinValueNode):

    cdef IFloat * _handle

    cpdef get_node_value(self, cbool verify= *, cbool ignore_cache=*)
    cpdef set_node_value(self, double value, cbool verify=*)
    cpdef get_min_value(self)
    cpdef get_max_value(self)
    cpdef set_min_value(self, double value)
    cpdef set_max_value(self, double value)
    cpdef has_increment(self)
    cpdef get_increment_mode(self)
    cpdef get_increment(self)
    cpdef get_valid_values(self, cbool bounded=*)
    cpdef get_representation(self)
    cpdef get_unit(self)
    cpdef get_display_notation(self)
    cpdef get_display_precision(self)


cdef class SpinBoolNode(SpinValueNode):

    cdef IBoolean* _handle

    cpdef get_node_value(self, cbool verify= *, cbool ignore_cache=*)
    cpdef set_node_value(self, cbool value, cbool verify=*)


cdef class SpinStrNode(SpinValueNode):

    cdef IString* _handle

    cpdef get_node_value(self, cbool verify= *, cbool ignore_cache=*)
    cpdef set_node_value(self, str value, cbool verify=*)
    cpdef get_max_len(self)


cdef class SpinCommandNode(SpinValueNode):

    cdef ICommand* _handle

    cpdef is_done(self, cbool verify=*)
    cpdef execute_node(self, cbool verify=*)


cdef class SpinRegisterNode(SpinValueNode):

    cdef IRegister* _handle

    cpdef get_address(self)
    cpdef get_node_value(self, cbool verify=*, cbool allow_cache=*)
    cpdef set_node_value(self, object buffer, cbool verify=*)


cdef class SpinEnumNode(SpinValueNode):

    cdef IEnumeration* _handle

    cpdef get_entries_names(self)
    cpdef get_entries(self)
    cpdef get_num_entries(self)
    cpdef get_entry_by_int_value(self, int64_t value)
    cpdef get_entry_by_name(self, str name)
    cpdef get_node_int_value(self, cbool verify=*, cbool ignore_cache=*)
    cpdef set_node_int_value(self, int64_t value, cbool verify=*)
    cpdef get_node_value(self, cbool verify=*, cbool ignore_cache=*)
    cpdef set_node_value(self, SpinEnumItemNode item, cbool verify=*)


cdef class SpinEnumDefNode(SpinEnumNode):

    cdef public dict enum_names
    """The ``xxx_names`` dictionary in :mod:`~rotpy.names` that maps the
    Spinnaker API given name to Spinnaker API given value for all the entries
    (items) of this enum.
    """
    cdef public dict enum_values
    """The ``xxx_names`` dictionary in :mod:`~rotpy.names` that maps the
    Spinnaker API given value to Spinnaker API given name for all the entries
    (items) of this enum.
    """

    cdef RotPyEnumWrapper* _enum_wrapper

    cdef set_wrapper(self, RotPyEnumWrapper* wrapper)
    cpdef get_entry_by_api_str(self, str value)
    cpdef get_node_api_str_value(self, cbool verify=*, cbool ignore_cache=*)
    cpdef set_node_api_str_value(self, str value, cbool verify=*)
    cpdef set_enum_ref(self, int index, str name)
    cpdef set_num_enums(self, int num)


cdef class SpinEnumItemNode(SpinValueNode):

    cdef IEnumEntry* _handle

    cdef public str enum_name
    """For :class:`SpinEnumItemNode` created as entries of
    :class:`SpinEnumDefNode` using :meth:`SpinEnumDefNode.get_entry_by_api_str`,
    it's the Spinnaker API given name of this entry as listed in
    :attr:`SpinEnumDefNode.enum_names`.
    """
    cdef public int enum_value
    """For :class:`SpinEnumItemNode` created as entries of
    :class:`SpinEnumDefNode` using :meth:`SpinEnumDefNode.get_entry_by_api_str`,
    it's the Spinnaker API given value of this entry as listed in
    :attr:`SpinEnumDefNode.enum_values`.
    """

    cpdef get_enum_int_value(self)
    cpdef get_enum_num(self)
    cpdef get_enum_name(self)
    cpdef is_self_clearing(self)


cdef class SpinTreeNode(SpinValueNode):

    cdef ICategory* _handle

    cpdef get_children(self)
    cpdef get_num_nodes(self)
    cpdef get_node_by_index(self, size_t index)


cdef class SpinPortNode(SpinBaseNode):

    cdef IPort* _handle

    cpdef write_port(self, object buffer, int64_t address)
    cpdef read_port(self, int64_t address, int64_t n)
