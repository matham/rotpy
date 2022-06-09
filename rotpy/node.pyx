from .names import InterfaceType_names, InterfaceType_values,\
    access_mode_names, access_mode_values, NameSpace_values, Visibility_names, \
    Visibility_values, CachingMode_names, CachingMode_values, \
    Representation_values, YesNo_values, IncMode_values, DisplayNotation_values
from array import array

cimport cpython.array

DEF MAX_BUFF_LEN = 256

cdef dict node_cls_map = {
    InterfaceType_names['Value']: SpinValueNode,
    InterfaceType_names['Base']: SpinBaseNode,
    InterfaceType_names['Integer']: SpinIntNode,
    InterfaceType_names['Boolean']: SpinBoolNode,
    InterfaceType_names['Command']: SpinCommandNode,
    InterfaceType_names['Float']: SpinFloatNode,
    InterfaceType_names['String']: SpinStrNode,
    InterfaceType_names['Register']: SpinRegisterNode,
    InterfaceType_names['Category']: SpinTreeNode,
    InterfaceType_names['Enumeration']: SpinEnumClsNode,
    InterfaceType_names['EnumEntry']: SpinEnumItemNode,
    InterfaceType_names['Port']: SpinPortNode,
}


ctypedef fused NodeBases:
    SpinBaseNode
    SpinValueNode
    SpinIntNode
    SpinFloatNode
    SpinBoolNode
    SpinStrNode
    SpinCommandNode
    SpinRegisterNode
    SpinEnumClsNode
    SpinEnumItemNode
    SpinTreeNode
    SpinPortNode


cdef object _node_inst(NodeBases node, object obj, INode* handle):
    node.set_handle(obj, dynamic_cast[IBasePointer](handle))
    return node


cdef object create_node_inst(object obj, INode* handle):
    cdef EInterfaceType node_type
    cdef NodeBases node

    with nogil:
        node_type = handle.GetPrincipalInterfaceType()

    if node_type == intfIValue:
        return _node_inst[SpinValueNode](SpinValueNode(), obj, handle)
    elif node_type == intfIBase:
        return _node_inst[SpinBaseNode](SpinBaseNode(), obj, handle)
    elif node_type == intfIInteger:
        return _node_inst[SpinIntNode](SpinIntNode(), obj, handle)
    elif node_type == intfIBoolean:
        return _node_inst[SpinBoolNode](SpinBoolNode(), obj, handle)
    elif node_type == intfICommand:
        return _node_inst[SpinCommandNode](SpinCommandNode(), obj, handle)
    elif node_type == intfIFloat:
        return _node_inst[SpinFloatNode](SpinFloatNode(), obj, handle)
    elif node_type == intfIString:
        return _node_inst[SpinStrNode](SpinStrNode(), obj, handle)
    elif node_type == intfIRegister:
        return _node_inst[SpinRegisterNode](SpinRegisterNode(), obj, handle)
    elif node_type == intfICategory:
        return _node_inst[SpinTreeNode](SpinTreeNode(), obj, handle)
    elif node_type == intfIEnumeration:
        # return _node_inst[SpinEnumClsNode](SpinEnumClsNode(), obj, handle)
        return None
    elif node_type == intfIEnumEntry:
        return _node_inst[SpinEnumItemNode](SpinEnumItemNode(), obj, handle)
    elif node_type == intfIPort:
        return _node_inst[SpinPortNode](SpinPortNode(), obj, handle)


cdef class NodeMap:
    """Provides access to nodes of a camera or system.

    TODO: Set all handles by default to NULL and doc which classes cannot be
    manually created.
    """

    def __cinit__(self):
        self._handle = NULL

    cdef void set_handle(self, INodeMap* handle):
        self._handle = handle

    cpdef get_nodes(self):
        """Returns a list of the nodes in the map.

        It only returns direct nodes of the map. If the nodes have
        children (e.g. enum class or tree) it is not recursed.
        """
        cdef uint64_t n, i
        cdef list items = []
        cdef NodeList_t nodes

        with nogil:
            n = self._handle.GetNumNodes()
            self._handle.GetNodes(nodes)

        for i in range(n):
            items.append(create_node_inst(self, (&nodes.at(i))[0]))

        return items

    cpdef get_num_nodes(self):
        """Gets the number of nodes in the map.
        """
        cdef uint64_t n
        with nogil:
            n = self._handle.GetNumNodes()
        return n

    cpdef poll(self, int64_t elapsed):
        """Fires nodes which have a polling time.

        :param elapsed: The elapsed time.

        TODO: Understand what this does.
        """
        with nogil:
            self._handle.Poll(elapsed)

    cpdef get_node_by_name(self, str name):
        """Gets a node from the nodemap by name.

        :param name: The name of the node.
        :return: A :class:`Node` derived instance.
        """
        cdef bytes name_b = name.encode()
        cdef const char * name_c = name_b
        cdef size_t n = len(name_b)
        cdef gcstring s
        cdef INode* handle

        with nogil:
            s.assign(name_c, n)
            handle = self._handle.GetNode(s)

        return create_node_inst(self, handle)

    cpdef get_node_by_index(self, size_t index):
        """Gets a node from the nodemap by index.

        :param index: The index of the node.
        :return: A :class:`Node` derived instance.
        """
        cdef NodeList_t items
        cdef INode* handle

        with nogil:
            self._handle.GetNodes(items)
            handle = (&items.at(index))[0]

        return create_node_inst(self, handle)

    cpdef invalidate_nodes(self):
        """Invalidates all nodes.
        """
        with nogil:
            self._handle.InvalidateNodes()

    cpdef get_dev_name(self):
        """Returns the device name.

        The device name identifies a device instance, e.g. for debugging
        purposes.
        """
        cdef gcstring s
        with nogil:
            s = self._handle.GetDeviceName()
        return s.c_str().decode()


"""
/**
 * Connects a port to a port node with given name
 */
virtual bool Connect(IPort * pPort, const GenICam::gcstring& PortName) const = 0;

/**
 * Connects a port to the standard port "Device"
 */
virtual bool Connect(IPort * pPort) const = 0;

/**
 * Returns the lock which guards the node map
 */
virtual CLock& GetLock() const = 0;
"""


cdef class SpinEnumReferenceNode:

    def __cinit__(self):
        self._enum_ref_handle = NULL

    cdef void set_handle(self, object source, IBase* handle) except *:
        self._enum_ref_handle = dynamic_cast[IEnumReferencePointer](handle)

    cpdef set_enum_ref(self, int index, str name):
        """Sets the value corresponding to a enum item.
        """
        cdef bytes name_b = name.encode()
        cdef size_t n = len(name)
        cdef const char * name_c = name_b
        cdef gcstring name_s

        with nogil:
            name_s.assign(name_c, n)
            self._enum_ref_handle.SetEnumReference(index, name_s)

    cpdef set_num_enums(self, int num):
        """Sets the number of enum values.
        """
        with nogil:
            self._enum_ref_handle.SetNumEnums(num)


cdef class SpinBaseNode:

    def __cinit__(self):
        self._base_handle = NULL
        self._handle_src = None

    cdef void set_handle(self, object source, IBase* handle) except *:
        self._base_handle = handle
        self._handle_src = source

    cpdef get_access_mode(self):
        """Gets the access mode of the node as a string from
        :attr:`~rotpy.names.access_mode_names`.
        """
        cdef EAccessMode n
        with nogil:
            n = self._base_handle.GetAccessMode()
        return access_mode_values[n]


cdef class SpinSelectorNode(SpinBaseNode):

    def __cinit__(self):
        self._sel_handle = NULL

    cdef void set_handle(self, object source, IBase* handle) except *:
        SpinBaseNode.set_handle(self, object, handle)
        self._sel_handle = dynamic_cast[ISelectorPointer](handle)

    cpdef is_selector(self):
        """Returns whether this feature selects a group of features"""
        cdef cbool n
        with nogil:
            n = self._sel_handle.IsSelector()
        return bool(n)

    cpdef get_selected_nodes(self):
        """Returns a list of nodes selected by this node.
        """
        cdef uint64_t n, i
        cdef list items = []
        cdef FeatureList_t nodes

        with nogil:
            self._sel_handle.GetSelectedFeatures(nodes)
            n = nodes.size()

        for i in range(n):
            items.append(create_node_inst(self, dynamic_cast[INodePointer]((&nodes.at(i))[0])))

        return items

    cpdef get_selecting_nodes(self):
        """Returns a list of nodes that select this node.
        """
        cdef uint64_t n, i
        cdef list items = []
        cdef FeatureList_t nodes

        with nogil:
            self._sel_handle.GetSelectingFeatures(nodes)
            n = nodes.size()

        for i in range(n):
            items.append(create_node_inst(self, dynamic_cast[INodePointer]((&nodes.at(i))[0])))

        return items


cdef class SpinNode(SpinSelectorNode):

    def __cinit__(self):
        self._node_handle = NULL

    cdef void set_handle(self, object source, IBase* handle) except *:
        SpinSelectorNode.set_handle(self, object, handle)
        self._node_handle = dynamic_cast[INodePointer](handle)

    cpdef dict get_metadata(self, include_value=False):
        """Returns a dict of metadata of the node.

        The items are the various info on the node as accessible from the node's
        methods (e.g. whether it's readable etc.).

        :param include_value: If True, we read the value and include it in the
            dict as a string.
        """
        d = {
            'implemented': self.is_implemented(),
            'readable': self.is_readable(),
            'writeable': self.is_writable(),
            'available': self.is_available(),
            'access_mode': self.get_access_mode(),
            'name': self.get_name(),
            'namespace': self.get_namespace(),
            'visibility': self.get_visibility(),
            'caching_mode': self.get_caching_mode(),
            'short_description': self.get_short_description(),
            'description': self.get_description(),
            'display_name': self.get_display_name(),
            'type': self.get_node_type(),
            'polling_time': self.get_polling_time(),
        }
        if include_value:
            d['value'] = self.get_node_value_as_str()
        return d

    # cpdef is_implemented(self):
    #     """Checks whether the node is implemented.
    #     """
    #     cdef bool8_t n
    #     with nogil:
    #         check_ret(spinNodeIsImplemented(self._handle, &n))
    #     return bool(n)
    #
    # cpdef is_readable(self):
    #     """Checks whether the node is readable.
    #     """
    #     cdef bool8_t n
    #     with nogil:
    #         check_ret(spinNodeIsReadable(self._handle, &n))
    #     return bool(n)
    #
    # cpdef is_writable(self):
    #     """Checks whether the node is writable.
    #     """
    #     cdef bool8_t n
    #     with nogil:
    #         check_ret(spinNodeIsWritable(self._handle, &n))
    #     return bool(n)
    #
    # cpdef is_available(self):
    #     """Checks whether the node is available.
    #     """
    #     cdef bool8_t n
    #     with nogil:
    #         check_ret(spinNodeIsAvailable(self._handle, &n))
    #     return bool(n)
    #
    # cpdef is_equal(self, SpinBaseNode other):
    #     """Checks whether the node is equal to the other node.
    #     """
    #     cdef bool8_t n
    #     with nogil:
    #         check_ret(spinNodeIsEqual(self._handle, other._handle, &n))
    #     return bool(n)

    cpdef is_cachable(self):
        """Checks whether the node value is cacheable.
        """
        cdef cbool n
        with nogil:
            n = self._node_handle.IsCachable()
        return bool(n)

    cpdef is_access_cachable(self):
        """Gets whether the AccessMode can be cached, as a string from
        :attr:`~rotpy.names.YesNo_names`.
        """
        cdef EYesNo n
        with nogil:
            n = self._node_handle.IsAccessModeCacheable()
        return YesNo_values[n]

    cpdef is_streamable(self):
        """Checks whether the node value is streamable.
        """
        cdef cbool n
        with nogil:
            n = self._node_handle.IsStreamable()
        return bool(n)

    cpdef is_deprecated(self):
        """Checks whether the node should not be used any more.
        """
        cdef cbool n
        with nogil:
            n = self._node_handle.IsDeprecated()
        return bool(n)

    cpdef is_feature(self):
        """Checks whether the node can be reached via category nodes from a
        category node named "Root".
        """
        cdef cbool n
        with nogil:
            n = self._node_handle.IsFeature()
        return bool(n)

    cpdef get_dev_name(self):
        """Gets the name of the device.
        """
        cdef gcstring s
        with nogil:
            s = self._node_handle.GetDeviceName()
        return s.c_str().decode()

    cpdef get_event_id(self):
        """Gets the event ID of the node.
        """
        cdef gcstring s
        with nogil:
            s = self._node_handle.GetEventID()
        return s.c_str().decode()

    cpdef get_name(self, cbool fully_qualified=False):
        """Gets the name of the node (no whitespace).

        Optionally fully qualified
        """
        cdef gcstring s
        with nogil:
            s = self._node_handle.GetName(fully_qualified)
        return s.c_str().decode()

    cpdef get_namespace(self):
        """Gets the namespace of the node as a string from
        :attr:`~rotpy.names.NameSpace_names`.
        """
        cdef ENameSpace n
        with nogil:
            n = self._node_handle.GetNameSpace()
        return NameSpace_values[n]

    cpdef get_visibility(self):
        """Gets the recommended visibility of the node as a string from
        :attr:`~rotpy.names.Visibility_names`.
        """
        cdef EVisibility n
        with nogil:
            n = self._node_handle.GetVisibility()
        return Visibility_values[n]

    cpdef invalidate(self):
        """Indicates that the node's value may have changed.

        Fires the callback on this and all dependent nodes
        """
        with nogil:
            self._node_handle.InvalidateNode()

    cpdef get_caching_mode(self):
        """Gets the caching mode of the node as a string from
        :attr:`~rotpy.names.CachingMode_names`.
        """
        cdef ECachingMode n
        with nogil:
            n = self._node_handle.GetCachingMode()
        return CachingMode_values[n]

    cpdef get_short_description(self):
        """Gets a short description of the node.
        """
        cdef gcstring s
        with nogil:
            s = self._node_handle.GetToolTip()
        return s.c_str().decode()

    cpdef get_description(self):
        """Gets a longer description of the node.
        """
        cdef gcstring s
        with nogil:
            s = self._node_handle.GetDescription()
        return s.c_str().decode()

    cpdef get_display_name(self):
        """Gets the display name of the node (whitespace possible).
        """
        cdef gcstring s
        with nogil:
            s = self._node_handle.GetDisplayName()
        return s.c_str().decode()

    cpdef get_doc_url(self):
        """Gets a URL pointing to the documentation of that feature.
        """
        cdef gcstring s
        with nogil:
            s = self._node_handle.GetDocuURL()
        return s.c_str().decode()

    cpdef get_property_names(self):
        """Returns a list of the names of all properties set during
        initialization.
        """
        cdef gcstring_vector v
        cdef size_t n
        cdef size_t i
        cdef list items = []

        with nogil:
            self._node_handle.GetPropertyNames(v)
            n = v.size()

        for i in range(n):
            items.append((&v.at(i))[0].c_str().decode())

        return items

    cpdef get_property(self, str name):
        """Gets the property value by name plus any additional attributes.

        If the property has multiple values/attribute they come with Tabs as
        delimiters.

        It returns a 3-tuple of ``(result, value, attributes)``, where result
        is a bool indicating the result of the call and the others are strings.

        TODO: resolve meaning of result.
        """
        cdef bytes name_b = name.encode()
        cdef size_t n = len(name)
        cdef const char * name_c = name_b
        cdef gcstring name_s
        cdef cbool res
        cdef gcstring value
        cdef gcstring attr

        with nogil:
            name_s.assign(name_c, n)
            res = self._node_handle.GetProperty(name_s, value, attr)

        return bool(res), value.c_str().decode(), attr.c_str().decode()

    cpdef get_node_type(self):
        """Gets the node type of the node as a string from
        :attr:`~rotpy.names.InterfaceType_values`.
        """
        cdef EInterfaceType n
        with nogil:
            n = self._node_handle.GetPrincipalInterfaceType()
        return InterfaceType_values[n]

    cpdef get_polling_time(self):
        """Gets recommended polling time (for non-cacheable nodes).
        """
        cdef int64_t n
        with nogil:
            n = self._node_handle.GetPollingTime()
        return n

    cpdef set_access_mode(self, str mode):
        """Imposes an access mode to the natural access mode of the node.

        ``mode`` is s string from :attr:`~rotpy.names.access_mode_names`.
        """
        cdef EAccessMode n = access_mode_names[mode]

        with nogil:
            self._node_handle.ImposeAccessMode(n)

    cpdef set_visibility(self, str visibility):
        """Imposes a visibility to the natural visibility of the node.

        ``mode`` is s string from :attr:`~rotpy.names.Visibility_names`.
        """
        cdef EVisibility n = Visibility_names[visibility]

        with nogil:
            self._node_handle.ImposeVisibility(n)

    cpdef get_alias_node(self):
        """Gets a alias node which describes the same feature in a different
        way.

        :return: A :class:`Node` derived instance.
        """
        cdef INode* handle
        with nogil:
            handle = self._node_handle.GetAlias()
        return create_node_inst(self, handle)

    cpdef get_cast_alias_node(self):
        """Gets a alias node which describes the same feature so that it can be
        casted.

        :return: A :class:`Node` derived instance.
        """
        cdef INode* handle
        with nogil:
            handle = self._node_handle.GetCastAlias()
        return create_node_inst(self, handle)

    cpdef set_ref(self, SpinNode node):
        """Sets the implementation to a reference node.
        """
        with nogil:
            self._node_handle.SetReference(node._node_handle)


"""
/**
 * @brief Get all nodes this node directly depends on.
 * @param[out] Children List of children nodes
 * @param LinkType The link type
 */
virtual void GetChildren(GenApi::NodeList_t & Children, ELinkType LinkType = ctReadingChildren) const = 0;

/**
 * @brief Gets all nodes this node is directly depending on
 * @param[out] Parents List of parent nodes
 */
virtual void GetParents(GenApi::NodeList_t & Parents) const = 0;

/**
 * Register change callback
 * Takes ownership of the CNodeCallback object
 */
virtual CallbackHandleType RegisterCallback(CNodeCallback * pCallback) = 0;

/**
 * De register change callback
 * Destroys CNodeCallback object
 * @return true if the callback handle was valid
 */
virtual bool DeregisterCallback(CallbackHandleType hCallback) = 0;
"""


cdef class SpinValueNode(SpinNode):

    def __cinit__(self):
        self._value_handle = NULL

    cdef void set_handle(self, object source, IBase* handle) except *:
        SpinNode.set_handle(self, object, handle)
        self._value_handle = dynamic_cast[IValuePointer](handle)

    cpdef get_node_value_as_str(
            self, cbool verify=False, cbool ignore_cache=False):
        """Gets the value of the node, independent of the type, as a string.

        :param verify: Whether to verify the Range verification. The access mode
            is always checked.
        :param ignore_cache: If true the value is read ignoring any caches.
        """
        cdef gcstring s
        with nogil:
            s = self._value_handle.ToString(verify, ignore_cache)
        return s.c_str().decode()

    cpdef set_node_value_from_str(self, str value, cbool verify=True):
        """Sets the value of the node, independent of the type, from a string.

        :param value: The value to which to set the node. It is important to
            ensure that the value of the string is appropriate to the node type.
        :param verify: Whether to verify the node access mode and range.
        """
        cdef bytes value_b = value.encode()
        cdef size_t n = len(value)
        cdef const char* msg = value_b
        cdef gcstring s

        with nogil:
            s.assign(msg, n)
            self._value_handle.FromString(s, verify)

    cpdef is_value_cached(self):
        """Checks if the value comes from cache or is requested from another
        node.
        """
        cdef cbool n
        with nogil:
            n = self._value_handle.IsValueCacheValid()
        return bool(n)


cdef class SpinIntNode(SpinValueNode):

    def __cinit__(self):
        self._handle = NULL

    cdef void set_handle(self, object source, IBase* handle) except *:
        SpinValueNode.set_handle(self, object, handle)
        self._handle = dynamic_cast[IIntegerPointer](handle)

    cpdef get_node_value(self, cbool verify=False, cbool ignore_cache=False):
        """Gets the value of the node.

        :param verify: Enables Range verification. The access mode is always
            checked.
        :param ignore_cache: If true the value is read ignoring any caches.
        """
        cdef int64_t n
        with nogil:
            n = self._handle.GetValue(verify, ignore_cache)
        return n

    cpdef set_node_value(self, int64_t value, cbool verify=True):
        """Sets the value of the node.

        :param value: The value to which to set the node.
        :param verify: Enables access mode and range verification.
        """
        with nogil:
            self._handle.SetValue(value, verify)

    cpdef get_min_value(self):
        """Gets the minimum allowed value of the node.
        """
        cdef int64_t n
        with nogil:
            n = self._handle.GetMin()
        return n

    cpdef get_max_value(self):
        """Gets the maximum allowed value of the node.
        """
        cdef int64_t n
        with nogil:
            n = self._handle.GetMax()
        return n

    cpdef set_min_value(self, int64_t value):
        """Sets the minimum allowed value of the node.
        """
        with nogil:
            self._handle.ImposeMin(value)

    cpdef set_max_value(self, int64_t value):
        """Sets the maximum allowed value of the node.
        """
        with nogil:
            self._handle.ImposeMax(value)

    cpdef get_increment_mode(self):
        """Gets the increment mode string of the node as listed in
        :attr:`~rotpy.names.IncMode_names.
        """
        cdef EIncMode n
        with nogil:
            n = self._handle.GetIncMode()
        return IncMode_values[n]

    cpdef get_increment(self):
        """Gets the increment value of the node. All possible values must be
        divisible by this.
        """
        cdef int64_t n
        with nogil:
            n = self._handle.GetInc()
        return n

    cpdef get_valid_values(self, cbool bounded=True):
        """Gets list of valid values.

        :param bounded: Whether to bound the values.

        TODO: what is bound? Ensure valid indexing is right.
        """
        cdef int64_autovector_t valid
        cdef list items = []
        cdef size_t n, i

        with nogil:
            valid = self._handle.GetListOfValidValues(bounded)
            n = valid.size()

        for i in range(n):
            items.append(valid[i])

        return items

    cpdef get_representation(self):
        """Gets the name of the representation that this node represents.
        E.g. linear, logarithmic, hexidecimal, MAC etc.

        It returns a name from :attr:`~rotpy.names.Representation_names`
        """
        cdef ERepresentation n
        with nogil:
            n = self._handle.GetRepresentation()
        return Representation_values[n]

    cpdef get_unit(self):
        """Gets the physical unit name.
        """
        cdef gcstring s
        with nogil:
            s = self._handle.GetUnit()
        return s.c_str().decode()


cdef class SpinFloatNode(SpinValueNode):

    def __cinit__(self):
        self._handle = NULL

    cdef void set_handle(self, object source, IBase* handle) except *:
        SpinValueNode.set_handle(self, object, handle)
        self._handle = dynamic_cast[IFloatPointer](handle)

    cpdef get_node_value(self, cbool verify=False, cbool ignore_cache=False):
        """Gets the value of the node.

        :param verify: Enables Range verification. The access mode is always
            checked.
        :param ignore_cache: If true the value is read ignoring any caches.
        """
        cdef double n
        with nogil:
            n = self._handle.GetValue(verify, ignore_cache)
        return n

    cpdef set_node_value(self, double value, cbool verify=True):
        """Sets the value of the node.

        :param value: The value to which to set the node.
        :param verify: Enables access mode and range verification.
        """
        with nogil:
            self._handle.SetValue(value, verify)

    cpdef get_min_value(self):
        """Gets the minimum allowed value of the node.
        """
        cdef double n
        with nogil:
            n = self._handle.GetMin()
        return n

    cpdef get_max_value(self):
        """Gets the maximum allowed value of the node.
        """
        cdef double n
        with nogil:
            n = self._handle.GetMax()
        return n

    cpdef set_min_value(self, double value):
        """Sets the minimum allowed value of the node.
        """
        with nogil:
            self._handle.ImposeMin(value)

    cpdef set_max_value(self, double value):
        """Sets the maximum allowed value of the node.
        """
        with nogil:
            self._handle.ImposeMax(value)

    cpdef has_increment(self):
        """Gets whether the float has a constant increment.
        """
        cdef cbool n
        with nogil:
            n = self._handle.HasInc()
        return bool(n)

    cpdef get_increment_mode(self):
        """Gets the increment mode string of the node as listed in
        :attr:`~rotpy.names.IncMode_names.
        """
        cdef EIncMode n
        with nogil:
            n = self._handle.GetIncMode()
        return IncMode_values[n]

    cpdef get_increment(self):
        """Gets the increment value of the node. All possible values must be
        divisible by this.
        """
        cdef double n
        with nogil:
            n = self._handle.GetInc()
        return n

    cpdef get_valid_values(self, cbool bounded=True):
        """Gets list of valid values.

        :param bounded: Whether to bound the values.

        TODO: what is bound? Ensure valid indexing is right.
        """
        cdef double_autovector_t valid
        cdef list items = []
        cdef size_t n, i

        with nogil:
            valid = self._handle.GetListOfValidValues(bounded)
            n = valid.size()

        for i in range(n):
            items.append(valid[i])

        return items

    cpdef get_representation(self):
        """Gets the name of the representation that this node represents.
        E.g. linear, logarithmic, hexidecimal, MAC etc.

        It returns a name from :attr:`~rotpy.names.Representation_names`
        """
        cdef ERepresentation n
        with nogil:
            n = self._handle.GetRepresentation()
        return Representation_values[n]

    cpdef get_unit(self):
        """Gets the physical unit name.
        """
        cdef gcstring s
        with nogil:
            s = self._handle.GetUnit()
        return s.c_str().decode()

    cpdef get_display_notation(self):
        """Gets the way the float should be converted to a string.

        It returns a name from :attr:`~rotpy.names.DisplayNotation_names`
        """
        cdef EDisplayNotation n
        with nogil:
            n = self._handle.GetDisplayNotation()
        return DisplayNotation_values[n]

    cpdef get_display_precision(self):
        """Gets the precision to be used when converting the float to a string.
        """
        cdef int64_t n
        with nogil:
            n = self._handle.GetDisplayPrecision()
        return n


cdef class SpinBoolNode(SpinValueNode):

    def __cinit__(self):
        self._handle = NULL

    cdef void set_handle(self, object source, IBase* handle) except *:
        SpinValueNode.set_handle(self, object, handle)
        self._handle = dynamic_cast[IBooleanPointer](handle)

    cpdef get_node_value(self, cbool verify=False, cbool ignore_cache=False):
        """Gets the value of the node.

        :param verify: Enables Range verification. The access mode is always
            checked.
        :param ignore_cache: If true the value is read ignoring any caches.
        """
        cdef cbool n
        with nogil:
            n = self._handle.GetValue(verify, ignore_cache)
        return bool(n)

    cpdef set_node_value(self, cbool value, cbool verify=True):
        """Sets the value of the node.

        :param value: The value to which to set the node.
        :param verify: Enables access mode and range verification.
        """
        with nogil:
            self._handle.SetValue(value, verify)


cdef class SpinStrNode(SpinValueNode):

    def __cinit__(self):
        self._handle = NULL

    cdef void set_handle(self, object source, IBase* handle) except *:
        SpinValueNode.set_handle(self, object, handle)
        self._handle = dynamic_cast[IStringPointer](handle)

    cpdef get_node_value(self, cbool verify=False, cbool ignore_cache=False):
        """Gets the value of the node.

        :param verify: Enables Range verification. The access mode is always
            checked.
        :param ignore_cache: If true the value is read ignoring any caches.
        """
        cdef gcstring s
        with nogil:
            s = self._handle.GetValue(verify, ignore_cache)
        return s.c_str().decode()

    cpdef set_node_value(self, str value, cbool verify=True):
        """Sets the value of the node.

        :param value: The value to which to set the node.
        :param verify: Enables access mode and range verification.
        """
        cdef bytes value_b = value.encode()
        cdef const char * value_c = value_b
        cdef size_t n = len(value_b)
        cdef gcstring s

        with nogil:
            s.assign(value_c, n)
            self._handle.SetValue(s, verify)

    cpdef get_max_len(self):
        """Gets the maximum length of the string in bytes.
        """
        cdef int64_t n
        with nogil:
            n = self._handle.GetMaxLength()
        return n


cdef class SpinCommandNode(SpinValueNode):

    def __cinit__(self):
        self._handle = NULL

    cdef void set_handle(self, object source, IBase* handle) except *:
        SpinValueNode.set_handle(self, object, handle)
        self._handle = dynamic_cast[ICommandPointer](handle)

    cpdef is_done(self, cbool verify=True):
        """Gets whether the command is executed.

        :param verify: Enables Range verification. The access mode is always
            checked.
        """
        cdef cbool n
        with nogil:
            n = self._handle.IsDone(verify)
        return bool(n)

    cpdef execute_node(self, cbool verify=True):
        """Execute the command.

        :param verify: Enables access mode and range verification.
        """
        with nogil:
            self._handle.Execute(verify)


cdef class SpinRegisterNode(SpinValueNode):

    def __cinit__(self):
        self._handle = NULL

    cdef void set_handle(self, object source, IBase* handle) except *:
        SpinValueNode.set_handle(self, object, handle)
        self._handle = dynamic_cast[IRegisterPointer](handle)

    cpdef get_address(self):
        """Gets the address of the register node.
        """
        cdef int64_t n
        with nogil:
            n = self._handle.GetAddress()
        return n

    cpdef get_node_value(self, cbool verify=False, cbool allow_cache=False):
        """Gets the register value of the node.

        :param verify: Whether to range verify the node. Access is always
            checked.
        :param allow_cache: Whether to allow getting the register value from
            cache.
        """
        cdef unsigned char[:] arr
        cdef int64_t n
        with nogil:
            n = self._handle.GetLength()

        buffer = array('B', b'\0' * n)
        arr = buffer

        with nogil:
            self._handle.Get(&arr[0], n, verify, not allow_cache)

        return buffer.tobytes()

    cpdef set_node_value(self, object buffer, cbool verify=True):
        """Sets the register's contents.

        :param buffer: A array/bytes type buffer to which to set the node.
        :param verify: Whether to range and access verify the node.
        """
        cdef int64_t n = len(buffer)
        cdef const unsigned char[:] buf = buffer
        with nogil:
            self._handle.Set(&buf[0], n, verify)


cdef class SpinEnumClsNode(SpinBaseNode):

    cpdef get_items(self):
        """Returns a list of :class:`SpinEnumItemNode` instances that are
        items of this enum class.
        """
        cdef list items = []
        # for i in range(self.get_num_items()):
        #     items.append(self.get_item_by_index(i))
        # return items

    # cpdef get_num_items(self):
    #     """Gets the number of items in the enum class.
    #     """
    #     cdef size_t n
    #     with nogil:
    #         check_ret(spinEnumerationGetNumEntries(self._handle, &n))
    #     return n
    #
    # cpdef SpinEnumItemNode get_item_by_index(self, size_t index):
    #     """Gets a enum item node from the enum class by index.
    #
    #     :param index: The index of the node.
    #     :return: A :class:`SpinEnumItemNode` instance.
    #     """
    #     cdef SpinEnumItemNode node
    #     cdef spinNodeHandle handle
    #
    #     with nogil:
    #         check_ret(spinEnumerationGetEntryByIndex(self._handle, index, &handle))
    #
    #     node = SpinEnumItemNode()
    #     node.set_handle_from_cls(self, handle)
    #
    #     return node
    #
    # cpdef SpinEnumItemNode get_item_by_name(self, str name):
    #     """Gets a enum item node from the enum class by name.
    #
    #     :param name: The symbolic string name of the enum item.
    #     :return: A :class:`SpinEnumItemNode` instance.
    #     """
    #     cdef SpinEnumItemNode node
    #     cdef spinNodeHandle handle
    #     cdef bytes name_b = name.encode()
    #     cdef const char * name_c = name_b
    #
    #     with nogil:
    #         check_ret(spinEnumerationGetEntryByName(self._handle, name_c, &handle))
    #
    #     node = SpinEnumItemNode()
    #     node.set_handle_from_cls(self, handle)
    #
    #     return node
    #
    # cpdef SpinEnumItemNode get_node_value(self):
    #     """Gets the enum item that the class is currently set to.
    #
    #     :return: A :class:`SpinEnumItemNode` instance.
    #     """
    #     cdef SpinEnumItemNode node
    #     cdef spinNodeHandle handle
    #
    #     with nogil:
    #         check_ret(spinEnumerationGetCurrentEntry(self._handle, &handle))
    #
    #     node = SpinEnumItemNode()
    #     node.set_handle_from_cls(self, handle)
    #
    #     return node
    #
    # cpdef set_node_value(self, SpinEnumItemNode item):
    #     """Sets the value of the enum class to this item.
    #     """
    #     cdef size_t n = item.get_node_enum_value()
    #     with nogil:
    #         check_ret(spinEnumerationSetEnumValue(self._handle, n))
    #
    # cpdef set_node_value_by_int(self, int64_t value):
    #     """Sets the value of the enum class to this int value.
    #
    #     .. note::
    #
    #         The enumeration item int and enum values are different - int values
    #         are defined on camera while the enum values defined in the Spinnaker
    #         API.
    #     """
    #     with nogil:
    #         check_ret(spinEnumerationSetIntValue(self._handle, value))
    #
    # cpdef set_node_value_by_enum(self, size_t value):
    #     """Sets the value of the enum class to this enum value.
    #
    #     .. note::
    #
    #         The enumeration item int and enum values are different - int values
    #         are defined on camera while the enum values defined in the Spinnaker
    #         API.
    #     """
    #     with nogil:
    #         check_ret(spinEnumerationSetEnumValue(self._handle, value))


cdef class SpinEnumItemNode(SpinValueNode):

    def __cinit__(self):
        self._handle = NULL

    cdef void set_handle(self, object source, IBase* handle) except *:
        SpinValueNode.set_handle(self, object, handle)
        self._handle = dynamic_cast[IEnumEntryPointer](handle)

    cpdef get_enum_num(self):
        """Gets the double number value associated with the entry.
        """
        cdef double n
        with nogil:
            n = self._handle.GetNumericValue()
        return n

    cpdef get_enum_int_value(self):
        """Gets the enum int value.

        .. note::

            This is not the same int number as the "enum" number associated
            with the entry from :mod:`rotpy.names`. This value is the device
            representation of the entry.
        """
        cdef int64_t n
        with nogil:
            n = self._handle.GetValue()
        return n

    cpdef get_enum_name(self):
        """Gets the string symbolic representation of the item.
        """
        cdef gcstring s
        with nogil:
            s = self._handle.GetSymbolic()
        return s.c_str().decode()

    cpdef is_self_clearing(self):
        """Returns whether the corresponding entry is self clearing.
        """
        cdef cbool n
        with nogil:
            n = self._handle.IsSelfClearing()
        return bool(n)


cdef class SpinTreeNode(SpinValueNode):

    def __cinit__(self):
        self._handle = NULL

    cdef void set_handle(self, object source, IBase* handle) except *:
        SpinValueNode.set_handle(self, object, handle)
        self._handle = dynamic_cast[ICategoryPointer](handle)

    cpdef get_children(self):
        """Returns a list of children nodes of the tree, including
        sub-categories.
        """
        cdef uint64_t n, i
        cdef list items = []
        cdef FeatureList_t nodes

        with nogil:
            self._handle.GetFeatures(nodes)
            n = nodes.size()

        for i in range(n):
            items.append(create_node_inst(self, dynamic_cast[INodePointer]((&nodes.at(i))[0])))

        return items

    cpdef get_num_nodes(self):
        """Gets the number of nodes in the tree.
        """
        cdef FeatureList_t nodes
        cdef size_t n

        with nogil:
            self._handle.GetFeatures(nodes)
            n = nodes.size()

        return n

    cpdef get_node_by_index(self, size_t index):
        """Gets a node from the tree by index.

        :param index: The index of the node.
        :return: A :class:`Node` derived instance.
        """
        cdef FeatureList_t nodes
        cdef IValue* handle
        with nogil:
            self._handle.GetFeatures(nodes)
            handle = (&nodes.at(index))[0]
        return create_node_inst(self, dynamic_cast[INodePointer](handle))


cdef class SpinPortNode(SpinBaseNode):

    def __cinit__(self):
        self._handle = NULL

    cdef void set_handle(self, object source, IBase* handle) except *:
        SpinBaseNode.set_handle(self, object, handle)
        self._handle = dynamic_cast[IPortPointer](handle)

    cpdef write_port(self, object buffer, int64_t address):
        """Writes a chunk of bytes to the port.

        :param buffer: A array/bytes type buffer to write.
        :param address: The port address.
        """
        cdef int64_t n = len(buffer)
        cdef const unsigned char[:] buf = buffer
        with nogil:
            self._handle.Write(&buf[0], address, n)

    cpdef read_port(self, int64_t address, int64_t n):
        """Reads a chunk of bytes from the port.

        :param address: The port address.
        :param n: The number of bytes to read
        :return: Bytes object.
        """
        cdef unsigned char[:] arr
        buffer = array('B', b'\0' * n)
        arr = buffer

        with nogil:
            self._handle.Read(&arr[0], address, n)

        return buffer.tobytes()
