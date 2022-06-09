cdef extern from "TransportLayerDefs.h" namespace "Spinnaker" nogil:
    cpdef enum StreamTypeEnum:
        StreamType_GigEVision
        StreamType_CameraLink
        StreamType_CameraLinkHS
        StreamType_CoaXPress
        StreamType_USB3Vision
        StreamType_Custom
        NUMSTREAMTYPE

    cpdef enum StreamModeEnum:
        StreamMode_Socket
        StreamMode_LWF
        StreamMode_MVA
        NUMSTREAMMODE

    cpdef enum StreamBufferCountModeEnum:
        StreamBufferCountMode_Manual
        StreamBufferCountMode_Auto
        NUMSTREAMBUFFERCOUNTMODE

    cpdef enum StreamBufferHandlingModeEnum:
        StreamBufferHandlingMode_OldestFirst
        StreamBufferHandlingMode_OldestFirstOverwrite
        StreamBufferHandlingMode_NewestOnly
        StreamBufferHandlingMode_NewestFirst
        NUMSTREAMBUFFERHANDLINGMODE

    cpdef enum DeviceTypeEnum:
        DeviceType_GigEVision
        DeviceType_CameraLink
        DeviceType_CameraLinkHS
        DeviceType_CoaXPress
        DeviceType_USB3Vision
        DeviceType_Custom
        NUMDEVICETYPE

    cpdef enum DeviceAccessStatusEnum:
        DeviceAccessStatus_Unknown
        DeviceAccessStatus_ReadWrite
        DeviceAccessStatus_ReadOnly
        DeviceAccessStatus_NoAccess
        DeviceAccessStatus_Busy
        DeviceAccessStatus_OpenReadWrite
        DeviceAccessStatus_OpenReadOnly
        NUMDEVICEACCESSSTATUS

    cpdef enum GevCCPEnum:
        GevCCP_EnumEntry_GevCCP_OpenAccess
        GevCCP_EnumEntry_GevCCP_ExclusiveAccess
        GevCCP_EnumEntry_GevCCP_ControlAccess
        NUMGEVCCP

    cpdef enum GUIXMLLocationEnum:
        GUIXMLLocation_Device
        GUIXMLLocation_Host
        NUMGUIXMLLOCATION

    cpdef enum GenICamXMLLocationEnum:
        GenICamXMLLocation_Device
        GenICamXMLLocation_Host
        NUMGENICAMXMLLOCATION

    cpdef enum DeviceEndianessMechanismEnum:
        DeviceEndianessMechanism_Legacy
        DeviceEndianessMechanism_Standard
        NUMDEVICEENDIANESSMECHANISM

    cpdef enum DeviceCurrentSpeedEnum:
        DeviceCurrentSpeed_UnknownSpeed
        DeviceCurrentSpeed_LowSpeed
        DeviceCurrentSpeed_FullSpeed
        DeviceCurrentSpeed_HighSpeed
        DeviceCurrentSpeed_SuperSpeed
        NUMDEVICECURRENTSPEED

    cpdef enum InterfaceTypeEnum:
        InterfaceType_GigEVision
        InterfaceType_CameraLink
        InterfaceType_CameraLinkHS
        InterfaceType_CoaXPress
        InterfaceType_USB3Vision
        InterfaceType_Custom
        NUMINTERFACETYPE

    cpdef enum POEStatusEnum:
        POEStatus_NotSupported
        POEStatus_PowerOff
        POEStatus_PowerOn
        NUMPOESTATUS

    cpdef enum FilterDriverStatusEnum:
        FilterDriverStatus_NotSupported
        FilterDriverStatus_Disabled
        FilterDriverStatus_Enabled
        NUMFILTERDRIVERSTATUS

    cpdef enum TLTypeEnum:
        TLType_GigEVision
        TLType_CameraLink
        TLType_CameraLinkHS
        TLType_CoaXPress
        TLType_USB3Vision
        TLType_Mixed
        TLType_Custom
        NUMTLTYPE
