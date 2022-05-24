from .names import NodeType_values, NodeType_names, AccessMode_names, \
    AccessMode_values, NameSpace_values, Visibility_names, Visibility_values, \
    CachingMode_names, CachingMode_values, Representation_values
from array import array

cimport cpython.array

DEF MAX_BUFF_LEN = 256

cdef dict node_cls_map = {
    NodeType_names['IntegerNode']: SpinIntNode,
    NodeType_names['BooleanNode']: SpinBoolNode,
    NodeType_names['FloatNode']: SpinFloatNode,
    NodeType_names['CommandNode']: SpinCommandNode,
    NodeType_names['StringNode']: SpinStrNode,
    NodeType_names['RegisterNode']: SpinRegisterNode,
    NodeType_names['EnumerationNode']: SpinEnumClsNode,
    NodeType_names['EnumEntryNode']: SpinEnumItemNode,
    NodeType_names['CategoryNode']: SpinTreeNode,
}


cdef class NodeMap:
    """Provides access to nodes of a camera or system.

    TODO: Set all handles by default to NULL and doc which classes cannot be
    manually created.
    """

    def __cinit__(self):
        self._handle = NULL

    cdef void set_handle(self, spinNodeMapHandle handle):
        self._handle = handle

    cpdef get_nodes(self):
        """Returns a list of immediate nodes of the map.

        It only returns direct nodes of the map. If the nodes have
        children (e.g. enum class or tree) it is not recursed.
        """
        cdef list items = []
        for i in range(self.get_num_nodes()):
            items.append(self.get_node_by_index(i))
        return items

    cpdef get_num_nodes(self):
        """Gets the number of nodes in the map.
        """
        cdef size_t n
        with nogil:
            check_ret(spinNodeMapGetNumNodes(self._handle, &n))
        return n

    cpdef poll(self, int64_t timestamp):
        """Fires nodes which have a polling time.

        :param timestamp: The timestamp.

        TODO: Understand what this does.
        """
        with nogil:
            check_ret(spinNodeMapPoll(self._handle, timestamp))

    cpdef get_node_by_name(self, str name):
        """Gets a node from the nodemap by name.

        :param name: The name of the node.
        :return: A :class:`Node` derived instance.
        """
        cdef bytes name_b = name.encode()
        cdef const char * name_c = name_b
        cdef spinNodeType node_type
        cdef spinNodeHandle handle
        cdef SpinBaseNode node_base

        with nogil:
            check_ret(spinNodeMapGetNode(self._handle, name_c, &handle))
            check_ret(spinNodeGetType(handle, &node_type))

        node = node_cls_map.get(node_type, SpinBaseNode)()
        node_base = node
        node_base.set_handle(self, handle)

        return node

    cpdef get_node_by_index(self, size_t index):
        """Gets a node from the nodemap by index.

        :param index: The index of the node.
        :return: A :class:`Node` derived instance.
        """
        cdef spinNodeType node_type
        cdef spinNodeHandle handle
        cdef SpinBaseNode node_base

        with nogil:
            check_ret(spinNodeMapGetNodeByIndex(self._handle, index, &handle))
            check_ret(spinNodeGetType(handle, &node_type))

        node = node_cls_map.get(node_type, SpinBaseNode)()
        node_base = node
        node_base.set_handle(self, handle)

        return node


cdef class SpinBaseNode:

    def __cinit__(self):
        self._handle = NULL
        self._map = None
        self._tree = None

    def __dealloc__(self):
        if self._map is not None:
            with nogil:
                check_ret(spinNodeMapReleaseNode(
                    self._map._handle, self._handle))
            self._handle = NULL
            self._map = None
        elif self._tree:
            with nogil:
                check_ret(spinCategoryReleaseNode(
                    self._tree._handle, self._handle))
            self._handle = NULL
            self._tree = None

    cdef void set_handle(self, NodeMap map, spinNodeHandle handle):
        self._handle = handle
        self._map = map

    cdef void set_handle_from_tree(self, SpinTreeNode tree, spinNodeHandle handle):
        self._handle = handle
        self._tree = tree

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

    cpdef is_implemented(self):
        """Checks whether the node is implemented.
        """
        cdef bool8_t n
        with nogil:
            check_ret(spinNodeIsImplemented(self._handle, &n))
        return bool(n)

    cpdef is_readable(self):
        """Checks whether the node is readable.
        """
        cdef bool8_t n
        with nogil:
            check_ret(spinNodeIsReadable(self._handle, &n))
        return bool(n)

    cpdef is_writable(self):
        """Checks whether the node is writable.
        """
        cdef bool8_t n
        with nogil:
            check_ret(spinNodeIsWritable(self._handle, &n))
        return bool(n)

    cpdef is_available(self):
        """Checks whether the node is available.
        """
        cdef bool8_t n
        with nogil:
            check_ret(spinNodeIsAvailable(self._handle, &n))
        return bool(n)

    cpdef is_equal(self, SpinBaseNode other):
        """Checks whether the node is equal to the other node.
        """
        cdef bool8_t n
        with nogil:
            check_ret(spinNodeIsEqual(self._handle, other._handle, &n))
        return bool(n)

    cpdef str get_access_mode(self):
        """Gets the access mode of the node as a string from
        :attr:`~rotpy.names.AccessMode_names`.
        """
        cdef spinAccessMode n
        with nogil:
            check_ret(spinNodeGetAccessMode(self._handle, &n))
        return AccessMode_values[n]

    cpdef str get_name(self):
        """Gets the name of the node (no whitespace).
        """
        cdef char msg[MAX_BUFF_LEN]
        cdef size_t n = MAX_BUFF_LEN
        with nogil:
            check_ret(spinNodeGetName(self._handle, msg, &n))
        return msg[:max(n - 1, 0)].decode()

    cpdef str get_namespace(self):
        """Gets the namespace of the node as a string from
        :attr:`~rotpy.names.NameSpace_names`.
        """
        cdef spinNameSpace n
        with nogil:
            check_ret(spinNodeGetNameSpace(self._handle, &n))
        return NameSpace_values[n]

    cpdef str get_visibility(self):
        """Gets the recommended visibility of the node as a string from
        :attr:`~rotpy.names.Visibility_names`.
        """
        cdef spinVisibility n
        with nogil:
            check_ret(spinNodeGetVisibility(self._handle, &n))
        return Visibility_values[n]

    cpdef invalidate(self):
        """Invalidates the node in case its values may have changed, rendering
        it no longer valid.
        """
        with nogil:
            check_ret(spinNodeInvalidateNode(self._handle))

    cpdef str get_caching_mode(self):
        """Gets the caching mode of the node as a string from
        :attr:`~rotpy.names.CachingMode_names`.
        """
        cdef spinCachingMode n
        with nogil:
            check_ret(spinNodeGetCachingMode(self._handle, &n))
        return CachingMode_values[n]

    cpdef str get_short_description(self):
        """Gets a short description of the node.
        """
        cdef char msg[MAX_BUFF_LEN]
        cdef size_t n = MAX_BUFF_LEN
        with nogil:
            check_ret(spinNodeGetToolTip(self._handle, msg, &n))
        return msg[:max(n - 1, 0)].decode()

    cpdef str get_description(self):
        """Gets a longer description of the node.
        """
        cdef char msg[MAX_BUFF_LEN]
        cdef size_t n = MAX_BUFF_LEN
        with nogil:
            check_ret(spinNodeGetDescription(self._handle, msg, &n))
        return msg[:max(n - 1, 0)].decode()

    cpdef str get_display_name(self):
        """Gets the display name of the node (whitespace possible).
        """
        cdef char msg[MAX_BUFF_LEN]
        cdef size_t n = MAX_BUFF_LEN
        with nogil:
            check_ret(spinNodeGetDisplayName(self._handle, msg, &n))
        return msg[:max(n - 1, 0)].decode()

    cpdef str get_node_type(self):
        """Gets the node type of the node as a string from
        :attr:`~rotpy.names.NodeType_names`.
        """
        cdef spinNodeType n
        with nogil:
            check_ret(spinNodeGetType(self._handle, &n))
        return NodeType_values[n]

    cpdef get_polling_time(self):
        """Gets the polling time of the node.
        """
        cdef int64_t n
        with nogil:
            check_ret(spinNodeGetPollingTime(self._handle, &n))
        return n

    cpdef str get_node_value_as_str(self, int verify=False):
        """Gets the value of the node, independent of the type, as a string.

        :param verify: Whether to verify the node.
        """
        cdef char msg[MAX_BUFF_LEN]
        cdef size_t n = MAX_BUFF_LEN
        with nogil:
            if verify:
                check_ret(spinNodeToStringEx(self._handle, 1, msg, &n))
            else:
                check_ret(spinNodeToString(self._handle, msg, &n))
        return msg[:max(n - 1, 0)].decode()

    cpdef set_node_value_from_str(self, str value, int verify=False):
        """Sets the value of the node, independent of the type, from a string.

        :param value: The value to which to set the node. It is important to
            ensure that the value of the string is appropriate to the node type.
        :param verify: Whether to verify the node.
        """
        cdef bytes value_b = value.encode()
        cdef const char* msg = value_b
        with nogil:
            if verify:
                check_ret(spinNodeFromStringEx(self._handle, 1, msg))
            else:
                check_ret(spinNodeFromString(self._handle, msg))


cdef class SpinIntNode(SpinBaseNode):

    cpdef int64_t get_node_value(self, int verify=False):
        """Gets the value of the node.

        :param verify: Whether to verify the node.
        """
        cdef int64_t n
        with nogil:
            if verify:
                check_ret(spinIntegerGetValueEx(self._handle, 1, &n))
            else:
                check_ret(spinIntegerGetValue(self._handle, &n))
        return n

    cpdef set_node_value(self, int64_t value, int verify=False):
        """Gets the value of the node.

        :param value: The value to which to set the node.
        :param verify: Whether to verify the node.
        """
        with nogil:
            if verify:
                check_ret(spinIntegerSetValueEx(self._handle, 1, value))
            else:
                check_ret(spinIntegerSetValue(self._handle, value))

    cpdef int64_t get_min_value(self):
        """Gets the minimum value of the node.
        """
        cdef int64_t n
        with nogil:
            check_ret(spinIntegerGetMin(self._handle, &n))
        return n

    cpdef int64_t get_max_value(self):
        """Gets the maximum value of the node.
        """
        cdef int64_t n
        with nogil:
            check_ret(spinIntegerGetMax(self._handle, &n))
        return n

    cpdef int64_t get_increment(self):
        """Gets the increment value of the node. All possible values must be
        divisible by this.
        """
        cdef int64_t n
        with nogil:
            check_ret(spinIntegerGetInc(self._handle, &n))
        return n

    cpdef str get_representation(self):
        """Gets the name of the representation that this node represents.
        E.g. linear, logarithmic, hexidecimal, MAC etc.

        It returns a name from :attr:`~rotpy.names.Representation_names`
        """
        cdef spinRepresentation n
        with nogil:
            check_ret(spinIntegerGetRepresentation(self._handle, &n))
        return Representation_values[n]


cdef class SpinFloatNode(SpinBaseNode):

    cpdef double get_node_value(self, int verify=False):
        """Gets the value of the node.

        :param verify: Whether to verify the node.
        """
        cdef double n
        with nogil:
            if verify:
                check_ret(spinFloatGetValueEx(self._handle, 1, &n))
            else:
                check_ret(spinFloatGetValue(self._handle, &n))
        return n

    cpdef set_node_value(self, double value, int verify=False):
        """Gets the value of the node.

        :param value: The value to which to set the node.
        :param verify: Whether to verify the node.
        """
        with nogil:
            if verify:
                check_ret(spinFloatSetValueEx(self._handle, 1, value))
            else:
                check_ret(spinFloatSetValue(self._handle, value))

    cpdef double get_min_value(self):
        """Gets the minimum value of the node.
        """
        cdef double n
        with nogil:
            check_ret(spinFloatGetMin(self._handle, &n))
        return n

    cpdef double get_max_value(self):
        """Gets the maximum value of the node.
        """
        cdef double n
        with nogil:
            check_ret(spinFloatGetMax(self._handle, &n))
        return n

    cpdef str get_representation(self):
        """Gets the name of the representation that this node represents.
        E.g. linear, logarithmic, hexidecimal, MAC etc.

        It returns a name from :attr:`~rotpy.names.Representation_names`
        """
        cdef spinRepresentation n
        with nogil:
            check_ret(spinFloatGetRepresentation(self._handle, &n))
        return Representation_values[n]

    cpdef str get_unit(self):
        """Gets the unit of the node value.
        """
        cdef char msg[MAX_BUFF_LEN]
        cdef size_t n = MAX_BUFF_LEN
        with nogil:
            check_ret(spinFloatGetUnit(self._handle, msg, &n))
        return msg[:max(n - 1, 0)].decode()


cdef class SpinBoolNode(SpinBaseNode):

    cpdef get_node_value(self):
        """Gets the value of the node.
        """
        cdef bool8_t n
        with nogil:
            check_ret(spinBooleanGetValue(self._handle, &n))
        return bool(n)

    cpdef set_node_value(self, bool8_t value):
        """Gets the value of the node.

        :param value: The value to which to set the node.
        """
        with nogil:
            check_ret(spinBooleanSetValue(self._handle, value))


cdef class SpinStrNode(SpinBaseNode):

    cpdef str get_node_value(self, int verify=False):
        """Gets the value of the node.

        :param verify: Whether to verify the node.
        """
        cdef char[:] arr
        cdef int64_t nn
        cdef size_t n
        with nogil:
            check_ret(spinStringGetMaxLength(self._handle, &nn))

        n = nn + 1
        buffer = array('b', b'\0' * n)
        arr = buffer

        with nogil:
            if verify:
                check_ret(spinStringGetValueEx(self._handle, 1, &arr[0], &n))
            else:
                check_ret(spinStringGetValue(self._handle, &arr[0], &n))
        return buffer.tobytes()[:max(n - 1, 0)].decode()

    cpdef set_node_value(self, str value, int verify=False):
        """Sets the value of the node.

        :param value: The value to which to set the node.
        :param verify: Whether to verify the node.
        """
        cdef bytes value_b = value.encode()
        cdef const char * msg = value_b
        with nogil:
            if verify:
                check_ret(spinStringSetValueEx(self._handle, 1, msg))
            else:
                check_ret(spinStringSetValue(self._handle, msg))


cdef class SpinCommandNode(SpinBaseNode):

    cpdef is_done(self):
        """Gets whether the action of node has finished executing.
        """
        cdef bool8_t n
        with nogil:
            check_ret(spinCommandIsDone(self._handle, &n))
        return bool(n)

    cpdef execute_node(self):
        """Executes the action associated with the node.
        """
        with nogil:
            check_ret(spinCommandExecute(self._handle))


cdef class SpinRegisterNode(SpinBaseNode):

    cpdef get_address(self):
        """Gets the address of the register node.
        """
        cdef int64_t n
        with nogil:
            check_ret(spinRegisterGetAddress(self._handle, &n))
        return n

    cpdef bytes get_node_value(
            self, int verify=False, int allow_cache=False):
        """Gets the register value of the node.

        :param verify: Whether to verify the node.
        :param allow_cache: Whether to allow getting the register value from
            cache.
        """
        cdef unsigned char[:] arr
        cdef int64_t n
        with nogil:
            check_ret(spinRegisterGetLength(self._handle, &n))

        buffer = array('B', b'\0' * n)
        arr = buffer

        with nogil:
            check_ret(spinRegisterGetEx(self._handle, verify, not allow_cache, &arr[0], n))
        return buffer.tobytes()

    cpdef set_node_value(self, object buffer, int verify=False):
        """Sets the value of the node.

        :param buffer: A array/bytes type buffer to which to set the node.
        :param verify: Whether to verify the node.
        """
        cdef int64_t n = len(buffer)
        cdef const unsigned char[:] buf = buffer
        with nogil:
            if verify:
                raise ValueError('verify is not currently supported')
                # TODO: fix
                # check_ret(spinRegisterSetEx(self._handle, 1, &buf[0], n))
            else:
                check_ret(spinRegisterSet(self._handle, &buf[0], n))

    cpdef set_ref(self, SpinBaseNode ref):
        """Uses a second ref node as a reference for the register node.

        :param ref: The other ref node to be used as a reference.
        """
        with nogil:
            check_ret(spinRegisterSetReference(self._handle, ref._handle))


cdef class SpinEnumClsNode(SpinBaseNode):

    cpdef get_items(self):
        """Returns a list of :class:`SpinEnumItemNode` instances that are
        items of this enum class.
        """
        cdef list items = []
        for i in range(self.get_num_items()):
            items.append(self.get_item_by_index(i))
        return items

    cpdef get_num_items(self):
        """Gets the number of items in the enum class.
        """
        cdef size_t n
        with nogil:
            check_ret(spinEnumerationGetNumEntries(self._handle, &n))
        return n

    cpdef SpinEnumItemNode get_item_by_index(self, size_t index):
        """Gets a enum item node from the enum class by index.

        :param index: The index of the node.
        :return: A :class:`SpinEnumItemNode` instance.
        """
        cdef SpinEnumItemNode node
        cdef spinNodeHandle handle

        with nogil:
            check_ret(spinEnumerationGetEntryByIndex(self._handle, index, &handle))

        node = SpinEnumItemNode()
        node.set_handle_from_cls(self, handle)

        return node

    cpdef SpinEnumItemNode get_item_by_name(self, str name):
        """Gets a enum item node from the enum class by name.

        :param name: The symbolic string name of the enum item.
        :return: A :class:`SpinEnumItemNode` instance.
        """
        cdef SpinEnumItemNode node
        cdef spinNodeHandle handle
        cdef bytes name_b = name.encode()
        cdef const char * name_c = name_b

        with nogil:
            check_ret(spinEnumerationGetEntryByName(self._handle, name_c, &handle))

        node = SpinEnumItemNode()
        node.set_handle_from_cls(self, handle)

        return node

    cpdef SpinEnumItemNode get_node_value(self):
        """Gets the enum item that the class is currently set to.

        :return: A :class:`SpinEnumItemNode` instance.
        """
        cdef SpinEnumItemNode node
        cdef spinNodeHandle handle

        with nogil:
            check_ret(spinEnumerationGetCurrentEntry(self._handle, &handle))

        node = SpinEnumItemNode()
        node.set_handle_from_cls(self, handle)

        return node

    cpdef set_node_value(self, SpinEnumItemNode item):
        """Sets the value of the enum class to this item.
        """
        cdef size_t n = item.get_node_enum_value()
        with nogil:
            check_ret(spinEnumerationSetEnumValue(self._handle, n))

    cpdef set_node_value_by_int(self, int64_t value):
        """Sets the value of the enum class to this int value.

        .. note::

            The enumeration item int and enum values are different - int values
            are defined on camera while the enum values defined in the Spinnaker
            API.
        """
        with nogil:
            check_ret(spinEnumerationSetIntValue(self._handle, value))

    cpdef set_node_value_by_enum(self, size_t value):
        """Sets the value of the enum class to this enum value.

        .. note::

            The enumeration item int and enum values are different - int values
            are defined on camera while the enum values defined in the Spinnaker
            API.
        """
        with nogil:
            check_ret(spinEnumerationSetEnumValue(self._handle, value))


cdef class SpinEnumItemNode(SpinBaseNode):

    def __cinit__(self):
        self._enum_cls = None

    def __dealloc__(self):
        if self._enum_cls is not None:
            with nogil:
                check_ret(spinEnumerationReleaseNode(
                    self._enum_cls._handle, self._handle))
            self._handle = NULL
            self._enum_cls = None

    cdef void set_handle_from_cls(self, SpinEnumClsNode cls, spinNodeHandle handle):
        self._handle = handle
        self._enum_cls = cls

    cpdef get_node_int_value(self):
        """Gets the integer value of the enum item node.

        .. note::

            The enumeration item int and enum values are different - int values
            are defined on camera while the enum values defined in the Spinnaker
            API.
        """
        cdef int64_t n
        with nogil:
            check_ret(spinEnumerationEntryGetIntValue(self._handle, &n))
        return n

    cpdef get_node_enum_value(self):
        """Gets the enum int value of the enum item node.

        .. note::

            The enumeration item int and enum values are different - int values
            are defined on camera while the enum values defined in the Spinnaker
            API.
        """
        cdef size_t n
        with nogil:
            check_ret(spinEnumerationEntryGetEnumValue(self._handle, &n))
        return n

    cpdef str get_node_str_value(self):
        """Gets the string symbolic representation of the value of the enum
        item node.
        """
        cdef char msg[MAX_BUFF_LEN]
        cdef size_t n = MAX_BUFF_LEN
        with nogil:
            check_ret(spinEnumerationEntryGetSymbolic(self._handle, msg, &n))
        return msg[:max(n - 1, 0)].decode()


cdef class SpinTreeNode(SpinBaseNode):

    cpdef get_children(self):
        """Returns a list of immediate children nodes of the tree.

        I.e. it only returns direct children of the tree. If the children have
        children it is not recursed.
        """
        cdef list items = []
        for i in range(self.get_num_nodes()):
            items.append(self.get_node_by_index(i))
        return items

    cpdef get_num_nodes(self):
        """Gets the number of nodes in the tree.
        """
        cdef size_t n
        with nogil:
            check_ret(spinCategoryGetNumFeatures(self._handle, &n))
        return n

    cpdef get_node_by_index(self, size_t index):
        """Gets a node from the tree by index.

        :param index: The index of the node.
        :return: A :class:`Node` derived instance.
        """
        cdef spinNodeType node_type
        cdef spinNodeHandle handle
        cdef SpinBaseNode node_base

        with nogil:
            check_ret(spinCategoryGetFeatureByIndex(self._handle, index, &handle))
            check_ret(spinNodeGetType(handle, &node_type))

        node = node_cls_map.get(node_type, SpinBaseNode)()
        node_base = node
        node_base.set_handle_from_tree(self, handle)

        return node


"""
These are unimplemented functions from the API:

/**
 * Registers a callback to a node
 * @see spinError
 *
 * @param hNode The node on which to register the callback
 * @param pCbFunction The function pointer of the function that will execute when the callback is triggered; must
 * match signature "void spinNodeCallbackFunction(spinNodeHandle hNode)"
 * @param phCb The callback handle pointer in which the callback is returned; used to unregister callbacks
 *
 * @return spinError The error code; returns SPINNAKER_ERR_SUCCESS (or 0) for no error
 */
SPINNAKERC_API spinNodeRegisterCallback(
    spinNodeHandle hNode,
    spinNodeCallbackFunction pCbFunction,
    spinNodeCallbackHandle* phCb);

/**
 * Unregisters a callback from a node
 * @see spinError
 *
 * @param hNode The node from which to unregister the callback
 * @param hCb The callback handle to unregister
 *
 * @return spinError The error code; returns SPINNAKER_ERR_SUCCESS (or 0) for no error
 */
SPINNAKERC_API spinNodeDeregisterCallback(spinNodeHandle hNode, spinNodeCallbackHandle hCb);

/**
 * Retrieves the imposed access mode of a node
 * @see spinError
 *
 * @param hNode The node of the imposed access mode to retrieve
 * @param imposedAccessMode The access mode enum pointer in which the imposed access mode is returned
 *
 * @return spinError The error code; returns SPINNAKER_ERR_SUCCESS (or 0) for no error
 */
SPINNAKERC_API spinNodeGetImposedAccessMode(spinNodeHandle hNode, spinAccessMode imposedAccessMode);

/**
 * Retrieves the imposed visibility of a node
 * @see spinError
 *
 * @param hNode The node of the visibility to impose
 * @param imposedVisibility The visibility enum pointer in which the imposed visibility is returned
 *
 * @return spinError The error code; returns SPINNAKER_ERR_SUCCESS (or 0) for no error
 */
SPINNAKERC_API spinNodeGetImposedVisibility(spinNodeHandle hNode, spinVisibility imposedVisibility);
/*@}*/
"""
