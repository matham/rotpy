from .names.spin import log_level_names, log_level_values, cmd_status_values
from cpython.ref cimport PyObject
from libc.stdlib cimport malloc, free
cimport rotpy.camera

# __all__ = ('SpinError', 'SpinSystem')

DEF MAX_BUFF_LEN = 256
# ctypedef spinError (*buf_func)(char*, size_t*) nogil


# cdef inline str read_buffer(buf_func f):
#     cdef char msg[MAX_BUFF_LEN]
#     cdef size_t n = MAX_BUFF_LEN
#     with nogil:
#         check_ret(f(msg, &n))
#     return msg[:max(n - 1, 0)].decode()
#
#
# cdef class SpinError:
#     """Provides the API for spinnaker error functions.
#     """
#
#     cpdef spinError get_last_error(self):
#         """Retrieves the error code of the last error.
#         """
#         cdef spinError err
#         with nogil:
#             check_ret(spinErrorGetLast(&err))
#         return err
#
#     cpdef str get_last_message(self):
#         """Retrieves the error message of the last error.
#         """
#         return read_buffer(&spinErrorGetLastMessage)
#
#     cpdef str get_last_build_date(self):
#         """Retrieves the build date of the last error.
#         """
#         return read_buffer(&spinErrorGetLastBuildDate)
#
#     cpdef str get_last_build_time(self):
#         """Retrieves the build time of the last error.
#         """
#         return read_buffer(&spinErrorGetLastBuildTime)
#
#     cpdef str get_last_filename(self):
#         """Retrieves the filename of the last error.
#         """
#         return read_buffer(&spinErrorGetLastFileName)
#
#     cpdef str get_last_full_message(self):
#         """Retrieves the full error message of the last error.
#         """
#         return read_buffer(&spinErrorGetLastFullMessage)
#
#     cpdef str get_last_function(self):
#         """Retrieves the function name of the last error.
#         """
#         return read_buffer(&spinErrorGetLastFunctionName)
#
#     cpdef int64_t get_last_line_num(self):
#         """Retrieves the error message of the last error.
#         """
#         cdef int64_t line
#         with nogil:
#             check_ret(spinErrorGetLastLineNumber(&line))
#         return line
#
#     cpdef dict get_error_data(self):
#         """Returns a dict with the error info of all the other functions:
#
#         .. code-block:: python
#
#             >>> SpinError().get_error_data()
#             {'code': 0,
#              'message': '',
#              'date': '',
#              'time': '',
#              'filename': '',
#              'full_message': '',
#              'function': '',
#              'line_num': 0,
#              }
#
#         """
#         return {
#             'code': self.get_last_error(),
#             'message': self.get_last_message(),
#             'date': self.get_last_build_date(),
#             'time': self.get_last_build_time(),
#             'filename': self.get_last_filename(),
#             'full_message': self.get_last_full_message(),
#             'function': self.get_last_function(),
#             'line_num': self.get_last_line_num(),
#         }


cdef class EventHandlerBase:
    pass


cdef class LoggingEventHandler(EventHandlerBase):
    """NDC is Nested Diagnostic Context."""

    def __init__(self, callback):
        EventHandlerBase.__init__()
        self._callback = callback

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
            self._callback(data)


cdef class SystemEventHandler(EventHandlerBase):

    def __init__(self, callback_arrival, callback_removal):
        EventHandlerBase.__init__()
        self._callback_arrival = callback_arrival
        self._callback_removal = callback_removal

        self._handler.SetCallback(
            <PyObject*>self,
            <void (*)(void *, cstr) nogil>self.handler_callback_arrival,
            <void (*)(void *, cstr) nogil> self.handler_callback_removal
        )

    cdef void handler_callback_arrival(self, cstr interface) nogil except *:
        with gil:
            if self._callback_arrival is None:
                return
            self._callback_arrival(interface.c_str().decode())

    cdef void handler_callback_removal(self, cstr interface) nogil except *:
        with gil:
            if self._callback_removal is None:
                return
            self._callback_removal(interface.c_str().decode())


cdef class InterfaceEventHandler(EventHandlerBase):

    def __init__(self, callback_arrival, callback_removal):
        EventHandlerBase.__init__()
        self._callback_arrival = callback_arrival
        self._callback_removal = callback_removal

        self._handler.SetCallback(
            <PyObject*>self,
            <void (*)(void *, uint64_t) nogil>self.handler_callback_arrival,
            <void (*)(void *, uint64_t) nogil> self.handler_callback_removal
        )

    cdef void handler_callback_arrival(self, uint64_t serial) nogil except *:
        with gil:
            if self._callback_arrival is None:
                return
            self._callback_arrival(serial)

    cdef void handler_callback_removal(self, uint64_t serial) nogil except *:
        with gil:
            if self._callback_removal is None:
                return
            self._callback_removal(serial)


cdef class SpinSystem:
    """Provides access to information, objects, and functionality of the system
    object. This includes the system object, interface and camera lists, and
    interface and logging events.
    """

    def __cinit__(self):
        self._system_set = 0
        self._sys_handlers = set()
        self._interface_handlers = set()
        self._log_handlers = set()
        self.system_nodes = SystemNodes(system=self)

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

    cpdef attach_event_handler(self, SystemEventHandler handler):
        """Registers an event handler for the system to get interface
        arrival/removal events.

        :param handler: The :class:`SystemEventHandler` to handle the events.

        The ``handler`` will receive the system events while it is registered.
        """
        if handler in self._sys_handlers:
            raise ValueError("Handler is already attached to the system")

        with nogil:
            self._system.get().RegisterEventHandler(handler._handler)
        self._sys_handlers.add(handler)

    cpdef detach_event_handler(self, SystemEventHandler handler):
        """Detaches the event handler previously attached with
        :meth:`attach_event_handler`.

        :param handler: The :class:`SystemEventHandler` that handled the events.
        """
        if handler not in self._sys_handlers:
            raise ValueError("Handler is not attached to the system")

        with nogil:
            self._system.get().UnregisterEventHandler(handler._handler)
        self._sys_handlers.remove(handler)

    cpdef attach_interface_event_handler(
            self, InterfaceEventHandler handler, cbool update=True):
        """Registers the event handler for all available interfaces that are
        found on the system. If new interfaces are detected by the system after
        this call, those interfaces will be automatically registered with this
        event.

        :param handler: The :class:`InterfaceEventHandler` to handle the events.
        :param update: Whether to update the interface list before attaching
            event for the available interfaces on the system.

        .. note::

            Only GEV interface arrivals and removals are currently handled.

        The ``handler`` will receive the interface events while it is
        registered.
        """
        if handler in self._interface_handlers:
            raise ValueError("Handler is already attached to the interfaces")

        with nogil:
            self._system.get().RegisterInterfaceEventHandler(
                handler._handler, update)
        self._interface_handlers.add(handler)

    cpdef detach_interface_event_handler(self, InterfaceEventHandler handler):
        """Detaches the event handler previously attached with
        :meth:`attach_interface_event_handler`.

        :param handler: The :class:`InterfaceEventHandler` that handled the
            events.
        """
        if handler not in self._interface_handlers:
            raise ValueError("Handler is not attached to the system")

        with nogil:
            self._system.get().UnregisterInterfaceEventHandler(handler._handler)
        self._interface_handlers.remove(handler)

    cpdef attach_log_event_handler(self, LoggingEventHandler handler):
        """Registers the event handler for the logging system.

        :param handler: The :class:`LoggingEventHandler` to handle the events.

        The ``handler`` will receive the events while it is registered.
        """
        if handler in self._log_handlers:
            raise ValueError(
                "Handler is already attached to the logging system")

        with nogil:
            self._system.get().RegisterLoggingEventHandler(handler._handler)
        self._log_handlers.add(handler)

    cpdef detach_log_event_handler(self, LoggingEventHandler handler):
        """Detaches the event handler previously attached with
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

        This returns GigE and Usb2 and Usb3 interfaces. Note that on MacOS only
        active GigE interfaces will be stored in the returned interface list.

        :param update_interfaces: Whether to update the internal interface list
            before getting the available interfaces list.
        :return: A :class:`InterfaceDeviceList`.
        """
        cdef InterfaceDeviceList interface_list = InterfaceDeviceList()
        interface_list.set_system(
            self, self._system.get().GetInterfaces(update_interfaces))
        return interface_list

    cpdef create_camera_list(
            self, cbool update_interfaces=True, cbool update_cams=True):
        """Creates and returns a new :class:`CameraList` for accessing
        cameras on the system.

        This returns both GigE Vision and Usb3 Vision cameras from all
        interfaces.

        :param update_interfaces: Whether to update the internal interface list
            before getting the camera list from all the interfaces.
        :param update_cams: Whether to update the internal camera list to detect
            new/removed cameras before getting the camera list.
        :return: A :class:`CameraList`.
        """
        cdef rotpy.camera.CameraList cam_list = rotpy.camera.CameraList()
        cam_list.set_system(
            self, self._system.get().GetCameras(update_interfaces, update_cams))
        return cam_list

    cpdef update_interface_list(self):
        """Updates the internal list of interfaces on the system.

        If desired to get the new interfaces, call
        :meth:`create_interface_list`.
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
        :meth:`create_interface_list` or :meth:`create_camera_list`,
        respectively.
        """
        cdef cbool changed
        with nogil:
            changed = self._system.get().UpdateCameras(update_interfaces)
        return bool(changed)


cdef class InterfaceDeviceList:
    """Provides access to a list of the interface devices to which cameras
    can be attached e.g. GigE and Usb2 and Usb3 interfaces. Note that on MacOS
    only active GigE interfaces will be stored in the returned InterfaceList.
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
        """Retrieves the number of interface devices in the interface device
        list.
        """
        cdef size_t n
        with nogil:
            n = self._interface_list.GetSize()
        return n

    cpdef create_interface(self, unsigned int index):
        """Retrieves an interface device from this interface device list using
        an index.

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

    def __cinit__(self):
        self._interface_set = 0
        self.interface_nodes = InterfaceNodes(interface=self)
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
        # todo: check for null
        self._interface_set = 1
        self._dev_list = dev_list

    cpdef attach_event_handler(self, InterfaceEventHandler handler):
        """Registers an event handler for the interface.

        :param handler: The :class:`InterfaceEventHandler` to handle the events.

        The ``handler`` will receive the interface events while it is
        registered.

        Event handlers are automatically cleaned up when an interface is
        removed, and must be registered to interfaces as they arrive. Note that
        GEV interfaces experience arrival/removal events when the IP information
        changes, similar to GEV cameras.
        """
        if handler in self._event_handlers:
            raise ValueError("Handler is already attached to the system")

        with nogil:
            self._interface.get().RegisterEventHandler(handler._handler)
        self._event_handlers.add(handler)

    cpdef detach_event_handler(self, InterfaceEventHandler handler):
        """Detaches the event handler previously attached with
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
        """Returns whether the interface is in use by any camera objects.
        """
        cdef cbool n
        with nogil:
            n = self._interface.get().IsInUse()
        return bool(n)

    cpdef send_command(
            self, unsigned int device_key, unsigned int group_key,
            unsigned int group_mask, unsigned long long action_time=0,
            unsigned int num_results=0):
        """Broadcast an Action Command to all devices on the interface.

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
        """Returns whether the interface is still valid for use.
        """
        cdef cbool n
        with nogil:
            n = self._interface.get().IsValid()
        return bool(n)

    cpdef create_camera_list(self, cbool update_cams=True):
        """Creates and returns a new :class:`CameraList` for accessing
        the cameras on this interface.

        It returns either usb3 vision or gige vision cameras depending on the
        underlying transport layer of this interface.

        :param update_cams: Whether to update the internal camera list to detect
            new/removed cameras before getting the camera list.
        :return: A :class:`CameraList`.
        """
        cdef rotpy.camera.CameraList cam_list = rotpy.camera.CameraList()
        cam_list.set_interface(
            self, self._interface.get().GetCameras(update_cams))
        return cam_list

    cpdef update_camera_list(self):
        """Updates the internal list of cameras on the system, returning a bool
        indicating whether there has been any changes and cameras have arrived
        or been removed.

        :return: True if cameras changed on interface and False otherwise.

        If desired to get the new cameras, call :meth:`create_camera_list`.
        """
        cdef cbool changed
        with nogil:
            changed = self._interface.get().UpdateCameras()
        return bool(changed)

    cpdef get_tl_node_map(self):
        """Gets the transport layer nodemap from the interface.

        :return: A :class:`~rotpy.node.NodeMap`.
        """
        cdef INodeMap* handle
        cdef NodeMap node_map = NodeMap()
        with nogil:
            handle = &self._interface.get().GetTLNodeMap()
        node_map.set_handle(handle)

        return node_map
