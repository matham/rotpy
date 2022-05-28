from ._interface cimport *
from .system cimport SpinSystem
from .image cimport Image
# from .node cimport NodeMap


cdef class CameraList:

    cdef SpinSystem system
    cdef CCameraList _cam_list
    cdef int _list_set

    cpdef refresh_cameras(self, cbool update_interfaces=*, cbool update_cams=*)
    cpdef get_size(self)
    cpdef Camera create_camera_by_index(self, unsigned int index)
    cpdef remove_camera_by_index(self, unsigned int index)
    cpdef Camera create_camera_by_serial(self, str serial)
    cpdef remove_camera_by_serial(self, str serial)
    cpdef Camera create_camera_by_dev_id(self, str dev_id)
    cpdef remove_camera_by_dev_id(self, str dev_id)
    cpdef extend_camera_list(self, CameraList other_list)


cdef class Camera:

    cdef CameraPtr _camera
    cdef CameraList _cam_list
    cdef int _cam_set

    cdef object set_camera_by_index(self, CameraList cam_list, unsigned int index)
    cdef object set_camera_by_serial(self, CameraList cam_list, bytes serial)
    cdef object set_camera_by_dev_id(self, CameraList cam_list, bytes dev_id)
    cpdef init_cam(self)
    cpdef deinit_cam(self)
    cpdef get_access_mode(self)
    cpdef read_port(self, uint64_t address, size_t num_bytes)
    cpdef write_port(self, uint64_t address, const unsigned char[:] data)
    cpdef begin_acquisition(self)
    cpdef end_acquisition(self)
    cpdef get_buffer_ownership(self)
    cpdef set_buffer_ownership(self, str ownership)
    cpdef get_buffer_count(self)
    cpdef get_buffer_size(self)
    cpdef get_buffer_total_size(self)
    cpdef get_unique_id(self)
    cpdef is_streaming(self)
    cpdef get_gui_xml(self)
    cpdef is_valid(self)
    cpdef is_init(self)
    cpdef get_max_packet_size(self)
    cpdef get_num_images_in_use(self)
    cpdef get_num_data_streams(self)
    cpdef force_ip(self)
    cpdef Image get_next_image(self, timeout=*, uint64_t stream_id=*)
    # cpdef NodeMap get_node_map(self)
    # cpdef NodeMap get_tl_node_map(self)
    # cpdef NodeMap get_tl_stream_node_map(self)
