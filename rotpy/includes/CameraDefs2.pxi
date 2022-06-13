cdef extern from "CameraDefs.h" namespace "Spinnaker" nogil:

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
