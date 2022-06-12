from ._interface cimport *
from .system cimport SpinSystem, EventHandlerBase, InterfaceDevice
from .image cimport Image
from .node cimport NodeMap
from .camera_nodes cimport CameraNodes, TLDevNodes, TLStreamNodes


cdef class DeviceEventHandler(EventHandlerBase):

    cdef object _callback
    cdef RotpyDeviceEventHandler _handler

    cpdef get_event_metadata(self)
    cpdef get_event_data(self, str event_name)
    cdef void handler_callback(self, const gcstring* event) nogil except*


cdef class ImageEventHandler(EventHandlerBase):

    cdef object _callback
    cdef RotpyImageEventHandler _handler

    cdef void handler_callback(self, ImagePtr image_ptr) nogil except*


cdef class CameraList:

    cdef SpinSystem system
    cdef InterfaceDevice _interface
    cdef CCameraList _cam_list

    cdef void set_system(self, SpinSystem system, CCameraList cam_list)
    cdef void set_interface(self, InterfaceDevice interface, CCameraList cam_list)
    cpdef get_size(self)
    cpdef create_camera_by_index(self, unsigned int index)
    cpdef remove_camera_by_index(self, unsigned int index)
    cpdef create_camera_by_serial(self, str serial)
    cpdef remove_camera_by_serial(self, str serial)
    cpdef create_camera_by_dev_id(self, str dev_id)
    cpdef remove_camera_by_dev_id(self, str dev_id)
    cpdef extend_camera_list(self, CameraList other_list)


cdef class Camera:

    cdef CameraPtr _camera
    cdef CameraList _cam_list
    cdef int _cam_set
    cdef set _image_handlers
    cdef set _dev_handlers
    cdef object _user_buf

    cdef public CameraNodes camera_nodes
    cdef public TLDevNodes tl_dev_nodes
    cdef public TLStreamNodes tl_stream_nodes

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
    cpdef attach_device_event_handler(self, DeviceEventHandler handler, str name=*)
    cpdef detach_device_event_handler(self, DeviceEventHandler handler)
    cpdef attach_image_event_handler(self, ImageEventHandler handler)
    cpdef detach_image_event_handler(self, ImageEventHandler handler)
    cpdef get_buffer_ownership(self)
    cpdef set_buffer_ownership(self, str ownership)
    cpdef get_buffer_count(self)
    cpdef get_buffer_size(self)
    cpdef get_buffer_total_size(self)
    cpdef set_user_buffer(self, buffer)
    cpdef set_user_buffers(self, buffers, uint64_t buffer_size)
    cpdef get_unique_id(self)
    cpdef is_streaming(self)
    cpdef get_gui_xml(self)
    cpdef is_valid(self)
    cpdef is_init(self)
    cpdef get_max_packet_size(self)
    cpdef get_num_images_in_use(self)
    cpdef get_num_data_streams(self)
    cpdef force_ip(self)
    cpdef get_next_image(self, timeout=*, uint64_t stream_id=*)
    cpdef get_node_map(self)
    cpdef get_tl_dev_node_map(self)
    cpdef get_tl_stream_node_map(self)
