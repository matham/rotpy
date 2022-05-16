cdef extern from "TransportLayerDefsC.h" nogil:

    cpdef enum _spinTLStreamTypeEnums:
        StreamType_GigEVision
        StreamType_CameraLink
        StreamType_CameraLinkHS
        StreamType_CoaXPress
        StreamType_USB3Vision
        StreamType_Custom
        NUMSTREAMTYPE
    ctypedef _spinTLStreamTypeEnums spinTLStreamTypeEnums

    cpdef enum _spinTLStreamModeEnums:
        StreamMode_Socket
        StreamMode_LWF
        StreamMode_MVA
        NUMSTREAMMODE
    ctypedef _spinTLStreamModeEnums spinTLStreamModeEnums

    cpdef enum _spinTLStreamBufferCountModeEnums:
        StreamBufferCountMode_Manual
        StreamBufferCountMode_Auto
        NUMSTREAMBUFFERCOUNTMODE
    ctypedef _spinTLStreamBufferCountModeEnums spinTLStreamBufferCountModeEnums

    cpdef enum _spinTLStreamBufferHandlingModeEnums:
        StreamBufferHandlingMode_OldestFirst
        StreamBufferHandlingMode_OldestFirstOverwrite
        StreamBufferHandlingMode_NewestOnly
        StreamBufferHandlingMode_NewestFirst
        NUMSTREAMBUFFERHANDLINGMODE
    ctypedef _spinTLStreamBufferHandlingModeEnums spinTLStreamBufferHandlingModeEnums

    cpdef enum _spinTLDeviceTypeEnums:
        DeviceType_GigEVision
        DeviceType_CameraLink
        DeviceType_CameraLinkHS
        DeviceType_CoaXPress
        DeviceType_USB3Vision
        DeviceType_Custom
        NUMDEVICETYPE
    ctypedef _spinTLDeviceTypeEnums spinTLDeviceTypeEnums

    cpdef enum _spinTLDeviceAccessStatusEnums:
        DeviceAccessStatus_Unknown
        DeviceAccessStatus_ReadWrite
        DeviceAccessStatus_ReadOnly
        DeviceAccessStatus_NoAccess
        DeviceAccessStatus_Busy
        DeviceAccessStatus_OpenReadWrite
        DeviceAccessStatus_OpenReadOnly
        NUMDEVICEACCESSSTATUS
    ctypedef _spinTLDeviceAccessStatusEnums spinTLDeviceAccessStatusEnums

    cpdef enum _spinTLGevCCPEnums:
        GevCCP_EnumEntry_GevCCP_OpenAccess
        GevCCP_EnumEntry_GevCCP_ExclusiveAccess
        GevCCP_EnumEntry_GevCCP_ControlAccess
        NUMGEVCCP
    ctypedef _spinTLGevCCPEnums spinTLGevCCPEnums

    cpdef enum _spinTLGUIXMLLocationEnums:
        GUIXMLLocation_Device
        GUIXMLLocation_Host
        NUMGUIXMLLOCATION
    ctypedef _spinTLGUIXMLLocationEnums spinTLGUIXMLLocationEnums

    cpdef enum _spinTLGenICamXMLLocationEnums:
        GenICamXMLLocation_Device
        GenICamXMLLocation_Host
        NUMGENICAMXMLLOCATION
    ctypedef _spinTLGenICamXMLLocationEnums spinTLGenICamXMLLocationEnums

    cpdef enum _spinTLDeviceEndianessMechanismEnums:
        DeviceEndianessMechanism_Legacy
        DeviceEndianessMechanism_Standard
        NUMDEVICEENDIANESSMECHANISM
    ctypedef _spinTLDeviceEndianessMechanismEnums spinTLDeviceEndianessMechanismEnums

    cpdef enum _spinTLDeviceCurrentSpeedEnums:
        DeviceCurrentSpeed_UnknownSpeed
        DeviceCurrentSpeed_LowSpeed
        DeviceCurrentSpeed_FullSpeed
        DeviceCurrentSpeed_HighSpeed
        DeviceCurrentSpeed_SuperSpeed
        NUMDEVICECURRENTSPEED
    ctypedef _spinTLDeviceCurrentSpeedEnums spinTLDeviceCurrentSpeedEnums

    cpdef enum _spinTLInterfaceTypeEnums:
        InterfaceType_GigEVision
        InterfaceType_CameraLink
        InterfaceType_CameraLinkHS
        InterfaceType_CoaXPress
        InterfaceType_USB3Vision
        InterfaceType_Custom
        NUMINTERFACETYPE
    ctypedef _spinTLInterfaceTypeEnums spinTLInterfaceTypeEnums

    cpdef enum _spinTLPOEStatusEnums:
        POEStatus_NotSupported
        POEStatus_PowerOff
        POEStatus_PowerOn
        NUMPOESTATUS
    ctypedef _spinTLPOEStatusEnums spinTLPOEStatusEnums

    cpdef enum _spinTLFilterDriverStatusEnums:
        FilterDriverStatus_NotSupported
        FilterDriverStatus_Disabled
        FilterDriverStatus_Enabled
        NUMFILTERDRIVERSTATUS
    ctypedef _spinTLFilterDriverStatusEnums spinTLFilterDriverStatusEnums

    cpdef enum _spinTLTLTypeEnums:
        TLType_GigEVision
        TLType_CameraLink
        TLType_CameraLinkHS
        TLType_CoaXPress
        TLType_USB3Vision
        TLType_Mixed
        TLType_Custom
        NUMTLTYPE
    ctypedef _spinTLTLTypeEnums spinTLTLTypeEnums
