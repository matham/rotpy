from .names.spin import log_level_names, log_level_values, event_values
from cpython.ref cimport PyObject


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


cdef class EventHandler:

    def __cinit__(self, callback, str event_name=''):
        self._callback = callback

    def __init__(self, callback, str event_name=''):
        cdef bytes name_b = event_name.encode()
        cdef size_t n = len(event_name)
        cdef const char* name_c = name_b
        cdef gcstring s

        if event_name:
            s.assign(name_c, n)
        self._handler.SetCallback(
            <PyObject*>self,
            <void (*)(void *, const gcstring *) nogil>self.handler_callback, s)

    cdef void handler_callback(self, const gcstring* event) nogil except *:
        cdef uint64_t dev_event_id = self._handler.GetDeviceEventId()
        cdef EventType event_tp = self._handler.GetEventType()
        cdef DeviceEventInferenceData inference_data
        cdef DeviceEventExposureEndData exposure_end_data
        cdef int event_id = 0

        if event[0] == "EventInference":
            DeviceEventUtility.ParseDeviceEventInference(
                self._handler.GetEventPayloadData(),
                self._handler.GetEventPayloadDataSize(), inference_data)
            event_id = 1
        elif event[0] == "EventExposureEnd":
            DeviceEventUtility.ParseDeviceEventExposureEnd(
                self._handler.GetEventPayloadData(),
                self._handler.GetEventPayloadDataSize(), exposure_end_data)
            event_id = 2

        with gil:
            event_name = event.c_str().decode()
            dev_name = self._handler.GetDeviceEventName().c_str().decode()
            event_type = event_values[event_tp]

            if event_id == 1:
                data = {
                    'valur': inference_data.result,
                    'confidence': inference_data.confidence,
                    'frame_id': inference_data.frameID}
            elif event_id == 2:
                data = {'frame_id': exposure_end_data.frameID}
            else:
                data = None

            self._callback(event_name, event_type, dev_name, dev_event_id, data)


cdef class SpinSystem:
    """Provides access to information, objects, and functionality of the system
    object. This includes the system object, interface and camera lists, and
    interface and logging events.
    """

    def __cinit__(self):
        self._system_set = 0

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

    cpdef refresh_camera_list(self, cbool update_interfaces=True):
        """Updates the list of cameras on the system, returning a bool
        indicating whether there has been any changes and cameras have arrived
        or been removed.

        :param update_interfaces: If True, the interface lists will also be
            updated.
        :return: True if cameras changed on interface and False otherwise.
        """
        cdef cbool changed
        with nogil:
            changed = self._system.get().UpdateCameras(update_interfaces)
        return bool(changed)

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

#
cdef class InterfaceDeviceList:
    """Provides access to a list of the interface devices to which cameras
    can be attached (e.g. USB, ethernet etc.). This includes updating, size, and
    camera retrieval.
    """

    def __cinit__(self, SpinSystem system):
        self._list_set = 0
        self.system = system

    def __init__(self, SpinSystem system):
        cdef SystemPtr system_ptr = system._system
        with nogil:
            self._interface_list = system_ptr.get().GetInterfaces(False)
        self._list_set = 1

    def __dealloc__(self):
        if self._list_set:
            self._list_set = 0
            with nogil:
                self._interface_list.Clear()

    cpdef refresh_interfaces(self):
        """Retrieves the list of detected (and enumerable) interface devices on
        the system.
        """
        cdef SystemPtr system = self.system._system
        with nogil:
            system.get().UpdateInterfaceList()
            self._interface_list.Clear()
            self._interface_list = system.get().GetInterfaces(False)

    cpdef get_size(self):
        """Retrieves the number of interface devices in the interface device
        list.
        """
        cdef size_t n
        with nogil:
            n = self._interface_list.GetSize()
        return n

    cpdef InterfaceDevice create_interface(self, unsigned int index):
        """Retrieves an interface device from this interface device list using
        an index.

        :param index: The index of the interface device.
        :return: A :class:`InterfaceDevice`.
        """
        dev = InterfaceDevice()
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

    cpdef get_in_use(self):
        """Returns whether the interface is in use by any camera objects.
        """
        cdef cbool n
        with nogil:
            n = self._interface.get().IsInUse()
#
#     cpdef NodeMap get_tl_node_map(self):
#         """Gets the transport layer nodemap from the interface.
#
#         :return: A :class:`~rotpy.node.NodeMap`.
#         """
#         cdef spinNodeMapHandle handle
#         cdef NodeMap node_map = NodeMap()
#         with nogil:
#             check_ret(spinInterfaceGetTLNodeMap(self._interface, &handle))
#         node_map.set_handle(handle)
#
#         return node_map
