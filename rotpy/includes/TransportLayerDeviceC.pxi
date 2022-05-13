cdef extern from "TransportLayerDeviceC.h" nogil:

    cdef struct _quickSpinTLDevice:
        quickSpinStringNode DeviceID
        quickSpinStringNode DeviceSerialNumber
        quickSpinStringNode DeviceVendorName
        quickSpinStringNode DeviceModelName
        quickSpinEnumerationNode DeviceType
        quickSpinStringNode DeviceDisplayName
        quickSpinEnumerationNode DeviceAccessStatus
        quickSpinStringNode DeviceVersion
        quickSpinStringNode DeviceUserID
        quickSpinStringNode DeviceDriverVersion
        quickSpinBooleanNode DeviceIsUpdater
        quickSpinEnumerationNode GevCCP
        quickSpinEnumerationNode GUIXMLLocation
        quickSpinStringNode GUIXMLPath
        quickSpinEnumerationNode GenICamXMLLocation
        quickSpinStringNode GenICamXMLPath
        quickSpinIntegerNode GevDeviceIPAddress
        quickSpinIntegerNode GevDeviceSubnetMask
        quickSpinIntegerNode GevDeviceMACAddress
        quickSpinIntegerNode GevDeviceGateway
        quickSpinIntegerNode DeviceLinkSpeed
        quickSpinIntegerNode GevVersionMajor
        quickSpinIntegerNode GevVersionMinor
        quickSpinBooleanNode GevDeviceModeIsBigEndian
        quickSpinIntegerNode GevDeviceReadAndWriteTimeout
        quickSpinIntegerNode GevDeviceMaximumRetryCount
        quickSpinIntegerNode GevDevicePort
        quickSpinCommandNode GevDeviceDiscoverMaximumPacketSize
        quickSpinIntegerNode GevDeviceMaximumPacketSize
        quickSpinBooleanNode GevDeviceIsWrongSubnet
        quickSpinCommandNode GevDeviceAutoForceIP
        quickSpinCommandNode GevDeviceForceIP
        quickSpinIntegerNode GevDeviceForceIPAddress
        quickSpinIntegerNode GevDeviceForceSubnetMask
        quickSpinIntegerNode GevDeviceForceGateway
        quickSpinBooleanNode DeviceMulticastMonitorMode
        quickSpinEnumerationNode DeviceEndianessMechanism
        quickSpinStringNode DeviceInstanceId
        quickSpinStringNode DeviceLocation
        quickSpinEnumerationNode DeviceCurrentSpeed
        quickSpinBooleanNode DeviceU3VProtocol
        quickSpinStringNode DevicePortId
    ctypedef _quickSpinTLDevice quickSpinTLDevice
