from cpython.ref cimport PyObject
cimport cpython.array

from array import array

__all__ = ('EventHandler', )

DEF MAX_BUFF_LEN = 256


cdef class EventHandler:
    """Callback may not raise an exception.
    """

    def __cinit__(self):
        self._handler_set = 0
        self.user_callback = None


cdef class DeviceEventHandler(EventHandler):
    """Device event handler.
    """

    def __cinit__(self, Camera camera):
        self._event_data = NULL
        self._camera = camera

    def __init__(self, Camera camera):
        with nogil:
            check_ret(spinDeviceEventHandlerCreate(
                &self._handler,
                <spinDeviceEventFunction>DeviceEventHandler._callback,
                <PyObject *> self
            ))
        self._handler_set = 1

    def __dealloc__(self):
        if self._handler_set:
            self._handler_set = 0
            with nogil:
                check_ret(spinDeviceEventHandlerDestroy(self._handler))

    @staticmethod
    cdef void _callback(const spinDeviceEventData data, const char* name, void* obj_id) nogil except *:
        with gil:
            obj = <DeviceEventHandler>obj_id
            if obj.user_callback is not None:
                obj._event_data = data
                obj.user_callback()

    cpdef attach_handler(self, callback, str event=None):
        """Attaches the handler to the :class:`~rotpy.camera.Camera` that was
        given when the instance was created. Once called, the callback will be
        called for new events.

        Only one callback can be used per handler instance. Instantiate another
        handler and attach to have multiple handlers.

        :param callback: The callback that will be called upon an event.
            The function takes no arguments and should do the minimal work to
            prevent blocking the calling thread. Use :meth:`get_last_event_data`
            to get the event data.
        :param event: If None, it'll handle all events. If it's an event name,
            only that type will be handled.
        """
        cdef bytes name_b
        cdef const char* name = NULL
        if self.user_callback is not None:
            raise TypeError("Instance has handler already attached")
        self.user_callback = callback

        if event is not None:
            name_b = event.encode()
            name = name_b

        with nogil:
            if name == NULL:
                check_ret(spinCameraRegisterDeviceEventHandler(
                    self._camera._camera, self._handler))
            else:
                check_ret(spinCameraRegisterDeviceEventHandlerEx(
                    self._camera._camera, self._handler, name))

    cpdef detach_handler(self):
        """Detaches the handler previously attached with :meth:`attach_handler`.
        """
        with nogil:
            check_ret(spinCameraUnregisterDeviceEventHandler(
                self._camera._camera, self._handler))
        self.user_callback = None

    cpdef dict get_last_event_data(self):
        """Returns all the event data of the last event. If there's no event
        it raises a TypeError exception.
        """
        cdef uint64_t id_
        cdef char msg[MAX_BUFF_LEN]
        cdef size_t n = MAX_BUFF_LEN, buff_size
        cdef str name
        cdef unsigned char[:] arr

        if self._event_data == NULL:
            raise TypeError("There's no event to introspect")

        with nogil:
            check_ret(spinDeviceEventGetId(self._event_data, &id_))
            check_ret(spinDeviceEventGetName(self._event_data, msg, &n))
            check_ret(spinDeviceEventGetPayloadDataSize(
                self._event_data, &buff_size))
            buff_size += 1

        buffer = array('B', b'\0' * buff_size)
        arr = buffer
        with nogil:
            check_ret(spinDeviceEventGetPayloadData(self._event_data, &arr[0], &buff_size))

        name = msg[:max(n - 1, 0)]
        return {
            'id': id_,
            'name': name,
            'data': buffer.tobytes()[:max(buff_size - 1, 0)].decode(),
        }



cdef class ImageEventHandler(EventHandler):
    """Image event handler.
    """

    def __cinit__(self, Camera camera):
        self._event_data = NULL
        self._camera = camera

    def __init__(self, Camera camera):
        with nogil:
            check_ret(spinImageEventHandlerCreate(
                &self._handler,
                <spinImageEventFunction>ImageEventHandler._callback,
                <PyObject *> self
            ))
        self._handler_set = 1

    def __dealloc__(self):
        if self._handler_set:
            self._handler_set = 0
            with nogil:
                check_ret(spinImageEventHandlerDestroy(self._handler))

    @staticmethod
    cdef void _callback(const spinImage data, void* obj_id) nogil except *:
        with gil:
            obj = <DeviceEventHandler>obj_id
            if obj.user_callback is not None:
                obj._event_data = data
                obj.user_callback()

    cpdef attach_handler(self, callback):
        """Attaches the handler to the :class:`~rotpy.camera.Camera` that was
        given when the instance was created. Once called, the callback will be
        called for new images.

        Only one callback can be used per handler instance. Instantiate another
        handler and attach to have multiple handlers.

        :param callback: The callback that will be called upon an image event.
            The function takes no arguments and should do the minimal work to
            prevent blocking the calling thread. Use :meth:`get_last_image`
            to get the event data.
        """
        if self.user_callback is not None:
            raise TypeError("Instance has handler already attached")
        self.user_callback = callback

        with nogil:
            check_ret(spinCameraRegisterImageEventHandler(
                self._camera._camera, self._handler))

    cpdef detach_handler(self):
        """Detaches the handler previously attached with :meth:`attach_handler`.
        """
        with nogil:
            check_ret(spinCameraUnregisterImageEventHandler(
                self._camera._camera, self._handler))
        self.user_callback = None

    cpdef get_last_image(self):
        """Returns image of the last event. If there's no event
        it raises a TypeError exception.
        """
        if self._event_data == NULL:
            raise TypeError("There's no event to introspect")


cdef class DeviceArrivalEventHandler(EventHandler):
    """Device arrival event handler.

    Either the :class:`rotpy.system.SpinSystem` or
    :class:`rotpy.system.InterfaceDevice` must be provided. For the former we'll
    get arrival events across all interfaces, for the latter only for the
    provided interface.
    """

    def __init__(self, SpinSystem system=None, InterfaceDevice interface=None):
        self._system = system
        self._interface = interface
        if system is None and interface is None:
            raise ValueError(
                "At lease one of the system or interface must be provided")

        with nogil:
            check_ret(spinDeviceArrivalEventHandlerCreate(
                &self._handler,
                <spinArrivalEventFunction>DeviceArrivalEventHandler._callback,
                <PyObject *> self
            ))
        self._handler_set = 1

    def __dealloc__(self):
        if self._handler_set:
            self._handler_set = 0
            with nogil:
                check_ret(spinDeviceArrivalEventHandlerDestroy(self._handler))

    @staticmethod
    cdef void _callback(uint64_t serial, void* obj_id) nogil except *:
        with gil:
            obj = <DeviceEventHandler>obj_id
            if obj.user_callback is not None:
                obj.user_callback(serial)

    cpdef attach_handler(self, callback):
        """Attaches the handler to the :class:`rotpy.system.SpinSystem` or
        :class:`rotpy.system.InterfaceDevice` that was
        given when the instance was created. Once called, the callback will be
        called for new device arrival events.

        Only one callback can be used per handler instance. Instantiate another
        handler and attach to have multiple handlers.

        :param callback: The callback that will be called upon an arrival event.
            The function takes one argument - the serial number and it
            should do minimal work to prevent blocking the calling thread.
        """
        cdef spinSystem system
        cdef spinInterface interface

        if self.user_callback is not None:
            raise TypeError("Instance has handler already attached")
        self.user_callback = callback

        if self._system is not None:
            system = self._system._system
            with nogil:
                check_ret(spinSystemRegisterDeviceArrivalEventHandler(
                    system, self._handler))
        else:
            interface = self._interface._interface
            with nogil:
                check_ret(spinInterfaceRegisterDeviceArrivalEventHandler(
                    interface, self._handler))

    cpdef detach_handler(self):
        """Detaches the handler previously attached with :meth:`attach_handler`.
        """
        cdef spinSystem system
        cdef spinInterface interface

        if self._system is not None:
            system = self._system._system
            with nogil:
                check_ret(spinSystemUnregisterDeviceArrivalEventHandler(
                    system, self._handler))
        else:
            interface = self._interface._interface
            with nogil:
                check_ret(spinInterfaceUnregisterDeviceArrivalEventHandler(
                    interface, self._handler))
        self.user_callback = None


cdef class DeviceRemovalEventHandler(EventHandler):
    """Device removal event handler.

    Either the :class:`rotpy.system.SpinSystem` or
    :class:`rotpy.system.InterfaceDevice` must be provided. For the former we'll
    get arrival events across all interfaces, for the latter only for the
    provided interface.
    """

    def __init__(self, SpinSystem system=None, InterfaceDevice interface=None):
        self._system = system
        self._interface = interface
        if system is None and interface is None:
            raise ValueError(
                "At lease one of the system or interface must be provided")

        with nogil:
            check_ret(spinDeviceRemovalEventHandlerCreate(
                &self._handler,
                <spinRemovalEventFunction>DeviceRemovalEventHandler._callback,
                <PyObject *> self
            ))
        self._handler_set = 1

    def __dealloc__(self):
        if self._handler_set:
            self._handler_set = 0
            with nogil:
                check_ret(spinDeviceRemovalEventHandlerDestroy(self._handler))

    @staticmethod
    cdef void _callback(uint64_t serial, void* obj_id) nogil except *:
        with gil:
            obj = <DeviceEventHandler>obj_id
            if obj.user_callback is not None:
                obj.user_callback(serial)

    cpdef attach_handler(self, callback):
        """Attaches the handler to the :class:`rotpy.system.SpinSystem` or
        :class:`rotpy.system.InterfaceDevice` that was
        given when the instance was created. Once called, the callback will be
        called for device removal events.

        Only one callback can be used per handler instance. Instantiate another
        handler and attach to have multiple handlers.

        :param callback: The callback that will be called upon a removal event.
            The function takes one argument - the serial number and it
            should do minimal work to prevent blocking the calling thread.
        """
        cdef spinSystem system
        cdef spinInterface interface

        if self.user_callback is not None:
            raise TypeError("Instance has handler already attached")
        self.user_callback = callback

        if self._system is not None:
            system = self._system._system
            with nogil:
                check_ret(spinSystemRegisterDeviceRemovalEventHandler(
                    system, self._handler))
        else:
            interface = self._interface._interface
            with nogil:
                check_ret(spinInterfaceRegisterDeviceRemovalEventHandler(
                    interface, self._handler))

    cpdef detach_handler(self):
        """Detaches the handler previously attached with :meth:`attach_handler`.
        """
        cdef spinSystem system
        cdef spinInterface interface

        if self._system is not None:
            system = self._system._system
            with nogil:
                check_ret(spinSystemUnregisterDeviceRemovalEventHandler(
                    system, self._handler))
        else:
            interface = self._interface._interface
            with nogil:
                check_ret(spinInterfaceUnregisterDeviceRemovalEventHandler(
                    interface, self._handler))
        self.user_callback = None


cdef class InterfaceEventHandler(EventHandler):
    """Interface event handler (both device arrival and device removal).

    Either the :class:`rotpy.system.SpinSystem` or
    :class:`rotpy.system.InterfaceDevice` must be provided. For the former we'll
    get arrival/removal events across all interfaces including newly added
    interfaces, for the latter only for the     provided interface.
    """

    def __init__(self, SpinSystem system=None, InterfaceDevice interface=None):
        self._system = system
        self._interface = interface
        if system is None and interface is None:
            raise ValueError(
                "At lease one of the system or interface must be provided")

        with nogil:
            check_ret(spinInterfaceEventHandlerCreate(
                &self._handler,
                <spinArrivalEventFunction>InterfaceEventHandler._callback_arrival,
                <spinRemovalEventFunction>InterfaceEventHandler._callback_removal,
                <PyObject *> self
            ))
        self._handler_set = 1

    def __dealloc__(self):
        if self._handler_set:
            self._handler_set = 0
            with nogil:
                check_ret(spinInterfaceEventHandlerDestroy(self._handler))

    @staticmethod
    cdef void _callback_arrival(uint64_t serial, void* obj_id) nogil except *:
        with gil:
            obj = <DeviceEventHandler>obj_id
            if obj.user_callback is not None:
                obj.user_callback(serial, 'arrival')

    @staticmethod
    cdef void _callback_removal(uint64_t serial, void* obj_id) nogil except *:
        with gil:
            obj = <DeviceEventHandler>obj_id
            if obj.user_callback is not None:
                obj.user_callback(serial, 'removal')

    cpdef attach_handler(self, callback):
        """Attaches the handler to the :class:`rotpy.system.SpinSystem` or
        :class:`rotpy.system.InterfaceDevice` that was
        given when the instance was created. Once called, the callback will be
        called for device arrival and removal events.

        Only one callback can be used per handler instance. Instantiate another
        handler and attach to have multiple handlers.

        :param callback: The callback that will be called upon an arrival or
            removal event. The function takes two arguments - the serial number
            and the event type string (``"arrival"`` or ``"removal"``).
            It should do minimal work to prevent blocking the calling thread.
        """
        cdef spinSystem system
        cdef spinInterface interface

        if self.user_callback is not None:
            raise TypeError("Instance has handler already attached")
        self.user_callback = callback

        if self._system is not None:
            system = self._system._system
            with nogil:
                check_ret(spinSystemRegisterInterfaceEventHandler(
                    system, self._handler))
        else:
            interface = self._interface._interface
            with nogil:
                check_ret(spinInterfaceRegisterInterfaceEventHandler(
                    interface, self._handler))

    cpdef detach_handler(self):
        """Detaches the handler previously attached with :meth:`attach_handler`.
        """
        cdef spinSystem system
        cdef spinInterface interface

        if self._system is not None:
            system = self._system._system
            with nogil:
                check_ret(spinSystemUnregisterInterfaceEventHandler(
                    system, self._handler))
        else:
            interface = self._interface._interface
            with nogil:
                check_ret(spinInterfaceUnregisterInterfaceEventHandler(
                    interface, self._handler))
        self.user_callback = None


cdef class LogEventHandler(EventHandler):
    """Log event handler"""

    def __cinit__(self, SpinSystem system):
        self._event_data = NULL
        self._system = system

    def __init__(self, SpinSystem system):
        with nogil:
            check_ret(spinLogEventHandlerCreate(
                &self._handler,
                <spinLogEventFunction>LogEventHandler._callback,
                <PyObject *> self
            ))
        self._handler_set = 1

    def __dealloc__(self):
        if self._handler_set:
            self._handler_set = 0
            with nogil:
                check_ret(spinLogEventHandlerDestroy(self._handler))

    @staticmethod
    cdef void _callback(const spinLogEventData data, void* obj_id) nogil except *:
        with gil:
            obj = <DeviceEventHandler>obj_id
            if obj.user_callback is not None:
                obj._event_data = data
                obj.user_callback()

    cpdef attach_handler(self, callback):
        """Attaches the handler to the :class:`~rotpy.system.SpinSystem` that was
        given when the instance was created. Once called, the callback will be
        called for new log events.

        Only one callback can be used per handler instance. Instantiate another
        handler and attach to have multiple handlers.

        :param callback: The callback that will be called upon an event.
            The function takes no arguments and should do the minimal work to
            prevent blocking the calling thread. Use :meth:`get_last_event_data`
            to get the event data.
        """
        if self.user_callback is not None:
            raise TypeError("Instance has handler already attached")
        self.user_callback = callback

        with nogil:
            check_ret(spinSystemRegisterLogEventHandler(
                self._system._system, self._handler))

    cpdef detach_handler(self):
        """Detaches the handler previously attached with :meth:`attach_handler`.
        """
        with nogil:
            check_ret(spinSystemUnregisterLogEventHandler(
                self._system._system, self._handler))
        self.user_callback = None

    cpdef dict get_last_event_data(self):
            """Returns all the event data of the last event. If there's no event
            it raises a TypeError exception.
            """
            cdef int64_t priority
            cdef char msg1[MAX_BUFF_LEN]
            cdef char msg2[MAX_BUFF_LEN]
            cdef char msg3[MAX_BUFF_LEN]
            cdef char msg4[MAX_BUFF_LEN]
            cdef char msg5[MAX_BUFF_LEN]
            cdef char msg6[MAX_BUFF_LEN]
            cdef size_t n1 = MAX_BUFF_LEN, n2 = MAX_BUFF_LEN, n3 = MAX_BUFF_LEN, \
                n4 = MAX_BUFF_LEN, n5 = MAX_BUFF_LEN, n6 = MAX_BUFF_LEN

            if self._event_data == NULL:
                raise TypeError("There's no event to introspect")

            with nogil:
                check_ret(spinLogDataGetPriority(self._event_data, &priority))
                check_ret(spinLogDataGetCategoryName(self._event_data, msg1, &n1))
                check_ret(spinLogDataGetPriorityName(self._event_data, msg2, &n2))
                check_ret(spinLogDataGetTimestamp(self._event_data, msg3, &n3))
                check_ret(spinLogDataGetNDC(self._event_data, msg4, &n4))
                check_ret(spinLogDataGetThreadName(self._event_data, msg5, &n5))
                check_ret(spinLogDataGetLogMessage(self._event_data, msg6, &n6))

            return {
                'priority_num': priority,
                'category': msg1[:max(n1 - 1, 0)].decode(),
                'priority': msg2[:max(n2 - 1, 0)].decode(),
                'timestamp': msg3[:max(n3 - 1, 0)].decode(),
                'ndc': msg4[:max(n4 - 1, 0)].decode(),
                'thread': msg5[:max(n5 - 1, 0)].decode(),
                'message': msg6[:max(n6 - 1, 0)].decode(),
            }
