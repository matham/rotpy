"""Bindings
===================

"""

from ._interface cimport *

from libc.stdlib cimport malloc, free
from libc.string cimport memset, memcpy
from cpython.ref cimport PyObject

DEF MAX_BUFF_LEN = 256


cdef int query_interface(spinInterface interface) except 1:
    cdef unsigned int i = 0
    cdef quickSpinTLInterface qsi
    cdef unsigned char interface_name_available = 0
    cdef unsigned char interface_name_readable = 0
    cdef char interface_name[MAX_BUFF_LEN]
    cdef size_t interface_name_len = MAX_BUFF_LEN
    cdef str name = 'Interface display name not readable'
    cdef spinCameraList cameras = NULL
    cdef size_t n_cams = 0

    check_ret(quickSpinTLInterfaceInit(interface, &qsi))
    check_ret(spinNodeIsAvailable(qsi.InterfaceDisplayName, &interface_name_available))
    check_ret(spinNodeIsReadable(qsi.InterfaceDisplayName, &interface_name_readable))

    if interface_name_readable and interface_name_available:
        check_ret(spinStringGetValue(qsi.InterfaceDisplayName, interface_name, &interface_name_len))

    name = interface_name[:max(interface_name_len - 1, 0)]
    print(f'Interface: {name}')

    check_ret(spinCameraListCreateEmpty(&cameras))
    check_ret(spinInterfaceGetCameras(interface, cameras))
    check_ret(spinCameraListGetSize(cameras, &n_cams))

    for i in range(n_cams):
        print(i)

    check_ret(spinCameraListClear(cameras))
    check_ret(spinCameraListDestroy(cameras))


def run():
    cdef unsigned int i = 0
    cdef spinSystem system = NULL
    cdef spinInterfaceList interfaces = NULL
    cdef spinInterface interface = NULL
    cdef size_t n_interfaces = 0
    cdef spinCameraList cameras = NULL
    cdef size_t n_cams = 0

    check_ret(spinSystemGetInstance(&system))

    check_ret(spinInterfaceListCreateEmpty(&interfaces))
    check_ret(spinSystemGetInterfaces(system, interfaces))
    check_ret(spinInterfaceListGetSize(interfaces, &n_interfaces))
    print(f'interfaces detected: {n_interfaces}')

    check_ret(spinCameraListCreateEmpty(&cameras))
    check_ret(spinSystemGetCameras(system, cameras))
    check_ret(spinCameraListGetSize(cameras, &n_cams))
    print(f'cams detected: {n_cams}')

    for i in range(n_interfaces):
        check_ret(spinInterfaceListGet(interfaces, i, &interface))
        query_interface(interface)
        check_ret(spinInterfaceRelease(interface))

    check_ret(spinCameraListClear(cameras))
    check_ret(spinCameraListDestroy(cameras))
    check_ret(spinInterfaceListClear(interfaces))
    check_ret(spinInterfaceListDestroy(interfaces))
    check_ret(spinSystemReleaseInstance(system))
