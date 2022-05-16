from ._interface cimport *
from .system cimport SpinSystem


cdef class SpinCameraList:

    cdef SpinSystem system
    cdef spinCameraList _cam_list
    cdef int _list_set

    cpdef refresh_cameras(self, int update_interfaces=*, int update_cams=*)
    cpdef int get_size(self)
    cpdef Camera create_camera_by_index(self, size_t index)
    cpdef remove_camera_by_index(self, size_t index)
    cpdef Camera create_camera_by_serial(self, str serial)
    cpdef remove_camera_by_serial(self, str serial)
    cpdef extend_camera_list(self, SpinCameraList other_list)


cdef class Camera:

    cdef spinCamera _camera
    cdef int _cam_set

    cdef object set_camera_by_index(self, SpinCameraList cam_list, size_t index)
    cdef object set_camera_by_serial(
        self, SpinCameraList cam_list, const char * serial)
    cpdef init_cam(self)
    cpdef deinit_cam(self)
