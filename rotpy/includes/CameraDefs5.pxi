cdef extern from "CameraDefs.h" namespace "Spinnaker" nogil:

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
