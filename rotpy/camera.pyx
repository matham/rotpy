from .system import SpinSystem
from.names import AccessMode_names, AccessMode_values, img_status_values

cimport cpython.array
from array import array

__all__ = ('SpinCameraList', 'Camera')

DEF MAX_BUFF_LEN = 256


cdef class SpinCameraList:
    """Provides access to camera lists. This includes updating, size, and
    camera retrieval.
    """

    def __cinit__(self, SpinSystem system):
        self._list_set = 0
        self.system = system

    def __init__(self, SpinSystem system):
        with nogil:
            check_ret(spinCameraListCreateEmpty(&self._cam_list))
        self._list_set = 1

    def __dealloc__(self):
        if self._list_set:
            self._list_set = 0
            with nogil:
                check_ret(spinCameraListClear(self._cam_list))
                check_ret(spinCameraListDestroy(self._cam_list))

    cpdef refresh_cameras(
            self, int update_interfaces=False, int update_cams=False):
        """Retrieves the list of detected (and enumerable) cameras on the
        system.

        :param update_interfaces: Whether to update the interface list.
        :param update_cams: Whether to update the camera list to detect
            new/removed cameras.
        """
        cdef spinSystem system = self.system._system
        if update_interfaces or update_cams:
            with nogil:
                check_ret(spinSystemGetCamerasEx(
                    system, update_interfaces, update_cams, self._cam_list
                ))
        else:
            with nogil:
                check_ret(spinSystemGetCameras(system, self._cam_list))

    cpdef int get_size(self):
        """Retrieves the number of cameras in the camera list.
        """
        cdef size_t n
        with nogil:
            check_ret(spinCameraListGetSize(self._cam_list, &n))
        return n

    cpdef Camera create_camera_by_index(self, int index):
        """Retrieves a camera from this camera list using an index.

        :param index: The index of the camera.
        :return: A :class:`Camera`.
        """
        camera = Camera()
        camera.set_camera_by_index(self, index)
        return camera

    cpdef remove_camera_by_index(self, int index):
        """Removes a camera from this camera list using its index.

        :param index: The index of the camera to remove.
        """
        with nogil:
            check_ret(spinCameraListRemove(self._cam_list, index))

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
        cdef char* data = buf
        with nogil:
            check_ret(spinCameraListRemoveBySerial(self._cam_list, data))

    cpdef extend_camera_list(self, SpinCameraList other_list):
        """Appends all the cameras from the other camera list to this list.

        :param other_list: The camera list to add to us.
        """
        cdef spinCameraList cam_list = other_list._cam_list
        with nogil:
            check_ret(spinCameraListAppend(self._cam_list, cam_list))


cdef class Camera:

    def __cinit__(self):
        self._cam_set = 0

    def __dealloc__(self):
        if self._cam_set:
            self._cam_set = 0
            with nogil:
                check_ret(spinCameraRelease(self._camera))

    cdef object set_camera_by_index(
            self, SpinCameraList cam_list, int index):
        with nogil:
            check_ret(spinCameraListGet(cam_list._cam_list, index, &self._camera))
        self._cam_set = 1

    cdef object set_camera_by_serial(
            self, SpinCameraList cam_list, const char* serial):
        with nogil:
            check_ret(spinCameraListGetBySerial(cam_list._cam_list, serial, &self._camera))
        self._cam_set = 1

    cpdef init_cam(self):
        """Initializes a camera, allowing for much more interaction.
        """
        with nogil:
            check_ret(spinCameraInit(self._camera))

    cpdef deinit_cam(self):
        """De-initializes a camera that was initialized with :meth:`init_cam`.
        """
        with nogil:
            check_ret(spinCameraDeInit(self._camera))

    cpdef get_access_mode(self):
        """Returns the access mode of the camera as a string from
        :attr:`~rotpy.names.AccessMode_values`.
        """
        cdef spinAccessMode mode
        with nogil:
            check_ret(spinCameraGetAccessMode(self._camera, &mode))
        return AccessMode_values[mode]

    cpdef read_port(self, uint64_t address, int num_bytes):
        """Reads a remote port on a physical Camera. This function can be used
        to read registers on the camera.

        :param address: A 64 bit address to a register on the camera.
        :param num_bytes: Number of bytes to read.
        :return: An array with the read bytes.

        .. warning::

            Only perform direct read/write to a register if the register isn't
            supported in the device nodemap. Otherwise the camera and nodemap
            may be left in an undefined state after the register read/write.
        """
        buffer = array('B', b'\0' * num_bytes)
        cdef unsigned char[:] arr = buffer
        with nogil:
            check_ret(spinCameraReadPort(self._camera, address, &arr[0], num_bytes))
        return buffer

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
            check_ret(spinCameraWritePort(self._camera, address, &data[0], size))

    cpdef begin_acquisition(self):
        """Starts acquiring images from the camera.
        """
        with nogil:
            check_ret(spinCameraBeginAcquisition(self._camera))

    cpdef end_acquisition(self):
        """Stops acquiring images from the camera.
        """
        with nogil:
            check_ret(spinCameraEndAcquisition(self._camera))

    cpdef str get_unique_id(self, int buffer_size=MAX_BUFF_LEN):
        """Retrieves a unique identifier for the camera.

        :param buffer_size: The size of the buffer to pass to the camera to
            fill. If the returned string is smaller, we return only the valid
            part.
        """
        buffer = array('b', b'\0' * buffer_size)
        cdef char[:] msg = buffer
        cdef size_t n = buffer_size
        with nogil:
            check_ret(spinCameraGetUniqueID(self._camera, &msg[0], &n))

        return buffer.tobytes()[:max(n - 1, 0)].decode()

    cpdef is_streaming(self):
        """Checks whether a camera is currently acquiring images.
        """
        cdef bool8_t streaming
        with nogil:
            check_ret(spinCameraIsStreaming(self._camera, &streaming))
        return bool(streaming)

    cpdef str get_gui_xml(self, int buffer_size=MAX_BUFF_LEN):
        """Retrieves the GUI XML from the camera.

        :param buffer_size: The size of the buffer to pass to the camera to
            fill. If the returned string is smaller, we return only the valid
            part.
        """
        buffer = array('b', b'\0' * buffer_size)
        cdef char[:] msg = buffer
        cdef size_t n = buffer_size
        with nogil:
            check_ret(spinCameraGetGuiXml(self._camera, &msg[0], &n))

        return buffer.tobytes()[:max(n - 1, 0)].decode()

    cpdef is_valid(self):
        """Checks whether a camera is still valid for use.
        """
        cdef bool8_t valid
        with nogil:
            check_ret(spinCameraIsValid(self._camera, &valid))
        return bool(valid)

    cpdef is_init(self):
        """Checks whether a camera is currently initialized.
        """
        cdef bool8_t init
        with nogil:
            check_ret(spinCameraIsInitialized(self._camera, &init))
        return bool(init)

    cpdef get_max_packet_size(self):
        """Returns the largest packet size that can be safely used on the
        interface that the device is connected to.
        """
        cdef unsigned int s
        with nogil:
            check_ret(spinCameraDiscoverMaxPacketSize(self._camera, &s))
        return s

    # cpdef force_ip(self):
    #     """Forces the camera to be on the same subnet as its corresponding
    #     interface (e.g. for gigE cameras).
    #     """
    #     with nogil:
    #         check_ret(spinCameraForceIP())

    cpdef Image get_next_image(self, timeout=None):
        """Gets the next image from the camera's buffer queue.

        :param timeout: Optional timeout in seconds. If not provided, it may
            wait indefinitely until an image becomes available. If provided,
            if it times out before an image is available it returns None.
        :return: An :class:`~rotpy.image.Image` or None if it timed out.

        .. warning::

            Make sure to call :meth:`~rotpy.image.Image.release` as quickly as
            possible after getting the image. Because until the image is
            released, the camera cannot re-use the buffer. So, if too many
            buffers are held, the camera may run out of buffers in which to
            store images.
        """
        cdef spinError ret
        cdef uint64_t to
        cdef spinImage raw_img
        cdef bool8_t incomplete
        cdef spinImageStatus status
        cdef char msg[MAX_BUFF_LEN]
        cdef size_t n = MAX_BUFF_LEN

        if timeout is None:
            with nogil:
                ret = spinCameraGetNextImage(self._camera, &raw_img)
        else:
            to = timeout * 1000
            with nogil:
                ret = spinCameraGetNextImageEx(self._camera, to, &raw_img)

        if ret == SPINNAKER_ERR_TIMEOUT or ret == GENICAM_ERR_TIMEOUT:
            return None
        check_ret(ret)

        with nogil:
            check_ret(spinImageIsIncomplete(raw_img, &incomplete))
            if incomplete:
                check_ret(spinImageGetStatus(raw_img, &status))
                check_ret(spinImageGetStatusDescription(status, msg, &n))
                check_ret(spinImageRelease(raw_img))

        if incomplete:
            raise ValueError(
                f'Image incomplete: "{msg[:max(n - 1, 0)].decode()}" '
                f'"({img_status_values[status]})"')
        return Image.create_from_camera(raw_img)
