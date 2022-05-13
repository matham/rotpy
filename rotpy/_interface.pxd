from libc.stdint cimport int64_t, uint64_t, uint8_t

include "includes/SpinnakerDefsC.pxi"
include "includes/CameraDefsC.pxi"
include "includes/ChunkDataDefC.pxi"
include "includes/SpinnakerGenApiDefsC.pxi"
include "includes/SpinnakerGenApiC.pxi"
include "includes/QuickSpinDefsC.pxi"
include "includes/TransportLayerDefsC.pxi"
include "includes/TransportLayerInterfaceC.pxi"
include "includes/TransportLayerSystemC.pxi"
include "includes/TransportLayerDeviceC.pxi"
include "includes/TransportLayerStreamC.pxi"
include "includes/QuickSpinC.pxi"
include "includes/SpinnakerC.pxi"

include "includes/compat.pxi"


cdef int check_ret(spinError ret) nogil except 1
