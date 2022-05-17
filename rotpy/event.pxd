from ._interface cimport *


cdef class EventHandler:
    cdef int _handler_set
    cdef object user_callback


cdef class DeviceEventHandler(EventHandler):
    cdef spinDeviceEventHandler _handler
    cdef spinDeviceEventData _event_data

    @staticmethod
    cdef void _callback(const spinDeviceEventData data, const char * name, void * obj_id) nogil except *


cdef class ImageEventHandler(EventHandler):
    cdef spinImageEventHandler _handler
    cdef spinImage _event_data

    @staticmethod
    cdef void _callback(const spinImage data, void * obj_id) nogil except *


cdef class DeviceArrivalEventHandler(EventHandler):
    cdef spinDeviceArrivalEventHandler _handler

    @staticmethod
    cdef void _callback(uint64_t serial, void * obj_id) nogil except *


cdef class DeviceRemovalEventHandler(EventHandler):
    cdef spinDeviceRemovalEventHandler _handler

    @staticmethod
    cdef void _callback(uint64_t serial, void * obj_id) nogil except *


cdef class InterfaceEventHandler(EventHandler):
    cdef spinInterfaceEventHandler _handler

    @staticmethod
    cdef void _callback_arrival(uint64_t serial, void * obj_id) nogil except *
    @staticmethod
    cdef void _callback_removal(uint64_t serial, void * obj_id) nogil except *


cdef class LogEventHandler(EventHandler):
    cdef spinLogEventHandler _handler
    cdef spinLogEventData _event_data

    @staticmethod
    cdef void _callback(const spinLogEventData data, void * obj_id) nogil except *
