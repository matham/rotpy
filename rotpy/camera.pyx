from .system import SpinSystem
from.names import img_status_values, access_mode_values, buffer_owner_values, \
    buffer_owner_names
from .node import NodeMap
from .camera_nodes cimport CameraNodes, TLDevNodes, TLStreamNodes

cimport cpython.array
from array import array

__all__ = ('CameraList', 'Camera')

DEF MAX_BUFF_LEN = 256


cdef class CameraList:
    """Provides access to camera lists. This includes updating, size, and
    camera retrieval.
    """

    def __cinit__(self, SpinSystem system):
        self._list_set = 0
        self.system = system

    def __init__(self, SpinSystem system):
        cdef SystemPtr system_ptr = system._system
        with nogil:
            self._cam_list = system_ptr.get().GetCameras(0, 0)
        self._list_set = 1

    def __dealloc__(self):
        if self._list_set:
            self._list_set = 0
            with nogil:
                self._cam_list.Clear()

    cpdef refresh_cameras(
            self, cbool update_interfaces=False, cbool update_cams=False):
        """Retrieves the list of detected (and enumerable) cameras on the
        system.

        :param update_interfaces: Whether to update the interface list.
        :param update_cams: Whether to update the camera list to detect
            new/removed cameras.
        """
        cdef SystemPtr system = self.system._system
        with nogil:
            self._cam_list.Clear()
            self._cam_list = system.get().GetCameras(
                update_interfaces, update_cams)

    cpdef get_size(self):
        """Retrieves the number of cameras in the camera list.
        """
        cdef size_t n
        with nogil:
            n = self._cam_list.GetSize()
        return n

    cpdef Camera create_camera_by_index(self, unsigned int index):
        """Retrieves a camera from this camera list using an index.

        :param index: The index of the camera.
        :return: A :class:`Camera`.
        """
        camera = Camera()
        camera.set_camera_by_index(self, index)
        return camera

    cpdef remove_camera_by_index(self, unsigned int index):
        """Removes a camera from this camera list using its index.

        :param index: The index of the camera to remove.
        """
        with nogil:
            self._cam_list.RemoveByIndex(index)

    cpdef Camera create_camera_by_serial(self, str serial):
        """Retrieves a camera from this camera list using its serial number.

        :param serial: The serial number of the camera to retrieve.
        :return: A :class:`Camera`.
        """
        cdef bytes buf = serial.encode()
        camera = Camera()
        camera.set_camera_by_serial(self, buf)
        return camera

    cpdef remove_camera_by_serial(self, str serial):
        """Removes a camera from this camera list using its serial number.

        :param serial: The serial number of the camera to remove.
        """
        cdef bytes buf = serial.encode()
        cdef cstr c_string = buf
        with nogil:
            self._cam_list.RemoveBySerial(c_string)

    cpdef Camera create_camera_by_dev_id(self, str dev_id):
        """Retrieves a camera from this camera list using its device identifier.

        :param dev_id: The device identifier of the camera to retrieve.
        :return: A :class:`Camera`.
        """
        cdef bytes buf = dev_id.encode()
        camera = Camera()
        camera.set_camera_by_dev_id(self, buf)
        return camera

    cpdef remove_camera_by_dev_id(self, str dev_id):
        """Removes a camera from this camera list using its device identifier.

        :param dev_id: The device identifier of the camera to remove.
        """
        cdef bytes buf = dev_id.encode()
        cdef cstr c_string = buf
        with nogil:
            self._cam_list.RemoveByDeviceID(c_string)

    cpdef extend_camera_list(self, CameraList other_list):
        """Appends all the cameras from the other camera list to this list.

        :param other_list: The camera list to add to us.
        """
        cdef CCameraList cam_list = other_list._cam_list
        with nogil:
            self._cam_list.Append(cam_list)


cdef class Camera:

    def __cinit__(self):
        self._cam_set = 0
        self.camera_nodes = CameraNodes(camera=self)
        self.tl_dev_nodes = TLDevNodes(camera=self)
        self.tl_stream_nodes = TLStreamNodes(camera=self)

    def __dealloc__(self):
        if self._cam_set:
            self._cam_set = 0

    cdef object set_camera_by_index(
            self, CameraList cam_list, unsigned int index):
        with nogil:
            self._camera = cam_list._cam_list.GetByIndex(index)

        if not self._camera.IsValid():
            raise ValueError(f'Could not find camera at index "{index}"')
        self._cam_list = cam_list
        self._cam_set = 1

    cdef object set_camera_by_serial(
            self, CameraList cam_list, bytes serial):
        cdef cstr c_string = serial
        with nogil:
            self._camera = cam_list._cam_list.GetBySerial(c_string)

        if not self._camera.IsValid():
            raise ValueError(
                f'Could not find camera with serial "{serial.decode()}"')
        self._cam_list = cam_list
        self._cam_set = 1

    cdef object set_camera_by_dev_id(
            self, CameraList cam_list, bytes dev_id):
        cdef cstr c_string = dev_id
        with nogil:
            self._camera = cam_list._cam_list.GetByDeviceID(c_string)

        if not self._camera.IsValid():
            raise ValueError(
                f'Could not find camera with device ID "{dev_id.decode()}"')
        self._cam_list = cam_list
        self._cam_set = 1

    cpdef init_cam(self):
        """Initializes a camera, allowing for much more interaction.
        """
        with nogil:
            self._camera.get().Init()

    cpdef deinit_cam(self):
        """De-initializes a camera that was initialized with :meth:`init_cam`.
        """
        with nogil:
            self._camera.get().DeInit()

    cpdef get_access_mode(self):
        """Returns the access mode that the software has on the Camera as a
        string from :attr:`~rotpy.names.access_mode_names`.

        The camera does not need to be initialized before calling this function.
        """
        cdef EAccessMode mode
        with nogil:
            mode = self._camera.get().GetAccessMode()
        return access_mode_values[mode]

    cpdef read_port(self, uint64_t address, size_t num_bytes):
        """Reads a remote port on a physical Camera. This function can be used
        to read registers on the camera.

        :param address: A 64 bit address to a register on the camera.
        :param num_bytes: Number of bytes to read.
        :return: An bytes object with the read bytes.

        .. warning::

            Only perform direct read/write to a register if the register isn't
            supported in the device nodemap. Otherwise the camera and nodemap
            may be left in an undefined state after the register read/write.
        """
        buffer = array('B', b'\0' * num_bytes)
        cdef unsigned char[:] arr = buffer
        with nogil:
            self._camera.get().ReadPort(address, &arr[0], num_bytes)
        return buffer.tobytes()

    cpdef write_port(self, uint64_t address, unsigned char[:] data):
        """Writes a remote port on a physical Camera. This function can be used
        to write registers on the camera.

        :param address: A 64 bit address to a register on the camera.
        :param data: Bytes or memory view-convertible bytes to write.

        .. warning::

            Only perform direct read/write to a register if the register isn't
            supported in the device nodemap. Otherwise the camera and nodemap
            may be left in an undefined state after the register read/write.
        """
        cdef int size = data.size
        with nogil:
            self._camera.get().WritePort(address, &data[0], size)

    cpdef begin_acquisition(self):
        """Starts the image acquisition engine.

        The camera must be initialized first.
        """
        with nogil:
            self._camera.get().BeginAcquisition()

    cpdef end_acquisition(self):
        """Stops the image acquisition engine.

        If :meth:`end_acquisition` is called without a prior call to
        :meth:`begin_acquisition` an error will be thrown.

        All Images that were acquired using :meth:`get_next_image` need to be
        released first before calling this. All buffers in the input pool and
        output queue will be discarded when this is called.
        """
        with nogil:
            self._camera.get().EndAcquisition()

    cpdef get_buffer_ownership(self):
        """Gets data buffer ownership as a string from
        :attr:`~rotpy.names.buffer_owner_names`.

        The data buffers can be owned by System or User. If the system owns the
        buffers, the memory required for the buffers are allocated and freed by
        the library.  If user owns the buffers, the user is responsible for
        allocating and ultimately freeing the memory. By default, data buffers
        are owned by the library.
        """
        cdef BufferOwnership owner
        with nogil:
            owner = self._camera.get().GetBufferOwnership()
        return buffer_owner_values[owner]

    cpdef set_buffer_ownership(self, str ownership):
        """Sets data buffer ownership from a string from
        :attr:`~rotpy.names.buffer_owner_names`.

        The data buffers can be owned by System or User. If the system owns the
        buffers, the memory required for the buffers are allocated and freed by
        the library.  If user owns the buffers, the user is responsible for
        allocating and ultimately freeing the memory. By default, data buffers
        are owned by the library.
        """
        cdef BufferOwnership o = buffer_owner_names[ownership]
        with nogil:
            self._camera.get().SetBufferOwnership(o)

    cpdef get_buffer_count(self):
        """Gets the number of user memory buffers.

        This will throw an exception if user memory buffer has not been set. If
        the user memory is contiguous, this will throw an exception unless
        :meth:`begin_acquisition` has been called.
        """
        cdef uint64_t n
        with nogil:
            n = self._camera.get().GetUserBufferCount()
        return n

    cpdef get_buffer_size(self):
        """Gets the size of one user memory buffer (in bytes).

        This will throw an exception if user memory buffer has not been set.
        If the user memory is contiguous, this will throw an exception unless
        :meth:`begin_acquisition` has been called. To prevent image tearing when
        working with USB3 cameras, the size of each buffer should be equal to
        ``((unsigned int) (bufferSize + 1024 - 1) / 1024) * 1024``
        where 1024 is the USB3 packet size.
        """
        cdef uint64_t n
        with nogil:
            n = self._camera.get().GetUserBufferSize()
        return n

    cpdef get_buffer_total_size(self):
        """Gets the total size of all the user memory buffers (in bytes).

        This will throw an exception if user memory buffer has not been set.
        """
        cdef uint64_t n
        with nogil:
            n = self._camera.get().GetUserBufferTotalSize()
        return n

    cpdef get_unique_id(self):
        """This returns a unique id string that identifies the camera. This is
        the camera serial number
        """
        cdef gcstring s
        with nogil:
            s = self._camera.get().GetUniqueID()
        return s.c_str().decode()

    cpdef is_streaming(self):
        """Checks whether a camera is currently streaming.
        """
        cdef cbool streaming
        with nogil:
            streaming = self._camera.get().IsStreaming()
        return bool(streaming)

    cpdef get_gui_xml(self):
        """Retrieves the GUI XML from the camera, that can be passed into the
        Spinnaker GUI framework.
        """
        cdef gcstring s
        with nogil:
            s = self._camera.get().GetGuiXml()
        return s.c_str().decode()

    cpdef is_valid(self):
        """Checks whether a camera is still valid for use.
        """
        cdef cbool valid
        with nogil:
            valid = self._camera.get().IsValid()
        return bool(valid)

    cpdef is_init(self):
        """Checks whether a camera is currently initialized.
        """
        cdef cbool init
        with nogil:
            init = self._camera.get().IsInitialized()
        return bool(init)

    cpdef get_max_packet_size(self):
        """Returns the largest packet size that can be safely used on the
        interface that the device is connected to.
        """
        cdef unsigned int s
        with nogil:
            s = self._camera.get().DiscoverMaxPacketSize()
        return s

    cpdef get_num_images_in_use(self):
        """Returns the number of images that are currently in use.
        """
        cdef unsigned int s
        with nogil:
            s = self._camera.get().GetNumImagesInUse()
        return s

    cpdef get_num_data_streams(self):
        """Returns the number of streams that a device supports.
        """
        cdef unsigned int s
        with nogil:
            s = self._camera.get().GetNumDataStreams()
        return s

    cpdef force_ip(self):
        """Forces the camera to be on the same subnet as its corresponding
        interface (e.g. for gigE cameras).
        """
        with nogil:
            self._camera.get().ForceIP()

    cpdef get_next_image(
            self, timeout=None, uint64_t stream_id=0):
        """Gets the next image that was received by the transport layer.

        :param timeout: Optional timeout in seconds. If not provided, it may
            wait indefinitely until an image becomes available. If provided,
            if it times out before an image is available it returns None.
        :param stream_id: The stream to grab the image. Most cameras support
            one stream so the default ``stream_id`` is 0 but if a camera
            supports multiple streams you can input the stream ID to select from
            which stream to grab images.
        :return: An :class:`~rotpy.image.Image` or None if it timed out.

        .. warning::

            Make sure to call :meth:`~rotpy.image.Image.release` as quickly as
            possible after getting the image. Because until the image is
            released, the camera cannot re-use the buffer. So, if too many
            buffers are held, the camera may run out of buffers in which to
            store images.
        """
        cdef ImagePtr raw_img
        cdef cbool incomplete
        cdef uint64_t to = EVENT_TIMEOUT_INFINITE
        cdef ImageStatus status
        cdef const char* msg

        if timeout is not None:
            to = round(timeout * 1000)
        with nogil:
            raw_img = self._camera.get().GetNextImage(to, stream_id)

        with nogil:
            incomplete = raw_img.get().IsIncomplete()
            if incomplete:
                status = raw_img.get().GetImageStatus()
                msg = CImage.GetImageStatusDescription(status)
                raw_img.get().Release()

        if incomplete:
            raise ValueError(
                f'Image incomplete: "{msg.decode()}" '
                f'"({img_status_values[status]})"')
        return Image.create_from_camera(raw_img)

    cpdef get_node_map(self):
        """Gets the :class:`~rotpy.node.NodeMap` that is generated from a
        GenICam XML file.

        The camera must be initialized by a call to :meth:`init_cam` first
        before the node map can be successfully acquired.

        :return: A :class:`~rotpy.node.NodeMap`.
        """
        cdef INodeMap* handle
        cdef NodeMap node_map = NodeMap()
        with nogil:
            handle = &self._camera.get().GetNodeMap()
        node_map.set_handle(handle)

        return node_map

    cpdef get_tl_dev_node_map(self):
        """Gets the :class:`~rotpy.node.NodeMap` that is generated from a
        GenICam XML file for the GenTL Device module.

        The camera does not need to be initialized with :meth:`init_cam` before
        acquiring this node map.

        :return: A :class:`~rotpy.node.NodeMap`.
        """
        cdef INodeMap* handle
        cdef NodeMap node_map = NodeMap()
        with nogil:
            handle = &self._camera.get().GetTLDeviceNodeMap()
        node_map.set_handle(handle)

        return node_map

    cpdef get_tl_stream_node_map(self):
        """Gets the :class:`~rotpy.node.NodeMap` that is generated from a
        GenICam XML file for the GenTL Stream module.

        The camera does not need to be initialized with :meth:`init_cam` before
        acquiring this node map.

        :return: A :class:`~rotpy.node.NodeMap`.
        """
        cdef INodeMap* handle
        cdef NodeMap node_map = NodeMap()
        with nogil:
            handle = &self._camera.get().GetTLStreamNodeMap()
        node_map.set_handle(handle)

        return node_map
