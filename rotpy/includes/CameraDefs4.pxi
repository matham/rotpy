cdef extern from "CameraDefs.h" namespace "Spinnaker" nogil:

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
