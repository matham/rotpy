from ._interface cimport *
from .camera cimport Camera
from .system cimport SpinSystem, InterfaceDevice


cdef class EventHandler:

    cdef int _handler_set
    cdef object user_callback


cdef class DeviceEventHandler(EventHandler):

    cdef spinDeviceEventHandler _handler
    cdef spinDeviceEventData _event_data
    cdef Camera _camera

    @staticmethod
    cdef void _callback(const spinDeviceEventData data, const char * name, void * obj_id) nogil except *
    cpdef attach_handler(self, callback, str event=*)
    cpdef detach_handler(self)
    cpdef dict get_last_event_data(self)


cdef class ImageEventHandler(EventHandler):

    cdef spinImageEventHandler _handler
    cdef spinImage _event_data
    cdef Camera _camera

    @staticmethod
    cdef void _callback(const spinImage data, void * obj_id) nogil except *
    cpdef attach_handler(self, callback)
    cpdef detach_handler(self)
    cpdef get_last_image(self)


cdef class DeviceArrivalEventHandler(EventHandler):

    cdef spinDeviceArrivalEventHandler _handler
    cdef SpinSystem _system
    cdef InterfaceDevice _interface

    @staticmethod
    cdef void _callback(uint64_t serial, void * obj_id) nogil except *
    cpdef attach_handler(self, callback)
    cpdef detach_handler(self)


cdef class DeviceRemovalEventHandler(EventHandler):

    cdef spinDeviceRemovalEventHandler _handler
    cdef SpinSystem _system
    cdef InterfaceDevice _interface

    @staticmethod
    cdef void _callback(uint64_t serial, void * obj_id) nogil except *
    cpdef attach_handler(self, callback)
    cpdef detach_handler(self)


cdef class InterfaceEventHandler(EventHandler):

    cdef spinInterfaceEventHandler _handler
    cdef SpinSystem _system
    cdef InterfaceDevice _interface

    @staticmethod
    cdef void _callback_arrival(uint64_t serial, void * obj_id) nogil except *
    @staticmethod
    cdef void _callback_removal(uint64_t serial, void * obj_id) nogil except *
    cpdef attach_handler(self, callback)
    cpdef detach_handler(self)


cdef class LogEventHandler(EventHandler):

    cdef spinLogEventHandler _handler
    cdef spinLogEventData _event_data
    cdef SpinSystem _system

    @staticmethod
    cdef void _callback(const spinLogEventData data, void * obj_id) nogil except *
    cpdef attach_handler(self, callback)
    cpdef detach_handler(self)
    cpdef dict get_last_event_data(self)
