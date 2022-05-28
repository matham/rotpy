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

    cpdef enum SequencerTriggerSourceEnums:
        SequencerTriggerSource_Off
        SequencerTriggerSource_FrameStart
        NUM_SEQUENCERTRIGGERSOURCE

    cpdef enum TransferQueueModeEnums:
        TransferQueueMode_FirstInFirstOut
        NUM_TRANSFERQUEUEMODE

    cpdef enum TransferOperationModeEnums:
        TransferOperationMode_Continuous
        TransferOperationMode_MultiBlock
        NUM_TRANSFEROPERATIONMODE

    cpdef enum TransferControlModeEnums:
        TransferControlMode_Basic
        TransferControlMode_Automatic
        TransferControlMode_UserControlled
        NUM_TRANSFERCONTROLMODE

    cpdef enum ChunkGainSelectorEnums:
        ChunkGainSelector_All
        ChunkGainSelector_Red
        ChunkGainSelector_Green
        ChunkGainSelector_Blue
        NUM_CHUNKGAINSELECTOR

    cpdef enum ChunkSelectorEnums:
        ChunkSelector_Image
        ChunkSelector_CRC
        ChunkSelector_FrameID
        ChunkSelector_OffsetX
        ChunkSelector_OffsetY
        ChunkSelector_Width
        ChunkSelector_Height
        ChunkSelector_ExposureTime
        ChunkSelector_Gain
        ChunkSelector_BlackLevel
        ChunkSelector_PixelFormat
        ChunkSelector_Timestamp
        ChunkSelector_SequencerSetActive
        ChunkSelector_SerialData
        ChunkSelector_ExposureEndLineStatusAll
        NUM_CHUNKSELECTOR

    cpdef enum ChunkBlackLevelSelectorEnums:
        ChunkBlackLevelSelector_All
        NUM_CHUNKBLACKLEVELSELECTOR

    cpdef enum ChunkPixelFormatEnums:
        ChunkPixelFormat_Mono8
        ChunkPixelFormat_Mono12Packed
        ChunkPixelFormat_Mono16
        ChunkPixelFormat_RGB8Packed
        ChunkPixelFormat_YUV422Packed
        ChunkPixelFormat_BayerGR8
        ChunkPixelFormat_BayerRG8
        ChunkPixelFormat_BayerGB8
        ChunkPixelFormat_BayerBG8
        ChunkPixelFormat_YCbCr601_422_8_CbYCrY
        NUM_CHUNKPIXELFORMAT

    cpdef enum FileOperationStatusEnums:
        FileOperationStatus_Success
        FileOperationStatus_Failure
        FileOperationStatus_Overflow
        NUM_FILEOPERATIONSTATUS

    cpdef enum FileOpenModeEnums:
        FileOpenMode_Read
        FileOpenMode_Write
        FileOpenMode_ReadWrite
        NUM_FILEOPENMODE

    cpdef enum FileOperationSelectorEnums:
        FileOperationSelector_Open
        FileOperationSelector_Close
        FileOperationSelector_Read
        FileOperationSelector_Write
        FileOperationSelector_Delete
        NUM_FILEOPERATIONSELECTOR

    cpdef enum FileSelectorEnums:
        FileSelector_UserSetDefault
        FileSelector_UserSet0
        FileSelector_UserSet1
        FileSelector_UserFile1
        FileSelector_SerialPort0
        NUM_FILESELECTOR

    cpdef enum BinningSelectorEnums:
        BinningSelector_All
        BinningSelector_Sensor
        BinningSelector_ISP
        NUM_BINNINGSELECTOR

    cpdef enum TestPatternGeneratorSelectorEnums:
        TestPatternGeneratorSelector_Sensor
        TestPatternGeneratorSelector_PipelineStart
        NUM_TESTPATTERNGENERATORSELECTOR

    cpdef enum CompressionSaturationPriorityEnums:
        CompressionSaturationPriority_DropFrame
        CompressionSaturationPriority_ReduceFrameRate
        NUM_COMPRESSIONSATURATIONPRIORITY

    cpdef enum TestPatternEnums:
        TestPattern_Off
        TestPattern_Increment
        TestPattern_SensorTestPattern
        NUM_TESTPATTERN

    cpdef enum PixelColorFilterEnums:
        PixelColorFilter_None
        PixelColorFilter_BayerRG
        PixelColorFilter_BayerGB
        PixelColorFilter_BayerGR
        PixelColorFilter_BayerBG
        NUM_PIXELCOLORFILTER

    cpdef enum AdcBitDepthEnums:
        AdcBitDepth_Bit8
        AdcBitDepth_Bit10
        AdcBitDepth_Bit12
        AdcBitDepth_Bit14
        NUM_ADCBITDEPTH

    cpdef enum DecimationHorizontalModeEnums:
        DecimationHorizontalMode_Discard
        NUM_DECIMATIONHORIZONTALMODE

    cpdef enum BinningVerticalModeEnums:
        BinningVerticalMode_Sum
        BinningVerticalMode_Average
        NUM_BINNINGVERTICALMODE

    cpdef enum PixelSizeEnums:
        PixelSize_Bpp1
        PixelSize_Bpp2
        PixelSize_Bpp4
        PixelSize_Bpp8
        PixelSize_Bpp10
        PixelSize_Bpp12
        PixelSize_Bpp14
        PixelSize_Bpp16
        PixelSize_Bpp20
        PixelSize_Bpp24
        PixelSize_Bpp30
        PixelSize_Bpp32
        PixelSize_Bpp36
        PixelSize_Bpp48
        PixelSize_Bpp64
        PixelSize_Bpp96
        NUM_PIXELSIZE

    cpdef enum DecimationSelectorEnums:
        DecimationSelector_All
        DecimationSelector_Sensor
        NUM_DECIMATIONSELECTOR

    cpdef enum ImageCompressionModeEnums:
        ImageCompressionMode_Off
        ImageCompressionMode_Lossless
        NUM_IMAGECOMPRESSIONMODE

    cpdef enum BinningHorizontalModeEnums:
        BinningHorizontalMode_Sum
        BinningHorizontalMode_Average
        NUM_BINNINGHORIZONTALMODE

    cpdef enum PixelFormatEnums:
        PixelFormat_Mono8
        PixelFormat_Mono16
        PixelFormat_RGB8Packed
        PixelFormat_BayerGR8
        PixelFormat_BayerRG8
        PixelFormat_BayerGB8
        PixelFormat_BayerBG8
        PixelFormat_BayerGR16
        PixelFormat_BayerRG16
        PixelFormat_BayerGB16
        PixelFormat_BayerBG16
        PixelFormat_Mono12Packed
        PixelFormat_BayerGR12Packed
        PixelFormat_BayerRG12Packed
        PixelFormat_BayerGB12Packed
        PixelFormat_BayerBG12Packed
        PixelFormat_YUV411Packed
        PixelFormat_YUV422Packed
        PixelFormat_YUV444Packed
        PixelFormat_Mono12p
        PixelFormat_BayerGR12p
        PixelFormat_BayerRG12p
        PixelFormat_BayerGB12p
        PixelFormat_BayerBG12p
        PixelFormat_YCbCr8
        PixelFormat_YCbCr422_8
        PixelFormat_YCbCr411_8
        PixelFormat_BGR8
        PixelFormat_BGRa8
        PixelFormat_Mono10Packed
        PixelFormat_BayerGR10Packed
        PixelFormat_BayerRG10Packed
        PixelFormat_BayerGB10Packed
        PixelFormat_BayerBG10Packed
        PixelFormat_Mono10p
        PixelFormat_BayerGR10p
        PixelFormat_BayerRG10p
        PixelFormat_BayerGB10p
        PixelFormat_BayerBG10p
        PixelFormat_Mono1p
        PixelFormat_Mono2p
        PixelFormat_Mono4p
        PixelFormat_Mono8s
        PixelFormat_Mono10
        PixelFormat_Mono12
        PixelFormat_Mono14
        PixelFormat_Mono16s
        PixelFormat_Mono32f
        PixelFormat_BayerBG10
        PixelFormat_BayerBG12
        PixelFormat_BayerGB10
        PixelFormat_BayerGB12
        PixelFormat_BayerGR10
        PixelFormat_BayerGR12
        PixelFormat_BayerRG10
        PixelFormat_BayerRG12
        PixelFormat_RGBa8
        PixelFormat_RGBa10
        PixelFormat_RGBa10p
        PixelFormat_RGBa12
        PixelFormat_RGBa12p
        PixelFormat_RGBa14
        PixelFormat_RGBa16
        PixelFormat_RGB8
        PixelFormat_RGB8_Planar
        PixelFormat_RGB10
        PixelFormat_RGB10_Planar
        PixelFormat_RGB10p
        PixelFormat_RGB10p32
        PixelFormat_RGB12
        PixelFormat_RGB12_Planar
        PixelFormat_RGB12p
        PixelFormat_RGB14
        PixelFormat_RGB16
        PixelFormat_RGB16s
        PixelFormat_RGB32f
        PixelFormat_RGB16_Planar
        PixelFormat_RGB565p
        PixelFormat_BGRa10
        PixelFormat_BGRa10p
        PixelFormat_BGRa12
        PixelFormat_BGRa12p
        PixelFormat_BGRa14
        PixelFormat_BGRa16
        PixelFormat_RGBa32f
        PixelFormat_BGR10
        PixelFormat_BGR10p
        PixelFormat_BGR12
        PixelFormat_BGR12p
        PixelFormat_BGR14
        PixelFormat_BGR16
        PixelFormat_BGR565p
        PixelFormat_R8
        PixelFormat_R10
        PixelFormat_R12
        PixelFormat_R16
        PixelFormat_G8
        PixelFormat_G10
        PixelFormat_G12
        PixelFormat_G16
        PixelFormat_B8
        PixelFormat_B10
        PixelFormat_B12
        PixelFormat_B16
        PixelFormat_Coord3D_ABC8
        PixelFormat_Coord3D_ABC8_Planar
        PixelFormat_Coord3D_ABC10p
        PixelFormat_Coord3D_ABC10p_Planar
        PixelFormat_Coord3D_ABC12p
        PixelFormat_Coord3D_ABC12p_Planar
        PixelFormat_Coord3D_ABC16
        PixelFormat_Coord3D_ABC16_Planar
        PixelFormat_Coord3D_ABC32f
        PixelFormat_Coord3D_ABC32f_Planar
        PixelFormat_Coord3D_AC8
        PixelFormat_Coord3D_AC8_Planar
        PixelFormat_Coord3D_AC10p
        PixelFormat_Coord3D_AC10p_Planar
        PixelFormat_Coord3D_AC12p
        PixelFormat_Coord3D_AC12p_Planar
        PixelFormat_Coord3D_AC16
        PixelFormat_Coord3D_AC16_Planar
        PixelFormat_Coord3D_AC32f
        PixelFormat_Coord3D_AC32f_Planar
        PixelFormat_Coord3D_A8
        PixelFormat_Coord3D_A10p
        PixelFormat_Coord3D_A12p
        PixelFormat_Coord3D_A16
        PixelFormat_Coord3D_A32f
        PixelFormat_Coord3D_B8
        PixelFormat_Coord3D_B10p
        PixelFormat_Coord3D_B12p
        PixelFormat_Coord3D_B16
        PixelFormat_Coord3D_B32f
        PixelFormat_Coord3D_C8
        PixelFormat_Coord3D_C10p
        PixelFormat_Coord3D_C12p
        PixelFormat_Coord3D_C16
        PixelFormat_Coord3D_C32f
        PixelFormat_Confidence1
        PixelFormat_Confidence1p
        PixelFormat_Confidence8
        PixelFormat_Confidence16
        PixelFormat_Confidence32f
        PixelFormat_BiColorBGRG8
        PixelFormat_BiColorBGRG10
        PixelFormat_BiColorBGRG10p
        PixelFormat_BiColorBGRG12
        PixelFormat_BiColorBGRG12p
        PixelFormat_BiColorRGBG8
        PixelFormat_BiColorRGBG10
        PixelFormat_BiColorRGBG10p
        PixelFormat_BiColorRGBG12
        PixelFormat_BiColorRGBG12p
        PixelFormat_SCF1WBWG8
        PixelFormat_SCF1WBWG10
        PixelFormat_SCF1WBWG10p
        PixelFormat_SCF1WBWG12
        PixelFormat_SCF1WBWG12p
        PixelFormat_SCF1WBWG14
        PixelFormat_SCF1WBWG16
        PixelFormat_SCF1WGWB8
        PixelFormat_SCF1WGWB10
        PixelFormat_SCF1WGWB10p
        PixelFormat_SCF1WGWB12
        PixelFormat_SCF1WGWB12p
        PixelFormat_SCF1WGWB14
        PixelFormat_SCF1WGWB16
        PixelFormat_SCF1WGWR8
        PixelFormat_SCF1WGWR10
        PixelFormat_SCF1WGWR10p
        PixelFormat_SCF1WGWR12
        PixelFormat_SCF1WGWR12p
        PixelFormat_SCF1WGWR14
        PixelFormat_SCF1WGWR16
        PixelFormat_SCF1WRWG8
        PixelFormat_SCF1WRWG10
        PixelFormat_SCF1WRWG10p
        PixelFormat_SCF1WRWG12
        PixelFormat_SCF1WRWG12p
        PixelFormat_SCF1WRWG14
        PixelFormat_SCF1WRWG16
        PixelFormat_YCbCr8_CbYCr
        PixelFormat_YCbCr10_CbYCr
        PixelFormat_YCbCr10p_CbYCr
        PixelFormat_YCbCr12_CbYCr
        PixelFormat_YCbCr12p_CbYCr
        PixelFormat_YCbCr411_8_CbYYCrYY
        PixelFormat_YCbCr422_8_CbYCrY
        PixelFormat_YCbCr422_10
        PixelFormat_YCbCr422_10_CbYCrY
        PixelFormat_YCbCr422_10p
        PixelFormat_YCbCr422_10p_CbYCrY
        PixelFormat_YCbCr422_12
        PixelFormat_YCbCr422_12_CbYCrY
        PixelFormat_YCbCr422_12p
        PixelFormat_YCbCr422_12p_CbYCrY
        PixelFormat_YCbCr601_8_CbYCr
        PixelFormat_YCbCr601_10_CbYCr
        PixelFormat_YCbCr601_10p_CbYCr
        PixelFormat_YCbCr601_12_CbYCr
        PixelFormat_YCbCr601_12p_CbYCr
        PixelFormat_YCbCr601_411_8_CbYYCrYY
        PixelFormat_YCbCr601_422_8
        PixelFormat_YCbCr601_422_8_CbYCrY
        PixelFormat_YCbCr601_422_10
        PixelFormat_YCbCr601_422_10_CbYCrY
        PixelFormat_YCbCr601_422_10p
        PixelFormat_YCbCr601_422_10p_CbYCrY
        PixelFormat_YCbCr601_422_12
        PixelFormat_YCbCr601_422_12_CbYCrY
        PixelFormat_YCbCr601_422_12p
        PixelFormat_YCbCr601_422_12p_CbYCrY
        PixelFormat_YCbCr709_8_CbYCr
        PixelFormat_YCbCr709_10_CbYCr
        PixelFormat_YCbCr709_10p_CbYCr
        PixelFormat_YCbCr709_12_CbYCr
        PixelFormat_YCbCr709_12p_CbYCr
        PixelFormat_YCbCr709_411_8_CbYYCrYY
        PixelFormat_YCbCr709_422_8
        PixelFormat_YCbCr709_422_8_CbYCrY
        PixelFormat_YCbCr709_422_10
        PixelFormat_YCbCr709_422_10_CbYCrY
        PixelFormat_YCbCr709_422_10p
        PixelFormat_YCbCr709_422_10p_CbYCrY
        PixelFormat_YCbCr709_422_12
        PixelFormat_YCbCr709_422_12_CbYCrY
        PixelFormat_YCbCr709_422_12p
        PixelFormat_YCbCr709_422_12p_CbYCrY
        PixelFormat_YUV8_UYV
        PixelFormat_YUV411_8_UYYVYY
        PixelFormat_YUV422_8
        PixelFormat_YUV422_8_UYVY
        PixelFormat_Polarized8
        PixelFormat_Polarized10p
        PixelFormat_Polarized12p
        PixelFormat_Polarized16
        PixelFormat_BayerRGPolarized8
        PixelFormat_BayerRGPolarized10p
        PixelFormat_BayerRGPolarized12p
        PixelFormat_BayerRGPolarized16
        PixelFormat_LLCMono8
        PixelFormat_LLCBayerRG8
        PixelFormat_JPEGMono8
        PixelFormat_JPEGColor8
        PixelFormat_Raw16
        PixelFormat_Raw8
        PixelFormat_R12_Jpeg
        PixelFormat_GR12_Jpeg
        PixelFormat_GB12_Jpeg
        PixelFormat_B12_Jpeg
        UNKNOWN_PIXELFORMAT
        NUM_PIXELFORMAT

    cpdef enum DecimationVerticalModeEnums:
        DecimationVerticalMode_Discard
        NUM_DECIMATIONVERTICALMODE

    cpdef enum LineModeEnums:
        LineMode_Input
        LineMode_Output
        NUM_LINEMODE

    cpdef enum LineSourceEnums:
        LineSource_Off
        LineSource_Line0
        LineSource_Line1
        LineSource_Line2
        LineSource_Line3
        LineSource_UserOutput0
        LineSource_UserOutput1
        LineSource_UserOutput2
        LineSource_UserOutput3
        LineSource_Counter0Active
        LineSource_Counter1Active
        LineSource_LogicBlock0
        LineSource_LogicBlock1
        LineSource_ExposureActive
        LineSource_FrameTriggerWait
        LineSource_SerialPort0
        LineSource_PPSSignal
        LineSource_AllPixel
        LineSource_AnyPixel
        NUM_LINESOURCE

    cpdef enum LineInputFilterSelectorEnums:
        LineInputFilterSelector_Deglitch
        LineInputFilterSelector_Debounce
        NUM_LINEINPUTFILTERSELECTOR

    cpdef enum UserOutputSelectorEnums:
        UserOutputSelector_UserOutput0
        UserOutputSelector_UserOutput1
        UserOutputSelector_UserOutput2
        UserOutputSelector_UserOutput3
        NUM_USEROUTPUTSELECTOR

    cpdef enum LineFormatEnums:
        LineFormat_NoConnect
        LineFormat_TriState
        LineFormat_TTL
        LineFormat_LVDS
        LineFormat_RS422
        LineFormat_OptoCoupled
        LineFormat_OpenDrain
        NUM_LINEFORMAT

    cpdef enum LineSelectorEnums:
        LineSelector_Line0
        LineSelector_Line1
        LineSelector_Line2
        LineSelector_Line3
        NUM_LINESELECTOR

    cpdef enum ExposureActiveModeEnums:
        ExposureActiveMode_Line1
        ExposureActiveMode_AnyPixels
        ExposureActiveMode_AllPixels
        NUM_EXPOSUREACTIVEMODE

    cpdef enum CounterTriggerActivationEnums:
        CounterTriggerActivation_LevelLow
        CounterTriggerActivation_LevelHigh
        CounterTriggerActivation_FallingEdge
        CounterTriggerActivation_RisingEdge
        CounterTriggerActivation_AnyEdge
        NUM_COUNTERTRIGGERACTIVATION

    cpdef enum CounterSelectorEnums:
        CounterSelector_Counter0
        CounterSelector_Counter1
        NUM_COUNTERSELECTOR

    cpdef enum CounterStatusEnums:
        CounterStatus_CounterIdle
        CounterStatus_CounterTriggerWait
        CounterStatus_CounterActive
        CounterStatus_CounterCompleted
        CounterStatus_CounterOverflow
        NUM_COUNTERSTATUS

    cpdef enum CounterTriggerSourceEnums:
        CounterTriggerSource_Off
        CounterTriggerSource_Line0
        CounterTriggerSource_Line1
        CounterTriggerSource_Line2
        CounterTriggerSource_Line3
        CounterTriggerSource_UserOutput0
        CounterTriggerSource_UserOutput1
        CounterTriggerSource_UserOutput2
        CounterTriggerSource_UserOutput3
        CounterTriggerSource_Counter0Start
        CounterTriggerSource_Counter1Start
        CounterTriggerSource_Counter0End
        CounterTriggerSource_Counter1End
        CounterTriggerSource_LogicBlock0
        CounterTriggerSource_LogicBlock1
        CounterTriggerSource_ExposureStart
        CounterTriggerSource_ExposureEnd
        CounterTriggerSource_FrameTriggerWait
        NUM_COUNTERTRIGGERSOURCE

    cpdef enum CounterResetSourceEnums:
        CounterResetSource_Off
        CounterResetSource_Line0
        CounterResetSource_Line1
        CounterResetSource_Line2
        CounterResetSource_Line3
        CounterResetSource_UserOutput0
        CounterResetSource_UserOutput1
        CounterResetSource_UserOutput2
        CounterResetSource_UserOutput3
        CounterResetSource_Counter0Start
        CounterResetSource_Counter1Start
        CounterResetSource_Counter0End
        CounterResetSource_Counter1End
        CounterResetSource_LogicBlock0
        CounterResetSource_LogicBlock1
        CounterResetSource_ExposureStart
        CounterResetSource_ExposureEnd
        CounterResetSource_FrameTriggerWait
        NUM_COUNTERRESETSOURCE

    cpdef enum CounterEventSourceEnums:
        CounterEventSource_Off
        CounterEventSource_MHzTick
        CounterEventSource_Line0
        CounterEventSource_Line1
        CounterEventSource_Line2
        CounterEventSource_Line3
        CounterEventSource_UserOutput0
        CounterEventSource_UserOutput1
        CounterEventSource_UserOutput2
        CounterEventSource_UserOutput3
        CounterEventSource_Counter0Start
        CounterEventSource_Counter1Start
        CounterEventSource_Counter0End
        CounterEventSource_Counter1End
        CounterEventSource_LogicBlock0
        CounterEventSource_LogicBlock1
        CounterEventSource_ExposureStart
        CounterEventSource_ExposureEnd
        CounterEventSource_FrameTriggerWait
        NUM_COUNTEREVENTSOURCE

    cpdef enum CounterEventActivationEnums:
        CounterEventActivation_LevelLow
        CounterEventActivation_LevelHigh
        CounterEventActivation_FallingEdge
        CounterEventActivation_RisingEdge
        CounterEventActivation_AnyEdge
        NUM_COUNTEREVENTACTIVATION

    cpdef enum CounterResetActivationEnums:
        CounterResetActivation_LevelLow
        CounterResetActivation_LevelHigh
        CounterResetActivation_FallingEdge
        CounterResetActivation_RisingEdge
        CounterResetActivation_AnyEdge
        NUM_COUNTERRESETACTIVATION

    cpdef enum DeviceTypeEnums:
        DeviceType_Transmitter
        DeviceType_Receiver
        DeviceType_Transceiver
        DeviceType_Peripheral
        NUM_DEVICETYPE

    cpdef enum DeviceConnectionStatusEnums:
        DeviceConnectionStatus_Active
        DeviceConnectionStatus_Inactive
        NUM_DEVICECONNECTIONSTATUS

    cpdef enum DeviceLinkThroughputLimitModeEnums:
        DeviceLinkThroughputLimitMode_On
        DeviceLinkThroughputLimitMode_Off
        NUM_DEVICELINKTHROUGHPUTLIMITMODE

    cpdef enum DeviceLinkHeartbeatModeEnums:
        DeviceLinkHeartbeatMode_On
        DeviceLinkHeartbeatMode_Off
        NUM_DEVICELINKHEARTBEATMODE

    cpdef enum DeviceStreamChannelTypeEnums:
        DeviceStreamChannelType_Transmitter
        DeviceStreamChannelType_Receiver
        NUM_DEVICESTREAMCHANNELTYPE

    cpdef enum DeviceStreamChannelEndiannessEnums:
        DeviceStreamChannelEndianness_Big
        DeviceStreamChannelEndianness_Little
        NUM_DEVICESTREAMCHANNELENDIANNESS

    cpdef enum DeviceClockSelectorEnums:
        DeviceClockSelector_Sensor
        DeviceClockSelector_SensorDigitization
        DeviceClockSelector_CameraLink
        NUM_DEVICECLOCKSELECTOR

    cpdef enum DeviceSerialPortSelectorEnums:
        DeviceSerialPortSelector_CameraLink
        NUM_DEVICESERIALPORTSELECTOR

    cpdef enum DeviceSerialPortBaudRateEnums:
        DeviceSerialPortBaudRate_Baud9600
        DeviceSerialPortBaudRate_Baud19200
        DeviceSerialPortBaudRate_Baud38400
        DeviceSerialPortBaudRate_Baud57600
        DeviceSerialPortBaudRate_Baud115200
        DeviceSerialPortBaudRate_Baud230400
        DeviceSerialPortBaudRate_Baud460800
        DeviceSerialPortBaudRate_Baud921600
        NUM_DEVICESERIALPORTBAUDRATE

    cpdef enum SensorTapsEnums:
        SensorTaps_One
        SensorTaps_Two
        SensorTaps_Three
        SensorTaps_Four
        SensorTaps_Eight
        SensorTaps_Ten
        NUM_SENSORTAPS

    cpdef enum SensorDigitizationTapsEnums:
        SensorDigitizationTaps_One
        SensorDigitizationTaps_Two
        SensorDigitizationTaps_Three
        SensorDigitizationTaps_Four
        SensorDigitizationTaps_Eight
        SensorDigitizationTaps_Ten
        NUM_SENSORDIGITIZATIONTAPS

    cpdef enum RegionSelectorEnums:
        RegionSelector_Region0
        RegionSelector_Region1
        RegionSelector_Region2
        RegionSelector_All
        NUM_REGIONSELECTOR

    cpdef enum RegionModeEnums:
        RegionMode_Off
        RegionMode_On
        NUM_REGIONMODE

    cpdef enum RegionDestinationEnums:
        RegionDestination_Stream0
        RegionDestination_Stream1
        RegionDestination_Stream2
        NUM_REGIONDESTINATION

    cpdef enum ImageComponentSelectorEnums:
        ImageComponentSelector_Intensity
        ImageComponentSelector_Color
        ImageComponentSelector_Infrared
        ImageComponentSelector_Ultraviolet
        ImageComponentSelector_Range
        ImageComponentSelector_Disparity
        ImageComponentSelector_Confidence
        ImageComponentSelector_Scatter
        NUM_IMAGECOMPONENTSELECTOR

    cpdef enum PixelFormatInfoSelectorEnums:
        PixelFormatInfoSelector_Mono1p
        PixelFormatInfoSelector_Mono2p
        PixelFormatInfoSelector_Mono4p
        PixelFormatInfoSelector_Mono8
        PixelFormatInfoSelector_Mono8s
        PixelFormatInfoSelector_Mono10
        PixelFormatInfoSelector_Mono10p
        PixelFormatInfoSelector_Mono12
        PixelFormatInfoSelector_Mono12p
        PixelFormatInfoSelector_Mono14
        PixelFormatInfoSelector_Mono16
        PixelFormatInfoSelector_Mono16s
        PixelFormatInfoSelector_Mono32f
        PixelFormatInfoSelector_BayerBG8
        PixelFormatInfoSelector_BayerBG10
        PixelFormatInfoSelector_BayerBG10p
        PixelFormatInfoSelector_BayerBG12
        PixelFormatInfoSelector_BayerBG12p
        PixelFormatInfoSelector_BayerBG16
        PixelFormatInfoSelector_BayerGB8
        PixelFormatInfoSelector_BayerGB10
        PixelFormatInfoSelector_BayerGB10p
        PixelFormatInfoSelector_BayerGB12
        PixelFormatInfoSelector_BayerGB12p
        PixelFormatInfoSelector_BayerGB16
        PixelFormatInfoSelector_BayerGR8
        PixelFormatInfoSelector_BayerGR10
        PixelFormatInfoSelector_BayerGR10p
        PixelFormatInfoSelector_BayerGR12
        PixelFormatInfoSelector_BayerGR12p
        PixelFormatInfoSelector_BayerGR16
        PixelFormatInfoSelector_BayerRG8
        PixelFormatInfoSelector_BayerRG10
        PixelFormatInfoSelector_BayerRG10p
        PixelFormatInfoSelector_BayerRG12
        PixelFormatInfoSelector_BayerRG12p
        PixelFormatInfoSelector_BayerRG16
        PixelFormatInfoSelector_RGBa8
        PixelFormatInfoSelector_RGBa10
        PixelFormatInfoSelector_RGBa10p
        PixelFormatInfoSelector_RGBa12
        PixelFormatInfoSelector_RGBa12p
        PixelFormatInfoSelector_RGBa14
        PixelFormatInfoSelector_RGBa16
        PixelFormatInfoSelector_RGB8
        PixelFormatInfoSelector_RGB8_Planar
        PixelFormatInfoSelector_RGB10
        PixelFormatInfoSelector_RGB10_Planar
        PixelFormatInfoSelector_RGB10p
        PixelFormatInfoSelector_RGB10p32
        PixelFormatInfoSelector_RGB12
        PixelFormatInfoSelector_RGB12_Planar
        PixelFormatInfoSelector_RGB12p
        PixelFormatInfoSelector_RGB14
        PixelFormatInfoSelector_RGB16
        PixelFormatInfoSelector_RGB16s
        PixelFormatInfoSelector_RGB32f
        PixelFormatInfoSelector_RGB16_Planar
        PixelFormatInfoSelector_RGB565p
        PixelFormatInfoSelector_BGRa8
        PixelFormatInfoSelector_BGRa10
        PixelFormatInfoSelector_BGRa10p
        PixelFormatInfoSelector_BGRa12
        PixelFormatInfoSelector_BGRa12p
        PixelFormatInfoSelector_BGRa14
        PixelFormatInfoSelector_BGRa16
        PixelFormatInfoSelector_RGBa32f
        PixelFormatInfoSelector_BGR8
        PixelFormatInfoSelector_BGR10
        PixelFormatInfoSelector_BGR10p
        PixelFormatInfoSelector_BGR12
        PixelFormatInfoSelector_BGR12p
        PixelFormatInfoSelector_BGR14
        PixelFormatInfoSelector_BGR16
        PixelFormatInfoSelector_BGR565p
        PixelFormatInfoSelector_R8
        PixelFormatInfoSelector_R10
        PixelFormatInfoSelector_R12
        PixelFormatInfoSelector_R16
        PixelFormatInfoSelector_G8
        PixelFormatInfoSelector_G10
        PixelFormatInfoSelector_G12
        PixelFormatInfoSelector_G16
        PixelFormatInfoSelector_B8
        PixelFormatInfoSelector_B10
        PixelFormatInfoSelector_B12
        PixelFormatInfoSelector_B16
        PixelFormatInfoSelector_Coord3D_ABC8
        PixelFormatInfoSelector_Coord3D_ABC8_Planar
        PixelFormatInfoSelector_Coord3D_ABC10p
        PixelFormatInfoSelector_Coord3D_ABC10p_Planar
        PixelFormatInfoSelector_Coord3D_ABC12p
        PixelFormatInfoSelector_Coord3D_ABC12p_Planar
        PixelFormatInfoSelector_Coord3D_ABC16
        PixelFormatInfoSelector_Coord3D_ABC16_Planar
        PixelFormatInfoSelector_Coord3D_ABC32f
        PixelFormatInfoSelector_Coord3D_ABC32f_Planar
        PixelFormatInfoSelector_Coord3D_AC8
        PixelFormatInfoSelector_Coord3D_AC8_Planar
        PixelFormatInfoSelector_Coord3D_AC10p
        PixelFormatInfoSelector_Coord3D_AC10p_Planar
        PixelFormatInfoSelector_Coord3D_AC12p
        PixelFormatInfoSelector_Coord3D_AC12p_Planar
        PixelFormatInfoSelector_Coord3D_AC16
        PixelFormatInfoSelector_Coord3D_AC16_Planar
        PixelFormatInfoSelector_Coord3D_AC32f
        PixelFormatInfoSelector_Coord3D_AC32f_Planar
        PixelFormatInfoSelector_Coord3D_A8
        PixelFormatInfoSelector_Coord3D_A10p
        PixelFormatInfoSelector_Coord3D_A12p
        PixelFormatInfoSelector_Coord3D_A16
        PixelFormatInfoSelector_Coord3D_A32f
        PixelFormatInfoSelector_Coord3D_B8
        PixelFormatInfoSelector_Coord3D_B10p
        PixelFormatInfoSelector_Coord3D_B12p
        PixelFormatInfoSelector_Coord3D_B16
        PixelFormatInfoSelector_Coord3D_B32f
        PixelFormatInfoSelector_Coord3D_C8
        PixelFormatInfoSelector_Coord3D_C10p
        PixelFormatInfoSelector_Coord3D_C12p
        PixelFormatInfoSelector_Coord3D_C16
        PixelFormatInfoSelector_Coord3D_C32f
        PixelFormatInfoSelector_Confidence1
        PixelFormatInfoSelector_Confidence1p
        PixelFormatInfoSelector_Confidence8
        PixelFormatInfoSelector_Confidence16
        PixelFormatInfoSelector_Confidence32f
        PixelFormatInfoSelector_BiColorBGRG8
        PixelFormatInfoSelector_BiColorBGRG10
        PixelFormatInfoSelector_BiColorBGRG10p
        PixelFormatInfoSelector_BiColorBGRG12
        PixelFormatInfoSelector_BiColorBGRG12p
        PixelFormatInfoSelector_BiColorRGBG8
        PixelFormatInfoSelector_BiColorRGBG10
        PixelFormatInfoSelector_BiColorRGBG10p
        PixelFormatInfoSelector_BiColorRGBG12
        PixelFormatInfoSelector_BiColorRGBG12p
        PixelFormatInfoSelector_SCF1WBWG8
        PixelFormatInfoSelector_SCF1WBWG10
        PixelFormatInfoSelector_SCF1WBWG10p
        PixelFormatInfoSelector_SCF1WBWG12
        PixelFormatInfoSelector_SCF1WBWG12p
        PixelFormatInfoSelector_SCF1WBWG14
        PixelFormatInfoSelector_SCF1WBWG16
        PixelFormatInfoSelector_SCF1WGWB8
        PixelFormatInfoSelector_SCF1WGWB10
        PixelFormatInfoSelector_SCF1WGWB10p
        PixelFormatInfoSelector_SCF1WGWB12
        PixelFormatInfoSelector_SCF1WGWB12p
        PixelFormatInfoSelector_SCF1WGWB14
        PixelFormatInfoSelector_SCF1WGWB16
        PixelFormatInfoSelector_SCF1WGWR8
        PixelFormatInfoSelector_SCF1WGWR10
        PixelFormatInfoSelector_SCF1WGWR10p
        PixelFormatInfoSelector_SCF1WGWR12
        PixelFormatInfoSelector_SCF1WGWR12p
        PixelFormatInfoSelector_SCF1WGWR14
        PixelFormatInfoSelector_SCF1WGWR16
        PixelFormatInfoSelector_SCF1WRWG8
        PixelFormatInfoSelector_SCF1WRWG10
        PixelFormatInfoSelector_SCF1WRWG10p
        PixelFormatInfoSelector_SCF1WRWG12
        PixelFormatInfoSelector_SCF1WRWG12p
        PixelFormatInfoSelector_SCF1WRWG14
        PixelFormatInfoSelector_SCF1WRWG16
        PixelFormatInfoSelector_YCbCr8
        PixelFormatInfoSelector_YCbCr8_CbYCr
        PixelFormatInfoSelector_YCbCr10_CbYCr
        PixelFormatInfoSelector_YCbCr10p_CbYCr
        PixelFormatInfoSelector_YCbCr12_CbYCr
        PixelFormatInfoSelector_YCbCr12p_CbYCr
        PixelFormatInfoSelector_YCbCr411_8
        PixelFormatInfoSelector_YCbCr411_8_CbYYCrYY
        PixelFormatInfoSelector_YCbCr422_8
        PixelFormatInfoSelector_YCbCr422_8_CbYCrY
        PixelFormatInfoSelector_YCbCr422_10
        PixelFormatInfoSelector_YCbCr422_10_CbYCrY
        PixelFormatInfoSelector_YCbCr422_10p
        PixelFormatInfoSelector_YCbCr422_10p_CbYCrY
        PixelFormatInfoSelector_YCbCr422_12
        PixelFormatInfoSelector_YCbCr422_12_CbYCrY
        PixelFormatInfoSelector_YCbCr422_12p
        PixelFormatInfoSelector_YCbCr422_12p_CbYCrY
        PixelFormatInfoSelector_YCbCr601_8_CbYCr
        PixelFormatInfoSelector_YCbCr601_10_CbYCr
        PixelFormatInfoSelector_YCbCr601_10p_CbYCr
        PixelFormatInfoSelector_YCbCr601_12_CbYCr
        PixelFormatInfoSelector_YCbCr601_12p_CbYCr
        PixelFormatInfoSelector_YCbCr601_411_8_CbYYCrYY
        PixelFormatInfoSelector_YCbCr601_422_8
        PixelFormatInfoSelector_YCbCr601_422_8_CbYCrY
        PixelFormatInfoSelector_YCbCr601_422_10
        PixelFormatInfoSelector_YCbCr601_422_10_CbYCrY
        PixelFormatInfoSelector_YCbCr601_422_10p
        PixelFormatInfoSelector_YCbCr601_422_10p_CbYCrY
        PixelFormatInfoSelector_YCbCr601_422_12
        PixelFormatInfoSelector_YCbCr601_422_12_CbYCrY
        PixelFormatInfoSelector_YCbCr601_422_12p
        PixelFormatInfoSelector_YCbCr601_422_12p_CbYCrY
        PixelFormatInfoSelector_YCbCr709_8_CbYCr
        PixelFormatInfoSelector_YCbCr709_10_CbYCr
        PixelFormatInfoSelector_YCbCr709_10p_CbYCr
        PixelFormatInfoSelector_YCbCr709_12_CbYCr
        PixelFormatInfoSelector_YCbCr709_12p_CbYCr
        PixelFormatInfoSelector_YCbCr709_411_8_CbYYCrYY
        PixelFormatInfoSelector_YCbCr709_422_8
        PixelFormatInfoSelector_YCbCr709_422_8_CbYCrY
        PixelFormatInfoSelector_YCbCr709_422_10
        PixelFormatInfoSelector_YCbCr709_422_10_CbYCrY
        PixelFormatInfoSelector_YCbCr709_422_10p
        PixelFormatInfoSelector_YCbCr709_422_10p_CbYCrY
        PixelFormatInfoSelector_YCbCr709_422_12
        PixelFormatInfoSelector_YCbCr709_422_12_CbYCrY
        PixelFormatInfoSelector_YCbCr709_422_12p
        PixelFormatInfoSelector_YCbCr709_422_12p_CbYCrY
        PixelFormatInfoSelector_YUV8_UYV
        PixelFormatInfoSelector_YUV411_8_UYYVYY
        PixelFormatInfoSelector_YUV422_8
        PixelFormatInfoSelector_YUV422_8_UYVY
        PixelFormatInfoSelector_Polarized8
        PixelFormatInfoSelector_Polarized10p
        PixelFormatInfoSelector_Polarized12p
        PixelFormatInfoSelector_Polarized16
        PixelFormatInfoSelector_BayerRGPolarized8
        PixelFormatInfoSelector_BayerRGPolarized10p
        PixelFormatInfoSelector_BayerRGPolarized12p
        PixelFormatInfoSelector_BayerRGPolarized16
        PixelFormatInfoSelector_LLCMono8
        PixelFormatInfoSelector_LLCBayerRG8
        PixelFormatInfoSelector_JPEGMono8
        PixelFormatInfoSelector_JPEGColor8
        NUM_PIXELFORMATINFOSELECTOR

    cpdef enum DeinterlacingEnums:
        Deinterlacing_Off
        Deinterlacing_LineDuplication
        Deinterlacing_Weave
        NUM_DEINTERLACING

    cpdef enum ImageCompressionRateOptionEnums:
        ImageCompressionRateOption_FixBitrate
        ImageCompressionRateOption_FixQuality
        NUM_IMAGECOMPRESSIONRATEOPTION

    cpdef enum ImageCompressionJPEGFormatOptionEnums:
        ImageCompressionJPEGFormatOption_Lossless
        ImageCompressionJPEGFormatOption_BaselineStandard
        ImageCompressionJPEGFormatOption_BaselineOptimized
        ImageCompressionJPEGFormatOption_Progressive
        NUM_IMAGECOMPRESSIONJPEGFORMATOPTION

    cpdef enum AcquisitionStatusSelectorEnums:
        AcquisitionStatusSelector_AcquisitionTriggerWait
        AcquisitionStatusSelector_AcquisitionActive
        AcquisitionStatusSelector_AcquisitionTransfer
        AcquisitionStatusSelector_FrameTriggerWait
        AcquisitionStatusSelector_FrameActive
        AcquisitionStatusSelector_ExposureActive
        NUM_ACQUISITIONSTATUSSELECTOR

    cpdef enum ExposureTimeModeEnums:
        ExposureTimeMode_Common
        ExposureTimeMode_Individual
        NUM_EXPOSURETIMEMODE

    cpdef enum ExposureTimeSelectorEnums:
        ExposureTimeSelector_Common
        ExposureTimeSelector_Red
        ExposureTimeSelector_Green
        ExposureTimeSelector_Blue
        ExposureTimeSelector_Cyan
        ExposureTimeSelector_Magenta
        ExposureTimeSelector_Yellow
        ExposureTimeSelector_Infrared
        ExposureTimeSelector_Ultraviolet
        ExposureTimeSelector_Stage1
        ExposureTimeSelector_Stage2
        NUM_EXPOSURETIMESELECTOR

    cpdef enum GainAutoBalanceEnums:
        GainAutoBalance_Off
        GainAutoBalance_Once
        GainAutoBalance_Continuous
        NUM_GAINAUTOBALANCE

    cpdef enum BlackLevelAutoEnums:
        BlackLevelAuto_Off
        BlackLevelAuto_Once
        BlackLevelAuto_Continuous
        NUM_BLACKLEVELAUTO

    cpdef enum BlackLevelAutoBalanceEnums:
        BlackLevelAutoBalance_Off
        BlackLevelAutoBalance_Once
        BlackLevelAutoBalance_Continuous
        NUM_BLACKLEVELAUTOBALANCE

    cpdef enum WhiteClipSelectorEnums:
        WhiteClipSelector_All
        WhiteClipSelector_Red
        WhiteClipSelector_Green
        WhiteClipSelector_Blue
        WhiteClipSelector_Y
        WhiteClipSelector_U
        WhiteClipSelector_V
        WhiteClipSelector_Tap1
        WhiteClipSelector_Tap2
        NUM_WHITECLIPSELECTOR

    cpdef enum TimerSelectorEnums:
        TimerSelector_Timer0
        TimerSelector_Timer1
        TimerSelector_Timer2
        NUM_TIMERSELECTOR

    cpdef enum TimerStatusEnums:
        TimerStatus_TimerIdle
        TimerStatus_TimerTriggerWait
        TimerStatus_TimerActive
        TimerStatus_TimerCompleted
        NUM_TIMERSTATUS

    cpdef enum TimerTriggerSourceEnums:
        TimerTriggerSource_Off
        TimerTriggerSource_AcquisitionTrigger
        TimerTriggerSource_AcquisitionStart
        TimerTriggerSource_AcquisitionEnd
        TimerTriggerSource_FrameTrigger
        TimerTriggerSource_FrameStart
        TimerTriggerSource_FrameEnd
        TimerTriggerSource_FrameBurstStart
        TimerTriggerSource_FrameBurstEnd
        TimerTriggerSource_LineTrigger
        TimerTriggerSource_LineStart
        TimerTriggerSource_LineEnd
        TimerTriggerSource_ExposureStart
        TimerTriggerSource_ExposureEnd
        TimerTriggerSource_Line0
        TimerTriggerSource_Line1
        TimerTriggerSource_Line2
        TimerTriggerSource_UserOutput0
        TimerTriggerSource_UserOutput1
        TimerTriggerSource_UserOutput2
        TimerTriggerSource_Counter0Start
        TimerTriggerSource_Counter1Start
        TimerTriggerSource_Counter2Start
        TimerTriggerSource_Counter0End
        TimerTriggerSource_Counter1End
        TimerTriggerSource_Counter2End
        TimerTriggerSource_Timer0Start
        TimerTriggerSource_Timer1Start
        TimerTriggerSource_Timer2Start
        TimerTriggerSource_Timer0End
        TimerTriggerSource_Timer1End
        TimerTriggerSource_Timer2End
        TimerTriggerSource_Encoder0
        TimerTriggerSource_Encoder1
        TimerTriggerSource_Encoder2
        TimerTriggerSource_SoftwareSignal0
        TimerTriggerSource_SoftwareSignal1
        TimerTriggerSource_SoftwareSignal2
        TimerTriggerSource_Action0
        TimerTriggerSource_Action1
        TimerTriggerSource_Action2
        TimerTriggerSource_LinkTrigger0
        TimerTriggerSource_LinkTrigger1
        TimerTriggerSource_LinkTrigger2
        NUM_TIMERTRIGGERSOURCE

    cpdef enum TimerTriggerActivationEnums:
        TimerTriggerActivation_RisingEdge
        TimerTriggerActivation_FallingEdge
        TimerTriggerActivation_AnyEdge
        TimerTriggerActivation_LevelHigh
        TimerTriggerActivation_LevelLow
        NUM_TIMERTRIGGERACTIVATION

    cpdef enum EncoderSelectorEnums:
        EncoderSelector_Encoder0
        EncoderSelector_Encoder1
        EncoderSelector_Encoder2
        NUM_ENCODERSELECTOR

    cpdef enum EncoderSourceAEnums:
        EncoderSourceA_Off
        EncoderSourceA_Line0
        EncoderSourceA_Line1
        EncoderSourceA_Line2
        NUM_ENCODERSOURCEA

    cpdef enum EncoderSourceBEnums:
        EncoderSourceB_Off
        EncoderSourceB_Line0
        EncoderSourceB_Line1
        EncoderSourceB_Line2
        NUM_ENCODERSOURCEB

    cpdef enum EncoderModeEnums:
        EncoderMode_FourPhase
        EncoderMode_HighResolution
        NUM_ENCODERMODE

    cpdef enum EncoderOutputModeEnums:
        EncoderOutputMode_Off
        EncoderOutputMode_PositionUp
        EncoderOutputMode_PositionDown
        EncoderOutputMode_DirectionUp
        EncoderOutputMode_DirectionDown
        EncoderOutputMode_Motion
        NUM_ENCODEROUTPUTMODE

    cpdef enum EncoderStatusEnums:
        EncoderStatus_EncoderUp
        EncoderStatus_EncoderDown
        EncoderStatus_EncoderIdle
        EncoderStatus_EncoderStatic
        NUM_ENCODERSTATUS

    cpdef enum EncoderResetSourceEnums:
        EncoderResetSource_Off
        EncoderResetSource_AcquisitionTrigger
        EncoderResetSource_AcquisitionStart
        EncoderResetSource_AcquisitionEnd
        EncoderResetSource_FrameTrigger
        EncoderResetSource_FrameStart
        EncoderResetSource_FrameEnd
        EncoderResetSource_ExposureStart
        EncoderResetSource_ExposureEnd
        EncoderResetSource_Line0
        EncoderResetSource_Line1
        EncoderResetSource_Line2
        EncoderResetSource_Counter0Start
        EncoderResetSource_Counter1Start
        EncoderResetSource_Counter2Start
        EncoderResetSource_Counter0End
        EncoderResetSource_Counter1End
        EncoderResetSource_Counter2End
        EncoderResetSource_Timer0Start
        EncoderResetSource_Timer1Start
        EncoderResetSource_Timer2Start
        EncoderResetSource_Timer0End
        EncoderResetSource_Timer1End
        EncoderResetSource_Timer2End
        EncoderResetSource_UserOutput0
        EncoderResetSource_UserOutput1
        EncoderResetSource_UserOutput2
        EncoderResetSource_SoftwareSignal0
        EncoderResetSource_SoftwareSignal1
        EncoderResetSource_SoftwareSignal2
        EncoderResetSource_Action0
        EncoderResetSource_Action1
        EncoderResetSource_Action2
        EncoderResetSource_LinkTrigger0
        EncoderResetSource_LinkTrigger1
        EncoderResetSource_LinkTrigger2
        NUM_ENCODERRESETSOURCE

    cpdef enum EncoderResetActivationEnums:
        EncoderResetActivation_RisingEdge
        EncoderResetActivation_FallingEdge
        EncoderResetActivation_AnyEdge
        EncoderResetActivation_LevelHigh
        EncoderResetActivation_LevelLow
        NUM_ENCODERRESETACTIVATION

    cpdef enum SoftwareSignalSelectorEnums:
        SoftwareSignalSelector_SoftwareSignal0
        SoftwareSignalSelector_SoftwareSignal1
        SoftwareSignalSelector_SoftwareSignal2
        NUM_SOFTWARESIGNALSELECTOR

    cpdef enum ActionUnconditionalModeEnums:
        ActionUnconditionalMode_Off
        ActionUnconditionalMode_On
        NUM_ACTIONUNCONDITIONALMODE

    cpdef enum SourceSelectorEnums:
        SourceSelector_Source0
        SourceSelector_Source1
        SourceSelector_Source2
        SourceSelector_All
        NUM_SOURCESELECTOR

    cpdef enum TransferSelectorEnums:
        TransferSelector_Stream0
        TransferSelector_Stream1
        TransferSelector_Stream2
        TransferSelector_All
        NUM_TRANSFERSELECTOR

    cpdef enum TransferTriggerSelectorEnums:
        TransferTriggerSelector_TransferStart
        TransferTriggerSelector_TransferStop
        TransferTriggerSelector_TransferAbort
        TransferTriggerSelector_TransferPause
        TransferTriggerSelector_TransferResume
        TransferTriggerSelector_TransferActive
        TransferTriggerSelector_TransferBurstStart
        TransferTriggerSelector_TransferBurstStop
        NUM_TRANSFERTRIGGERSELECTOR

    cpdef enum TransferTriggerModeEnums:
        TransferTriggerMode_Off
        TransferTriggerMode_On
        NUM_TRANSFERTRIGGERMODE

    cpdef enum TransferTriggerSourceEnums:
        TransferTriggerSource_Line0
        TransferTriggerSource_Line1
        TransferTriggerSource_Line2
        TransferTriggerSource_Counter0Start
        TransferTriggerSource_Counter1Start
        TransferTriggerSource_Counter2Start
        TransferTriggerSource_Counter0End
        TransferTriggerSource_Counter1End
        TransferTriggerSource_Counter2End
        TransferTriggerSource_Timer0Start
        TransferTriggerSource_Timer1Start
        TransferTriggerSource_Timer2Start
        TransferTriggerSource_Timer0End
        TransferTriggerSource_Timer1End
        TransferTriggerSource_Timer2End
        TransferTriggerSource_SoftwareSignal0
        TransferTriggerSource_SoftwareSignal1
        TransferTriggerSource_SoftwareSignal2
        TransferTriggerSource_Action0
        TransferTriggerSource_Action1
        TransferTriggerSource_Action2
        NUM_TRANSFERTRIGGERSOURCE

    cpdef enum TransferTriggerActivationEnums:
        TransferTriggerActivation_RisingEdge
        TransferTriggerActivation_FallingEdge
        TransferTriggerActivation_AnyEdge
        TransferTriggerActivation_LevelHigh
        TransferTriggerActivation_LevelLow
        NUM_TRANSFERTRIGGERACTIVATION

    cpdef enum TransferStatusSelectorEnums:
        TransferStatusSelector_Streaming
        TransferStatusSelector_Paused
        TransferStatusSelector_Stopping
        TransferStatusSelector_Stopped
        TransferStatusSelector_QueueOverflow
        NUM_TRANSFERSTATUSSELECTOR

    cpdef enum TransferComponentSelectorEnums:
        TransferComponentSelector_Red
        TransferComponentSelector_Green
        TransferComponentSelector_Blue
        TransferComponentSelector_All
        NUM_TRANSFERCOMPONENTSELECTOR

    cpdef enum Scan3dDistanceUnitEnums:
        Scan3dDistanceUnit_Millimeter
        Scan3dDistanceUnit_Inch
        NUM_SCAN3DDISTANCEUNIT

    cpdef enum Scan3dCoordinateSystemEnums:
        Scan3dCoordinateSystem_Cartesian
        Scan3dCoordinateSystem_Spherical
        Scan3dCoordinateSystem_Cylindrical
        NUM_SCAN3DCOORDINATESYSTEM

    cpdef enum Scan3dOutputModeEnums:
        Scan3dOutputMode_UncalibratedC
        Scan3dOutputMode_CalibratedABC_Grid
        Scan3dOutputMode_CalibratedABC_PointCloud
        Scan3dOutputMode_CalibratedAC
        Scan3dOutputMode_CalibratedAC_Linescan
        Scan3dOutputMode_CalibratedC
        Scan3dOutputMode_CalibratedC_Linescan
        Scan3dOutputMode_RectifiedC
        Scan3dOutputMode_RectifiedC_Linescan
        Scan3dOutputMode_DisparityC
        Scan3dOutputMode_DisparityC_Linescan
        NUM_SCAN3DOUTPUTMODE

    cpdef enum Scan3dCoordinateSystemReferenceEnums:
        Scan3dCoordinateSystemReference_Anchor
        Scan3dCoordinateSystemReference_Transformed
        NUM_SCAN3DCOORDINATESYSTEMREFERENCE

    cpdef enum Scan3dCoordinateSelectorEnums:
        Scan3dCoordinateSelector_CoordinateA
        Scan3dCoordinateSelector_CoordinateB
        Scan3dCoordinateSelector_CoordinateC
        NUM_SCAN3DCOORDINATESELECTOR

    cpdef enum Scan3dCoordinateTransformSelectorEnums:
        Scan3dCoordinateTransformSelector_RotationX
        Scan3dCoordinateTransformSelector_RotationY
        Scan3dCoordinateTransformSelector_RotationZ
        Scan3dCoordinateTransformSelector_TranslationX
        Scan3dCoordinateTransformSelector_TranslationY
        Scan3dCoordinateTransformSelector_TranslationZ
        NUM_SCAN3DCOORDINATETRANSFORMSELECTOR

    cpdef enum Scan3dCoordinateReferenceSelectorEnums:
        Scan3dCoordinateReferenceSelector_RotationX
        Scan3dCoordinateReferenceSelector_RotationY
        Scan3dCoordinateReferenceSelector_RotationZ
        Scan3dCoordinateReferenceSelector_TranslationX
        Scan3dCoordinateReferenceSelector_TranslationY
        Scan3dCoordinateReferenceSelector_TranslationZ
        NUM_SCAN3DCOORDINATEREFERENCESELECTOR

    cpdef enum ChunkImageComponentEnums:
        ChunkImageComponent_Intensity
        ChunkImageComponent_Color
        ChunkImageComponent_Infrared
        ChunkImageComponent_Ultraviolet
        ChunkImageComponent_Range
        ChunkImageComponent_Disparity
        ChunkImageComponent_Confidence
        ChunkImageComponent_Scatter
        NUM_CHUNKIMAGECOMPONENT

    cpdef enum ChunkCounterSelectorEnums:
        ChunkCounterSelector_Counter0
        ChunkCounterSelector_Counter1
        ChunkCounterSelector_Counter2
        NUM_CHUNKCOUNTERSELECTOR

    cpdef enum ChunkTimerSelectorEnums:
        ChunkTimerSelector_Timer0
        ChunkTimerSelector_Timer1
        ChunkTimerSelector_Timer2
        NUM_CHUNKTIMERSELECTOR

    cpdef enum ChunkEncoderSelectorEnums:
        ChunkEncoderSelector_Encoder0
        ChunkEncoderSelector_Encoder1
        ChunkEncoderSelector_Encoder2
        NUM_CHUNKENCODERSELECTOR

    cpdef enum ChunkEncoderStatusEnums:
        ChunkEncoderStatus_EncoderUp
        ChunkEncoderStatus_EncoderDown
        ChunkEncoderStatus_EncoderIdle
        ChunkEncoderStatus_EncoderStatic
        NUM_CHUNKENCODERSTATUS

    cpdef enum ChunkExposureTimeSelectorEnums:
        ChunkExposureTimeSelector_Common
        ChunkExposureTimeSelector_Red
        ChunkExposureTimeSelector_Green
        ChunkExposureTimeSelector_Blue
        ChunkExposureTimeSelector_Cyan
        ChunkExposureTimeSelector_Magenta
        ChunkExposureTimeSelector_Yellow
        ChunkExposureTimeSelector_Infrared
        ChunkExposureTimeSelector_Ultraviolet
        ChunkExposureTimeSelector_Stage1
        ChunkExposureTimeSelector_Stage2
        NUM_CHUNKEXPOSURETIMESELECTOR

    cpdef enum ChunkSourceIDEnums:
        ChunkSourceID_Source0
        ChunkSourceID_Source1
        ChunkSourceID_Source2
        NUM_CHUNKSOURCEID

    cpdef enum ChunkRegionIDEnums:
        ChunkRegionID_Region0
        ChunkRegionID_Region1
        ChunkRegionID_Region2
        NUM_CHUNKREGIONID

    cpdef enum ChunkTransferStreamIDEnums:
        ChunkTransferStreamID_Stream0
        ChunkTransferStreamID_Stream1
        ChunkTransferStreamID_Stream2
        ChunkTransferStreamID_Stream3
        NUM_CHUNKTRANSFERSTREAMID

    cpdef enum ChunkScan3dDistanceUnitEnums:
        ChunkScan3dDistanceUnit_Millimeter
        ChunkScan3dDistanceUnit_Inch
        NUM_CHUNKSCAN3DDISTANCEUNIT

    cpdef enum ChunkScan3dOutputModeEnums:
        ChunkScan3dOutputMode_UncalibratedC
        ChunkScan3dOutputMode_CalibratedABC_Grid
        ChunkScan3dOutputMode_CalibratedABC_PointCloud
        ChunkScan3dOutputMode_CalibratedAC
        ChunkScan3dOutputMode_CalibratedAC_Linescan
        ChunkScan3dOutputMode_CalibratedC
        ChunkScan3dOutputMode_CalibratedC_Linescan
        ChunkScan3dOutputMode_RectifiedC
        ChunkScan3dOutputMode_RectifiedC_Linescan
        ChunkScan3dOutputMode_DisparityC
        ChunkScan3dOutputMode_DisparityC_Linescan
        NUM_CHUNKSCAN3DOUTPUTMODE

    cpdef enum ChunkScan3dCoordinateSystemEnums:
        ChunkScan3dCoordinateSystem_Cartesian
        ChunkScan3dCoordinateSystem_Spherical
        ChunkScan3dCoordinateSystem_Cylindrical
        NUM_CHUNKSCAN3DCOORDINATESYSTEM

    cpdef enum ChunkScan3dCoordinateSystemReferenceEnums:
        ChunkScan3dCoordinateSystemReference_Anchor
        ChunkScan3dCoordinateSystemReference_Transformed
        NUM_CHUNKSCAN3DCOORDINATESYSTEMREFERENCE

    cpdef enum ChunkScan3dCoordinateSelectorEnums:
        ChunkScan3dCoordinateSelector_CoordinateA
        ChunkScan3dCoordinateSelector_CoordinateB
        ChunkScan3dCoordinateSelector_CoordinateC
        NUM_CHUNKSCAN3DCOORDINATESELECTOR

    cpdef enum ChunkScan3dCoordinateTransformSelectorEnums:
        ChunkScan3dCoordinateTransformSelector_RotationX
        ChunkScan3dCoordinateTransformSelector_RotationY
        ChunkScan3dCoordinateTransformSelector_RotationZ
        ChunkScan3dCoordinateTransformSelector_TranslationX
        ChunkScan3dCoordinateTransformSelector_TranslationY
        ChunkScan3dCoordinateTransformSelector_TranslationZ
        NUM_CHUNKSCAN3DCOORDINATETRANSFORMSELECTOR

    cpdef enum ChunkScan3dCoordinateReferenceSelectorEnums:
        ChunkScan3dCoordinateReferenceSelector_RotationX
        ChunkScan3dCoordinateReferenceSelector_RotationY
        ChunkScan3dCoordinateReferenceSelector_RotationZ
        ChunkScan3dCoordinateReferenceSelector_TranslationX
        ChunkScan3dCoordinateReferenceSelector_TranslationY
        ChunkScan3dCoordinateReferenceSelector_TranslationZ
        NUM_CHUNKSCAN3DCOORDINATEREFERENCESELECTOR

    cpdef enum DeviceTapGeometryEnums:
        DeviceTapGeometry_Geometry_1X_1Y
        DeviceTapGeometry_Geometry_1X2_1Y
        DeviceTapGeometry_Geometry_1X2_1Y2
        DeviceTapGeometry_Geometry_2X_1Y
        DeviceTapGeometry_Geometry_2X_1Y2Geometry_2XE_1Y
        DeviceTapGeometry_Geometry_2XE_1Y2
        DeviceTapGeometry_Geometry_2XM_1Y
        DeviceTapGeometry_Geometry_2XM_1Y2
        DeviceTapGeometry_Geometry_1X_1Y2
        DeviceTapGeometry_Geometry_1X_2YE
        DeviceTapGeometry_Geometry_1X3_1Y
        DeviceTapGeometry_Geometry_3X_1Y
        DeviceTapGeometry_Geometry_1X
        DeviceTapGeometry_Geometry_1X2
        DeviceTapGeometry_Geometry_2X
        DeviceTapGeometry_Geometry_2XE
        DeviceTapGeometry_Geometry_2XM
        DeviceTapGeometry_Geometry_1X3
        DeviceTapGeometry_Geometry_3X
        DeviceTapGeometry_Geometry_1X4_1Y
        DeviceTapGeometry_Geometry_4X_1Y
        DeviceTapGeometry_Geometry_2X2_1Y
        DeviceTapGeometry_Geometry_2X2E_1YGeometry_2X2M_1Y
        DeviceTapGeometry_Geometry_1X2_2YE
        DeviceTapGeometry_Geometry_2X_2YE
        DeviceTapGeometry_Geometry_2XE_2YE
        DeviceTapGeometry_Geometry_2XM_2YE
        DeviceTapGeometry_Geometry_1X4
        DeviceTapGeometry_Geometry_4X
        DeviceTapGeometry_Geometry_2X2
        DeviceTapGeometry_Geometry_2X2E
        DeviceTapGeometry_Geometry_2X2M
        DeviceTapGeometry_Geometry_1X8_1Y
        DeviceTapGeometry_Geometry_8X_1Y
        DeviceTapGeometry_Geometry_4X2_1Y
        DeviceTapGeometry_Geometry_2X2E_2YE
        DeviceTapGeometry_Geometry_1X8
        DeviceTapGeometry_Geometry_8X
        DeviceTapGeometry_Geometry_4X2
        DeviceTapGeometry_Geometry_4X2E
        DeviceTapGeometry_Geometry_4X2E_1Y
        DeviceTapGeometry_Geometry_1X10_1Y
        DeviceTapGeometry_Geometry_10X_1Y
        DeviceTapGeometry_Geometry_1X10
        DeviceTapGeometry_Geometry_10X
        NUM_DEVICETAPGEOMETRY

    cpdef enum GevPhysicalLinkConfigurationEnums:
        GevPhysicalLinkConfiguration_SingleLink
        GevPhysicalLinkConfiguration_MultiLink
        GevPhysicalLinkConfiguration_StaticLAG
        GevPhysicalLinkConfiguration_DynamicLAG
        NUM_GEVPHYSICALLINKCONFIGURATION

    cpdef enum GevCurrentPhysicalLinkConfigurationEnums:
        GevCurrentPhysicalLinkConfiguration_SingleLink
        GevCurrentPhysicalLinkConfiguration_MultiLink
        GevCurrentPhysicalLinkConfiguration_StaticLAG
        GevCurrentPhysicalLinkConfiguration_DynamicLAG
        NUM_GEVCURRENTPHYSICALLINKCONFIGURATION

    cpdef enum GevIPConfigurationStatusEnums:
        GevIPConfigurationStatus_None
        GevIPConfigurationStatus_PersistentIP
        GevIPConfigurationStatus_DHCP
        GevIPConfigurationStatus_LLA
        GevIPConfigurationStatus_ForceIP
        NUM_GEVIPCONFIGURATIONSTATUS

    cpdef enum GevGVCPExtendedStatusCodesSelectorEnums:
        GevGVCPExtendedStatusCodesSelector_Version1_1
        GevGVCPExtendedStatusCodesSelector_Version2_0
        NUM_GEVGVCPEXTENDEDSTATUSCODESSELECTOR

    cpdef enum GevGVSPExtendedIDModeEnums:
        GevGVSPExtendedIDMode_Off
        GevGVSPExtendedIDMode_On
        NUM_GEVGVSPEXTENDEDIDMODE

    cpdef enum ClConfigurationEnums:
        ClConfiguration_Base
        ClConfiguration_Medium
        ClConfiguration_Full
        ClConfiguration_DualBase
        ClConfiguration_EightyBit
        NUM_CLCONFIGURATION

    cpdef enum ClTimeSlotsCountEnums:
        ClTimeSlotsCount_One
        ClTimeSlotsCount_Two
        ClTimeSlotsCount_Three
        NUM_CLTIMESLOTSCOUNT

    cpdef enum CxpLinkConfigurationStatusEnums:
        CxpLinkConfigurationStatus_None
        CxpLinkConfigurationStatus_Pending
        CxpLinkConfigurationStatus_CXP1_X1
        CxpLinkConfigurationStatus_CXP2_X1
        CxpLinkConfigurationStatus_CXP3_X1
        CxpLinkConfigurationStatus_CXP5_X1
        CxpLinkConfigurationStatus_CXP6_X1
        CxpLinkConfigurationStatus_CXP1_X2
        CxpLinkConfigurationStatus_CXP2_X2
        CxpLinkConfigurationStatus_CXP3_X2
        CxpLinkConfigurationStatus_CXP5_X2
        CxpLinkConfigurationStatus_CXP6_X2
        CxpLinkConfigurationStatus_CXP1_X3
        CxpLinkConfigurationStatus_CXP2_X3
        CxpLinkConfigurationStatus_CXP3_X3
        CxpLinkConfigurationStatus_CXP5_X3
        CxpLinkConfigurationStatus_CXP6_X3
        CxpLinkConfigurationStatus_CXP1_X4
        CxpLinkConfigurationStatus_CXP2_X4
        CxpLinkConfigurationStatus_CXP3_X4
        CxpLinkConfigurationStatus_CXP5_X4
        CxpLinkConfigurationStatus_CXP6_X4
        CxpLinkConfigurationStatus_CXP1_X5
        CxpLinkConfigurationStatus_CXP2_X5
        CxpLinkConfigurationStatus_CXP3_X5
        CxpLinkConfigurationStatus_CXP5_X5
        CxpLinkConfigurationStatus_CXP6_X5
        CxpLinkConfigurationStatus_CXP1_X6
        CxpLinkConfigurationStatus_CXP2_X6
        CxpLinkConfigurationStatus_CXP3_X6
        CxpLinkConfigurationStatus_CXP5_X6
        CxpLinkConfigurationStatus_CXP6_X6
        NUM_CXPLINKCONFIGURATIONSTATUS

    cpdef enum CxpLinkConfigurationPreferredEnums:
        CxpLinkConfigurationPreferred_CXP1_X1
        CxpLinkConfigurationPreferred_CXP2_X1
        CxpLinkConfigurationPreferred_CXP3_X1
        CxpLinkConfigurationPreferred_CXP5_X1
        CxpLinkConfigurationPreferred_CXP6_X1
        CxpLinkConfigurationPreferred_CXP1_X2
        CxpLinkConfigurationPreferred_CXP2_X2
        CxpLinkConfigurationPreferred_CXP3_X2
        CxpLinkConfigurationPreferred_CXP5_X2
        CxpLinkConfigurationPreferred_CXP6_X2
        CxpLinkConfigurationPreferred_CXP1_X3
        CxpLinkConfigurationPreferred_CXP2_X3
        CxpLinkConfigurationPreferred_CXP3_X3
        CxpLinkConfigurationPreferred_CXP5_X3
        CxpLinkConfigurationPreferred_CXP6_X3
        CxpLinkConfigurationPreferred_CXP1_X4
        CxpLinkConfigurationPreferred_CXP2_X4
        CxpLinkConfigurationPreferred_CXP3_X4
        CxpLinkConfigurationPreferred_CXP5_X4
        CxpLinkConfigurationPreferred_CXP6_X4
        CxpLinkConfigurationPreferred_CXP1_X5
        CxpLinkConfigurationPreferred_CXP2_X5
        CxpLinkConfigurationPreferred_CXP3_X5
        CxpLinkConfigurationPreferred_CXP5_X5
        CxpLinkConfigurationPreferred_CXP6_X5
        CxpLinkConfigurationPreferred_CXP1_X6
        CxpLinkConfigurationPreferred_CXP2_X6
        CxpLinkConfigurationPreferred_CXP3_X6
        CxpLinkConfigurationPreferred_CXP5_X6
        CxpLinkConfigurationPreferred_CXP6_X6
        NUM_CXPLINKCONFIGURATIONPREFERRED

    cpdef enum CxpLinkConfigurationEnums:
        CxpLinkConfiguration_Auto
        CxpLinkConfiguration_CXP1_X1
        CxpLinkConfiguration_CXP2_X1
        CxpLinkConfiguration_CXP3_X1
        CxpLinkConfiguration_CXP5_X1
        CxpLinkConfiguration_CXP6_X1
        CxpLinkConfiguration_CXP1_X2
        CxpLinkConfiguration_CXP2_X2
        CxpLinkConfiguration_CXP3_X2
        CxpLinkConfiguration_CXP5_X2
        CxpLinkConfiguration_CXP6_X2
        CxpLinkConfiguration_CXP1_X3
        CxpLinkConfiguration_CXP2_X3
        CxpLinkConfiguration_CXP3_X3
        CxpLinkConfiguration_CXP5_X3
        CxpLinkConfiguration_CXP6_X3
        CxpLinkConfiguration_CXP1_X4
        CxpLinkConfiguration_CXP2_X4
        CxpLinkConfiguration_CXP3_X4
        CxpLinkConfiguration_CXP5_X4
        CxpLinkConfiguration_CXP6_X4
        CxpLinkConfiguration_CXP1_X5
        CxpLinkConfiguration_CXP2_X5
        CxpLinkConfiguration_CXP3_X5
        CxpLinkConfiguration_CXP5_X5
        CxpLinkConfiguration_CXP6_X5
        CxpLinkConfiguration_CXP1_X6
        CxpLinkConfiguration_CXP2_X6
        CxpLinkConfiguration_CXP3_X6
        CxpLinkConfiguration_CXP5_X6
        CxpLinkConfiguration_CXP6_X6
        NUM_CXPLINKCONFIGURATION

    cpdef enum CxpConnectionTestModeEnums:
        CxpConnectionTestMode_Off
        CxpConnectionTestMode_Mode1
        NUM_CXPCONNECTIONTESTMODE

    cpdef enum CxpPoCxpStatusEnums:
        CxpPoCxpStatus_Auto
        CxpPoCxpStatus_Off
        CxpPoCxpStatus_Tripped
        NUM_CXPPOCXPSTATUS