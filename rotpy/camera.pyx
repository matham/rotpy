"""Camera
=========

Provides access to the camera lists, the cameras, and camera related
event handlers.
"""
from .names.spin import img_status_values, buffer_owner_values, \
    buffer_owner_names, event_values
from .names.geni import AccessMode_values
from .node import NodeMap

cimport rotpy.system
cimport rotpy.image
cimport rotpy.camera_nodes

from cpython.ref cimport PyObject
cimport cpython.array
from libc.stdlib cimport malloc, free
from array import array

__all__ = ('DeviceEventHandler', 'ImageEventHandler', 'CameraList', 'Camera')


cdef class DeviceEventHandler(rotpy.system.EventHandlerBase):
    """A camera event handler that is returned by
    :meth:`~Camera.attach_device_event_handler` that handles callbacks for
    camera events.

    This represents a callback function that is called on each event with
    3 positional arguments: this instance, the :class:`Camera` instance that
    created this, and the event name string.
    """

    cdef set_callback(self, Camera camera, callback, str event_name=''):

        cdef bytes name_b = event_name.encode()
        cdef size_t n = len(event_name)
        cdef const char* name_c = name_b
        cdef gcstring s

        self._callback = callback
        self._camera = camera

        if event_name:
            s.assign(name_c, n)
        self._handler.SetCallback(
            <PyObject*>self,
            <void (*)(void *, const gcstring *) nogil>self.handler_callback, s)

    cpdef get_event_metadata(self):
        """Returns the metadata associated with the callback event.

        It returns a 3-tuple of ``(event_type, dev_name, dev_event_id)``.
        Where ``event_type`` is the string event type from
        :attr:`~rotpy.names.spin.event_names`. ``dev_name`` is the name of the
        device event. And ``dev_event_id`` is the ID of the device event.

        .. warning::

            This is only valid if called from within the callback, not once the
            callback is completed.
        """
        cdef const char * msg
        cdef uint64_t dev_event_id
        cdef EventType event_tp

        with nogil:
            dev_event_id = self._handler.GetDeviceEventId()
            event_tp = self._handler.GetEventType()
            msg = self._handler.GetDeviceEventName().c_str()

        dev_name = msg.decode()
        event_type = event_values[event_tp]

        return event_type, dev_name, dev_event_id

    cpdef get_event_data(self, str event_name):
        """Returns the data associated with the callback event.

        It returns a dictionary of data values or None if no data is associated
        with the event.

        .. warning::

            This is only valid if called from within the callback, not once the
            callback is completed.
        """
        cdef DeviceEventInferenceData inference_data
        cdef DeviceEventExposureEndData exposure_end_data
        cdef dict data = None

        if event_name == "EventInference":
            with nogil:
                DeviceEventUtility.ParseDeviceEventInference(
                    self._handler.GetEventPayloadData(),
                    self._handler.GetEventPayloadDataSize(), inference_data)
            data = {
                'value': inference_data.result,
                'confidence': inference_data.confidence,
                'frame_id': inference_data.frameID}
        elif event_name == "EventExposureEnd":
            with nogil:
                DeviceEventUtility.ParseDeviceEventExposureEnd(
                    self._handler.GetEventPayloadData(),
                    self._handler.GetEventPayloadDataSize(), exposure_end_data)
            data = {'frame_id': exposure_end_data.frameID}

        return data

    cdef void handler_callback(self, const gcstring* event) nogil except *:
        cdef const char *msg = event.c_str()
        with gil:
            if self._callback is None:
                return
            self._callback(self, self._camera, msg.decode())


cdef class ImageEventHandler(rotpy.system.EventHandlerBase):
    """A camera image handler that is returned by
    :meth:`~Camera.attach_image_event_handler` that handles callbacks for
    camera images arrival events.

    This represents a callback function that is called every time a new image
    becomes available with 3 positional arguments: this instance, the
    :class:`Camera` instance that created this, and the
    :class:`~rotpy.image.Image` instance representing the new image.

    Remember to :meth:`~rotpy.image.Image.release` the image quickly so that
    the buffers can be re-used by the camera.
    """

    cdef set_callback(self, Camera camera, callback):
        self._callback = callback
        self._camera = camera

        self._handler.SetCallback(
            <PyObject*>self, <void (*)(void *, ImagePtr) nogil>
            self.handler_callback)

    cdef void handler_callback(self, ImagePtr image_ptr) nogil except*:
        if image_ptr.get().IsIncomplete():
            return

        with gil:
            if self._callback is None:
                return
            self._callback(
                self, self._camera,
                rotpy.image.Image.create_from_camera(image_ptr))


cdef class CameraList:
    """Provides access to cameras enumerated by the system or interfaces as a
    list of cameras on the system or specific to that interface.

    .. warning::

        Do **not** create a :class:`CameraList` manually, rather get it from
        :meth:`create_from_system` or :meth:`create_from_interface`.

    Once a :class:`CameraList` is created from the system or interface,
    updating the system or interface so it detects new cameras will **not**
    be reflected in existing :class:`CameraList`. Instead, create a new one
    to access those new cameras.
    """

    def __cinit__(self):
        self.system = None
        self._interface = None

    def __dealloc__(self):
        if self.system is not None or self._interface is not None:
            # this is only called after all cameras are dead because each camera
            # has a ref to the camera list
            with nogil:
                self._cam_list.Clear()
            self.system = None
            self._interface = None

    cdef void set_system(
            self, rotpy.system.SpinSystem system, CCameraList cam_list):
        self.system = system
        self._cam_list = cam_list

    cdef void set_interface(
            self, rotpy.system.InterfaceDevice interface, CCameraList cam_list):
        self._interface = interface
        self._cam_list = cam_list

    @staticmethod
    def create_from_system(
            rotpy.system.SpinSystem system, cbool update_interfaces=True,
            cbool update_cams=True):
        """Creates and returns a new :class:`CameraList` for accessing
        cameras across all interfaces on the system.

        This returns both GigE Vision and Usb3 Vision cameras from all
        interfaces.

        :param system: A :class:`~rotpy.system.SpinSystem` instance.
        :param update_interfaces: Whether to update the system's internal
            interface list before getting the camera list from all the
            interfaces.
        :param update_cams: Whether to update the system's internal camera list
            to detect new/removed cameras before getting the camera list.
        :return: A :class:`CameraList`.
        """
        cdef CameraList cam_list = CameraList()
        cam_list.set_system(
            system,
            system._system.get().GetCameras(update_interfaces, update_cams))
        return cam_list

    @staticmethod
    def create_from_interface(
            rotpy.system.InterfaceDevice interface, cbool update_cams=True):
        """Creates and returns a new :class:`CameraList` for accessing
        the cameras on a specific interface.

        It returns either usb3 vision or gige vision cameras depending on the
        underlying transport layer of this interface.

        :param interface: A :class:`~rotpy.system.InterfaceDevice` instance.
        :param update_cams: Whether to update the interface's internal camera
            list to detect new/removed cameras before getting the camera list.
        :return: A :class:`CameraList`.
        """
        cdef CameraList cam_list = CameraList()
        cam_list.set_interface(
            interface, interface._interface.get().GetCameras(update_cams))
        return cam_list

    cpdef get_size(self):
        """Retrieves the number of cameras in the camera list.
        """
        cdef size_t n
        with nogil:
            n = self._cam_list.GetSize()
        return n

    cpdef create_camera_by_index(self, unsigned int index):
        """Retrieves a camera from this camera list using a zero-based index
        that is less than :meth:`get_size`.

        :param index: The index of the camera.
        :return: A :class:`Camera`.
        """
        cdef Camera camera = Camera()
        camera.set_camera_by_index(self, index)
        return camera

    cpdef remove_camera_by_index(self, unsigned int index):
        """Removes a camera from this camera list using its index.

        :param index: The index of the camera to remove.
        """
        with nogil:
            self._cam_list.RemoveByIndex(index)

    cpdef create_camera_by_serial(self, str serial):
        """Retrieves a camera from this camera list using its serial number
        string.

        :param serial: The serial number of the camera to retrieve.
        :return: A :class:`Camera`.

        You can get a camera's serial number using the ``"DeviceSerialNumber"``
        node once the camera is :meth:`~Camera.init_cam`. It's pre-listed
        at :attr:`~rotpy.camera_nodes.CameraNodes.DeviceSerialNumber`.
        """
        cdef bytes buf = serial.encode()
        cdef Camera camera = Camera()
        camera.set_camera_by_serial(self, buf)
        return camera

    cpdef remove_camera_by_serial(self, str serial):
        """Removes a camera from this camera list using its serial number
        string.

        :param serial: The serial number of the camera to remove.

        You can get a camera's serial number using the ``"DeviceSerialNumber"``
        node once the camera is :meth:`~Camera.init_cam`. It's pre-listed
        at :attr:`~rotpy.camera_nodes.CameraNodes.DeviceSerialNumber`.
        """
        cdef bytes buf = serial.encode()
        cdef cstr c_string = buf
        with nogil:
            self._cam_list.RemoveBySerial(c_string)

    cpdef create_camera_by_dev_id(self, str dev_id):
        """Retrieves a camera from this camera list using its device identifier.

        :param dev_id: The device identifier of the camera to retrieve.
            This can be gotten from :meth:`~Camera.get_unique_id`.
        :return: A :class:`Camera`.
        """
        cdef bytes buf = dev_id.encode()
        cdef Camera camera = Camera()
        camera.set_camera_by_dev_id(self, buf)
        return camera

    cpdef remove_camera_by_dev_id(self, str dev_id):
        """Removes a camera from this camera list using its device identifier.

        :param dev_id: The device identifier of the camera to remove.
            This can be gotten from :meth:`~Camera.get_unique_id`.
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
    """A Spinnaker based camera, such as GigE, USB2/3 etc.

    .. warning::

        Do **not** create a :class:`Camera` manually, rather get it from
        :meth:`CameraList.create_camera_by_index`,
        :meth:`CameraList.create_camera_by_serial`, or
        :meth:`CameraList.create_camera_by_dev_id`.

    Before the camera can be used and most nodes are accessible, you need to
    initialize the camera using :meth:`init_cam`. When you're done, call
    :meth:`deinit_cam`.
    """

    def __cinit__(self):
        self._cam_set = 0
        self._image_handlers = set()
        self._dev_handlers = set()
        self.camera_nodes = rotpy.camera_nodes.CameraNodes(camera=self)
        self.tl_dev_nodes = rotpy.camera_nodes.TLDevNodes(camera=self)
        self.tl_stream_nodes = rotpy.camera_nodes.TLStreamNodes(camera=self)
        self._user_buf = None

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

    cpdef release(self):
        """Releases the camera's resources, including the nodes.

        Once called, non of the pre-listed node are valid and other camera
        methods should not be called.
        """
        self.camera_nodes.clear_camera()
        self.tl_dev_nodes.clear_camera()
        self.tl_stream_nodes.clear_camera()

    cpdef init_cam(self):
        """Initializes a camera, allowing for much more interaction, including
        more properties.

        This is required before images can be acquired.
        """
        with nogil:
            self._camera.get().Init()

    cpdef deinit_cam(self):
        """De-initializes a camera that was initialized with :meth:`init_cam`.

        This should happen after you're done with the camera.
        """
        with nogil:
            self._camera.get().DeInit()

    cpdef get_access_mode(self):
        """Returns the access mode that the software has on the Camera as a
        string from :attr:`~rotpy.names.geni.AccessMode_names`.

        The camera does not need to be initialized before calling this function.
        """
        cdef EAccessMode mode
        with nogil:
            mode = self._camera.get().GetAccessMode()
        return AccessMode_values[mode]

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
        """Starts the image acquisition engine from the camera.

        The camera must be initialized first with :meth:`init_cam`.
        """
        with nogil:
            self._camera.get().BeginAcquisition()

    cpdef end_acquisition(self):
        """Stops the image acquisition engine.

        If :meth:`end_acquisition` is called without a prior call to
        :meth:`begin_acquisition` an error will be thrown.

        All Images that were acquired using :meth:`get_next_image` need to be
        :meth:`~rotpy.image.Image.release` first before calling this. All
        buffers in the input pool and output queue will be discarded when this
        is called.
        """
        with nogil:
            self._camera.get().EndAcquisition()

    cpdef attach_device_event_handler(self, callback, str name=''):
        """Registers the callback to get events from camera.

        :param callback: A function that will be called upon camera events.
            See :class:`DeviceEventHandler` for the function signature.
        :param name: An optional event name. If empty (the default), all events
            will be handled.
        :returns: A :class:`DeviceEventHandler` instance representing the
            callback.

        The ``callback`` will receive the camera events while it is registered,
        possibly even before this function returns(?) and could potentially
        be called by external threads. It's best not to do any work in it.

        .. warning::

            The camera has to be initialized first with :meth:`init_cam` before
            registering callbacks for events.
        """
        cdef DeviceEventHandler handler = DeviceEventHandler()
        handler.set_callback(self, callback, name)

        cdef bytes name_b = name.encode()
        cdef size_t n = len(name)
        cdef const char * name_c = name_b
        cdef gcstring name_s

        self._dev_handlers.add(handler)
        try:
            with nogil:
                if n:
                    name_s.assign(name_c, n)
                    self._camera.get().RegisterEventHandler(
                        handler._handler, name_s)
                else:
                    self._camera.get().RegisterEventHandler(handler._handler)
        except:
            self._dev_handlers.remove(handler)
            raise

        return handler

    cpdef detach_device_event_handler(self, DeviceEventHandler handler):
        """Detaches an event handler previously returned by
        :meth:`attach_device_event_handler`.

        :param handler: The :class:`DeviceEventHandler` that handled the events.

        .. warning::

            Event handlers should be unregistered first before calling
            :meth:`deinit_cam`. Otherwise an exception will be thrown in the
            :meth:`deinit_cam` call and require the user to unregister event
            handlers before the camera can be re-initialized again.
        """
        if handler not in self._dev_handlers:
            raise ValueError("Handler is not attached to the system")

        with nogil:
            self._camera.get().UnregisterEventHandler(handler._handler)
        self._dev_handlers.remove(handler)

    cpdef attach_image_event_handler(self, callback):
        """Registers the callback to get called on new camera images.

        :param callback: A function that will be called upon new images.
            See :class:`ImageEventHandler` for the function signature.
        :returns: A :class:`ImageEventHandler` instance representing the
            callback.

        The ``callback`` will receive the camera images while it is registered,
        possibly even before this function returns(?) and could potentially
        be called by external threads. It's best not to do any work in it.

        .. warning::

            The camera has to be initialized first with :meth:`init_cam` before
            registering handlers for images.
        """
        cdef ImageEventHandler handler = ImageEventHandler()
        handler.set_callback(self, callback)

        self._image_handlers.add(handler)
        try:
            with nogil:
                self._camera.get().RegisterEventHandler(handler._handler)
        except:
            self._image_handlers.remove(handler)
            raise

        return handler

    cpdef detach_image_event_handler(self, ImageEventHandler handler):
        """Detaches an event handler previously returned by
        :meth:`attach_image_event_handler`.

        :param handler: The :class:`ImageEventHandler` that handled the events.

        .. warning::

            Event handlers should be unregistered first before calling
            :meth:`deinit_cam`. Otherwise an exception will be thrown in the
            :meth:`deinit_cam` call and require the user to unregister event
            handlers before the camera can be re-initialized again.
        """
        if handler not in self._image_handlers:
            raise ValueError("Handler is not attached to the system")

        with nogil:
            self._camera.get().UnregisterEventHandler(handler._handler)
        self._image_handlers.remove(handler)

    cpdef get_buffer_ownership(self):
        """Gets data buffer ownership as a string from
        :attr:`~rotpy.names.spin.buffer_owner_names`.

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
        :attr:`~rotpy.names.spin.buffer_owner_names`.

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

    cpdef set_user_buffer(self, buffer):
        """Specify contiguous user allocated memory to use as data buffers.

        To prevent image tearing when working with USB3 cameras, the size of
        the buffer should be equal to
        ``((len(buffer) + 1024 - 1) // 1024) * 1024`` where 1024 is the USB3
        packet size.

        :param buffer: A memoryview such as an array, bytes, bytesarray etc.
        """
        cdef unsigned char[:] arr = buffer
        cdef uint64_t n = len(buffer)
        self._user_buf = buffer

        with nogil:
            self._camera.get().SetUserBuffers(&arr[0], n)

    cpdef set_user_buffers(self, buffers, uint64_t buffer_size):
        """Specify non-contiguous user allocated memory to use as data buffers.

        Each buffer must have enough memory to hold one image.
        To prevent image tearing when working with USB3 cameras, the size of
        each buffer should be equal to
        ``((len(buffer) + 1024 - 1) // 1024) * 1024`` where 1024 is the USB3
        packet size.

        :param buffers: A list of memoryviews such as arrays, bytes,
            bytesarrays etc. Each memoryview in the list will be a individual
            buffer.
        :param buffer_size: The size of the smallest buffer in ``buffers`` in
            bytes. Individual buffer items can be larger, but not smaller.
        """
        cdef unsigned char[:] arr
        cdef uint64_t n = len(buffers)
        cdef uint64_t i
        cdef void** items = <void**>malloc(n * sizeof(void*))

        if items == NULL:
            raise MemoryError
        self._user_buf = buffers

        for i in range(n):
            if len(buffers[i]) < buffer_size:
                raise ValueError(
                    f'Buffer {i} is smaller than buffer size {buffer_size}')

            arr = buffers[i]
            items[i] = &arr[0]

        with nogil:
            self._camera.get().SetUserBuffers(items, n, buffer_size)
        free(items)

    cpdef get_unique_id(self):
        """This returns a unique id string that identifies the camera.

        This e.g. could be the device hardware identifier on the interface etc.
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
            If the image data was incomplete, a ValueError is raised.

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
        if not raw_img.IsValid():
            return None

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
        return rotpy.image.Image.create_from_camera(raw_img)

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
