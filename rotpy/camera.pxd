from ._interface cimport *
cimport rotpy.system
cimport rotpy.image
cimport rotpy.camera_nodes
from .node cimport NodeMap


cdef class DeviceEventHandler(rotpy.system.EventHandlerBase):

    cdef object _callback
    cdef Camera _camera
    cdef RotpyDeviceEventHandler _handler

    cdef set_callback(self, Camera camera, callback, str event_name=*)
    cpdef get_event_metadata(self)
    cpdef get_event_data(self, str event_name)
    cdef void handler_callback(self, const gcstring* event) nogil except*


cdef class ImageEventHandler(rotpy.system.EventHandlerBase):

    cdef object _callback
    cdef Camera _camera
    cdef RotpyImageEventHandler _handler

    cdef set_callback(self, Camera camera, callback)
    cdef void handler_callback(self, ImagePtr image_ptr) nogil except*


cdef class CameraList:

    cdef rotpy.system.SpinSystem system
    cdef rotpy.system.InterfaceDevice _interface
    cdef CCameraList _cam_list

    cdef void set_system(self, rotpy.system.SpinSystem system, CCameraList cam_list)
    cdef void set_interface(self, rotpy.system.InterfaceDevice interface, CCameraList cam_list)
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

    cdef public rotpy.camera_nodes.CameraNodes camera_nodes
    """The pre-listed camera nodes from :class:`~rotpy.camera_nodes.CameraNodes`.

    Use this property to get a pre-instantiated
    :class:`~rotpy.camera_nodes.CameraNodes` because
    :class:`~rotpy.camera_nodes.CameraNodes` is not user instantiable.

    .. note::

        Remember to check whether each of the pre-listed nodes are
        :meth:`~rotpy.node.SpinBaseNode.is_available`,
        :meth:`~rotpy.node.SpinBaseNode.is_readable`,
        :meth:`~rotpy.node.SpinBaseNode.is_writable` etc.
    """
    cdef public rotpy.camera_nodes.TLDevNodes tl_dev_nodes
    """The pre-listed transport layer device nodes from :class:`~rotpy.camera_nodes.TLDevNodes`.

    Use this property to get a pre-instantiated
    :class:`~rotpy.camera_nodes.TLDevNodes` because
    :class:`~rotpy.camera_nodes.TLDevNodes` is not user instantiable.

    .. note::

        Remember to check whether each of the pre-listed nodes are
        :meth:`~rotpy.node.SpinBaseNode.is_available`,
        :meth:`~rotpy.node.SpinBaseNode.is_readable`,
        :meth:`~rotpy.node.SpinBaseNode.is_writable` etc.
    """
    cdef public rotpy.camera_nodes.TLStreamNodes tl_stream_nodes
    """The pre-listed transport layer streaming nodes from :class:`~rotpy.camera_nodes.TLStreamNodes`.

    Use this property to get a pre-instantiated
    :class:`~rotpy.camera_nodes.TLStreamNodes` because
    :class:`~rotpy.camera_nodes.TLStreamNodes` is not user instantiable.

    .. note::

        Remember to check whether each of the pre-listed nodes are
        :meth:`~rotpy.node.SpinBaseNode.is_available`,
        :meth:`~rotpy.node.SpinBaseNode.is_readable`,
        :meth:`~rotpy.node.SpinBaseNode.is_writable` etc.
    """

    cdef object set_camera_by_index(self, CameraList cam_list, unsigned int index)
    cdef object set_camera_by_serial(self, CameraList cam_list, bytes serial)
    cdef object set_camera_by_dev_id(self, CameraList cam_list, bytes dev_id)
    cpdef release(self)
    cpdef init_cam(self)
    cpdef deinit_cam(self)
    cpdef get_access_mode(self)
    cpdef read_port(self, uint64_t address, size_t num_bytes)
    cpdef write_port(self, uint64_t address, const unsigned char[:] data)
    cpdef begin_acquisition(self)
    cpdef end_acquisition(self)
    cpdef attach_device_event_handler(self, callback, str name=*)
    cpdef detach_device_event_handler(self, DeviceEventHandler handler)
    cpdef attach_image_event_handler(self, callback)
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
