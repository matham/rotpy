from .names import NodeType_values, AccessMode_names, AccessMode_values, \
    NameSpace_names, NameSpace_values, Visibility_names, Visibility_values, \
    CachingMode_names, CachingMode_values
cimport cpython.array

from array import array

DEF MAX_BUFF_LEN = 256


cdef class NodeMap:
    """Provides access to nodes of a camera or system.

    TODO: Set all handles by default to NULL and doc which classes cannot be
    manually created.
    """

    def __cinit__(self):
        self._handle = NULL

    def __init__(self):
        self.node_cls_map = {
            NodeType_values['IntegerNode']: SpinIntNode,
            NodeType_values['BooleanNode']: SpinBoolNode,
            NodeType_values['FloatNode']: SpinFloatNode,
            NodeType_values['CommandNode']: SpinCommandNode,
            NodeType_values['StringNode']: SpinStrNode,
            NodeType_values['RegisterNode']: SpinRegisterNode,
            NodeType_values['EnumerationNode']: SpinEnumClsNode,
            NodeType_values['EnumEntryNode']: SpinEnumItemNode,
            NodeType_values['CategoryNode']: SpinCategoryNode,
            NodeType_values['PortNode']: SpinPortNode,
        }

    cdef void set_handle(self, spinNodeMapHandle handle):
        self._handle = handle

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

        node = self.node_cls_map[node_type]()
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

        node = self.node_cls_map[node_type]()
        node_base = node
        node_base.set_handle(self, handle)

        return node



cdef class SpinBaseNode:

    def __cinit__(self):
        self._handle = NULL
        self._map = None

    def __dealloc__(self):
        if self._map is not None:
            with nogil:
                check_ret(spinNodeMapReleaseNode(
                    self._map._handle, self._handle))
            self._handle = NULL
            self._map = None

    cdef void set_handle(self, NodeMap map, spinNodeHandle handle):
        self._handle = handle
        self._map = map

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

    cpdef str get_node_value_as_str(self, int verify):
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

    cpdef set_node_value_from_str(self, str value, int verify):
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
    pass


cdef class SpinFloatNode(SpinBaseNode):
    pass


cdef class SpinBoolNode(SpinBaseNode):
    pass


cdef class SpinStrNode(SpinBaseNode):

    cpdef str get_node_value(self, int verify):
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

    cpdef set_node_value(self, str value, int verify):
        """Gets the value of the node.

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
