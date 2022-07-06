"""System
================

Provides access to the system in hardware interfaces that have access to
cameras.
"""
from .names.spin import log_level_names, log_level_values, cmd_status_values, \
    error_code_values

from cpython.ref cimport PyObject
from libc.stdlib cimport malloc, free
cimport rotpy.system_nodes

__all__ = (
    'SpinnakerAPIException', 'EventHandlerBase', 'LoggingEventHandler',
    'SystemEventHandler', 'InterfaceEventHandler', 'SpinSystem',
    'InterfaceDeviceList', 'InterfaceDevice')


class SpinnakerAPIException(Exception):
    """An exception that represents an error raised from the Spinnaker API.
    """

    spin_what = ''
    """The basic error message including the code."""
    spin_full_msg = ''
    """The full message, including line numbers, function names, etc."""
    spin_msg = ''
    """The error message."""
    spin_file_name = ''
    """The file name that generated the error."""
    spin_func_name = ''
    """The function name that generated the error."""
    spin_build_date = ''
    """The build date of the file."""
    spin_build_time = ''
    """The build time of the file."""
    spin_line_num = 0
    """The line number of the exception."""
    spin_error_code = 0
    """The numerical error code as a value in
    :attr:`~rotyp.names.spin.error_code_names`.
    """
    spin_error_name = ''
    """The string error type as a string in
    :attr:`~rotyp.names.spin.error_code_names`.
    """

    def __init__(
            self, *args, spin_what='', spin_full_msg='', spin_msg='',
            spin_file_name='', spin_func_name='', spin_build_date='',
            spin_build_time='', spin_line_num=0, spin_error_code=0):
        super().__init__(*args)
        self.spin_what = spin_what
        self.spin_full_msg = spin_full_msg
        self.spin_msg = spin_msg
        self.spin_file_name = spin_file_name
        self.spin_func_name = spin_func_name
        self.spin_build_date = spin_build_date
        self.spin_build_time = spin_build_time
        self.spin_line_num = spin_line_num
        self.spin_error_code = spin_error_code
        self.spin_error_name = error_code_values.get(spin_error_code, 'Unknown')


cdef class EventHandlerBase:
    """Base class for all event handlers.
    """
    pass


cdef class LoggingEventHandler(EventHandlerBase):
    """A system log event handler that is returned by
    :meth:`~SpinSystem.attach_log_event_handler` that handles callbacks for
    internal Spinnaker logging events.

    This represents a callback function that is called on each log event with
    3 positional arguments: this instance, the :class:`SpinSystem` instance that
    created this, and a dict with the log data.

    Some dict keys are the error ``category``, the error ``message``,
    the ``ndc`` (Nested Diagnostic Context), the ``thread`` in which it
    happened, the ``timestamp`` string, the ``priority`` name, and the
    ``priority_num``.
    """

    cdef set_callback(self, SpinSystem system, callback):
        self._callback = callback
        self._system = system

        self._handler.SetCallback(
            <PyObject*>self,
            <void (*)(void *, const LoggingEventDataPtr) nogil>
            self.handler_callback)

    cdef void handler_callback(
            self, const LoggingEventDataPtr event) nogil except *:
        cdef LoggingEventData *item = event.get()

        with gil:
            if self._callback is None:
                return

            data = {
                'category': item.GetCategoryName().decode(),
                'message': item.GetLogMessage().decode(),
                'ndc': item.GetNDC().decode(),
                'thread': item.GetThreadName().decode(),
                'timestamp': item.GetTimestamp().decode(),
                'priority': item.GetPriorityName().decode(),
                'priority_num': item.GetPriority(),
            }
            self._callback(self, self._system, data)


cdef class SystemEventHandler(EventHandlerBase):
    """A system interface arrival/removal handler that is returned by
    :meth:`~SpinSystem.attach_event_handler` that handles callbacks for
    when a new hardware interface to which cameras may be attached (e.g. USB
    port) is added or removed from the system.

    This represents an arrival and removal callback function that is each called
    respectively (if provided when it's created), on each arrival/removal event
    with 3 positional arguments: this instance, the :class:`SpinSystem` instance
    that created this, and a string representing the interface name.
    """

    cdef set_callback(
            self, SpinSystem system, callback_arrival, callback_removal):
        self._callback_arrival = callback_arrival
        self._callback_removal = callback_removal
        self._system = system

        self._handler.SetCallback(
            <PyObject*>self,
            <void (*)(void *, cstr) nogil>self.handler_callback_arrival,
            <void (*)(void *, cstr) nogil> self.handler_callback_removal
        )

    cdef void handler_callback_arrival(self, cstr interface) nogil except *:
        with gil:
            if self._callback_arrival is None:
                return
            self._callback_arrival(
                self, self._system, interface.c_str().decode())

    cdef void handler_callback_removal(self, cstr interface) nogil except *:
        with gil:
            if self._callback_removal is None:
                return
            self._callback_removal(
                self, self._system, interface.c_str().decode())


cdef class InterfaceEventHandler(EventHandlerBase):
    """A system/interface camera arrival/removal handler that is returned by
    :meth:`~SpinSystem.attach_interface_event_handler` and
    :meth:`~InterfaceDevice.attach_event_handler` that handles callbacks for
    when a camera is added or removed from the system or specific interface.

    This represents an arrival and removal callback function that is each called
    respectively (if provided when it's created), on each arrival/removal event
    with 3 positional arguments: this instance, the :class:`SpinSystem`
    or :class:`InterfaceDevice` instance that created this, and an integer
    representing the camera serial number.
    """

    cdef set_callback(
            self, object interface_or_sys, callback_arrival,
            callback_removal):
        self._callback_arrival = callback_arrival
        self._callback_removal = callback_removal
        self._interface_or_sys = interface_or_sys

        self._handler.SetCallback(
            <PyObject*>self,
            <void (*)(void *, uint64_t) nogil>self.handler_callback_arrival,
            <void (*)(void *, uint64_t) nogil> self.handler_callback_removal
        )

    cdef void handler_callback_arrival(self, uint64_t serial) nogil except *:
        with gil:
            if self._callback_arrival is None:
                return
            self._callback_arrival(self, self._interface_or_sys, serial)

    cdef void handler_callback_removal(self, uint64_t serial) nogil except *:
        with gil:
            if self._callback_removal is None:
                return
            self._callback_removal(self, self._interface_or_sys, serial)


cdef class SpinSystem:
    """A :class:`SpinSystem` provides access to interfaces and cameras
    attached to these interfaces across the system.
    """

    def __cinit__(self):
        self._system_set = 0
        self._sys_handlers = set()
        self._interface_handlers = set()
        self._log_handlers = set()
        self.system_nodes = rotpy.system_nodes.SystemNodes(system=self)

    def __init__(self):
        with nogil:
            self._system = CSystem.GetInstance()
        self._system_set = 1

    def __dealloc__(self):
        if self._system_set:
            self._system_set = 0
            with nogil:
                self._system.get().ReleaseInstance()

    cpdef set_logging_level(self, str level):
        """Sets the logging level for all logging events on the system.
        Logging events below such level will not trigger callbacks

        :param level: The name of the level as listed in
            :attr:`~rotpy.names.spin.log_level_names`.
        """
        cdef SpinnakerLogLevel log_level = log_level_names[level]
        with nogil:
            self._system.get().SetLoggingEventPriorityLevel(log_level)

    cpdef get_logging_level(self):
        """Gets the logging level (as listed in
        :attr:`~rotpy.names.spin.log_level_names`) for all logging events on the
        system.
        """
        cdef SpinnakerLogLevel log_level
        with nogil:
            log_level = self._system.get().GetLoggingEventPriorityLevel()
        return log_level_values[log_level]

    cpdef detach_all_log_handlers(self):
        """Detaches all the attached log event handlers that have been
        previously attached.
        """
        with nogil:
            self._system.get().UnregisterAllLoggingEventHandlers()
        self._log_handlers.clear()

    cpdef get_in_use(self):
        """Checks if the system is in use by any interface or camera objects.
        """
        cdef cbool val
        with nogil:
            val = self._system.get().IsInUse()
        return bool(val)

    cpdef get_library_version(self):
        """Gets the current Spinnaker library version as a 4 tuple of
        ``(major, minor, type, build)``.
        """
        cdef LibraryVersion version
        with nogil:
            version = self._system.get().GetLibraryVersion()
        return version.major, version.minor, version.type, version.build

    cpdef get_tl_node_map(self):
        """Gets the transport layer nodemap from the system.

        :return: A :class:`~rotpy.node.NodeMap`.
        """
        cdef INodeMap* handle
        cdef NodeMap node_map = NodeMap()
        with nogil:
            handle = &self._system.get().GetTLNodeMap()
        node_map.set_handle(handle)

        return node_map

    cpdef attach_event_handler(
            self, callback_arrival=None, callback_removal=None):
        """Registers the system callbacks to get interface arrival/removal
        events.

        :param callback_arrival: A function that will be called upon interface
            arrival events. If it's ``None``, arrival events will be ignored.
            See :class:`SystemEventHandler` for the function signature.
        :param callback_removal: A function that will be called upon interface
            removal events. If it's ``None``, removal events will be ignored.
            See :class:`SystemEventHandler` for the function signature.
        :returns: A :class:`SystemEventHandler` instance representing the
            callbacks.

        The callbacks will receive the system events while they are registered,
        possibly even before this function returns(?) and could potentially
        be called by external threads. It's best not to do any work in it.
        """
        cdef SystemEventHandler handler = SystemEventHandler()
        handler.set_callback(self, callback_arrival, callback_removal)

        self._sys_handlers.add(handler)
        try:
            with nogil:
                self._system.get().RegisterEventHandler(handler._handler)
        except:
            self._sys_handlers.remove(handler)
            raise
        return handler

    cpdef detach_event_handler(self, SystemEventHandler handler):
        """Detaches the event handler returned by :meth:`attach_event_handler`.

        :param handler: The :class:`SystemEventHandler` that handled the events.
        """
        if handler not in self._sys_handlers:
            raise ValueError("Handler is not attached to the system")

        with nogil:
            self._system.get().UnregisterEventHandler(handler._handler)
        self._sys_handlers.remove(handler)

    cpdef attach_interface_event_handler(
            self, callback_arrival=None, callback_removal=None,
            cbool update=True):
        """Registers device arrival and removal events for all
        interfaces that are found on the system. If new interfaces are detected
        by the system after this call, those interfaces will be automatically
        registered with this event.

        :param callback_arrival: A function that will be called upon device
            arrival events. If it's ``None``, arrival events will be ignored.
            See :class:`InterfaceEventHandler` for the function signature.
        :param callback_removal: A function that will be called upon device
            removal events. If it's ``None``, removal events will be ignored.
            See :class:`InterfaceEventHandler` for the function signature.
        :param update: Whether to update the interface list before attaching
            event for the available interfaces on the system.
        :returns: A :class:`InterfaceEventHandler` instance representing the
            callbacks.

        .. note::

            Only GEV interface arrivals and removals are currently handled.

        The callbacks will receive the interface events while they are
        registered,
        possibly even before this function returns(?) and could potentially
        be called by external threads. It's best not to do any work in it.
        """
        cdef InterfaceEventHandler handler = InterfaceEventHandler()
        handler.set_callback(self, callback_arrival, callback_removal)

        self._interface_handlers.add(handler)
        try:
            with nogil:
                self._system.get().RegisterInterfaceEventHandler(
                    handler._handler, update)
        except:
            self._interface_handlers.remove(handler)
            raise
        return handler

    cpdef detach_interface_event_handler(self, InterfaceEventHandler handler):
        """Detaches the event handler previously returned by
        :meth:`attach_interface_event_handler`.

        :param handler: The :class:`InterfaceEventHandler` that handled the
            events.
        """
        if handler not in self._interface_handlers:
            raise ValueError("Handler is not attached to the system")

        with nogil:
            self._system.get().UnregisterInterfaceEventHandler(handler._handler)
        self._interface_handlers.remove(handler)

    cpdef attach_log_event_handler(self, callback):
        """Registers the callback to get logging events from system.

        :param callback: A function that will be called upon logging events.
            See :class:`LoggingEventHandler` for the function signature.
        :returns: A :class:`LoggingEventHandler` instance representing the
            callback.

        The ``callback`` will receive the events while it is registered,
        possibly even before this function returns(?) and could potentially
        be called by external threads. It's best not to do any work in it.
        """
        cdef LoggingEventHandler handler = LoggingEventHandler()
        handler.set_callback(self, callback)

        self._log_handlers.add(handler)
        try:
            with nogil:
                self._system.get().RegisterLoggingEventHandler(handler._handler)
        except:
            self._log_handlers.remove(handler)
            raise
        return handler

    cpdef detach_log_event_handler(self, LoggingEventHandler handler):
        """Detaches an event handler returned by
        :meth:`attach_log_event_handler`.

        :param handler: The :class:`LoggingEventHandler` that handled the
            events.
        """
        if handler not in self._log_handlers:
            raise ValueError("Handler is not attached to the logging system")

        with nogil:
            self._system.get().UnregisterLoggingEventHandler(handler._handler)
        self._log_handlers.remove(handler)

    cpdef send_command(
            self, unsigned int device_key, unsigned int group_key,
            unsigned int group_mask, unsigned long long action_time=0,
            unsigned int num_results=0):
        """Broadcast an Action Command to all devices on the system.

        :param device_key: The action command's device key.
        :param group_key: The action command's group key.
        :param group_mask: The action command's group mask.
        :param action_time: Time when to assert a future action. Zero (default)
            means immediate action.
        :param num_results: The number of results expected in the return list.
            The value passed should be equal to the expected number of devices
            that acknowledge the command. The returned list will be the actual
            number of received results. If this is 0, the function will return
            as soon as the command has been broadcasted.
        :return: A list of tuples, one tuple for each item in the result.
            Each tuple is ``(address, status)``, where ``address`` is the device
            address and ``status`` is the status string from
            :attr:`~rotpy.names.spin.cmd_status_names`.
        """
        cdef unsigned int n = num_results
        cdef ActionCommandResult* results = NULL
        cdef list out = []
        cdef size_t i

        if n:
            results = <ActionCommandResult *>malloc(
                n * sizeof(ActionCommandResult))
            if results == NULL:
                raise MemoryError

        with nogil:
            self._system.get().SendActionCommand(
                device_key, group_key, group_mask, action_time, &n, results)

        for i in range(n):
            out.append((
                results[i].DeviceAddress, cmd_status_values[results[i].status]))

        if results != NULL:
            free(results)
        return out

    cpdef create_interface_list(self, cbool update_interfaces=True):
        """Creates and returns a new :class:`InterfaceDeviceList` for accessing
        interfaces on the system.

        This returns GigE and USB2 and USB3 interfaces. Note that on MacOS only
        active GigE interfaces will be stored in the returned interface list.

        :param update_interfaces: Whether to update the internal interface list
            before getting the available interfaces list.
        :return: A :class:`InterfaceDeviceList`.
        """
        cdef InterfaceDeviceList interface_list = InterfaceDeviceList()
        interface_list.set_system(
            self, self._system.get().GetInterfaces(update_interfaces))
        return interface_list

    cpdef update_interface_list(self):
        """Updates the internal list of interfaces on the system.

        If desired to get the new interfaces, call
        :meth:`create_interface_list`, existing :class:`InterfaceDeviceList`
        will not reflect the updates.
        """
        with nogil:
            self._system.get().UpdateInterfaceList()

    cpdef update_camera_list(self, cbool update_interfaces=True):
        """Updates the internal list of cameras on the system, returning a bool
        indicating whether there has been any changes and cameras have arrived
        or been removed.

        :param update_interfaces: If True, the interface lists will also be
            updated.
        :return: True if cameras changed on interface and False otherwise.

        If desired to get the new interfaces or cameras, call
        :meth:`create_interface_list` or
        :meth:`~rotpy.camera.CameraList.create_from_system`, respectively
        because existing :class:`~rotpy.camera.CameraList` will not reflect the
        updates.
        """
        cdef cbool changed
        with nogil:
            changed = self._system.get().UpdateCameras(update_interfaces)
        return bool(changed)


cdef class InterfaceDeviceList:
    """Provides access to a list of the interface devices to which cameras
    can be attached e.g. GigE and USB2 and USB3 interfaces.

    .. warning::

        Do **not** create a :class:`InterfaceDeviceList` manually, rather get it
        from :meth:`~SpinSystem.create_interface_list`.

    Once a :class:`InterfaceDeviceList` is created from the system,
    updating the system so it detects new interface will **not**
    be reflected in existing :class:`InterfaceDeviceList`. Instead, create
    new one to access those new interfaces.


    .. note::

        On MacOS only active GigE interfaces will be stored in the returned
        :class:`InterfaceDeviceList`.
    """

    def __cinit__(self):
        self._list_set = 0

    def __dealloc__(self):
        if self._list_set:
            self._list_set = 0
            with nogil:
                # because cameras have a ref to the cam list, which has a ref to
                # the interface, which has a ref to this interface list, this is
                # only called once they are all dead
                self._interface_list.Clear()

    cdef void set_system(
            self, SpinSystem system, CInterfaceList interface_list):
        self.system = system
        self._interface_list = interface_list
        self._list_set = 1

    cpdef get_size(self):
        """Retrieves the number of detected interface devices in the list.
        """
        cdef size_t n
        with nogil:
            n = self._interface_list.GetSize()
        return n

    cpdef create_interface(self, unsigned int index):
        """Retrieves an interface device from this interface device list using
        using a zero-based index that is less than :meth:`get_size`.

        :param index: The index of the interface device.
        :return: A :class:`InterfaceDevice`.
        """
        cdef InterfaceDevice dev = InterfaceDevice()
        dev.set_interface(self, index)
        return dev

    cpdef extend(self, InterfaceDeviceList other):
        """Extends this interface list with a copy of the other interface list.

        :param other: The other :class:`InterfaceDeviceList` to add to us.
        """
        cdef CInterfaceList other_list = other._interface_list
        with nogil:
            self._interface_list.Append(&other_list)


cdef class InterfaceDevice:
    """A hardware interface to which cameras such as GigE, USB2/3 can be
    attached.

    .. warning::

        Do **not** create a :class:`InterfaceDevice` manually, rather get it
        from :meth:`InterfaceDeviceList.create_interface`.
    """

    def __cinit__(self):
        self._interface_set = 0
        self.interface_nodes = rotpy.system_nodes.InterfaceNodes(interface=self)
        self._event_handlers = set()

    def __dealloc__(self):
        if self._interface_set:
            self._interface_set = 0

    cdef object set_interface(self, InterfaceDeviceList dev_list, unsigned int index):
        cdef CInterfaceList if_list = dev_list._interface_list
        with nogil:
            self._interface = if_list.GetByIndex(index)

        if not self._interface.IsValid():
            raise ValueError(f'Could not find interface at index "{index}"')
        self._interface_set = 1
        self._dev_list = dev_list

    cpdef release(self):
        """Releases the interface's resources, including its nodes.

        Once called, non of the pre-listed node are valid and other interface
        methods should not be called.
        """
        self.interface_nodes.clear_interface()

    cpdef attach_event_handler(
            self, callback_arrival=None, callback_removal=None):
        """Registers device arrival and removal events for this interface.

        :param callback_arrival: A function that will be called upon device
            arrival events. If it's ``None``, arrival events will be ignored.
            See :class:`InterfaceEventHandler` for the function signature.
        :param callback_removal: A function that will be called upon device
            removal events. If it's ``None``, removal events will be ignored.
            See :class:`InterfaceEventHandler` for the function signature.
        :returns: A :class:`InterfaceEventHandler` instance representing the
            callbacks.

        The callbacks will receive the interface events while they are
        registered,
        possibly even before this function returns(?) and could potentially
        be called by external threads. It's best not to do any work in it.

        Event handlers are automatically cleaned up when an interface is
        removed, and must be registered to interfaces as they arrive. Note that
        GEV interfaces experience arrival/removal events when the IP information
        changes, similar to GEV cameras.
        """
        cdef InterfaceEventHandler handler = InterfaceEventHandler()
        handler.set_callback(self, callback_arrival, callback_removal)

        self._event_handlers.add(handler)
        try:
            with nogil:
                self._interface.get().RegisterEventHandler(handler._handler)
        except:
            self._event_handlers.remove(handler)
            raise
        return handler

    cpdef detach_event_handler(self, InterfaceEventHandler handler):
        """Detaches the event handler previously returned by
        :meth:`attach_event_handler`.

        :param handler: The :class:`InterfaceEventHandler` that handled the
            events.
        """
        if handler not in self._event_handlers:
            raise ValueError("Handler is not attached to the system")

        with nogil:
            self._interface.get().UnregisterEventHandler(handler._handler)
        self._event_handlers.remove(handler)

    cpdef get_in_use(self):
        """Returns whether this interface is in use by any camera objects.
        """
        cdef cbool n
        with nogil:
            n = self._interface.get().IsInUse()
        return bool(n)

    cpdef send_command(
            self, unsigned int device_key, unsigned int group_key,
            unsigned int group_mask, unsigned long long action_time=0,
            unsigned int num_results=0):
        """Broadcast an Action Command to all devices on this interface.

        :param device_key: The action command's device key.
        :param group_key: The action command's group key.
        :param group_mask: The action command's group mask.
        :param action_time: Time when to assert a future action. Zero (default)
            means immediate action.
        :param num_results: The number of results expected in the return list.
            The value passed should be equal to the expected number of devices
            that acknowledge the command. The returned list will be the actual
            number of received results. If this is 0, the function will return
            as soon as the command has been broadcasted.
        :return: A list of tuples, one tuple for each item in the result.
            Each tuple is ``(address, status)``, where ``address`` is the device
            address and ``status`` is the status string from
            :attr:`~rotpy.names.spin.cmd_status_names`.
        """
        cdef unsigned int n = num_results
        cdef ActionCommandResult * results = NULL
        cdef list out = []
        cdef size_t i

        if n:
            results = <ActionCommandResult *> malloc(
                n * sizeof(ActionCommandResult))
            if results == NULL:
                raise MemoryError

        with nogil:
            self._interface.get().SendActionCommand(
                device_key, group_key, group_mask, action_time, &n, results)

        for i in range(n):
            out.append((
                results[i].DeviceAddress, cmd_status_values[results[i].status]))

        if results != NULL:
            free(results)
        return out

    cpdef get_is_valid(self):
        """Returns whether this interface is still valid for use.
        """
        cdef cbool n
        with nogil:
            n = self._interface.get().IsValid()
        return bool(n)

    cpdef update_camera_list(self):
        """Updates the internal list of cameras on this interface, returning a
        bool indicating whether there has been any changes and cameras have
        arrived or been removed.

        :return: True if cameras changed on interface and False otherwise.

        If desired to get the new cameras, call
        :meth:`~rotpy.camera.CameraList.create_from_interface` because existing
        :class:`~rotpy.camera.CameraList` will not reflect the updates.
        """
        cdef cbool changed
        with nogil:
            changed = self._interface.get().UpdateCameras()
        return bool(changed)

    cpdef get_tl_node_map(self):
        """Gets the transport layer nodemap from this interface.

        :return: A :class:`~rotpy.node.NodeMap`.
        """
        cdef INodeMap* handle
        cdef NodeMap node_map = NodeMap()
        with nogil:
            handle = &self._interface.get().GetTLNodeMap()
        node_map.set_handle(handle)

        return node_map
