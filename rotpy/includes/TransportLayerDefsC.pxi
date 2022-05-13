cdef extern from "TransportLayerDefsC.h" nogil:

    cdef enum _spinTLStreamTypeEnums:
        StreamType_GigEVision
        StreamType_CameraLink
        StreamType_CameraLinkHS
        StreamType_CoaXPress
        StreamType_USB3Vision
        StreamType_Custom
        NUMSTREAMTYPE
    ctypedef _spinTLStreamTypeEnums spinTLStreamTypeEnums

    cdef enum _spinTLStreamModeEnums:
        StreamMode_Socket
        StreamMode_LWF
        StreamMode_MVA
        NUMSTREAMMODE
    ctypedef _spinTLStreamModeEnums spinTLStreamModeEnums

    cdef enum _spinTLStreamBufferCountModeEnums:
        StreamBufferCountMode_Manual
        StreamBufferCountMode_Auto
        NUMSTREAMBUFFERCOUNTMODE
    ctypedef _spinTLStreamBufferCountModeEnums spinTLStreamBufferCountModeEnums

    cdef enum _spinTLStreamBufferHandlingModeEnums:
        StreamBufferHandlingMode_OldestFirst
        StreamBufferHandlingMode_OldestFirstOverwrite
        StreamBufferHandlingMode_NewestOnly
        StreamBufferHandlingMode_NewestFirst
        NUMSTREAMBUFFERHANDLINGMODE
    ctypedef _spinTLStreamBufferHandlingModeEnums spinTLStreamBufferHandlingModeEnums

    cdef enum _spinTLDeviceTypeEnums:
        DeviceType_GigEVision
        DeviceType_CameraLink
        DeviceType_CameraLinkHS
        DeviceType_CoaXPress
        DeviceType_USB3Vision
        DeviceType_Custom
        NUMDEVICETYPE
    ctypedef _spinTLDeviceTypeEnums spinTLDeviceTypeEnums

    cdef enum _spinTLDeviceAccessStatusEnums:
        DeviceAccessStatus_Unknown
        DeviceAccessStatus_ReadWrite
        DeviceAccessStatus_ReadOnly
        DeviceAccessStatus_NoAccess
        DeviceAccessStatus_Busy
        DeviceAccessStatus_OpenReadWrite
        DeviceAccessStatus_OpenReadOnly
        NUMDEVICEACCESSSTATUS
    ctypedef _spinTLDeviceAccessStatusEnums spinTLDeviceAccessStatusEnums

    cdef enum _spinTLGevCCPEnums:
        GevCCP_EnumEntry_GevCCP_OpenAccess
        GevCCP_EnumEntry_GevCCP_ExclusiveAccess
        GevCCP_EnumEntry_GevCCP_ControlAccess
        NUMGEVCCP
    ctypedef _spinTLGevCCPEnums spinTLGevCCPEnums

    cdef enum _spinTLGUIXMLLocationEnums:
        GUIXMLLocation_Device
        GUIXMLLocation_Host
        NUMGUIXMLLOCATION
    ctypedef _spinTLGUIXMLLocationEnums spinTLGUIXMLLocationEnums

    cdef enum _spinTLGenICamXMLLocationEnums:
        GenICamXMLLocation_Device
        GenICamXMLLocation_Host
        NUMGENICAMXMLLOCATION
    ctypedef _spinTLGenICamXMLLocationEnums spinTLGenICamXMLLocationEnums

    cdef enum _spinTLDeviceEndianessMechanismEnums:
        DeviceEndianessMechanism_Legacy
        DeviceEndianessMechanism_Standard
        NUMDEVICEENDIANESSMECHANISM
    ctypedef _spinTLDeviceEndianessMechanismEnums spinTLDeviceEndianessMechanismEnums

    cdef enum _spinTLDeviceCurrentSpeedEnums:
        DeviceCurrentSpeed_UnknownSpeed
        DeviceCurrentSpeed_LowSpeed
        DeviceCurrentSpeed_FullSpeed
        DeviceCurrentSpeed_HighSpeed
        DeviceCurrentSpeed_SuperSpeed
        NUMDEVICECURRENTSPEED
    ctypedef _spinTLDeviceCurrentSpeedEnums spinTLDeviceCurrentSpeedEnums

    cdef enum _spinTLInterfaceTypeEnums:
        InterfaceType_GigEVision
        InterfaceType_CameraLink
        InterfaceType_CameraLinkHS
        InterfaceType_CoaXPress
        InterfaceType_USB3Vision
        InterfaceType_Custom
        NUMINTERFACETYPE
    ctypedef _spinTLInterfaceTypeEnums spinTLInterfaceTypeEnums

    cdef enum _spinTLPOEStatusEnums:
        POEStatus_NotSupported
        POEStatus_PowerOff
        POEStatus_PowerOn
        NUMPOESTATUS
    ctypedef _spinTLPOEStatusEnums spinTLPOEStatusEnums

    cdef enum _spinTLFilterDriverStatusEnums:
        FilterDriverStatus_NotSupported
        FilterDriverStatus_Disabled
        FilterDriverStatus_Enabled
        NUMFILTERDRIVERSTATUS
    ctypedef _spinTLFilterDriverStatusEnums spinTLFilterDriverStatusEnums

    cdef enum _spinTLTLTypeEnums:
        TLType_GigEVision
        TLType_CameraLink
        TLType_CameraLinkHS
        TLType_CoaXPress
        TLType_USB3Vision
        TLType_Mixed
        TLType_Custom
        NUMTLTYPE
    ctypedef _spinTLTLTypeEnums spinTLTLTypeEnums
