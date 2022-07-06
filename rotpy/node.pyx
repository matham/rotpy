"""Node
=======

Spinnaker uses `GenICam <https://en.wikipedia.org/wiki/GenICam>`_ to declare and
make available the system and camera properties as well-defined nodes with a
clear API.

Each node represents a camera or system property, and they
can be e.g. a :class:`SpinIntNode`, :class:`SpinFloatNode`,
:class:`SpinBoolNode`, :class:`SpinStrNode`, :class:`SpinCommandNode` etc. E.g.
a :class:`SpinIntNode` supports getting and setting a value, getting
the optionally allowed increments, and getting the unit etc.

All nodes inherit from :class:`SpinBaseNode`, but some nodes have additional
inheritance adding more functionality. E.g. :class:`SpinIntNode` inherits from
:class:`SpinSelectorNode`, :class:`SpinNode`, and :class:`SpinValueNode`.

Node access
^^^^^^^^^^^

There are two approaches to getting access to the nodes: using the pre-listed
nodes or getting it by name/index from a :class:`NodeMap`.

You can get the pre-listed nodes for the system, interface, and camera from
:attr:`~rotpy.system.SpinSystem.system_nodes`,
:attr:`~rotpy.system.InterfaceDevice.interface_nodes`,
:attr:`~rotpy.camera.Camera.camera_nodes`,
:attr:`~rotpy.camera.Camera.tl_dev_nodes`, and
:attr:`~rotpy.camera.Camera.tl_stream_nodes`, respectively.

To use a :class:`NodeMap`, you first have to get an instance and then
look up a node by name. Like the pre-listed nodes, you can get the node map
for the system, interface, and camera from
:meth:`~rotpy.system.SpinSystem.get_tl_node_map`,
:meth:`~rotpy.system.InterfaceDevice.get_tl_node_map`,
:meth:`~rotpy.camera.Camera.get_node_map`,
:meth:`~rotpy.camera.Camera.get_tl_dev_node_map`, and
:meth:`~rotpy.camera.Camera.get_tl_stream_node_map`, respectively.

Pre-listed nodes operate identically as getting the node from a
:class:`NodeMap`, except it provides these nodes as named properties with the
same name as the node.

E.g. to select whether the system enumerates USB devices, you have to get the
node that controls this property and then set its value. Using the pre-listed
approach on :attr:`~rotpy.system_nodes.SystemNodes.EnumerateUSBInterfaces`
you'd do:

.. code-block:: python

    >>> from rotpy.system import SpinSystem
    >>> system = SpinSystem()
    >>> system.system_nodes.EnumerateUSBInterfaces
    <rotpy.node.SpinBoolNode at 0x26822c20d68>
    >>> # first make sure this node is actually available for this system
    >>> system.system_nodes.EnumerateUSBInterfaces.is_available()
    True
    >>> system.system_nodes.EnumerateUSBInterfaces.get_node_value()
    True
    >>> system.system_nodes.EnumerateUSBInterfaces.set_node_value(False)

Similarly, using a :class:`NodeMap` from
:meth:`~rotpy.system.SpinSystem.get_tl_node_map` you'd do:

.. code-block:: python

    >>> from rotpy.system import SpinSystem
    >>> system = SpinSystem()
    >>> node_map = system.get_tl_node_map()
    >>> node = node_map.get_node_by_name('EnumerateUSBInterfaces')
    >>> node is not None and node.is_available()
    True
    >>> node.get_node_value()
    True
    >>> node.set_node_value(False)

You can use these approaches interchangeably and on the same system.

.. warning::

    Remember to always check whether the node is available and
    readable/writeable as needed. Even pre-listed nodes need to be checked,
    and being pre-listed does not mean they are implemented for the specific
    system/camera.
"""
from .names.geni import InterfaceType_names, InterfaceType_values,\
    AccessMode_names, AccessMode_values, NameSpace_values, Visibility_names, \
    Visibility_values, CachingMode_names, CachingMode_values, \
    Representation_values, YesNo_values, IncMode_values, DisplayNotation_values
from array import array

cimport cpython.array

__all__ = (
    'NodeMap', 'SpinBaseNode', 'SpinSelectorNode', 'SpinNode', 'SpinValueNode',
    'SpinIntNode', 'SpinFloatNode', 'SpinBoolNode', 'SpinStrNode',
    'SpinCommandNode', 'SpinRegisterNode', 'SpinEnumNode', 'SpinEnumDefNode',
    'SpinEnumItemNode', 'SpinTreeNode', 'SpinPortNode',
)


ctypedef fused NodeBases:
    SpinBaseNode
    SpinValueNode
    SpinIntNode
    SpinFloatNode
    SpinBoolNode
    SpinStrNode
    SpinCommandNode
    SpinRegisterNode
    SpinEnumNode
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
        return _node_inst[SpinEnumNode](SpinEnumNode(), obj, handle)
    elif node_type == intfIEnumEntry:
        return _node_inst[SpinEnumItemNode](SpinEnumItemNode(), obj, handle)
    elif node_type == intfIPort:
        return _node_inst[SpinPortNode](SpinPortNode(), obj, handle)


cdef class NodeMap:
    """Provides access to nodes of a camera or system.

    See :mod:`~rotpy.node` for details.
    """

    def __cinit__(self):
        self._handle = NULL

    cdef void set_handle(self, INodeMap* handle):
        self._handle = handle

    cpdef get_nodes(self):
        """Returns a list of all the nodes in the map.

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
        """
        with nogil:
            self._handle.Poll(elapsed)

    cpdef get_node_by_name(self, str name):
        """Gets a node from the node map by name.

        :param name: The string name of the node.
        :return: A :class:`SpinBaseNode` derived instance or None if there
            isn't one with that name.
        """
        cdef bytes name_b = name.encode()
        cdef const char * name_c = name_b
        cdef size_t n = len(name_b)
        cdef gcstring s
        cdef INode* handle

        with nogil:
            s.assign(name_c, n)
            handle = self._handle.GetNode(s)

        if handle == NULL:
            return None
        return create_node_inst(self, handle)

    cpdef get_node_by_index(self, size_t index):
        """Gets a node from the node map using a zero-based index that is less
        than :meth:`get_num_nodes`.

        :param index: The index of the node.
        :return: A :class:`SpinBaseNode` derived instance.
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

    cpdef connect_port(self, SpinPortNode node, str name=''):
        """Connects a port to another port.

        :param node: The :class:`SpinPortNode` node to connect.
        :param name: The name of the node to connect to. If not specified (the
            default), it connects to the standard port "Device".
        :return: bool, whether it connected.
        """
        cdef bytes name_b = name.encode()
        cdef size_t n = len(name)
        cdef const char * name_c = name_b
        cdef gcstring name_s
        cdef cbool res

        with nogil:
            if n:
                name_s.assign(name_c, n)
                res = self._handle.Connect(node._handle, name_s)
            else:
                res = self._handle.Connect(node._handle)

        return bool(res)


cdef class SpinBaseNode:
    """The base node class that provides functionality for checking the state
    of the node.
    """

    def __cinit__(self):
        self._base_handle = NULL
        self._handle_src = None

    cdef void set_handle(self, object source, IBase* handle) except *:
        self._base_handle = handle
        self._handle_src = source

    cdef clear_handle(self):
        self._base_handle = NULL
        self._handle_src = None

    cpdef get_access_mode(self):
        """Gets the access mode of the node as a string from
        :attr:`~rotpy.names.geni.AccessMode_names`.
        """
        if self._base_handle == NULL:
            raise TypeError('Invalid node')
        cdef EAccessMode n
        with nogil:
            n = self._base_handle.GetAccessMode()
        return AccessMode_values[n]

    cpdef is_readable(self):
        """Returns whether the node is readable (i.e. RW or RO).
        """
        if self._base_handle == NULL:
            raise TypeError('Invalid node')
        cdef EAccessMode n
        with nogil:
            n = self._base_handle.GetAccessMode()
        return RO == n or RW == n

    cpdef is_writable(self):
        """Returns whether the node is writable (i.e. RW or WO).
        """
        if self._base_handle == NULL:
            raise TypeError('Invalid node')
        cdef EAccessMode n
        with nogil:
            n = self._base_handle.GetAccessMode()
        return WO == n or RW == n

    cpdef is_implemented(self):
        """Returns whether the node is implemented (i.e. not NI).
        """
        if self._base_handle == NULL:
            raise TypeError('Invalid node')
        cdef EAccessMode n
        with nogil:
            n = self._base_handle.GetAccessMode()
        return NI != n

    cpdef is_available(self):
        """Returns whether the node is available (i.e. it's implemented and
        available - not NI and not NA).
        """
        if self._base_handle == NULL:
            raise TypeError('Invalid node')
        cdef EAccessMode n
        with nogil:
            n = self._base_handle.GetAccessMode()
        return not (n == NA or n == NI)

    cpdef is_visible(self, str visibility, str max_visibility):
        """Returns whether the visibility level is less than or equal than the
         maximum visibility according to the visibility levels of
         :attr:`~rotpy.names.geni.Visibility_names`.
        """
        return Visibility_names[visibility] <= Visibility_names[max_visibility]


cdef class SpinSelectorNode(SpinBaseNode):
    """Provides selection functionality to the node, if the node can be used
    to select other nodes (e.g. as a category) or if it's selectable by another
    node.
    """

    def __cinit__(self):
        self._sel_handle = NULL

    cdef void set_handle(self, object source, IBase* handle) except *:
        SpinBaseNode.set_handle(self, source, handle)
        self._sel_handle = dynamic_cast[ISelectorPointer](handle)

    cdef clear_handle(self):
        SpinBaseNode.clear_handle(self)
        self._sel_handle = NULL

    cpdef is_selector(self):
        """Returns whether this feature selects a group of features.
        """
        if self._sel_handle == NULL:
            raise TypeError('Invalid node')
        cdef cbool n
        with nogil:
            n = self._sel_handle.IsSelector()
        return bool(n)

    cpdef get_selected_nodes(self):
        """Returns a list of newly created node instances selected by this node.
        """
        if self._sel_handle == NULL:
            raise TypeError('Invalid node')
        cdef uint64_t n, i
        cdef list items = []
        cdef FeatureList_t nodes

        with nogil:
            self._sel_handle.GetSelectedFeatures(nodes)
            n = nodes.size()

        for i in range(n):
            items.append(
                create_node_inst(
                    self, dynamic_cast[INodePointer]((&nodes.at(i))[0])))

        return items

    cpdef get_selecting_nodes(self):
        """Returns a list of newly created node instances that select this node.
        """
        if self._sel_handle == NULL:
            raise TypeError('Invalid node')
        cdef uint64_t n, i
        cdef list items = []
        cdef FeatureList_t nodes

        with nogil:
            self._sel_handle.GetSelectingFeatures(nodes)
            n = nodes.size()

        for i in range(n):
            items.append(
                create_node_inst(
                    self, dynamic_cast[INodePointer]((&nodes.at(i))[0])))

        return items


cdef class SpinNode(SpinSelectorNode):
    """Provides basic node functionality for nodes that have additional
    functionality such as values etc.
    """

    def __cinit__(self):
        self._node_handle = NULL

    cdef void set_handle(self, object source, IBase* handle) except *:
        SpinSelectorNode.set_handle(self, source, handle)
        self._node_handle = dynamic_cast[INodePointer](handle)

    cdef clear_handle(self):
        SpinSelectorNode.clear_handle(self)
        self._node_handle = NULL

    cpdef dict get_metadata(self):
        """Returns a dict of metadata of the node.

        The items are the various info on the node as accessible from the node's
        methods (e.g. whether it's readable etc.).
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
        return d

    cpdef is_cachable(self):
        """Checks whether the node value is cacheable.
        """
        if self._node_handle == NULL:
            raise TypeError('Invalid node')
        cdef cbool n
        with nogil:
            n = self._node_handle.IsCachable()
        return bool(n)

    cpdef is_access_cachable(self):
        """Gets whether the AccessMode can be cached, as a string from
        :attr:`~rotpy.names.geni.YesNo_names`.
        """
        if self._node_handle == NULL:
            raise TypeError('Invalid node')
        cdef EYesNo n
        with nogil:
            n = self._node_handle.IsAccessModeCacheable()
        return YesNo_values[n]

    cpdef is_streamable(self):
        """Checks whether the node value is streamable.
        """
        if self._node_handle == NULL:
            raise TypeError('Invalid node')
        cdef cbool n
        with nogil:
            n = self._node_handle.IsStreamable()
        return bool(n)

    cpdef is_deprecated(self):
        """Checks whether the node should not be used any more.
        """
        if self._node_handle == NULL:
            raise TypeError('Invalid node')
        cdef cbool n
        with nogil:
            n = self._node_handle.IsDeprecated()
        return bool(n)

    cpdef is_feature(self):
        """Checks whether the node can be reached via category nodes from a
        category node named "Root".
        """
        if self._node_handle == NULL:
            raise TypeError('Invalid node')
        cdef cbool n
        with nogil:
            n = self._node_handle.IsFeature()
        return bool(n)

    cpdef get_dev_name(self):
        """Gets the name of the device.
        """
        if self._node_handle == NULL:
            raise TypeError('Invalid node')
        cdef gcstring s
        with nogil:
            s = self._node_handle.GetDeviceName()
        return s.c_str().decode()

    cpdef get_event_id(self):
        """Gets the event ID of the node.
        """
        if self._node_handle == NULL:
            raise TypeError('Invalid node')
        cdef gcstring s
        with nogil:
            s = self._node_handle.GetEventID()
        return s.c_str().decode()

    cpdef get_name(self, cbool fully_qualified=False):
        """Gets the name of the node (no whitespace).

        Optionally fully qualified
        """
        if self._node_handle == NULL:
            raise TypeError('Invalid node')
        cdef gcstring s
        with nogil:
            s = self._node_handle.GetName(fully_qualified)
        return s.c_str().decode()

    cpdef get_namespace(self):
        """Gets the namespace of the node as a string from
        :attr:`~rotpy.names.geni.NameSpace_names`.
        """
        if self._node_handle == NULL:
            raise TypeError('Invalid node')
        cdef ENameSpace n
        with nogil:
            n = self._node_handle.GetNameSpace()
        return NameSpace_values[n]

    cpdef get_visibility(self):
        """Gets the recommended visibility of the node as a string from
        :attr:`~rotpy.names.geni.Visibility_names`.
        """
        if self._node_handle == NULL:
            raise TypeError('Invalid node')
        cdef EVisibility n
        with nogil:
            n = self._node_handle.GetVisibility()
        return Visibility_values[n]

    cpdef invalidate(self):
        """Indicates that the node's value may have changed.

        Fires the callback on this and all dependent nodes
        """
        if self._node_handle == NULL:
            raise TypeError('Invalid node')
        with nogil:
            self._node_handle.InvalidateNode()

    cpdef get_caching_mode(self):
        """Gets the caching mode of the node as a string from
        :attr:`~rotpy.names.geni.CachingMode_names`.
        """
        if self._node_handle == NULL:
            raise TypeError('Invalid node')
        cdef ECachingMode n
        with nogil:
            n = self._node_handle.GetCachingMode()
        return CachingMode_values[n]

    cpdef get_short_description(self):
        """Gets a short description of the node.
        """
        if self._node_handle == NULL:
            raise TypeError('Invalid node')
        cdef gcstring s
        with nogil:
            s = self._node_handle.GetToolTip()
        return s.c_str().decode()

    cpdef get_description(self):
        """Gets a longer description of the node.
        """
        if self._node_handle == NULL:
            raise TypeError('Invalid node')
        cdef gcstring s
        with nogil:
            s = self._node_handle.GetDescription()
        return s.c_str().decode()

    cpdef get_display_name(self):
        """Gets the display name of the node (whitespace possible).
        """
        if self._node_handle == NULL:
            raise TypeError('Invalid node')
        cdef gcstring s
        with nogil:
            s = self._node_handle.GetDisplayName()
        return s.c_str().decode()

    cpdef get_doc_url(self):
        """Gets a URL pointing to the documentation of that feature.
        """
        if self._node_handle == NULL:
            raise TypeError('Invalid node')
        cdef gcstring s
        with nogil:
            s = self._node_handle.GetDocuURL()
        return s.c_str().decode()

    cpdef get_property_names(self):
        """Returns a list of the names of all properties set during
        initialization.
        """
        if self._node_handle == NULL:
            raise TypeError('Invalid node')
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
        """
        if self._node_handle == NULL:
            raise TypeError('Invalid node')
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
        :attr:`~rotpy.names.geni.InterfaceType_values`.
        """
        if self._node_handle == NULL:
            raise TypeError('Invalid node')
        cdef EInterfaceType n
        with nogil:
            n = self._node_handle.GetPrincipalInterfaceType()
        return InterfaceType_values[n]

    cpdef get_polling_time(self):
        """Gets recommended polling time (for non-cacheable nodes).
        """
        if self._node_handle == NULL:
            raise TypeError('Invalid node')
        cdef int64_t n
        with nogil:
            n = self._node_handle.GetPollingTime()
        return n

    cpdef set_access_mode(self, str mode):
        """Imposes an access mode to the natural access mode of the node.

        ``mode`` is s string from :attr:`~rotpy.names.geni.AccessMode_names`.
        """
        if self._node_handle == NULL:
            raise TypeError('Invalid node')
        cdef EAccessMode n = AccessMode_names[mode]

        with nogil:
            self._node_handle.ImposeAccessMode(n)

    cpdef set_visibility(self, str visibility):
        """Imposes a visibility to the natural visibility of the node.

        ``mode`` is s string from :attr:`~rotpy.names.geni.Visibility_names`.
        """
        if self._node_handle == NULL:
            raise TypeError('Invalid node')
        cdef EVisibility n = Visibility_names[visibility]

        with nogil:
            self._node_handle.ImposeVisibility(n)

    cpdef get_alias_node(self):
        """Gets a alias node which describes the same feature in a different
        way.

        :return: A :class:`SpinBaseNode` derived instance or None if there isn't
            one.
        """
        if self._node_handle == NULL:
            raise TypeError('Invalid node')
        cdef INode* handle
        with nogil:
            handle = self._node_handle.GetAlias()

        if handle == NULL:
            return None
        return create_node_inst(self, handle)

    cpdef get_cast_alias_node(self):
        """Gets a alias node which describes the same feature so that it can be
        casted.

        :return: A :class:`SpinBaseNode` derived instance or None if there isn't
            one.
        """
        if self._node_handle == NULL:
            raise TypeError('Invalid node')
        cdef INode* handle
        with nogil:
            handle = self._node_handle.GetCastAlias()

        if handle == NULL:
            return None
        return create_node_inst(self, handle)

    cpdef set_ref(self, SpinNode node):
        """Sets the implementation to a reference node.
        """
        if self._node_handle == NULL:
            raise TypeError('Invalid node')
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
    """A node that represents a value e.g. a string, an integer etc.
    """

    def __cinit__(self):
        self._value_handle = NULL

    cdef void set_handle(self, object source, IBase* handle) except *:
        SpinNode.set_handle(self, source, handle)
        self._value_handle = dynamic_cast[IValuePointer](handle)

    cdef clear_handle(self):
        SpinNode.clear_handle(self)
        self._value_handle = NULL

    cpdef get_node_value_as_str(
            self, cbool verify=False, cbool ignore_cache=False):
        """Gets the value of the node, independent of the type, as a string.

        :param verify: Whether to verify the Range verification. The access mode
            is always checked.
        :param ignore_cache: If true the value is read ignoring any caches.
        :returns: A string representing the node's value.
        """
        if self._value_handle == NULL:
            raise TypeError('Invalid node')
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
        if self._value_handle == NULL:
            raise TypeError('Invalid node')
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
        if self._value_handle == NULL:
            raise TypeError('Invalid node')
        cdef cbool n
        with nogil:
            n = self._value_handle.IsValueCacheValid()
        return bool(n)


cdef class SpinIntNode(SpinValueNode):
    """Node that represents an integer.
    """

    def __cinit__(self):
        self._handle = NULL

    cdef void set_handle(self, object source, IBase* handle) except *:
        SpinValueNode.set_handle(self, source, handle)
        self._handle = dynamic_cast[IIntegerPointer](handle)

    cdef clear_handle(self):
        SpinValueNode.clear_handle(self)
        self._handle = NULL

    cpdef get_node_value(self, cbool verify=False, cbool ignore_cache=False):
        """Gets the value of the node.

        :param verify: Enables Range verification. The access mode is always
            checked.
        :param ignore_cache: If true the value is read ignoring any caches.
        :returns: The node's integer value.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef int64_t n
        with nogil:
            n = self._handle.GetValue(verify, ignore_cache)
        return n

    cpdef set_node_value(self, int64_t value, cbool verify=True):
        """Sets the value of the node.

        :param value: The value to which to set the node.
        :param verify: Enables access mode and range verification.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        with nogil:
            self._handle.SetValue(value, verify)

    cpdef get_min_value(self):
        """Gets the minimum allowed value of the node.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef int64_t n
        with nogil:
            n = self._handle.GetMin()
        return n

    cpdef get_max_value(self):
        """Gets the maximum allowed value of the node.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef int64_t n
        with nogil:
            n = self._handle.GetMax()
        return n

    cpdef set_min_value(self, int64_t value):
        """Sets the minimum allowed value of the node.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        with nogil:
            self._handle.ImposeMin(value)

    cpdef set_max_value(self, int64_t value):
        """Sets the maximum allowed value of the node.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        with nogil:
            self._handle.ImposeMax(value)

    cpdef get_increment_mode(self):
        """Gets the increment mode string of the node as listed in
        :attr:`~rotpy.names.geni.IncMode_names.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef EIncMode n
        with nogil:
            n = self._handle.GetIncMode()
        return IncMode_values[n]

    cpdef get_increment(self):
        """Gets the increment value of the node. All possible values must be
        divisible by this.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef int64_t n
        with nogil:
            n = self._handle.GetInc()
        return n

    cpdef get_valid_values(self, cbool bounded=True):
        """Gets list of valid values.

        :param bounded: Whether to bound the values.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
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

        It returns a name from :attr:`~rotpy.names.geni.Representation_names`
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef ERepresentation n
        with nogil:
            n = self._handle.GetRepresentation()
        return Representation_values[n]

    cpdef get_unit(self):
        """Gets the physical unit name as a string.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef gcstring s
        with nogil:
            s = self._handle.GetUnit()
        return s.c_str().decode()


cdef class SpinFloatNode(SpinValueNode):
    """Node that represents a floating point number.
    """

    def __cinit__(self):
        self._handle = NULL

    cdef void set_handle(self, object source, IBase* handle) except *:
        SpinValueNode.set_handle(self, source, handle)
        self._handle = dynamic_cast[IFloatPointer](handle)

    cdef clear_handle(self):
        SpinValueNode.clear_handle(self)
        self._handle = NULL

    cpdef get_node_value(self, cbool verify=False, cbool ignore_cache=False):
        """Gets the value of the node as a float.

        :param verify: Enables Range verification. The access mode is always
            checked.
        :param ignore_cache: If true the value is read ignoring any caches.
        :returns: The node's floating point value.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef double n
        with nogil:
            n = self._handle.GetValue(verify, ignore_cache)
        return n

    cpdef set_node_value(self, double value, cbool verify=True):
        """Sets the value of the node.

        :param value: The value to which to set the node.
        :param verify: Enables access mode and range verification.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        with nogil:
            self._handle.SetValue(value, verify)

    cpdef get_min_value(self):
        """Gets the minimum allowed value of the node.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef double n
        with nogil:
            n = self._handle.GetMin()
        return n

    cpdef get_max_value(self):
        """Gets the maximum allowed value of the node.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef double n
        with nogil:
            n = self._handle.GetMax()
        return n

    cpdef set_min_value(self, double value):
        """Sets the minimum allowed value of the node.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        with nogil:
            self._handle.ImposeMin(value)

    cpdef set_max_value(self, double value):
        """Sets the maximum allowed value of the node.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        with nogil:
            self._handle.ImposeMax(value)

    cpdef has_increment(self):
        """Gets whether the float has a constant increment.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef cbool n
        with nogil:
            n = self._handle.HasInc()
        return bool(n)

    cpdef get_increment_mode(self):
        """Gets the increment mode string of the node as listed in
        :attr:`~rotpy.names.geni.IncMode_names.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef EIncMode n
        with nogil:
            n = self._handle.GetIncMode()
        return IncMode_values[n]

    cpdef get_increment(self):
        """Gets the increment value of the node. All possible values must be
        divisible by this.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef double n
        with nogil:
            n = self._handle.GetInc()
        return n

    cpdef get_valid_values(self, cbool bounded=True):
        """Gets list of valid values.

        :param bounded: Whether to bound the values.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
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

        It returns a name from :attr:`~rotpy.names.geni.Representation_names`
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef ERepresentation n
        with nogil:
            n = self._handle.GetRepresentation()
        return Representation_values[n]

    cpdef get_unit(self):
        """Gets the physical unit name as a string.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef gcstring s
        with nogil:
            s = self._handle.GetUnit()
        return s.c_str().decode()

    cpdef get_display_notation(self):
        """Gets the way the float should be converted to a string.

        It returns a name from :attr:`~rotpy.names.geni.DisplayNotation_names`
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef EDisplayNotation n
        with nogil:
            n = self._handle.GetDisplayNotation()
        return DisplayNotation_values[n]

    cpdef get_display_precision(self):
        """Gets the precision to be used when converting the float to a string.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef int64_t n
        with nogil:
            n = self._handle.GetDisplayPrecision()
        return n


cdef class SpinBoolNode(SpinValueNode):
    """Node that represents boolean.
    """

    def __cinit__(self):
        self._handle = NULL

    cdef void set_handle(self, object source, IBase* handle) except *:
        SpinValueNode.set_handle(self, source, handle)
        self._handle = dynamic_cast[IBooleanPointer](handle)

    cdef clear_handle(self):
        SpinValueNode.clear_handle(self)
        self._handle = NULL

    cpdef get_node_value(self, cbool verify=False, cbool ignore_cache=False):
        """Gets the value of the node as a bool.

        :param verify: Enables Range verification. The access mode is always
            checked.
        :param ignore_cache: If true the value is read ignoring any caches.
        :returns: The node's boolean value.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef cbool n
        with nogil:
            n = self._handle.GetValue(verify, ignore_cache)
        return bool(n)

    cpdef set_node_value(self, cbool value, cbool verify=True):
        """Sets the value of the node.

        :param value: The value to which to set the node.
        :param verify: Enables access mode and range verification.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        with nogil:
            self._handle.SetValue(value, verify)


cdef class SpinStrNode(SpinValueNode):
    """Node that represents a string.
    """

    def __cinit__(self):
        self._handle = NULL

    cdef void set_handle(self, object source, IBase* handle) except *:
        SpinValueNode.set_handle(self, source, handle)
        self._handle = dynamic_cast[IStringPointer](handle)

    cdef clear_handle(self):
        SpinValueNode.clear_handle(self)
        self._handle = NULL

    cpdef get_node_value(self, cbool verify=False, cbool ignore_cache=False):
        """Gets the value of the node as a string.

        :param verify: Enables Range verification. The access mode is always
            checked.
        :param ignore_cache: If true the value is read ignoring any caches.
        :returns: The node's string value.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef gcstring s
        with nogil:
            s = self._handle.GetValue(verify, ignore_cache)
        return s.c_str().decode()

    cpdef set_node_value(self, str value, cbool verify=True):
        """Sets the value of the node.

        :param value: The value to which to set the node.
        :param verify: Enables access mode and range verification.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef bytes value_b = value.encode()
        cdef const char * value_c = value_b
        cdef size_t n = len(value_b)
        cdef gcstring s

        with nogil:
            s.assign(value_c, n)
            self._handle.SetValue(s, verify)

    cpdef get_max_len(self):
        """Gets the maximum length of the node's string in bytes.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef int64_t n
        with nogil:
            n = self._handle.GetMaxLength()
        return n


cdef class SpinCommandNode(SpinValueNode):
    """Node that represents a command to be executed.
    """

    def __cinit__(self):
        self._handle = NULL

    cdef void set_handle(self, object source, IBase* handle) except *:
        SpinValueNode.set_handle(self, source, handle)
        self._handle = dynamic_cast[ICommandPointer](handle)

    cdef clear_handle(self):
        SpinValueNode.clear_handle(self)
        self._handle = NULL

    cpdef is_done(self, cbool verify=True):
        """Gets whether the command is executed.

        :param verify: Enables Range verification. The access mode is always
            checked.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef cbool n
        with nogil:
            n = self._handle.IsDone(verify)
        return bool(n)

    cpdef execute_node(self, cbool verify=True):
        """Execute the command.

        :param verify: Enables access mode and range verification.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        with nogil:
            self._handle.Execute(verify)


cdef class SpinRegisterNode(SpinValueNode):
    """Node that represents a register that can be set to some bytes
    representing a value.
    """

    def __cinit__(self):
        self._handle = NULL

    cdef void set_handle(self, object source, IBase* handle) except *:
        SpinValueNode.set_handle(self, source, handle)
        self._handle = dynamic_cast[IRegisterPointer](handle)

    cdef clear_handle(self):
        SpinValueNode.clear_handle(self)
        self._handle = NULL

    cpdef get_address(self):
        """Gets the address of the register node.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef int64_t n
        with nogil:
            n = self._handle.GetAddress()
        return n

    cpdef get_node_value(self, cbool verify=False, cbool allow_cache=False):
        """Gets the register value of the node as a bytes object.

        :param verify: Whether to range verify the node. Access is always
            checked.
        :param allow_cache: Whether to allow getting the register value from
            cache.
        :returns: The bytes object representing the node value.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
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
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef int64_t n = len(buffer)
        cdef const unsigned char[:] buf = buffer
        with nogil:
            self._handle.Set(&buf[0], n, verify)


cdef class SpinEnumNode(SpinValueNode):
    """Node that represents an enum class.

    This node can be set to a specific value from the children of this node,
    each represented by a :class:`SpinEnumItemNode`. Each item also is
    associated with a symbolic string name and an integer value. In addition,
    some enums (e.g. :class:`SpinEnumDefNode`) will also have a secondary
    name and integer associated with it that is defined by the Spinnaker API in
    :mod:`~rotpy.names`.
    """

    def __cinit__(self):
        self._handle = NULL

    cdef void set_handle(self, object source, IBase* handle) except *:
        SpinValueNode.set_handle(self, source, handle)
        self._handle = dynamic_cast[IEnumerationPointer](handle)

    cdef clear_handle(self):
        SpinValueNode.clear_handle(self)
        self._handle = NULL

    cpdef get_entries_names(self):
        """Returns a list of the enum entries (items) symbolic string names.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef NodeList_t entries
        cdef list items = []
        cdef size_t n, i

        with nogil:
            self._handle.GetEntries(entries)
            n = entries.size()

        for i in range(n):
            items.append(dynamic_cast[IEnumEntryPointer](
                (&entries.at(i))[0]).GetSymbolic().c_str().decode())
        return items

    cpdef get_entries(self):
        """Returns a list of :class:`SpinEnumItemNode` instances that are the
        entries (items) of this enum class.

        .. note::

            Every call to this function creates a list of new
            :class:`SpinEnumItemNode` representing the items.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef NodeList_t entries
        cdef list items = []
        cdef size_t n, i

        with nogil:
            self._handle.GetEntries(entries)
            n = entries.size()

        for i in range(n):
            items.append(create_node_inst(self, (&entries.at(i))[0]))
        return items

    cpdef get_num_entries(self):
        """Gets the number of entries (items) of this enum class.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef NodeList_t entries
        cdef size_t n
        with nogil:
            self._handle.GetEntries(entries)
            n = entries.size()
        return n

    cpdef get_entry_by_int_value(self, int64_t value):
        """Gets a enum entry (item) node from this enum class by its int value.

        :param value: The int value of the entry to get. This int value is the
            node int value, not the int associated with the enum by the
            Spinnaker API in :mod:`~rotpy.names` for some enums.
        :return: A :class:`SpinEnumItemNode` instance or None if not found.

        .. note::

            Every call to this function creates a new :class:`SpinEnumItemNode`.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef SpinEnumItemNode entry
        cdef IEnumEntry* handle

        with nogil:
            handle = self._handle.GetEntry(value)

        if handle == NULL:
            return None

        entry = SpinEnumItemNode()
        entry.set_handle(self, dynamic_cast[IBasePointer](handle))
        return entry

    cpdef get_entry_by_name(self, str name):
        """Gets a enum entry (item) node from the enum class by its symbolic
        string name.

        :param name: The symbolic string name of the enum entry to get.
        :return: A :class:`SpinEnumItemNode` instance or None if not found.

        .. note::

            Every call to this function creates a new :class:`SpinEnumItemNode`.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef SpinEnumItemNode entry
        cdef IEnumEntry* handle
        cdef bytes name_b = name.encode()
        cdef const char * name_c = name_b
        cdef size_t n = len(name_b)
        cdef gcstring s

        with nogil:
            s.assign(name_c, n)
            handle = self._handle.GetEntryByName(s)

        if handle == NULL:
            return None

        entry = SpinEnumItemNode()
        entry.set_handle(self, dynamic_cast[IBasePointer](handle))
        return entry

    cpdef get_node_int_value(self, cbool verify=False, cbool ignore_cache=False):
        """Gets the int value of the enum entry (item) that this enum is
        currently set to.

        :param verify: Enables Range verification. The access mode is always
            checked.
        :param ignore_cache: If true the value is read ignoring any caches.
        :returns: An integer. This int value is the node int value, not the int
            associated with the enum by the Spinnaker API in :mod:`~rotpy.names`
            for some enums.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef int64_t n
        with nogil:
            n = self._handle.GetIntValue(verify, ignore_cache)
        return n

    cpdef set_node_int_value(self, int64_t value, cbool verify=True):
        """Sets the enum's current value to a enum entry (item) using the
        entry's int value.

        :param value: The int value to which to set the node. This int value is
            the node int value, not the int associated with the enum by the
            Spinnaker API in :mod:`~rotpy.names` for some enums.
        :param verify: Enables access mode and range verification.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        with nogil:
            self._handle.SetIntValue(value, verify)

    cpdef get_node_value(self, cbool verify=False, cbool ignore_cache=False):
        """Gets the :class:`SpinEnumItemNode` entry that the enum is currently
        set to.

        :param verify: Enables Range verification. The access mode is always
            checked.
        :param ignore_cache: If true the value is read ignoring any caches.
        :returns: A :class:`SpinEnumItemNode`.

        .. note::

            Every call to this function creates a new :class:`SpinEnumItemNode`.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef SpinEnumItemNode entry
        cdef IEnumEntry* handle

        with nogil:
            handle = self._handle.GetCurrentEntry(verify, ignore_cache)

        if handle == NULL:
            return None

        entry = SpinEnumItemNode()
        entry.set_handle(self, dynamic_cast[IBasePointer](handle))
        return entry

    cpdef set_node_value(self, SpinEnumItemNode item, cbool verify=True):
        """Sets the enum's current value to a :class:`SpinEnumItemNode` entry.

        :param item: The :class:`SpinEnumItemNode` item to which to set the
            node.
        :param verify: Enables access mode and range verification.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef int64_t value = item.get_enum_int_value()
        with nogil:
            self._handle.SetIntValue(value, verify)


cdef class SpinEnumDefNode(SpinEnumNode):
    """Same as :class:`SpinEnumNode`, except that these enum instances have an
    associated name and integer additionally defined for its entries (items) in
    :mod:`~rotpy.names` by the Spinnaker API.

    This class is also used for enum instances that are pre-listed e.g. in
    :mod:`~rotpy.system_nodes` or :mod:`~rotpy.camera_nodes`. These pre-listed
    enum nodes have associated names in :mod:`~rotpy.names` hence the
    additional functionality.
    """

    def __cinit__(self):
        self._enum_wrapper = NULL

    def __dealloc__(self):
        if self._enum_wrapper != NULL:
            del self._enum_wrapper
            self._enum_wrapper = NULL

    cdef set_wrapper(self, RotPyEnumWrapper* wrapper):
        self._enum_wrapper = wrapper

    cdef clear_handle(self):
        SpinEnumNode.clear_handle(self)
        if self._enum_wrapper != NULL:
            del self._enum_wrapper
            self._enum_wrapper = NULL

    cpdef get_entry_by_api_str(self, str value):
        """Gets a enum entry (item) node from this enum class by its Spinnaker
        API string value as listed in :attr:`enum_names`.

        :param value: The string value of the entry to get as listed in
            :attr:`enum_names`.
        :return: A :class:`SpinEnumItemNode` instance or None if not found.

        .. note::

            Every call to this function creates a new :class:`SpinEnumItemNode`.
        """
        if self._enum_wrapper == NULL:
            raise TypeError('Invalid node')
        # use LUTSelectorEnums as a stand-in for all enums so the right
        # polymorphism is selected by the compiler
        cdef int n = self.enum_names[value]
        cdef SpinEnumItemNode entry
        cdef IEnumEntry* handle

        with nogil:
            handle = self._enum_wrapper.GetEntry(n)

        if handle == NULL:
            return None

        entry = SpinEnumItemNode()
        entry.set_handle(self, dynamic_cast[IBasePointer](handle))
        entry.enum_name = value
        entry.enum_value = n
        return entry

    cpdef get_node_api_str_value(
            self, cbool verify=False, cbool ignore_cache=False):
        """Gets the Spinnaker API string value of the enum entry that this enum
        is currently set to as listed in :attr:`enum_names`.

        :param verify: Enables Range verification. The access mode is always
            checked.
        :param ignore_cache: If true the value is read ignoring any caches.
        """
        if self._enum_wrapper == NULL:
            raise TypeError('Invalid node')
        # use LUTSelectorEnums as a stand-in for all enums so the right
        # polymorphism is selected by the compiler
        cdef int n
        with nogil:
            n = self._enum_wrapper.GetValue(verify, ignore_cache)
        return self.enum_values[n]

    cpdef set_node_api_str_value(self, str value, cbool verify=True):
        """Sets the value of this enum to a enum entry (item) using its
        Spinnaker API string as listed in :attr:`enum_names`.

        :param value: The Spinnaker API string value to which to set the node.
        :param verify: Enables access mode and range verification.
        """
        if self._enum_wrapper == NULL:
            raise TypeError('Invalid node')
        # use LUTSelectorEnums as a stand-in for all enums so the right
        # polymorphism is selected by the compiler
        cdef int n = self.enum_names[value]
        with nogil:
            self._enum_wrapper.SetValue(n, verify)

    cpdef set_enum_ref(self, int index, str name):
        """Sets the int value corresponding to a enum item.
        """
        if self._enum_wrapper == NULL:
            raise TypeError('Invalid node')
        cdef bytes name_b = name.encode()
        cdef size_t n = len(name)
        cdef const char * name_c = name_b
        cdef gcstring name_s

        with nogil:
            name_s.assign(name_c, n)
            self._enum_wrapper.SetEnumReference(index, name_s)

    cpdef set_num_enums(self, int num):
        """Sets the number of enum entries (items) of this node.
        """
        if self._enum_wrapper == NULL:
            raise TypeError('Invalid node')
        with nogil:
            self._enum_wrapper.SetNumEnums(num)


cdef class SpinEnumItemNode(SpinValueNode):
    """Represents an entry (item) of a :class:`SpinEnumNode` or
    :class:`SpinEnumDefNode` to which that node can be set to.
    """

    def __cinit__(self):
        self._handle = NULL

    cdef void set_handle(self, object source, IBase* handle) except *:
        SpinValueNode.set_handle(self, source, handle)
        self._handle = dynamic_cast[IEnumEntryPointer](handle)

    cdef clear_handle(self):
        SpinValueNode.clear_handle(self)
        self._handle = NULL

    cpdef get_enum_num(self):
        """Gets the double (floating point) number value associated with the
        entry.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef double n
        with nogil:
            n = self._handle.GetNumericValue()
        return n

    cpdef get_enum_int_value(self):
        """Gets the enum entry (item) int value.

        .. note::

            This int value is the node int value, not the :attr:`enum_value` int
            associated with the enum by the Spinnaker API in :mod:`~rotpy.names`
            for some enums.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef int64_t n
        with nogil:
            n = self._handle.GetValue()
        return n

    cpdef get_enum_name(self):
        """Gets the string symbolic representation of the item.

        .. note::

            This string is the node symbolic name, not the :attr:`enum_name`
            associated with the enum by the Spinnaker API in :mod:`~rotpy.names`
            for some enums.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef gcstring s
        with nogil:
            s = self._handle.GetSymbolic()
        return s.c_str().decode()

    cpdef is_self_clearing(self):
        """Returns whether the corresponding entry is self clearing.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef cbool n
        with nogil:
            n = self._handle.IsSelfClearing()
        return bool(n)


cdef class SpinTreeNode(SpinValueNode):
    """Node that is a parent and contains other nodes as children.
    """

    def __cinit__(self):
        self._handle = NULL

    cdef void set_handle(self, object source, IBase* handle) except *:
        SpinValueNode.set_handle(self, source, handle)
        self._handle = dynamic_cast[ICategoryPointer](handle)

    cdef clear_handle(self):
        SpinValueNode.clear_handle(self)
        self._handle = NULL

    cpdef get_children(self):
        """Returns a list of children nodes of the tree, including
        sub-trees.

        .. note::

            Every call to this method creates a list of new
            :class:`SpinBaseNode` representing the children.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef uint64_t n, i
        cdef list items = []
        cdef FeatureList_t nodes

        with nogil:
            self._handle.GetFeatures(nodes)
            n = nodes.size()

        for i in range(n):
            items.append(create_node_inst(
                self, dynamic_cast[INodePointer]((&nodes.at(i))[0])))

        return items

    cpdef get_num_nodes(self):
        """Gets the number of children nodes in the tree.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef FeatureList_t nodes
        cdef size_t n

        with nogil:
            self._handle.GetFeatures(nodes)
            n = nodes.size()

        return n

    cpdef get_node_by_index(self, size_t index):
        """Gets a node from the tree by index using a zero-based index that is
        less than :meth:`get_num_nodes`..

        :param index: The index of the child node.
        :return: A new :class:`SpinBaseNode` derived instance representing the
            child.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef FeatureList_t nodes
        cdef IValue* handle
        with nogil:
            self._handle.GetFeatures(nodes)
            handle = (&nodes.at(index))[0]
        return create_node_inst(self, dynamic_cast[INodePointer](handle))


cdef class SpinPortNode(SpinBaseNode):
    """Node that represents a pure data port.
    """

    def __cinit__(self):
        self._handle = NULL

    cdef void set_handle(self, object source, IBase* handle) except *:
        SpinBaseNode.set_handle(self, source, handle)
        self._handle = dynamic_cast[IPortPointer](handle)

    cdef clear_handle(self):
        SpinBaseNode.clear_handle(self)
        self._handle = NULL

    cpdef write_port(self, object buffer, int64_t address):
        """Writes a chunk of bytes to the port.

        :param buffer: A array/bytes type buffer to write.
        :param address: The port address.
        """
        if self._handle == NULL:
            raise TypeError('Invalid node')
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
        if self._handle == NULL:
            raise TypeError('Invalid node')
        cdef unsigned char[:] arr
        buffer = array('B', b'\0' * n)
        arr = buffer

        with nogil:
            self._handle.Read(&arr[0], address, n)

        return buffer.tobytes()
