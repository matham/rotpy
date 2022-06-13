cdef extern from "CameraDefs.h" namespace "Spinnaker" nogil:

    cpdef enum LUTSelectorEnums:
        LUTSelector_LUT1
        NUM_LUTSELECTOR

    cpdef enum ExposureModeEnums:
        ExposureMode_Timed
        ExposureMode_TriggerWidth
        NUM_EXPOSUREMODE

    cpdef enum AcquisitionModeEnums:
        AcquisitionMode_Continuous
        AcquisitionMode_SingleFrame
        AcquisitionMode_MultiFrame
        NUM_ACQUISITIONMODE

    cpdef enum TriggerSourceEnums:
        TriggerSource_Software
        TriggerSource_Line0
        TriggerSource_Line1
        TriggerSource_Line2
        TriggerSource_Line3
        TriggerSource_UserOutput0
        TriggerSource_UserOutput1
        TriggerSource_UserOutput2
        TriggerSource_UserOutput3
        TriggerSource_Counter0Start
        TriggerSource_Counter1Start
        TriggerSource_Counter0End
        TriggerSource_Counter1End
        TriggerSource_LogicBlock0
        TriggerSource_LogicBlock1
        TriggerSource_Action0
        NUM_TRIGGERSOURCE

    cpdef enum TriggerActivationEnums:
        TriggerActivation_LevelLow
        TriggerActivation_LevelHigh
        TriggerActivation_FallingEdge
        TriggerActivation_RisingEdge
        TriggerActivation_AnyEdge
        NUM_TRIGGERACTIVATION

    cpdef enum SensorShutterModeEnums:
        SensorShutterMode_Global
        SensorShutterMode_Rolling
        SensorShutterMode_GlobalReset
        NUM_SENSORSHUTTERMODE

    cpdef enum TriggerModeEnums:
        TriggerMode_Off
        TriggerMode_On
        NUM_TRIGGERMODE

    cpdef enum TriggerOverlapEnums:
        TriggerOverlap_Off
        TriggerOverlap_ReadOut
        TriggerOverlap_PreviousFrame
        NUM_TRIGGEROVERLAP

    cpdef enum TriggerSelectorEnums:
        TriggerSelector_AcquisitionStart
        TriggerSelector_FrameStart
        TriggerSelector_FrameBurstStart
        NUM_TRIGGERSELECTOR

    cpdef enum ExposureAutoEnums:
        ExposureAuto_Off
        ExposureAuto_Once
        ExposureAuto_Continuous
        NUM_EXPOSUREAUTO

    cpdef enum EventSelectorEnums:
        EventSelector_Error
        EventSelector_ExposureEnd
        EventSelector_SerialPortReceive
        NUM_EVENTSELECTOR

    cpdef enum EventNotificationEnums:
        EventNotification_On
        EventNotification_Off
        NUM_EVENTNOTIFICATION

    cpdef enum LogicBlockSelectorEnums:
        LogicBlockSelector_LogicBlock0
        LogicBlockSelector_LogicBlock1
        NUM_LOGICBLOCKSELECTOR

    cpdef enum LogicBlockLUTInputActivationEnums:
        LogicBlockLUTInputActivation_LevelLow
        LogicBlockLUTInputActivation_LevelHigh
        LogicBlockLUTInputActivation_FallingEdge
        LogicBlockLUTInputActivation_RisingEdge
        LogicBlockLUTInputActivation_AnyEdge
        NUM_LOGICBLOCKLUTINPUTACTIVATION

    cpdef enum LogicBlockLUTInputSelectorEnums:
        LogicBlockLUTInputSelector_Input0
        LogicBlockLUTInputSelector_Input1
        LogicBlockLUTInputSelector_Input2
        LogicBlockLUTInputSelector_Input3
        NUM_LOGICBLOCKLUTINPUTSELECTOR

    cpdef enum LogicBlockLUTInputSourceEnums:
        LogicBlockLUTInputSource_Zero
        LogicBlockLUTInputSource_Line0
        LogicBlockLUTInputSource_Line1
        LogicBlockLUTInputSource_Line2
        LogicBlockLUTInputSource_Line3
        LogicBlockLUTInputSource_UserOutput0
        LogicBlockLUTInputSource_UserOutput1
        LogicBlockLUTInputSource_UserOutput2
        LogicBlockLUTInputSource_UserOutput3
        LogicBlockLUTInputSource_Counter0Start
        LogicBlockLUTInputSource_Counter1Start
        LogicBlockLUTInputSource_Counter0End
        LogicBlockLUTInputSource_Counter1End
        LogicBlockLUTInputSource_LogicBlock0
        LogicBlockLUTInputSource_LogicBlock1
        LogicBlockLUTInputSource_ExposureStart
        LogicBlockLUTInputSource_ExposureEnd
        LogicBlockLUTInputSource_FrameTriggerWait
        LogicBlockLUTInputSource_AcquisitionActive
        NUM_LOGICBLOCKLUTINPUTSOURCE

    cpdef enum LogicBlockLUTSelectorEnums:
        LogicBlockLUTSelector_Value
        LogicBlockLUTSelector_Enable
        NUM_LOGICBLOCKLUTSELECTOR

    cpdef enum ColorTransformationSelectorEnums:
        ColorTransformationSelector_RGBtoRGB
        ColorTransformationSelector_RGBtoYUV
        NUM_COLORTRANSFORMATIONSELECTOR

    cpdef enum RgbTransformLightSourceEnums:
        RgbTransformLightSource_General
        RgbTransformLightSource_Tungsten2800K
        RgbTransformLightSource_WarmFluorescent3000K
        RgbTransformLightSource_CoolFluorescent4000K
        RgbTransformLightSource_Daylight5000K
        RgbTransformLightSource_Cloudy6500K
        RgbTransformLightSource_Shade8000K
        RgbTransformLightSource_Custom
        NUM_RGBTRANSFORMLIGHTSOURCE

    cpdef enum ColorTransformationValueSelectorEnums:
        ColorTransformationValueSelector_Gain00
        ColorTransformationValueSelector_Gain01
        ColorTransformationValueSelector_Gain02
        ColorTransformationValueSelector_Gain10
        ColorTransformationValueSelector_Gain11
        ColorTransformationValueSelector_Gain12
        ColorTransformationValueSelector_Gain20
        ColorTransformationValueSelector_Gain21
        ColorTransformationValueSelector_Gain22
        ColorTransformationValueSelector_Offset0
        ColorTransformationValueSelector_Offset1
        ColorTransformationValueSelector_Offset2
        NUM_COLORTRANSFORMATIONVALUESELECTOR

    cpdef enum DeviceRegistersEndiannessEnums:
        DeviceRegistersEndianness_Little
        DeviceRegistersEndianness_Big
        NUM_DEVICEREGISTERSENDIANNESS

    cpdef enum DeviceScanTypeEnums:
        DeviceScanType_Areascan
        NUM_DEVICESCANTYPE

    cpdef enum DeviceCharacterSetEnums:
        DeviceCharacterSet_UTF8
        DeviceCharacterSet_ASCII
        NUM_DEVICECHARACTERSET

    cpdef enum DeviceTLTypeEnums:
        DeviceTLType_GigEVision
        DeviceTLType_CameraLink
        DeviceTLType_CameraLinkHS
        DeviceTLType_CoaXPress
        DeviceTLType_USB3Vision
        DeviceTLType_Custom
        NUM_DEVICETLTYPE

    cpdef enum DevicePowerSupplySelectorEnums:
        DevicePowerSupplySelector_External
        NUM_DEVICEPOWERSUPPLYSELECTOR

    cpdef enum DeviceTemperatureSelectorEnums:
        DeviceTemperatureSelector_Sensor
        NUM_DEVICETEMPERATURESELECTOR

    cpdef enum DeviceIndicatorModeEnums:
        DeviceIndicatorMode_Inactive
        DeviceIndicatorMode_Active
        DeviceIndicatorMode_ErrorStatus
        NUM_DEVICEINDICATORMODE

    cpdef enum AutoExposureControlPriorityEnums:
        AutoExposureControlPriority_Gain
        AutoExposureControlPriority_ExposureTime
        NUM_AUTOEXPOSURECONTROLPRIORITY

    cpdef enum AutoExposureMeteringModeEnums:
        AutoExposureMeteringMode_Average
        AutoExposureMeteringMode_Spot
        AutoExposureMeteringMode_Partial
        AutoExposureMeteringMode_CenterWeighted
        AutoExposureMeteringMode_HistgramPeak
        NUM_AUTOEXPOSUREMETERINGMODE

    cpdef enum BalanceWhiteAutoProfileEnums:
        BalanceWhiteAutoProfile_Indoor
        BalanceWhiteAutoProfile_Outdoor
        NUM_BALANCEWHITEAUTOPROFILE

    cpdef enum AutoAlgorithmSelectorEnums:
        AutoAlgorithmSelector_Awb
        AutoAlgorithmSelector_Ae
        NUM_AUTOALGORITHMSELECTOR

    cpdef enum AutoExposureTargetGreyValueAutoEnums:
        AutoExposureTargetGreyValueAuto_Off
        AutoExposureTargetGreyValueAuto_Continuous
        NUM_AUTOEXPOSURETARGETGREYVALUEAUTO

    cpdef enum AutoExposureLightingModeEnums:
        AutoExposureLightingMode_AutoDetect
        AutoExposureLightingMode_Backlight
        AutoExposureLightingMode_Frontlight
        AutoExposureLightingMode_Normal
        NUM_AUTOEXPOSURELIGHTINGMODE

    cpdef enum GevIEEE1588StatusEnums:
        GevIEEE1588Status_Initializing
        GevIEEE1588Status_Faulty
        GevIEEE1588Status_Disabled
        GevIEEE1588Status_Listening
        GevIEEE1588Status_PreMaster
        GevIEEE1588Status_Master
        GevIEEE1588Status_Passive
        GevIEEE1588Status_Uncalibrated
        GevIEEE1588Status_Slave
        NUM_GEVIEEE1588STATUS

    cpdef enum GevIEEE1588ModeEnums:
        GevIEEE1588Mode_Auto
        GevIEEE1588Mode_SlaveOnly
        NUM_GEVIEEE1588MODE

    cpdef enum GevIEEE1588ClockAccuracyEnums:
        GevIEEE1588ClockAccuracy_Unknown
        NUM_GEVIEEE1588CLOCKACCURACY

    cpdef enum GevCCPEnums:
        GevCCP_OpenAccess
        GevCCP_ExclusiveAccess
        GevCCP_ControlAccess
        NUM_GEVCCP

    cpdef enum GevSupportedOptionSelectorEnums:
        GevSupportedOptionSelector_UserDefinedName
        GevSupportedOptionSelector_SerialNumber
        GevSupportedOptionSelector_HeartbeatDisable
        GevSupportedOptionSelector_LinkSpeed
        GevSupportedOptionSelector_CCPApplicationSocket
        GevSupportedOptionSelector_ManifestTable
        GevSupportedOptionSelector_TestData
        GevSupportedOptionSelector_DiscoveryAckDelay
        GevSupportedOptionSelector_DiscoveryAckDelayWritable
        GevSupportedOptionSelector_ExtendedStatusCodes
        GevSupportedOptionSelector_Action
        GevSupportedOptionSelector_PendingAck
        GevSupportedOptionSelector_EventData
        GevSupportedOptionSelector_Event
        GevSupportedOptionSelector_PacketResend
        GevSupportedOptionSelector_WriteMem
        GevSupportedOptionSelector_CommandsConcatenation
        GevSupportedOptionSelector_IPConfigurationLLA
        GevSupportedOptionSelector_IPConfigurationDHCP
        GevSupportedOptionSelector_IPConfigurationPersistentIP
        GevSupportedOptionSelector_StreamChannelSourceSocket
        GevSupportedOptionSelector_MessageChannelSourceSocket
        NUM_GEVSUPPORTEDOPTIONSELECTOR

    cpdef enum BlackLevelSelectorEnums:
        BlackLevelSelector_All
        BlackLevelSelector_Analog
        BlackLevelSelector_Digital
        NUM_BLACKLEVELSELECTOR

    cpdef enum BalanceWhiteAutoEnums:
        BalanceWhiteAuto_Off
        BalanceWhiteAuto_Once
        BalanceWhiteAuto_Continuous
        NUM_BALANCEWHITEAUTO

    cpdef enum GainAutoEnums:
        GainAuto_Off
        GainAuto_Once
        GainAuto_Continuous
        NUM_GAINAUTO

    cpdef enum BalanceRatioSelectorEnums:
        BalanceRatioSelector_Red
        BalanceRatioSelector_Blue
        NUM_BALANCERATIOSELECTOR

    cpdef enum GainSelectorEnums:
        GainSelector_All
        NUM_GAINSELECTOR

    cpdef enum DefectCorrectionModeEnums:
        DefectCorrectionMode_Average
        DefectCorrectionMode_Highlight
        DefectCorrectionMode_Zero
        NUM_DEFECTCORRECTIONMODE

    cpdef enum UserSetSelectorEnums:
        UserSetSelector_Default
        UserSetSelector_UserSet0
        UserSetSelector_UserSet1
        NUM_USERSETSELECTOR

    cpdef enum UserSetDefaultEnums:
        UserSetDefault_Default
        UserSetDefault_UserSet0
        UserSetDefault_UserSet1
        NUM_USERSETDEFAULT

    cpdef enum SerialPortBaudRateEnums:
        SerialPortBaudRate_Baud300
        SerialPortBaudRate_Baud600
        SerialPortBaudRate_Baud1200
        SerialPortBaudRate_Baud2400
        SerialPortBaudRate_Baud4800
        SerialPortBaudRate_Baud9600
        SerialPortBaudRate_Baud14400
        SerialPortBaudRate_Baud19200
        SerialPortBaudRate_Baud38400
        SerialPortBaudRate_Baud57600
        SerialPortBaudRate_Baud115200
        SerialPortBaudRate_Baud230400
        SerialPortBaudRate_Baud460800
        SerialPortBaudRate_Baud921600
        NUM_SERIALPORTBAUDRATE

    cpdef enum SerialPortParityEnums:
        SerialPortParity_None
        SerialPortParity_Odd
        SerialPortParity_Even
        SerialPortParity_Mark
        SerialPortParity_Space
        NUM_SERIALPORTPARITY

    cpdef enum SerialPortSelectorEnums:
        SerialPortSelector_SerialPort0
        NUM_SERIALPORTSELECTOR

    cpdef enum SerialPortStopBitsEnums:
        SerialPortStopBits_Bits1
        SerialPortStopBits_Bits1AndAHalf
        SerialPortStopBits_Bits2
        NUM_SERIALPORTSTOPBITS

    cpdef enum SerialPortSourceEnums:
        SerialPortSource_Line0
        SerialPortSource_Line1
        SerialPortSource_Line2
        SerialPortSource_Line3
        SerialPortSource_Off
        NUM_SERIALPORTSOURCE

    cpdef enum SequencerModeEnums:
        SequencerMode_Off
        SequencerMode_On
        NUM_SEQUENCERMODE

    cpdef enum SequencerConfigurationValidEnums:
        SequencerConfigurationValid_No
        SequencerConfigurationValid_Yes
        NUM_SEQUENCERCONFIGURATIONVALID

    cpdef enum SequencerSetValidEnums:
        SequencerSetValid_No
        SequencerSetValid_Yes
        NUM_SEQUENCERSETVALID

    cpdef enum SequencerTriggerActivationEnums:
        SequencerTriggerActivation_RisingEdge
        SequencerTriggerActivation_FallingEdge
        SequencerTriggerActivation_AnyEdge
        SequencerTriggerActivation_LevelHigh
        SequencerTriggerActivation_LevelLow
        NUM_SEQUENCERTRIGGERACTIVATION

    cpdef enum SequencerConfigurationModeEnums:
        SequencerConfigurationMode_Off
        SequencerConfigurationMode_On
        NUM_SEQUENCERCONFIGURATIONMODE
