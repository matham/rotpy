from cpython.ref cimport PyObject


__all__ = ('EventHandler', )


cdef class EventHandler:
    """Callback may not raise an exception.
    """

    def __cinit__(self):
        self._handler_set = 0
        self.user_callback = None


cdef class DeviceEventHandler(EventHandler):
    """Device event handler.
    """

    def __cinit__(self):
        self._event_data = NULL

    def __init__(self):
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


cdef class ImageEventHandler(EventHandler):
    """Image event handler.
    """

    def __cinit__(self):
        self._event_data = NULL

    def __init__(self):
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


cdef class DeviceArrivalEventHandler(EventHandler):
    """Device arrival event handler.
    """

    def __init__(self):
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


cdef class DeviceRemovalEventHandler(EventHandler):
    """Device removal event handler.
    """

    def __init__(self):
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


cdef class InterfaceEventHandler(EventHandler):
    """Interface event handler (both device arrival and device removal).
    """

    def __init__(self):
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


cdef class LogEventHandler(EventHandler):
    """Log event handler"""

    def __cinit__(self):
        self._event_data = NULL

    def __init__(self):
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
