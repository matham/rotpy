from ._interface cimport *
from .system cimport SpinSystem
from .image cimport Image
from .node cimport NodeMap


cdef class SpinCameraList:

    cdef SpinSystem system
    cdef spinCameraList _cam_list
    cdef int _list_set

    cpdef refresh_cameras(self, int update_interfaces=*, int update_cams=*)
    cpdef int get_size(self)
    cpdef Camera create_camera_by_index(self, int index)
    cpdef remove_camera_by_index(self, int index)
    cpdef Camera create_camera_by_serial(self, str serial)
    cpdef remove_camera_by_serial(self, str serial)
    cpdef extend_camera_list(self, SpinCameraList other_list)


cdef class Camera:

    cdef spinCamera _camera
    cdef int _cam_set

    cdef object set_camera_by_index(self, SpinCameraList cam_list, int index)
    cdef object set_camera_by_serial(
        self, SpinCameraList cam_list, const char * serial)
    cpdef init_cam(self)
    cpdef deinit_cam(self)
    cpdef get_access_mode(self)
    cpdef read_port(self, uint64_t address, int num_bytes)
    cpdef write_port(self, uint64_t address, const unsigned char[:] data)
    cpdef begin_acquisition(self)
    cpdef end_acquisition(self)
    cpdef str get_unique_id(self, int buffer_size=*)
    cpdef is_streaming(self)
    cpdef str get_gui_xml(self, int buffer_size=*)
    cpdef is_valid(self)
    cpdef is_init(self)
    cpdef get_max_packet_size(self)
    # cpdef force_ip(self)
    cpdef Image get_next_image(self, timeout=*)
    cpdef NodeMap get_node_map(self)
    cpdef NodeMap get_tl_node_map(self)
    cpdef NodeMap get_tl_stream_node_map(self)
