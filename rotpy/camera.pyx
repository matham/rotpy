from .system import SpinSystem

__all__ = ('SpinCameraList', 'Camera')


cdef class SpinCameraList:
    """Provides access to camera lists. This includes updating, size, and
    camera retrieval.
    """

    def __cinit__(self, SpinSystem system):
        self._list_set = 0
        self.system = system

    def __init__(self, SpinSystem system):
        check_ret(spinCameraListCreateEmpty(&self._cam_list))
        self._list_set = 1

    def __dealloc__(self):
        if self._list_set:
            self._list_set = 0
            check_ret(spinCameraListClear(self._cam_list))
            check_ret(spinCameraListDestroy(self._cam_list))

    cpdef refresh_cameras(
            self, int update_interfaces=False, int update_cams=False):
        """Retrieves the list of detected (and enumerable) cameras on the
        system.

        :param update_interfaces: Whether to update the interface list. 
        :param update_cams: Whether to update the camera list.
        """
        if update_interfaces or update_cams:
            check_ret(spinSystemGetCamerasEx(
                self.system._system, update_interfaces, update_cams,
                self._cam_list
            ))
        else:
            check_ret(spinSystemGetCameras(self.system._system, self._cam_list))

    cpdef int get_size(self):
        """Retrieves the number of cameras in the camera list.
        """
        cdef size_t n
        check_ret(spinCameraListGetSize(self._cam_list, &n))
        return n

    cpdef Camera create_camera_by_index(self, size_t index):
        """Retrieves a camera from this camera list using an index.
        
        :param index: The index of the camera.
        :return: A :class:`Camera`.
        """
        camera = Camera()
        camera.set_camera_by_index(self, index)
        return camera

    cpdef remove_camera_by_index(self, size_t index):
        """Removes a camera from this camera list using its index.

        :param index: The index of the camera to remove.
        """
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
        check_ret(spinCameraListRemoveBySerial(self._cam_list, buf))

    cpdef extend_camera_list(self, SpinCameraList other_list):
        """Appends all the cameras from the other camera list to this list.
        
        :param other_list: The camera list to add to us.
        """
        check_ret(spinCameraListAppend(self._cam_list, other_list._cam_list))


cdef class Camera:

    def __cinit__(self):
        self._cam_set = 0

    def __dealloc__(self):
        if self._cam_set:
            self._cam_set = 0
            check_ret(spinCameraRelease(self._camera))

    cdef object set_camera_by_index(
            self, SpinCameraList cam_list, size_t index):
        check_ret(spinCameraListGet(cam_list._cam_list, index, &self._camera))
        self._cam_set = 1

    cdef object set_camera_by_serial(
            self, SpinCameraList cam_list, const char* serial):
        check_ret(spinCameraListGetBySerial(cam_list._cam_list, serial, &self._camera))
        self._cam_set = 1
