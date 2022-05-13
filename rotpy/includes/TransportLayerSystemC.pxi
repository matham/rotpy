cdef extern from "TransportLayerSystemC.h" nogil:

    cdef struct _quickSpinTLSystem:
        quickSpinStringNode TLID
        quickSpinStringNode TLVendorName
        quickSpinStringNode TLModelName
        quickSpinStringNode TLVersion
        quickSpinStringNode TLFileName
        quickSpinStringNode TLDisplayName
        quickSpinStringNode TLPath
        quickSpinEnumerationNode TLType
        quickSpinIntegerNode GenTLVersionMajor
        quickSpinIntegerNode GenTLVersionMinor
        quickSpinIntegerNode GenTLSFNCVersionMajor
        quickSpinIntegerNode GenTLSFNCVersionMinor
        quickSpinIntegerNode GenTLSFNCVersionSubMinor
        quickSpinIntegerNode GevVersionMajor
        quickSpinIntegerNode GevVersionMinor
        quickSpinCommandNode InterfaceUpdateList
        quickSpinIntegerNode InterfaceSelector
        quickSpinStringNode InterfaceID
        quickSpinStringNode InterfaceDisplayName
        quickSpinIntegerNode GevInterfaceMACAddress
        quickSpinIntegerNode GevInterfaceDefaultIPAddress
        quickSpinIntegerNode GevInterfaceDefaultSubnetMask
        quickSpinIntegerNode GevInterfaceDefaultGateway
        quickSpinBooleanNode EnumerateGEVInterfaces
        quickSpinBooleanNode EnumerateUSBInterfaces
        quickSpinBooleanNode EnumerateGen2Cameras
    ctypedef _quickSpinTLSystem quickSpinTLSystem
