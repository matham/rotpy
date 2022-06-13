cdef extern from "CameraDefs.h" namespace "Spinnaker" nogil:

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
