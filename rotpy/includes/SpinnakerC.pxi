cdef extern from "SpinnakerC.h" nogil:

    spinError spinErrorGetLast(spinError* pError)

    spinError spinErrorGetLastMessage(char* pBuf, size_t* pBufLen)

    spinError spinErrorGetLastBuildDate(char* pBuf, size_t* pBufLen)

    spinError spinErrorGetLastBuildTime(char* pBuf, size_t* pBufLen)

    spinError spinErrorGetLastFileName(char* pBuf, size_t* pBufLen)

    spinError spinErrorGetLastFullMessage(char* pBuf, size_t* pBufLen)

    spinError spinErrorGetLastFunctionName(char* pBuf, size_t* pBufLen)

    spinError spinErrorGetLastLineNumber(int64_t* pLineNum)

    spinError spinSystemGetInstance(spinSystem* phSystem)

    spinError spinSystemReleaseInstance(spinSystem hSystem)

    spinError spinSystemGetInterfaces(spinSystem hSystem, spinInterfaceList hInterfaceList)

    spinError spinSystemGetCameras(spinSystem hSystem, spinCameraList hCameraList)

    spinError spinSystemGetCamerasEx(spinSystem hSystem, bool8_t bUpdateInterfaces, bool8_t bUpdateCameras, spinCameraList hCameraList)

    spinError spinSystemSetLoggingLevel(spinSystem hSystem, spinnakerLogLevel logLevel)

    spinError spinSystemGetLoggingLevel(spinSystem hSystem, spinnakerLogLevel* pLogLevel)

    spinError spinSystemRegisterLogEventHandler(spinSystem hSystem, spinLogEventHandler hLogEventHandler)

    spinError spinSystemUnregisterLogEventHandler(spinSystem hSystem, spinLogEventHandler hLogEventHandler)

    spinError spinSystemUnregisterAllLogEventHandlers(spinSystem hSystem)

    spinError spinSystemIsInUse(spinSystem hSystem, bool8_t* pbIsInUse)

    spinError spinSystemRegisterDeviceArrivalEventHandler(spinSystem hSystem, spinDeviceArrivalEventHandler hDeviceArrivalEventHandler)

    spinError spinSystemRegisterDeviceRemovalEventHandler(spinSystem hSystem, spinDeviceRemovalEventHandler hDeviceRemovalEventHandler)

    spinError spinSystemUnregisterDeviceArrivalEventHandler(spinSystem hSystem, spinDeviceArrivalEventHandler hDeviceArrivalEventHandler)

    spinError spinSystemUnregisterDeviceRemovalEventHandler(spinSystem hSystem, spinDeviceRemovalEventHandler hDeviceRemovalEventHandler)

    spinError spinSystemRegisterInterfaceEventHandler(spinSystem hSystem, spinInterfaceEventHandler hInterfaceEventHandler)

    spinError spinSystemUnregisterInterfaceEventHandler(spinSystem hSystem, spinInterfaceEventHandler hInterfaceEventHandler)

    spinError spinSystemUpdateCameras(spinSystem hSystem, bool8_t* pbChanged)

    spinError spinSystemUpdateCamerasEx(spinSystem hSystem, bool8_t bUpdateInterfaces, bool8_t* pbChanged)

    spinError spinSystemSendActionCommand(spinSystem hSystem, size_t iDeviceKey, size_t iGroupKey, size_t iGroupMask, size_t iActionTime, size_t* piResultSize, actionCommandResult results)

    spinError spinSystemGetLibraryVersion(spinSystem hSystem, spinLibraryVersion* hLibraryVersion)

    spinError spinSystemGetTLNodeMap(spinSystem hSystem, spinNodeMapHandle* phNodeMap)

    spinError spinInterfaceListCreateEmpty(spinInterfaceList* phInterfaceList)

    spinError spinInterfaceListDestroy(spinInterfaceList hInterfaceList)

    spinError spinInterfaceListGetSize(spinInterfaceList hInterfaceList, size_t* pSize)

    spinError spinInterfaceListGet(spinInterfaceList hInterfaceList, size_t index, spinInterface* phInterface)

    spinError spinInterfaceListClear(spinInterfaceList hInterfaceList)

    spinError spinCameraListCreateEmpty(spinCameraList* phCameraList)

    spinError spinCameraListDestroy(spinCameraList hCameraList)

    spinError spinCameraListGetSize(spinCameraList hCameraList, size_t* pSize)

    spinError spinCameraListGet(spinCameraList hCameraList, size_t index, spinCamera* phCamera)

    spinError spinCameraListClear(spinCameraList hCameraList)

    spinError spinCameraListRemove(spinCameraList hCameraList, size_t index)

    spinError spinCameraListAppend(spinCameraList hCameraListBase, spinCameraList hCameraListToAppend)

    spinError spinCameraListGetBySerial(spinCameraList hCameraList, const char* pSerial, spinCamera* phCamera)

    spinError spinCameraListRemoveBySerial(spinCameraList hCameraList, const char* pSerial)

    spinError spinInterfaceUpdateCameras(spinInterface hInterface, bool8_t* pbChanged)

    spinError spinInterfaceGetCameras(spinInterface hInterface, spinCameraList hCameraList)

    spinError spinInterfaceGetCamerasEx(spinInterface hInterface, bool8_t bUpdateCameras, spinCameraList hCameraList)

    spinError spinInterfaceGetTLNodeMap(spinInterface hInterface, spinNodeMapHandle* phNodeMap)

    spinError spinInterfaceRegisterDeviceArrivalEventHandler(spinInterface hInterface, spinDeviceArrivalEventHandler hDeviceArrivalEventHandler)

    spinError spinInterfaceRegisterDeviceRemovalEventHandler(spinInterface hInterface, spinDeviceRemovalEventHandler hDeviceRemovalEventHandler)

    spinError spinInterfaceUnregisterDeviceArrivalEventHandler(spinInterface hInterface, spinDeviceArrivalEventHandler hDeviceArrivalEventHandler)

    spinError spinInterfaceUnregisterDeviceRemovalEventHandler(spinInterface hInterface, spinDeviceRemovalEventHandler hDeviceRemovalEventHandler)

    spinError spinInterfaceRegisterInterfaceEventHandler(spinInterface hInterface, spinInterfaceEventHandler hInterfaceEventHandler)

    spinError spinInterfaceUnregisterInterfaceEventHandler(spinInterface hInterface, spinInterfaceEventHandler hInterfaceEventHandler)

    spinError spinInterfaceRelease(spinInterface hInterface)

    spinError spinInterfaceIsInUse(spinInterface hInterface, bool8_t* pbIsInUse)

    spinError spinInterfaceSendActionCommand(spinInterface hInterface, size_t iDeviceKey, size_t iGroupKey, size_t iGroupMask, size_t iActionTime, size_t* piResultSize, actionCommandResult results)

    spinError spinCameraInit(spinCamera hCamera)

    spinError spinCameraDeInit(spinCamera hCamera)

    spinError spinCameraGetNodeMap(spinCamera hCamera, spinNodeMapHandle* phNodeMap)

    spinError spinCameraGetTLDeviceNodeMap(spinCamera hCamera, spinNodeMapHandle* phNodeMap)

    spinError spinCameraGetTLStreamNodeMap(spinCamera hCamera, spinNodeMapHandle* phNodeMap)

    spinError spinCameraGetAccessMode(spinCamera hCamera, spinAccessMode* pAccessMode)

    spinError spinCameraReadPort(spinCamera hCamera, uint64_t iAddress, void* pBuffer, size_t iSize)

    spinError spinCameraWritePort(spinCamera hCamera, uint64_t iAddress, void* pBuffer, size_t iSize)

    spinError spinCameraBeginAcquisition(spinCamera hCamera)

    spinError spinCameraEndAcquisition(spinCamera hCamera)

    spinError spinCameraGetNextImage(spinCamera hCamera, spinImage* phImage)

    spinError spinCameraGetNextImageEx(spinCamera hCamera, uint64_t grabTimeout, spinImage* phImage)

    spinError spinCameraGetUniqueID(spinCamera hCamera, char* pBuf, size_t* pBufLen)

    spinError spinCameraIsStreaming(spinCamera hCamera, bool8_t* pbIsStreaming)

    spinError spinCameraGetGuiXml(spinCamera hCamera, char* pBuf, size_t* pBufLen)

    spinError spinCameraRegisterDeviceEventHandler(spinCamera hCamera, spinDeviceEventHandler hDeviceEventHandler)

    spinError spinCameraRegisterDeviceEventHandlerEx(spinCamera hCamera, spinDeviceEventHandler hDeviceEventHandler, const char* pName)

    spinError spinCameraUnregisterDeviceEventHandler(spinCamera hCamera, spinDeviceEventHandler hDeviceEventHandler)

    spinError spinCameraRegisterImageEventHandler(spinCamera hCamera, spinImageEventHandler hImageEventHandler)

    spinError spinCameraUnregisterImageEventHandler(spinCamera hCamera, spinImageEventHandler hImageEventHandler)

    spinError spinCameraRelease(spinCamera hCamera)

    spinError spinCameraIsValid(spinCamera hCamera, bool8_t* pbValid)

    spinError spinCameraIsInitialized(spinCamera hCamera, bool8_t* pbInit)

    spinError spinCameraDiscoverMaxPacketSize(spinCamera hCamera, unsigned int* pMaxPacketSize)

    spinError spinCameraForceIP()

    spinError spinImageCreateEmpty(spinImage * phImage)

    spinError spinImageCreate(spinImage hSrcImage, spinImage* phDestImage)

    spinError spinImageCreateEx(spinImage* phImage, size_t width, size_t height, size_t offsetX, size_t offsetY, spinPixelFormatEnums pixelFormat, void* pData)

    spinError spinImageCreateEx2(spinImage* phImage, size_t width, size_t height, size_t offsetX, size_t offsetY, spinPixelFormatEnums pixelFormat, void* pData, spinPayloadTypeInfoIDs dataPayloadType, size_t dataSize)

    spinError spinImageDestroy(spinImage hImage)

    spinError spinImageSetDefaultColorProcessing(spinColorProcessingAlgorithm algorithm)

    spinError spinImageGetDefaultColorProcessing(spinColorProcessingAlgorithm* pAlgorithm)

    spinError spinImageGetColorProcessing(spinImage hImage, spinColorProcessingAlgorithm* pAlgorithm)

    spinError spinImageSetNumDecompressionThreads(unsigned int numThreads)

    spinError spinImageGetNumDecompressionThreads(unsigned int* pNumThreads)

    spinError spinImageConvert(spinImage hSrcImage, spinPixelFormatEnums pixelFormat, spinImage hDestImage)

    spinError spinImageConvertEx(spinImage hSrcImage, spinPixelFormatEnums pixelFormat, spinColorProcessingAlgorithm algorithm, spinImage hDestImage)

    spinError spinImageReset(spinImage hImage, size_t width, size_t height, size_t offsetX, size_t offsetY, spinPixelFormatEnums pixelFormat)

    spinError spinImageResetEx(spinImage hImage, size_t width, size_t height, size_t offsetX, size_t offsetY, spinPixelFormatEnums pixelFormat, void* pData)

    spinError spinImageGetID(spinImage hImage, uint64_t* pId)

    spinError spinImageGetData(spinImage hImage, void** ppData)

    spinError spinImageGetPrivateData(spinImage hImage, void** ppData)

    spinError spinImageGetBufferSize(spinImage hImage, size_t* pSize)

    spinError spinImageDeepCopy(spinImage hSrcImage, spinImage hDestImage)

    spinError spinImageGetWidth(spinImage hImage, size_t* pWidth)

    spinError spinImageGetHeight(spinImage hImage, size_t* pHeight)

    spinError spinImageGetOffsetX(spinImage hImage, size_t* pOffsetX)

    spinError spinImageGetOffsetY(spinImage hImage, size_t* pOffsetY)

    spinError spinImageGetPaddingX(spinImage hImage, size_t* pPaddingX)

    spinError spinImageGetPaddingY(spinImage hImage, size_t* pPaddingY)

    spinError spinImageGetFrameID(spinImage hImage, uint64_t* pFrameID)

    spinError spinImageGetTimeStamp(spinImage hImage, uint64_t* pTimeStamp)

    spinError spinImageGetPayloadType(spinImage hImage, size_t* pPayloadType)

    spinError spinImageGetTLPayloadType(spinImage hImage, spinPayloadTypeInfoIDs* pPayloadType)

    spinError spinImageGetPixelFormat(spinImage hImage, spinPixelFormatEnums* pPixelFormat)

    spinError spinImageGetTLPixelFormat(spinImage hImage, uint64_t* pPixelFormat)

    spinError spinImageGetTLPixelFormatNamespace(spinImage hImage, spinPixelFormatNamespaceID* pPixelFormatNamespace)

    spinError spinImageGetPixelFormatName(spinImage hImage, char* pBuf, size_t* pBufLen)

    spinError spinImageIsIncomplete(spinImage hImage, bool8_t* pbIsIncomplete)

    spinError spinImageGetValidPayloadSize(spinImage hImage, size_t* pSize)

    spinError spinImageSave(spinImage hImage, const char* pFilename, spinImageFileFormat format)

    spinError spinImageSaveFromExt(spinImage hImage, const char* pFilename)

    spinError spinImageSavePng(spinImage hImage, const char* pFilename, const spinPNGOption* pOption)

    spinError spinImageSavePpm(spinImage hImage, const char* pFilename, const spinPPMOption* pOption)

    spinError spinImageSavePgm(spinImage hImage, const char* pFilename, const spinPGMOption* pOption)

    spinError spinImageSaveTiff(spinImage hImage, const char* pFilename, const spinTIFFOption* pOption)

    spinError spinImageSaveJpeg(spinImage hImage, const char* pFilename, const spinJPEGOption* pOption)

    spinError spinImageSaveJpg2(spinImage hImage, const char* pFilename, const spinJPG2Option* pOption)

    spinError spinImageSaveBmp(spinImage hImage, const char* pFilename, const spinBMPOption* pOption)

    spinError spinImageGetChunkLayoutID(spinImage hImage, uint64_t* pId)

    spinError spinImageCalculateStatistics(spinImage hImage, const spinImageStatistics hStatistics)

    spinError spinImageGetStatus(spinImage hImage, spinImageStatus* pStatus)

    spinError spinImageGetStatusDescription(spinImageStatus status, char* pBuf, size_t* pBufLen)

    spinError spinImageRelease(spinImage hImage)

    spinError spinImageHasCRC(spinImage hImage, bool8_t* pbHasCRC)

    spinError spinImageCheckCRC(spinImage hImage, bool8_t* pbCheckCRC)

    spinError spinImageGetBitsPerPixel(spinImage hImage, size_t* pBitsPerPixel)

    spinError spinImageGetSize(spinImage hImage, size_t* pImageSize)

    spinError spinImageGetStride(spinImage hImage, size_t* pStride)

    spinError spinDeviceEventHandlerCreate(spinDeviceEventHandler* phDeviceEventHandler, spinDeviceEventFunction pFunction, void* pUserData)

    spinError spinDeviceEventHandlerDestroy(spinDeviceEventHandler hDeviceEventHandler)

    spinError spinImageEventHandlerCreate(spinImageEventHandler* phImageEventHandler, spinImageEventFunction pFunction, void* pUserData)

    spinError spinImageEventHandlerDestroy(spinImageEventHandler hImageEventHandler)

    spinError spinDeviceArrivalEventHandlerCreate(spinDeviceArrivalEventHandler* phDeviceArrivalEventHandler, spinArrivalEventFunction pFunction, void* pUserData)

    spinError spinDeviceArrivalEventHandlerDestroy(spinDeviceArrivalEventHandler hDeviceArrivalEventHandler)

    spinError spinDeviceRemovalEventHandlerCreate(spinDeviceRemovalEventHandler* phDeviceRemovalEventHandler, spinRemovalEventFunction pFunction, void* pUserData)

    spinError spinDeviceRemovalEventHandlerDestroy(spinDeviceRemovalEventHandler hDeviceRemovalEventHandler)

    spinError spinInterfaceEventHandlerCreate(spinInterfaceEventHandler* phInterfaceEventHandler, spinArrivalEventFunction pArrivalFunction, spinRemovalEventFunction pRemovalFunction, void* pUserData)

    spinError spinInterfaceEventHandlerDestroy(spinInterfaceEventHandler hInterfaceEventHandler)

    spinError spinLogEventHandlerCreate(spinLogEventHandler* phLogEventHandler, spinLogEventFunction pFunction, void* pUserData)

    spinError spinLogEventHandlerDestroy(spinLogEventHandler hLogEventHandler)

    spinError spinImageStatisticsCreate(spinImageStatistics* phStatistics)

    spinError spinImageStatisticsDestroy(spinImageStatistics hStatistics)

    spinError spinImageStatisticsEnableAll(spinImageStatistics hStatistics)

    spinError spinImageStatisticsDisableAll(spinImageStatistics hStatistics)

    spinError spinImageStatisticsEnableGreyOnly(spinImageStatistics hStatistics)

    spinError spinImageStatisticsEnableRgbOnly(spinImageStatistics hStatistics)

    spinError spinImageStatisticsEnableHslOnly(spinImageStatistics hStatistics)

    spinError spinImageStatisticsGetChannelStatus(spinImageStatistics hStatistics, spinStatisticsChannel channel, bool8_t* pbEnabled)

    spinError spinImageStatisticsSetChannelStatus(spinImageStatistics hStatistics, spinStatisticsChannel channel, bool8_t bEnable)

    spinError spinImageStatisticsGetRange(spinImageStatistics hStatistics, spinStatisticsChannel channel, unsigned int* pMin, unsigned int* pMax)

    spinError spinImageStatisticsGetPixelValueRange(spinImageStatistics hStatistics, spinStatisticsChannel channel, unsigned int* pMin, unsigned int* pMax)

    spinError spinImageStatisticsGetNumPixelValues(spinImageStatistics hStatistics, spinStatisticsChannel channel, unsigned int* pNumValues)

    spinError spinImageStatisticsGetMean(spinImageStatistics hStatistics, spinStatisticsChannel channel, float* pMean)

    spinError spinImageStatisticsGetHistogram(spinImageStatistics hStatistics, spinStatisticsChannel channel, int** ppHistogram)

    spinError spinImageStatisticsGetAll(spinImageStatistics hStatistics, spinStatisticsChannel channel, unsigned int* pRangeMin, unsigned int* pRangeMax, unsigned int* pPixelValueMin, unsigned int* pPixelValueMax, unsigned int* pNumPixelValues, float* pPixelValueMean, int** ppHistogram)

    spinError spinLogDataGetCategoryName(spinLogEventData hLogEventData, char* pBuf, size_t* pBufLen)

    spinError spinLogDataGetPriority(spinLogEventData hLogEventData, int64_t* pValue)

    spinError spinLogDataGetPriorityName(spinLogEventData hLogEventData, char* pBuf, size_t* pBufLen)

    spinError spinLogDataGetTimestamp(spinLogEventData hLogEventData, char* pBuf, size_t* pBufLen)

    spinError spinLogDataGetNDC(spinLogEventData hLogEventData, char* pBuf, size_t* pBufLen)

    spinError spinLogDataGetThreadName(spinLogEventData hLogEventData, char* pBuf, size_t* pBufLen)

    spinError spinLogDataGetLogMessage(spinLogEventData hLogEventData, char* pBuf, size_t* pBufLen)

    spinError spinDeviceEventGetId(spinDeviceEventData hDeviceEventData, uint64_t* pEventId)

    spinError spinDeviceEventGetPayloadData(spinDeviceEventData hDeviceEventData, const uint8_t* pBuf, size_t* pBufSize)

    spinError spinDeviceEventGetPayloadDataSize(spinDeviceEventData hDeviceEventData, size_t* pBufSize)

    spinError spinDeviceEventGetName(spinDeviceEventData hDeviceEventData, char* pBuf, size_t* pBufLen)

    spinError spinImageChunkDataGetIntValue(spinImage hImage, const char* pName, int64_t* pValue)

    spinError spinImageChunkDataGetFloatValue(spinImage hImage, const char* pName, double* pValue)
