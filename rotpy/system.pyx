from .names import log_level_names, log_level_values

__all__ = ('SpinError', 'SpinSystem')

DEF MAX_BUFF_LEN = 256
ctypedef spinError (*buf_func)(char*, size_t*) nogil


cdef inline str read_buffer(buf_func f):
    cdef char msg[MAX_BUFF_LEN]
    cdef size_t n = MAX_BUFF_LEN
    with nogil:
        check_ret(f(msg, &n))
    return msg[:max(n - 1, 0)]


cdef class SpinError:
    """Provides the API for spinnaker error functions.
    """

    cpdef spinError get_last_error(self):
        """Retrieves the error code of the last error.
        """
        cdef spinError err
        with nogil:
            check_ret(spinErrorGetLast(&err))
        return err

    cpdef str get_last_message(self):
        """Retrieves the error message of the last error.
        """
        return read_buffer(&spinErrorGetLastMessage)

    cpdef str get_last_build_date(self):
        """Retrieves the build date of the last error.
        """
        return read_buffer(&spinErrorGetLastBuildDate)

    cpdef str get_last_build_time(self):
        """Retrieves the build time of the last error.
        """
        return read_buffer(&spinErrorGetLastBuildTime)

    cpdef str get_last_filename(self):
        """Retrieves the filename of the last error.
        """
        return read_buffer(&spinErrorGetLastFileName)

    cpdef str get_last_full_message(self):
        """Retrieves the full error message of the last error.
        """
        return read_buffer(&spinErrorGetLastFullMessage)

    cpdef str get_last_function(self):
        """Retrieves the function name of the last error.
        """
        return read_buffer(&spinErrorGetLastFunctionName)

    cpdef int64_t get_last_line_num(self):
        """Retrieves the error message of the last error.
        """
        cdef int64_t line
        with nogil:
            check_ret(spinErrorGetLastLineNumber(&line))
        return line

    cpdef dict get_error_data(self):
        """Returns a dict with the error info of all the other functions:

        .. code-block:: python

            >>> SpinError().get_error_data()
            {'code': 0,
             'message': '',
             'date': '',
             'time': '',
             'filename': '',
             'full_message': '',
             'function': '',
             'line_num': 0,
             }

        """
        return {
            'code': self.get_last_error(),
            'message': self.get_last_message(),
            'date': self.get_last_build_date(),
            'time': self.get_last_build_time(),
            'filename': self.get_last_filename(),
            'full_message': self.get_last_full_message(),
            'function': self.get_last_function(),
            'line_num': self.get_last_line_num(),
        }


cdef class SpinSystem:
    """Provides access to information, objects, and functionality of the system
    object. This includes the system object, interface and camera lists, and
    interface and logging events.
    """

    def __cinit__(self):
        self._system_set = 0

    def __int__(self):
        with nogil:
            check_ret(spinSystemGetInstance(&self._system))
        self._system_set = 1

    def __dealloc__(self):
        if self._system_set:
            self._system_set = 0
            with nogil:
                check_ret(spinSystemReleaseInstance(self._system))

    cpdef set_logging_level(self, str level):
        """Sets the logging level for all logging events on the system.

        :param level: The name of the level as listed in
            :attr:`~rotpy.names.log_level_names`.
        """
        cdef spinnakerLogLevel log_level = log_level_names[level]
        with nogil:
            check_ret(spinSystemSetLoggingLevel(self._system, log_level))

    cpdef str get_logging_level(self):
        """Gets the logging level (as listed in
        :attr:`~rotpy.names.log_level_names`) for all logging events on the
        system.
        """
        cdef spinnakerLogLevel log_level
        with nogil:
            check_ret(spinSystemGetLoggingLevel(self._system, &log_level))
        return log_level_values[log_level]

    cpdef str detach_all_log_handlers(self):
        """Detaches all the attached log event handlers that have been
        previously attached.
        """
        with nogil:
            check_ret(spinSystemUnregisterAllLogEventHandlers(self._system))

    cpdef object get_in_use(self):
        """Checks whether the system is currently in use.
        """
        cdef bool8_t is_used
        with nogil:
            check_ret(spinSystemIsInUse(self._system, &is_used))
        return bool(is_used)

    cpdef object refresh_camera_list(self, int update_interfaces=False):
        """Updates the list of cameras on the system, returning a bool
        indicating whether there has been any changes and cameras have arrived
        or been removed.

        :param update_interfaces: If True, the interface lists will also be
            updated.
        """
        cdef bool8_t changed
        if update_interfaces:
            with nogil:
                check_ret(spinSystemUpdateCamerasEx(self._system, 1, &changed))
        else:
            with nogil:
                check_ret(spinSystemUpdateCameras(self._system, &changed))
        return bool(changed)

    cpdef tuple get_library_version(self):
        """Gets the current Spinnaker library version as a 4 tuple of
        ``(major, minor, type, build)``.
        """
        cdef spinLibraryVersion version
        with nogil:
            check_ret(spinSystemGetLibraryVersion(self._system, &version))
        return version.major, version.minor, version.type, version.build


cdef class InterfaceDeviceList:
    """Provides access to a list of the interface devices to which cameras
    can be attached (e.g. USB, ethernet etc.). This includes updating, size, and
    camera retrieval.
    """

    def __cinit__(self, SpinSystem system):
        self._list_set = 0
        self.system = system

    def __init__(self, SpinSystem system):
        with nogil:
            check_ret(spinInterfaceListCreateEmpty(&self._interface_list))
        self._list_set = 1

    def __dealloc__(self):
        if self._list_set:
            self._list_set = 0
            with nogil:
                check_ret(spinInterfaceListClear(self._interface_list))
                check_ret(spinInterfaceListDestroy(self._interface_list))

    cpdef refresh_interfaces(self):
        """Retrieves the list of detected (and enumerable) interface devices on
        the system.
        """
        cdef spinSystem system = self.system._system
        with nogil:
            check_ret(spinSystemGetInterfaces(system, self._interface_list))

    cpdef int get_size(self):
        """Retrieves the number of interface devices in the interface device
        list.
        """
        cdef size_t n
        with nogil:
            check_ret(spinInterfaceListGetSize(self._interface_list, &n))
        return n

    cpdef InterfaceDevice create_interface(self, int index):
        """Retrieves an interface device from this interface device list using
        an index.

        :param index: The index of the interface device.
        :return: A :class:`InterfaceDevice`.
        """
        dev = InterfaceDevice()
        dev.set_interface(self, index)
        return dev


cdef class InterfaceDevice:

    def __cinit__(self):
        self._interface_set = 0

    def __dealloc__(self):
        if self._interface_set:
            self._interface_set = 0
            with nogil:
                check_ret(spinInterfaceRelease(self._interface))

    cdef object set_interface(self, InterfaceDeviceList dev_list, int index):
        with nogil:
            check_ret(
                spinInterfaceListGet(dev_list._interface_list, index, &self._interface))
        self._interface_set = 1
