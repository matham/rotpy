from libcpp cimport bool as cbool
from libcpp.string cimport string as cstr
from libc.stdint cimport int64_t, uint64_t, uint8_t, uint32_t


cdef extern from "SpinGenApi/GCTypes.h" nogil:
    ctypedef float float32_t
    ctypedef double float64_t


cdef extern from "SpinGenApi/GCString.h" namespace "Spinnaker::GenICam" nogil:
    cdef cppclass gcstring:
        gcstring() except +raise_spin_exc
        const char * c_str() except +raise_spin_exc
        gcstring& assign(const char * pc, size_t n) except +raise_spin_exc
        cbool operator ==(const char * pc) except +raise_spin_exc


cdef extern from "SpinGenApi/GCStringVector.h" namespace "Spinnaker::GenICam" nogil:
    cdef cppclass gcstring_vector:
        gcstring& at(size_t uiIndex) except +raise_spin_exc
        size_t size() except +raise_spin_exc


cdef extern from "SpinGenApi/Autovector.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass int64_autovector_t:
        int64_t& operator[](size_t uiIndex) except +raise_spin_exc
        size_t size() except +raise_spin_exc

    cdef cppclass double_autovector_t:
        double& operator[](size_t uiIndex) except +raise_spin_exc
        size_t size() except +raise_spin_exc


cdef extern from "SpinGenApi/INode.h" namespace "Spinnaker::GenApi" nogil:
    pass


cdef extern from "SpinGenApi/Container.h" namespace "Spinnaker::GenApi" nogil:
    ctypedef value_vector FeatureList_t


cdef extern from "SpinGenApi/Reference.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass IReference:
        void SetReference(INode * pBase) except +raise_spin_exc

    cdef cppclass IEnumReference:
        pass


cdef extern from "SpinGenApi/Base.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass IBase:
        EAccessMode GetAccessMode() except +raise_spin_exc


cdef extern from "SpinGenApi/ISelector.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass ISelector(IBase):
        cbool IsSelector() except +raise_spin_exc
        void GetSelectedFeatures(FeatureList_t&) except +raise_spin_exc
        void GetSelectingFeatures(FeatureList_t&) except +raise_spin_exc


cdef extern from "SpinGenApi/INode.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass INode(ISelector, IReference):
        gcstring GetName(cbool FullQualified) except +raise_spin_exc
        EInterfaceType GetPrincipalInterfaceType() except +raise_spin_exc
        ENameSpace GetNameSpace() except +raise_spin_exc
        EVisibility GetVisibility() except +raise_spin_exc
        void InvalidateNode() except +raise_spin_exc
        ECachingMode GetCachingMode() except +raise_spin_exc
        gcstring GetToolTip() except +raise_spin_exc
        gcstring GetDescription() except +raise_spin_exc
        gcstring GetDisplayName() except +raise_spin_exc
        gcstring GetDeviceName() except +raise_spin_exc
        gcstring GetDocuURL() except +raise_spin_exc
        cbool IsDeprecated() except +raise_spin_exc
        cbool IsFeature() except +raise_spin_exc
        INode * GetCastAlias() except +raise_spin_exc
        INode * GetAlias() except +raise_spin_exc
        void ImposeVisibility(EVisibility ImposedVisibility) except +raise_spin_exc
        void ImposeAccessMode(EAccessMode ImposedAccessMode) except +raise_spin_exc
        cbool IsStreamable() except +raise_spin_exc
        gcstring GetEventID() except +raise_spin_exc
        INodeMap * GetNodeMap() except +raise_spin_exc
        int64_t GetPollingTime() except +raise_spin_exc
        EYesNo IsAccessModeCacheable() except +raise_spin_exc
        cbool IsCachable() except +raise_spin_exc
        void GetPropertyNames(gcstring_vector& PropertyNames) except +raise_spin_exc
        cbool GetProperty(const gcstring& PropertyName, gcstring& ValueStr, gcstring& AttributeStr) except +raise_spin_exc

    ctypedef node_vector NodeList_t


cdef extern from "SpinGenApi/IValue.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass IValue(INode):
        INode* GetNode() except +raise_spin_exc
        gcstring ToString(cbool Verify, cbool IgnoreCache) except +raise_spin_exc
        void FromString(const gcstring& ValueStr, cbool Verify) except +raise_spin_exc
        cbool IsValueCacheValid() except +raise_spin_exc


cdef extern from "SpinGenApi/IInteger.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass IInteger(IValue):
        void SetValue(int64_t Value, cbool Verify) except +raise_spin_exc
        int64_t GetValue(cbool Verify, cbool IgnoreCache) except +raise_spin_exc
        int64_t GetMin() except +raise_spin_exc
        int64_t GetMax() except +raise_spin_exc
        EIncMode GetIncMode() except +raise_spin_exc
        int64_t GetInc() except +raise_spin_exc
        int64_autovector_t GetListOfValidValues(cbool bounded) except +raise_spin_exc
        ERepresentation GetRepresentation() except +raise_spin_exc
        gcstring GetUnit() except +raise_spin_exc
        void ImposeMin(int64_t Value) except +raise_spin_exc
        void ImposeMax(int64_t Value) except +raise_spin_exc


cdef extern from "SpinGenApi/IFloat.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass IFloat(IValue):
        void SetValue(double Value, cbool Verify) except +raise_spin_exc
        double GetValue(cbool Verify, cbool IgnoreCache) except +raise_spin_exc
        double GetMin() except +raise_spin_exc
        double GetMax() except +raise_spin_exc
        cbool HasInc() except +raise_spin_exc
        EIncMode GetIncMode() except +raise_spin_exc
        double GetInc() except +raise_spin_exc
        double_autovector_t GetListOfValidValues(cbool bounded) except +raise_spin_exc
        ERepresentation GetRepresentation() except +raise_spin_exc
        gcstring GetUnit() except +raise_spin_exc
        void ImposeMin(double Value) except +raise_spin_exc
        void ImposeMax(double Value) except +raise_spin_exc
        EDisplayNotation GetDisplayNotation() except +raise_spin_exc
        int64_t GetDisplayPrecision() except +raise_spin_exc


cdef extern from "SpinGenApi/IBoolean.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass IBoolean(IValue):
        void SetValue(cbool Value, cbool Verify) except +raise_spin_exc
        cbool GetValue(cbool Verify, cbool IgnoreCache) except +raise_spin_exc


cdef extern from "SpinGenApi/IString.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass IString(IValue):
        void SetValue(const gcstring& Value, cbool Verify) except +raise_spin_exc
        gcstring GetValue(cbool Verify, cbool IgnoreCache) except +raise_spin_exc
        int64_t GetMaxLength() except +raise_spin_exc


cdef extern from "SpinGenApi/ICommand.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass ICommand(IValue):
        void Execute(cbool Verify) except +raise_spin_exc
        cbool IsDone(cbool Verify) except +raise_spin_exc


cdef extern from "SpinGenApi/IRegister.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass IRegister(IValue):
        void Set(const uint8_t* pBuffer, int64_t Length, cbool Verify) except +raise_spin_exc
        void Get(uint8_t * pBuffer, int64_t Length, cbool Verify, cbool IgnoreCache) except +raise_spin_exc
        int64_t GetLength() except +raise_spin_exc
        int64_t GetAddress() except +raise_spin_exc


cdef extern from "SpinGenApi/Container.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass node_vector:
        INode*& at(size_t uiIndex) except +raise_spin_exc
        size_t size() except +raise_spin_exc

    cdef cppclass value_vector:
        IValue*& at(size_t uiIndex) except +raise_spin_exc
        size_t size() except +raise_spin_exc


cdef extern from "SpinGenApi/Types.h" namespace "Spinnaker::GenApi" nogil:
    ctypedef gcstring_vector StringList_t


cdef extern from "SpinGenApi/IEnumeration.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass IEnumeration(IValue):
        void GetSymbolics(StringList_t& Symbolics) except +raise_spin_exc
        void GetEntries(NodeList_t& Entries) except +raise_spin_exc
        void SetIntValue(int64_t Value, cbool Verify) except +raise_spin_exc
        int64_t GetIntValue(cbool Verify, cbool IgnoreCache) except +raise_spin_exc
        IEnumEntry* GetEntryByName(const gcstring& Symbolic) except +raise_spin_exc
        IEnumEntry* GetEntry(const int64_t IntValue) except +raise_spin_exc
        IEnumEntry* GetCurrentEntry(cbool Verify, cbool IgnoreCache) except +raise_spin_exc


cdef extern from "SpinGenApi/IEnumerationT.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass IEnumerationT[EnumT](IEnumeration, IEnumReference):
        pass


cdef extern from "SpinGenApi/IEnumEntry.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass IEnumEntry(IValue):
        int64_t GetValue() except +raise_spin_exc
        gcstring GetSymbolic() except +raise_spin_exc
        double GetNumericValue() except +raise_spin_exc
        cbool IsSelfClearing() except +raise_spin_exc


cdef extern from "SpinGenApi/ICategory.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass ICategory(IValue):
        void GetFeatures(FeatureList_t& Features) except +raise_spin_exc


cdef extern from "SpinGenApi/IPort.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass IPort(IBase):
        void Read(void * pBuffer, int64_t Address, int64_t Length) except +raise_spin_exc
        void Write(const void * pBuffer, int64_t Address, int64_t Length) except +raise_spin_exc


cdef extern from "SpinGenApi/INodeMap.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass INodeMap:
        void GetNodes(NodeList_t& Nodes) except +raise_spin_exc
        INode * GetNode(const gcstring& Name) except +raise_spin_exc
        void InvalidateNodes() except +raise_spin_exc
        cbool Connect(IPort * pPort, const gcstring& PortName) except +raise_spin_exc
        cbool Connect(IPort * pPort) except +raise_spin_exc
        gcstring GetDeviceName() except +raise_spin_exc
        void Poll(int64_t ElapsedTime) except +raise_spin_exc
        uint64_t GetNumNodes() except +raise_spin_exc


cdef extern from "Exception.h" namespace "Spinnaker" nogil:
    cdef cppclass CException "Spinnaker::Exception":
        Exception() except +raise_spin_exc
        const char * GetFullErrorMessage() except +raise_spin_exc
        const char * GetErrorMessage() except +raise_spin_exc
        const char * GetFileName() except +raise_spin_exc
        const char * GetFunctionName() except +raise_spin_exc
        const char * GetBuildDate() except +raise_spin_exc
        const char * GetBuildTime() except +raise_spin_exc
        int GetLineNumber() except +raise_spin_exc
        Error GetError() except +raise_spin_exc


cdef extern from "ChunkDataInference.h" namespace "Spinnaker" nogil:
    cdef enum InferenceBoxType:
        INFERENCE_BOX_TYPE_RECTANGLE = 0
        INFERENCE_BOX_TYPE_CIRCLE = 1
        INFERENCE_BOX_TYPE_ROTATED_RECTANGLE = 2

    cdef struct InferenceBoxRect:
        int16_t topLeftXCoord
        int16_t topLeftYCoord
        int16_t bottomRightXCoord
        int16_t bottomRightYCoord

    cdef struct InferenceBoxCircle:
        int16_t centerXCoord
        int16_t centerYCoord
        int16_t radius

    cdef struct InferenceBoxRotatedRect:
        int16_t topLeftXCoord
        int16_t topLeftYCoord
        int16_t bottomRightXCoord
        int16_t bottomRightYCoord
        short rotationAngle

    cdef struct InferenceBoundingBox:
        InferenceBoxType boxType
        int16_t classId
        float32_t confidence

        InferenceBoxRect rect
        InferenceBoxCircle circle
        InferenceBoxRotatedRect rotatedRect

    cdef cppclass InferenceBoundingBoxResult:
        int8_t GetVersion() except +raise_spin_exc
        int16_t GetBoxCount() except +raise_spin_exc
        int8_t GetBoxSize() except +raise_spin_exc
        InferenceBoundingBox GetBoxAt(const uint16_t index) except +raise_spin_exc


cdef extern from "ChunkData.h" namespace "Spinnaker" nogil:
    cdef cppclass ChunkData:
        float64_t GetBlackLevel() except +raise_spin_exc
        int64_t GetFrameID() except +raise_spin_exc
        float64_t GetExposureTime() except +raise_spin_exc
        int64_t GetCompressionMode() except +raise_spin_exc
        float64_t GetCompressionRatio() except +raise_spin_exc
        int64_t GetTimestamp() except +raise_spin_exc
        int64_t GetExposureEndLineStatusAll() except +raise_spin_exc
        int64_t GetWidth() except +raise_spin_exc
        int64_t GetImage() except +raise_spin_exc
        int64_t GetHeight() except +raise_spin_exc
        float64_t GetGain() except +raise_spin_exc
        int64_t GetSequencerSetActive() except +raise_spin_exc
        int64_t GetCRC() except +raise_spin_exc
        int64_t GetOffsetX() except +raise_spin_exc
        int64_t GetOffsetY() except +raise_spin_exc
        int64_t GetSerialDataLength() except +raise_spin_exc
        int64_t GetPartSelector() except +raise_spin_exc
        int64_t GetPixelDynamicRangeMin() except +raise_spin_exc
        int64_t GetPixelDynamicRangeMax() except +raise_spin_exc
        int64_t GetTimestampLatchValue() except +raise_spin_exc
        int64_t GetLineStatusAll() except +raise_spin_exc
        int64_t GetCounterValue() except +raise_spin_exc
        float64_t GetTimerValue() except +raise_spin_exc
        int64_t GetScanLineSelector() except +raise_spin_exc
        int64_t GetEncoderValue() except +raise_spin_exc
        int64_t GetLinePitch() except +raise_spin_exc
        int64_t GetTransferBlockID() except +raise_spin_exc
        int64_t GetTransferQueueCurrentBlockCount() except +raise_spin_exc
        int64_t GetStreamChannelID() except +raise_spin_exc
        float64_t GetScan3dCoordinateScale() except +raise_spin_exc
        float64_t GetScan3dCoordinateOffset() except +raise_spin_exc
        float64_t GetScan3dInvalidDataValue() except +raise_spin_exc
        float64_t GetScan3dAxisMin() except +raise_spin_exc
        float64_t GetScan3dAxisMax() except +raise_spin_exc
        float64_t GetScan3dTransformValue() except +raise_spin_exc
        float64_t GetScan3dCoordinateReferenceValue() except +raise_spin_exc
        int64_t GetInferenceFrameId() except +raise_spin_exc
        int64_t GetInferenceResult() except +raise_spin_exc
        float64_t GetInferenceConfidence() except +raise_spin_exc
        InferenceBoundingBoxResult GetInferenceBoundingBoxResult() except +raise_spin_exc


cdef extern from "Image.h" namespace "Spinnaker" nogil:
    cdef cppclass ImagePtr:
        ImagePtr() except +raise_spin_exc
        CImage * get() const
        cbool IsValid() except +raise_spin_exc

    cdef cppclass CImage "Spinnaker::Image":
        @staticmethod
        ImagePtr Create0 "Create"() except +raise_spin_exc
        @staticmethod
        ImagePtr Create1 "Create"(const ImagePtr image) except +raise_spin_exc
        @staticmethod
        ImagePtr Create6 "Create"(
            size_t width,
            size_t height,
            size_t offsetX,
            size_t offsetY,
            PixelFormatEnums pixelFormat,
            void* pData
        ) except +raise_spin_exc
        @staticmethod
        ImagePtr Create8 "Create"(
            size_t width,
            size_t height,
            size_t offsetX,
            size_t offsetY,
            PixelFormatEnums pixelFormat,
            void* pData,
            PayloadTypeInfoIDs dataPayloadType,
            size_t dataSize
        ) except +raise_spin_exc
        @staticmethod
        void SetDefaultColorProcessing(ColorProcessingAlgorithm colorAlgorithm) except +raise_spin_exc
        @staticmethod
        ColorProcessingAlgorithm GetDefaultColorProcessing() except +raise_spin_exc
        @staticmethod
        void SetNumDecompressionThreads(unsigned int numThreads) except +raise_spin_exc
        @staticmethod
        unsigned int GetNumDecompressionThreads() except +raise_spin_exc
        @staticmethod
        const char * GetImageStatusDescription(ImageStatus status) except +raise_spin_exc

        ColorProcessingAlgorithm GetColorProcessing() except +raise_spin_exc
        ImagePtr Convert(PixelFormatEnums format, ColorProcessingAlgorithm colorAlgorithm) except +raise_spin_exc
        void Convert(
            ImagePtr destinationImage,
            PixelFormatEnums format,
            ColorProcessingAlgorithm colorAlgorithm
        ) except +raise_spin_exc
        void ResetImage(
            size_t width,
            size_t height,
            size_t offsetX,
            size_t offsetY,
            PixelFormatEnums pixelFormat
        ) except +raise_spin_exc
        void ResetImage(
            size_t width,
            size_t height,
            size_t offsetX,
            size_t offsetY,
            PixelFormatEnums pixelFormat,
            void* pData
        ) except +raise_spin_exc
        void ResetImage(
            size_t width,
            size_t height,
            size_t offsetX,
            size_t offsetY,
            PixelFormatEnums pixelFormat,
            void* pData,
            PayloadTypeInfoIDs dataPayloadType,
            size_t dataSize
        ) except +raise_spin_exc
        void Release() except +raise_spin_exc
        uint64_t GetID() except +raise_spin_exc
        void * GetData() except +raise_spin_exc
        float GetDataAbsoluteMax() except +raise_spin_exc
        float GetDataAbsoluteMin() except +raise_spin_exc
        void * GetPrivateData() except +raise_spin_exc
        size_t GetBufferSize() except +raise_spin_exc
        void DeepCopy(const ImagePtr pSrcImage) except +raise_spin_exc
        size_t GetWidth() except +raise_spin_exc
        size_t GetHeight() except +raise_spin_exc
        size_t GetStride() except +raise_spin_exc
        size_t GetBitsPerPixel() except +raise_spin_exc
        size_t GetNumChannels() except +raise_spin_exc
        size_t GetXOffset() except +raise_spin_exc
        size_t GetYOffset() except +raise_spin_exc
        size_t GetXPadding() except +raise_spin_exc
        size_t GetYPadding() except +raise_spin_exc
        uint64_t GetFrameID() except +raise_spin_exc
        size_t GetPayloadType() except +raise_spin_exc
        PayloadTypeInfoIDs GetTLPayloadType() except +raise_spin_exc
        uint64_t GetTLPixelFormat() except +raise_spin_exc
        PixelFormatNamespaceID GetTLPixelFormatNamespace() except +raise_spin_exc
        gcstring GetPixelFormatName() except +raise_spin_exc
        PixelFormatEnums GetPixelFormat() except +raise_spin_exc
        PixelFormatIntType GetPixelFormatIntType() except +raise_spin_exc
        cbool IsIncomplete() except +raise_spin_exc
        size_t GetValidPayloadSize() except +raise_spin_exc
        uint64_t GetChunkLayoutId() except +raise_spin_exc
        uint64_t GetTimeStamp() except +raise_spin_exc
        cbool HasCRC() except +raise_spin_exc
        cbool CheckCRC() except +raise_spin_exc
        size_t GetImageSize() except +raise_spin_exc
        cbool IsInUse() except +raise_spin_exc
        ImageStatus GetImageStatus() except +raise_spin_exc
        cbool IsCompressed() except +raise_spin_exc
        void Save(const char * pFilename, ImageFileFormat format) except +raise_spin_exc
        void Save(const char * pFilename, PNGOption& pOption) except +raise_spin_exc
        void Save(const char * pFilename, PPMOption& pOption) except +raise_spin_exc
        void Save(const char * pFilename, PGMOption& pOption) except +raise_spin_exc
        void Save(const char * pFilename, TIFFOption& pOption) except +raise_spin_exc
        void Save(const char * pFilename, JPEGOption& pOption) except +raise_spin_exc
        void Save(const char * pFilename, JPG2Option& pOption) except +raise_spin_exc
        void Save(const char * pFilename, BMPOption& pOption) except +raise_spin_exc
        ChunkData& GetChunkData() except +raise_spin_exc


cdef extern from "TransportLayerDevice.h" namespace "Spinnaker" nogil:
    cdef cppclass TransportLayerDevice:
        IString &DeviceID
        IString &DeviceSerialNumber
        IString &DeviceVendorName
        IString &DeviceModelName
        IEnumerationT[DeviceTypeEnum] &DeviceType
        IString &DeviceDisplayName
        IEnumerationT[DeviceAccessStatusEnum] &DeviceAccessStatus
        IString &DeviceVersion
        IString &DeviceUserID
        IString &DeviceDriverVersion
        IBoolean &DeviceIsUpdater
        IEnumerationT[GevCCPEnum] &GevCCP
        IEnumerationT[GUIXMLLocationEnum] &GUIXMLLocation
        IString &GUIXMLPath
        IEnumerationT[GenICamXMLLocationEnum] &GenICamXMLLocation
        IString &GenICamXMLPath
        IInteger &GevDeviceIPAddress
        IInteger &GevDeviceSubnetMask
        IInteger &GevDeviceMACAddress
        IInteger &GevDeviceGateway
        IInteger &DeviceLinkSpeed
        IInteger &GevVersionMajor
        IInteger &GevVersionMinor
        IBoolean &GevDeviceModeIsBigEndian
        IInteger &GevDeviceReadAndWriteTimeout
        IInteger &GevDeviceMaximumRetryCount
        IInteger &GevDevicePort
        ICommand &GevDeviceDiscoverMaximumPacketSize
        IInteger &GevDeviceMaximumPacketSize
        IBoolean &GevDeviceIsWrongSubnet
        ICommand &GevDeviceAutoForceIP
        ICommand &GevDeviceForceIP
        IInteger &GevDeviceForceIPAddress
        IInteger &GevDeviceForceSubnetMask
        IInteger &GevDeviceForceGateway
        IBoolean &DeviceMulticastMonitorMode
        IEnumerationT[DeviceEndianessMechanismEnum] &DeviceEndianessMechanism
        IString &DeviceInstanceId
        IString &DeviceLocation
        IEnumerationT[DeviceCurrentSpeedEnum] &DeviceCurrentSpeed
        IBoolean &DeviceU3VProtocol
        IString &DevicePortId


cdef extern from "TransportLayerStream.h" namespace "Spinnaker" nogil:
    cdef cppclass TransportLayerStream:
        IString &StreamID
        IEnumerationT[StreamTypeEnum] &StreamType
        IEnumerationT[StreamModeEnum] &StreamMode
        IInteger &StreamBufferCountManual
        IInteger &StreamBufferCountResult
        IInteger &StreamBufferCountMax
        IEnumerationT[StreamBufferCountModeEnum] &StreamBufferCountMode
        IEnumerationT[StreamBufferHandlingModeEnum] &StreamBufferHandlingMode
        IInteger &StreamAnnounceBufferMinimum
        IInteger &StreamAnnouncedBufferCount
        IInteger &StreamStartedFrameCount
        IInteger &StreamDeliveredFrameCount
        IInteger &StreamReceivedFrameCount
        IInteger &StreamIncompleteFrameCount
        IInteger &StreamLostFrameCount
        IInteger &StreamDroppedFrameCount
        IInteger &StreamInputBufferCount
        IInteger &StreamOutputBufferCount
        IBoolean &StreamIsGrabbing
        IInteger &StreamChunkCountMaximum
        IInteger &StreamBufferAlignment
        IBoolean &StreamCRCCheckEnable
        IInteger &StreamReceivedPacketCount
        IInteger &StreamMissedPacketCount
        IBoolean &StreamPacketResendEnable
        IInteger &StreamPacketResendTimeout
        IInteger &StreamPacketResendMaxRequests
        IInteger &StreamPacketResendRequestCount
        IInteger &StreamPacketResendRequestSuccessCount
        IInteger &StreamPacketResendRequestedPacketCount
        IInteger &StreamPacketResendReceivedPacketCount
        IBoolean &GevPacketResendMode
        IInteger &GevMaximumNumberResendRequests
        IInteger &GevPacketResendTimeout
        IInteger &GevTotalPacketCount
        IInteger &GevFailedPacketCount
        IInteger &GevResendPacketCount
        IInteger &StreamFailedBufferCount
        IInteger &GevResendRequestCount
        IInteger &StreamBlockTransferSize


cdef extern from "CameraPtr.h" namespace "Spinnaker" nogil:
    pass


cdef extern from "Camera.h" namespace "Spinnaker" nogil:
    cdef cppclass CameraPtr:
        CameraPtr() except +raise_spin_exc
        CCamera * get() const
        cbool IsValid() except +raise_spin_exc

    cdef cppclass CCamera "Spinnaker::Camera":
        void Init() except +raise_spin_exc
        void DeInit() except +raise_spin_exc
        cbool IsInitialized() except +raise_spin_exc
        cbool IsValid() except +raise_spin_exc
        void ReadPort(uint64_t iAddress, void * pBuffer, size_t iSize) except +raise_spin_exc
        void WritePort(uint64_t iAddress, const void * pBuffer, size_t iSize) except +raise_spin_exc
        void BeginAcquisition() except +raise_spin_exc
        void EndAcquisition() except +raise_spin_exc
        unsigned int DiscoverMaxPacketSize() except +raise_spin_exc
        void ForceIP() except +raise_spin_exc
        EAccessMode GetAccessMode() except +raise_spin_exc
        BufferOwnership GetBufferOwnership() except +raise_spin_exc
        void SetBufferOwnership(const BufferOwnership mode) except +raise_spin_exc
        uint64_t GetUserBufferCount() except +raise_spin_exc
        uint64_t GetUserBufferSize() except +raise_spin_exc
        uint64_t GetUserBufferTotalSize() except +raise_spin_exc
        gcstring GetUniqueID() except +raise_spin_exc
        cbool IsStreaming() except +raise_spin_exc
        gcstring GetGuiXml() except +raise_spin_exc
        unsigned int GetNumImagesInUse() except +raise_spin_exc
        unsigned int GetNumDataStreams() except +raise_spin_exc
        ImagePtr GetNextImage(uint64_t grabTimeout, uint64_t streamID) except +raise_spin_exc
        INodeMap& GetNodeMap() except +raise_spin_exc
        INodeMap& GetTLDeviceNodeMap() except +raise_spin_exc
        INodeMap& GetTLStreamNodeMap() except +raise_spin_exc
        void RegisterEventHandler(CEventHandler& evtHandlerToRegister) except +raise_spin_exc
        void RegisterEventHandler(CEventHandler& evtHandlerToRegister, const gcstring &eventName) except +raise_spin_exc
        void UnregisterEventHandler(CEventHandler& evtHandlerToUnregister) except +raise_spin_exc
        void SetUserBuffers(void * pMemBuffers, uint64_t totalSize) except +raise_spin_exc
        void SetUserBuffers(void** ppMemBuffers, const uint64_t bufferCount, const uint64_t bufferSize) except +raise_spin_exc

        TransportLayerDevice TLDevice
        TransportLayerStream TLStream

        IInteger &LUTIndex
        IBoolean &LUTEnable
        IInteger &LUTValue
        IEnumerationT[LUTSelectorEnums] &LUTSelector
        IFloat &ExposureTime
        ICommand &AcquisitionStop
        IFloat &AcquisitionResultingFrameRate
        IFloat &AcquisitionLineRate
        ICommand &AcquisitionStart
        ICommand &TriggerSoftware
        IEnumerationT[ExposureModeEnums] &ExposureMode
        IEnumerationT[AcquisitionModeEnums] &AcquisitionMode
        IInteger &AcquisitionFrameCount
        IEnumerationT[TriggerSourceEnums] &TriggerSource
        IEnumerationT[TriggerActivationEnums] &TriggerActivation
        IEnumerationT[SensorShutterModeEnums] &SensorShutterMode
        IFloat &TriggerDelay
        IEnumerationT[TriggerModeEnums] &TriggerMode
        IFloat &AcquisitionFrameRate
        IEnumerationT[TriggerOverlapEnums] &TriggerOverlap
        IEnumerationT[TriggerSelectorEnums] &TriggerSelector
        IBoolean &AcquisitionFrameRateEnable
        IEnumerationT[ExposureAutoEnums] &ExposureAuto
        IInteger &AcquisitionBurstFrameCount
        IInteger &EventTest
        IInteger &EventTestTimestamp
        IInteger &EventExposureEndFrameID
        IInteger &EventExposureEnd
        IInteger &EventExposureEndTimestamp
        IInteger &EventError
        IInteger &EventErrorTimestamp
        IInteger &EventErrorCode
        IInteger &EventErrorFrameID
        IEnumerationT[EventSelectorEnums] &EventSelector
        IBoolean &EventSerialReceiveOverflow
        IInteger &EventSerialPortReceive
        IInteger &EventSerialPortReceiveTimestamp
        IString &EventSerialData
        IInteger &EventSerialDataLength
        IEnumerationT[EventNotificationEnums] &EventNotification
        IInteger &LogicBlockLUTRowIndex
        IEnumerationT[LogicBlockSelectorEnums] &LogicBlockSelector
        IEnumerationT[LogicBlockLUTInputActivationEnums] &LogicBlockLUTInputActivation
        IEnumerationT[LogicBlockLUTInputSelectorEnums] &LogicBlockLUTInputSelector
        IEnumerationT[LogicBlockLUTInputSourceEnums] &LogicBlockLUTInputSource
        IBoolean &LogicBlockLUTOutputValue
        IInteger &LogicBlockLUTOutputValueAll
        IEnumerationT[LogicBlockLUTSelectorEnums] &LogicBlockLUTSelector
        IFloat &ColorTransformationValue
        IBoolean &ColorTransformationEnable
        IEnumerationT[ColorTransformationSelectorEnums] &ColorTransformationSelector
        IEnumerationT[RgbTransformLightSourceEnums] &RgbTransformLightSource
        IFloat &Saturation
        IBoolean &SaturationEnable
        IEnumerationT[ColorTransformationValueSelectorEnums] &ColorTransformationValueSelector
        IInteger &TimestampLatchValue
        ICommand &TimestampReset
        IString &DeviceUserID
        IFloat &DeviceTemperature
        IInteger &MaxDeviceResetTime
        IInteger &DeviceTLVersionMinor
        IString &DeviceSerialNumber
        IString &DeviceVendorName
        IEnumerationT[DeviceRegistersEndiannessEnums] &DeviceRegistersEndianness
        IString &DeviceManufacturerInfo
        IInteger &DeviceLinkSpeed
        IInteger &LinkUptime
        IInteger &DeviceEventChannelCount
        ICommand &TimestampLatch
        IEnumerationT[DeviceScanTypeEnums] &DeviceScanType
        ICommand &DeviceReset
        IEnumerationT[DeviceCharacterSetEnums] &DeviceCharacterSet
        IInteger &DeviceLinkThroughputLimit
        IString &DeviceFirmwareVersion
        IInteger &DeviceStreamChannelCount
        IEnumerationT[DeviceTLTypeEnums] &DeviceTLType
        IString &DeviceVersion
        IEnumerationT[DevicePowerSupplySelectorEnums] &DevicePowerSupplySelector
        IString &SensorDescription
        IString &DeviceModelName
        IInteger &DeviceTLVersionMajor
        IEnumerationT[DeviceTemperatureSelectorEnums] &DeviceTemperatureSelector
        IInteger &EnumerationCount
        IFloat &PowerSupplyCurrent
        IString &DeviceID
        IInteger &DeviceUptime
        IInteger &DeviceLinkCurrentThroughput
        IInteger &DeviceMaxThroughput
        ICommand &FactoryReset
        IFloat &PowerSupplyVoltage
        IEnumerationT[DeviceIndicatorModeEnums] &DeviceIndicatorMode
        IFloat &DeviceLinkBandwidthReserve
        IInteger &AasRoiOffsetY
        IInteger &AasRoiOffsetX
        IEnumerationT[AutoExposureControlPriorityEnums] &AutoExposureControlPriority
        IFloat &BalanceWhiteAutoLowerLimit
        IFloat &BalanceWhiteAutoDamping
        IInteger &AasRoiHeight
        IFloat &AutoExposureGreyValueUpperLimit
        IFloat &AutoExposureTargetGreyValue
        IFloat &AutoExposureGainLowerLimit
        IFloat &AutoExposureGreyValueLowerLimit
        IEnumerationT[AutoExposureMeteringModeEnums] &AutoExposureMeteringMode
        IFloat &AutoExposureExposureTimeUpperLimit
        IFloat &AutoExposureGainUpperLimit
        IFloat &AutoExposureControlLoopDamping
        IFloat &AutoExposureEVCompensation
        IFloat &AutoExposureExposureTimeLowerLimit
        IEnumerationT[BalanceWhiteAutoProfileEnums] &BalanceWhiteAutoProfile
        IEnumerationT[AutoAlgorithmSelectorEnums] &AutoAlgorithmSelector
        IEnumerationT[AutoExposureTargetGreyValueAutoEnums] &AutoExposureTargetGreyValueAuto
        IBoolean &AasRoiEnable
        IEnumerationT[AutoExposureLightingModeEnums] &AutoExposureLightingMode
        IInteger &AasRoiWidth
        IFloat &BalanceWhiteAutoUpperLimit
        IInteger &LinkErrorCount
        IBoolean &GevCurrentIPConfigurationDHCP
        IInteger &GevInterfaceSelector
        IInteger &GevSCPD
        IInteger &GevTimestampTickFrequency
        IInteger &GevSCPSPacketSize
        IInteger &GevCurrentDefaultGateway
        IBoolean &GevSCCFGUnconditionalStreaming
        IInteger &GevMCTT
        IBoolean &GevSCPSDoNotFragment
        IInteger &GevCurrentSubnetMask
        IInteger &GevStreamChannelSelector
        IInteger &GevCurrentIPAddress
        IInteger &GevMCSP
        IInteger &GevGVCPPendingTimeout
        IEnumerationT[GevIEEE1588StatusEnums] &GevIEEE1588Status
        IString &GevFirstURL
        IInteger &GevMACAddress
        IInteger &GevPersistentSubnetMask
        IInteger &GevMCPHostPort
        IInteger &GevSCPHostPort
        IBoolean &GevGVCPPendingAck
        IInteger &GevSCPInterfaceIndex
        IBoolean &GevSupportedOption
        IEnumerationT[GevIEEE1588ModeEnums] &GevIEEE1588Mode
        IBoolean &GevCurrentIPConfigurationLLA
        IInteger &GevSCSP
        IBoolean &GevIEEE1588
        IBoolean &GevSCCFGExtendedChunkData
        IInteger &GevPersistentIPAddress
        IBoolean &GevCurrentIPConfigurationPersistentIP
        IEnumerationT[GevIEEE1588ClockAccuracyEnums] &GevIEEE1588ClockAccuracy
        IInteger &GevHeartbeatTimeout
        IInteger &GevPersistentDefaultGateway
        IEnumerationT[GevCCPEnums] &GevCCP
        IInteger &GevMCDA
        IInteger &GevSCDA
        IInteger &GevSCPDirection
        IBoolean &GevSCPSFireTestPacket
        IString &GevSecondURL
        IEnumerationT[GevSupportedOptionSelectorEnums] &GevSupportedOptionSelector
        IBoolean &GevGVCPHeartbeatDisable
        IInteger &GevMCRC
        IBoolean &GevSCPSBigEndian
        IInteger &GevNumberOfInterfaces
        IInteger &TLParamsLocked
        IInteger &PayloadSize
        IInteger &PacketResendRequestCount
        IBoolean &SharpeningEnable
        IEnumerationT[BlackLevelSelectorEnums] &BlackLevelSelector
        IBoolean &GammaEnable
        IBoolean &SharpeningAuto
        IBoolean &BlackLevelClampingEnable
        IFloat &BalanceRatio
        IEnumerationT[BalanceWhiteAutoEnums] &BalanceWhiteAuto
        IFloat &SharpeningThreshold
        IEnumerationT[GainAutoEnums] &GainAuto
        IFloat &Sharpening
        IFloat &Gain
        IEnumerationT[BalanceRatioSelectorEnums] &BalanceRatioSelector
        IEnumerationT[GainSelectorEnums] &GainSelector
        IFloat &BlackLevel
        IInteger &BlackLevelRaw
        IFloat &Gamma
        IInteger &DefectTableIndex
        ICommand &DefectTableFactoryRestore
        IInteger &DefectTableCoordinateY
        ICommand &DefectTableSave
        IEnumerationT[DefectCorrectionModeEnums] &DefectCorrectionMode
        IInteger &DefectTableCoordinateX
        IInteger &DefectTablePixelCount
        IBoolean &DefectCorrectStaticEnable
        ICommand &DefectTableApply
        IBoolean &UserSetFeatureEnable
        ICommand &UserSetSave
        IEnumerationT[UserSetSelectorEnums] &UserSetSelector
        ICommand &UserSetLoad
        IEnumerationT[UserSetDefaultEnums] &UserSetDefault
        IEnumerationT[SerialPortBaudRateEnums] &SerialPortBaudRate
        IInteger &SerialPortDataBits
        IEnumerationT[SerialPortParityEnums] &SerialPortParity
        IInteger &SerialTransmitQueueMaxCharacterCount
        IInteger &SerialReceiveQueueCurrentCharacterCount
        IEnumerationT[SerialPortSelectorEnums] &SerialPortSelector
        IEnumerationT[SerialPortStopBitsEnums] &SerialPortStopBits
        ICommand &SerialReceiveQueueClear
        IInteger &SerialReceiveFramingErrorCount
        IInteger &SerialTransmitQueueCurrentCharacterCount
        IInteger &SerialReceiveParityErrorCount
        IEnumerationT[SerialPortSourceEnums] &SerialPortSource
        IInteger &SerialReceiveQueueMaxCharacterCount
        IInteger &SequencerSetStart
        IEnumerationT[SequencerModeEnums] &SequencerMode
        IEnumerationT[SequencerConfigurationValidEnums] &SequencerConfigurationValid
        IEnumerationT[SequencerSetValidEnums] &SequencerSetValid
        IInteger &SequencerSetSelector
        IEnumerationT[SequencerTriggerActivationEnums] &SequencerTriggerActivation
        IEnumerationT[SequencerConfigurationModeEnums] &SequencerConfigurationMode
        ICommand &SequencerSetSave
        IEnumerationT[SequencerTriggerSourceEnums] &SequencerTriggerSource
        IInteger &SequencerSetActive
        IInteger &SequencerSetNext
        ICommand &SequencerSetLoad
        IInteger &SequencerPathSelector
        IBoolean &SequencerFeatureEnable
        IInteger &TransferBlockCount
        ICommand &TransferStart
        IInteger &TransferQueueMaxBlockCount
        IInteger &TransferQueueCurrentBlockCount
        IEnumerationT[TransferQueueModeEnums] &TransferQueueMode
        IEnumerationT[TransferOperationModeEnums] &TransferOperationMode
        ICommand &TransferStop
        IInteger &TransferQueueOverflowCount
        IEnumerationT[TransferControlModeEnums] &TransferControlMode
        IFloat &ChunkBlackLevel
        IInteger &ChunkFrameID
        IString &ChunkSerialData
        IFloat &ChunkExposureTime
        IInteger &ChunkCompressionMode
        IFloat &ChunkCompressionRatio
        IBoolean &ChunkSerialReceiveOverflow
        IInteger &ChunkTimestamp
        IBoolean &ChunkModeActive
        IInteger &ChunkExposureEndLineStatusAll
        IEnumerationT[ChunkGainSelectorEnums] &ChunkGainSelector
        IEnumerationT[ChunkSelectorEnums] &ChunkSelector
        IEnumerationT[ChunkBlackLevelSelectorEnums] &ChunkBlackLevelSelector
        IInteger &ChunkWidth
        IInteger &ChunkImage
        IInteger &ChunkHeight
        IEnumerationT[ChunkPixelFormatEnums] &ChunkPixelFormat
        IFloat &ChunkGain
        IInteger &ChunkSequencerSetActive
        IInteger &ChunkCRC
        IInteger &ChunkOffsetX
        IInteger &ChunkOffsetY
        IBoolean &ChunkEnable
        IInteger &ChunkSerialDataLength
        IInteger &FileAccessOffset
        IInteger &FileAccessLength
        IEnumerationT[FileOperationStatusEnums] &FileOperationStatus
        ICommand &FileOperationExecute
        IEnumerationT[FileOpenModeEnums] &FileOpenMode
        IInteger &FileOperationResult
        IEnumerationT[FileOperationSelectorEnums] &FileOperationSelector
        IEnumerationT[FileSelectorEnums] &FileSelector
        IInteger &FileSize
        IEnumerationT[BinningSelectorEnums] &BinningSelector
        IInteger &PixelDynamicRangeMin
        IInteger &PixelDynamicRangeMax
        IInteger &OffsetY
        IInteger &BinningHorizontal
        IInteger &Width
        IEnumerationT[TestPatternGeneratorSelectorEnums] &TestPatternGeneratorSelector
        IFloat &CompressionRatio
        IEnumerationT[CompressionSaturationPriorityEnums] &CompressionSaturationPriority
        IBoolean &ReverseX
        IBoolean &ReverseY
        IEnumerationT[TestPatternEnums] &TestPattern
        IEnumerationT[PixelColorFilterEnums] &PixelColorFilter
        IInteger &WidthMax
        IEnumerationT[AdcBitDepthEnums] &AdcBitDepth
        IInteger &BinningVertical
        IEnumerationT[DecimationHorizontalModeEnums] &DecimationHorizontalMode
        IEnumerationT[BinningVerticalModeEnums] &BinningVerticalMode
        IInteger &OffsetX
        IInteger &HeightMax
        IInteger &DecimationHorizontal
        IEnumerationT[PixelSizeEnums] &PixelSize
        IInteger &SensorHeight
        IEnumerationT[DecimationSelectorEnums] &DecimationSelector
        IBoolean &IspEnable
        IBoolean &AdaptiveCompressionEnable
        IEnumerationT[ImageCompressionModeEnums] &ImageCompressionMode
        IInteger &DecimationVertical
        IInteger &Height
        IEnumerationT[BinningHorizontalModeEnums] &BinningHorizontalMode
        IEnumerationT[PixelFormatEnums] &PixelFormat
        IInteger &SensorWidth
        IEnumerationT[DecimationVerticalModeEnums] &DecimationVerticalMode
        ICommand &TestEventGenerate
        ICommand &TriggerEventTest
        IInteger &GuiXmlManifestAddress
        IInteger &Test0001
        IBoolean &V3_3Enable
        IEnumerationT[LineModeEnums] &LineMode
        IEnumerationT[LineSourceEnums] &LineSource
        IEnumerationT[LineInputFilterSelectorEnums] &LineInputFilterSelector
        IBoolean &UserOutputValue
        IInteger &UserOutputValueAll
        IEnumerationT[UserOutputSelectorEnums] &UserOutputSelector
        IBoolean &LineStatus
        IEnumerationT[LineFormatEnums] &LineFormat
        IInteger &LineStatusAll
        IEnumerationT[LineSelectorEnums] &LineSelector
        IEnumerationT[ExposureActiveModeEnums] &ExposureActiveMode
        IBoolean &LineInverter
        IFloat &LineFilterWidth
        IEnumerationT[CounterTriggerActivationEnums] &CounterTriggerActivation
        IInteger &CounterValue
        IEnumerationT[CounterSelectorEnums] &CounterSelector
        IInteger &CounterValueAtReset
        IEnumerationT[CounterStatusEnums] &CounterStatus
        IEnumerationT[CounterTriggerSourceEnums] &CounterTriggerSource
        IInteger &CounterDelay
        IEnumerationT[CounterResetSourceEnums] &CounterResetSource
        IEnumerationT[CounterEventSourceEnums] &CounterEventSource
        IEnumerationT[CounterEventActivationEnums] &CounterEventActivation
        IInteger &CounterDuration
        IEnumerationT[CounterResetActivationEnums] &CounterResetActivation
        IEnumerationT[DeviceTypeEnums] &DeviceType
        IString &DeviceFamilyName
        IInteger &DeviceSFNCVersionMajor
        IInteger &DeviceSFNCVersionMinor
        IInteger &DeviceSFNCVersionSubMinor
        IInteger &DeviceManifestEntrySelector
        IInteger &DeviceManifestXMLMajorVersion
        IInteger &DeviceManifestXMLMinorVersion
        IInteger &DeviceManifestXMLSubMinorVersion
        IInteger &DeviceManifestSchemaMajorVersion
        IInteger &DeviceManifestSchemaMinorVersion
        IString &DeviceManifestPrimaryURL
        IString &DeviceManifestSecondaryURL
        IInteger &DeviceTLVersionSubMinor
        IInteger &DeviceGenCPVersionMajor
        IInteger &DeviceGenCPVersionMinor
        IInteger &DeviceConnectionSelector
        IInteger &DeviceConnectionSpeed
        IEnumerationT[DeviceConnectionStatusEnums] &DeviceConnectionStatus
        IInteger &DeviceLinkSelector
        IEnumerationT[DeviceLinkThroughputLimitModeEnums] &DeviceLinkThroughputLimitMode
        IInteger &DeviceLinkConnectionCount
        IEnumerationT[DeviceLinkHeartbeatModeEnums] &DeviceLinkHeartbeatMode
        IFloat &DeviceLinkHeartbeatTimeout
        IFloat &DeviceLinkCommandTimeout
        IInteger &DeviceStreamChannelSelector
        IEnumerationT[DeviceStreamChannelTypeEnums] &DeviceStreamChannelType
        IInteger &DeviceStreamChannelLink
        IEnumerationT[DeviceStreamChannelEndiannessEnums] &DeviceStreamChannelEndianness
        IInteger &DeviceStreamChannelPacketSize
        ICommand &DeviceFeaturePersistenceStart
        ICommand &DeviceFeaturePersistenceEnd
        ICommand &DeviceRegistersStreamingStart
        ICommand &DeviceRegistersStreamingEnd
        ICommand &DeviceRegistersCheck
        IBoolean &DeviceRegistersValid
        IEnumerationT[DeviceClockSelectorEnums] &DeviceClockSelector
        IFloat &DeviceClockFrequency
        IEnumerationT[DeviceSerialPortSelectorEnums] &DeviceSerialPortSelector
        IEnumerationT[DeviceSerialPortBaudRateEnums] &DeviceSerialPortBaudRate
        IInteger &Timestamp
        IEnumerationT[SensorTapsEnums] &SensorTaps
        IEnumerationT[SensorDigitizationTapsEnums] &SensorDigitizationTaps
        IEnumerationT[RegionSelectorEnums] &RegionSelector
        IEnumerationT[RegionModeEnums] &RegionMode
        IEnumerationT[RegionDestinationEnums] &RegionDestination
        IEnumerationT[ImageComponentSelectorEnums] &ImageComponentSelector
        IBoolean &ImageComponentEnable
        IInteger &LinePitch
        IEnumerationT[PixelFormatInfoSelectorEnums] &PixelFormatInfoSelector
        IInteger &PixelFormatInfoID
        IEnumerationT[DeinterlacingEnums] &Deinterlacing
        IEnumerationT[ImageCompressionRateOptionEnums] &ImageCompressionRateOption
        IInteger &ImageCompressionQuality
        IFloat &ImageCompressionBitrate
        IEnumerationT[ImageCompressionJPEGFormatOptionEnums] &ImageCompressionJPEGFormatOption
        ICommand &AcquisitionAbort
        ICommand &AcquisitionArm
        IEnumerationT[AcquisitionStatusSelectorEnums] &AcquisitionStatusSelector
        IBoolean &AcquisitionStatus
        IInteger &TriggerDivider
        IInteger &TriggerMultiplier
        IEnumerationT[ExposureTimeModeEnums] &ExposureTimeMode
        IEnumerationT[ExposureTimeSelectorEnums] &ExposureTimeSelector
        IEnumerationT[GainAutoBalanceEnums] &GainAutoBalance
        IEnumerationT[BlackLevelAutoEnums] &BlackLevelAuto
        IEnumerationT[BlackLevelAutoBalanceEnums] &BlackLevelAutoBalance
        IEnumerationT[WhiteClipSelectorEnums] &WhiteClipSelector
        IFloat &WhiteClip
        IRegister &LUTValueAll
        IInteger &UserOutputValueAllMask
        ICommand &CounterReset
        IEnumerationT[TimerSelectorEnums] &TimerSelector
        IFloat &TimerDuration
        IFloat &TimerDelay
        ICommand &TimerReset
        IFloat &TimerValue
        IEnumerationT[TimerStatusEnums] &TimerStatus
        IEnumerationT[TimerTriggerSourceEnums] &TimerTriggerSource
        IEnumerationT[TimerTriggerActivationEnums] &TimerTriggerActivation
        IEnumerationT[EncoderSelectorEnums] &EncoderSelector
        IEnumerationT[EncoderSourceAEnums] &EncoderSourceA
        IEnumerationT[EncoderSourceBEnums] &EncoderSourceB
        IEnumerationT[EncoderModeEnums] &EncoderMode
        IInteger &EncoderDivider
        IEnumerationT[EncoderOutputModeEnums] &EncoderOutputMode
        IEnumerationT[EncoderStatusEnums] &EncoderStatus
        IFloat &EncoderTimeout
        IEnumerationT[EncoderResetSourceEnums] &EncoderResetSource
        IEnumerationT[EncoderResetActivationEnums] &EncoderResetActivation
        ICommand &EncoderReset
        IInteger &EncoderValue
        IInteger &EncoderValueAtReset
        IEnumerationT[SoftwareSignalSelectorEnums] &SoftwareSignalSelector
        ICommand &SoftwareSignalPulse
        IEnumerationT[ActionUnconditionalModeEnums] &ActionUnconditionalMode
        IInteger &ActionDeviceKey
        IInteger &ActionQueueSize
        IInteger &ActionSelector
        IInteger &ActionGroupMask
        IInteger &ActionGroupKey
        IInteger &EventAcquisitionTrigger
        IInteger &EventAcquisitionTriggerTimestamp
        IInteger &EventAcquisitionTriggerFrameID
        IInteger &EventAcquisitionStart
        IInteger &EventAcquisitionStartTimestamp
        IInteger &EventAcquisitionStartFrameID
        IInteger &EventAcquisitionEnd
        IInteger &EventAcquisitionEndTimestamp
        IInteger &EventAcquisitionEndFrameID
        IInteger &EventAcquisitionTransferStart
        IInteger &EventAcquisitionTransferStartTimestamp
        IInteger &EventAcquisitionTransferStartFrameID
        IInteger &EventAcquisitionTransferEnd
        IInteger &EventAcquisitionTransferEndTimestamp
        IInteger &EventAcquisitionTransferEndFrameID
        IInteger &EventAcquisitionError
        IInteger &EventAcquisitionErrorTimestamp
        IInteger &EventAcquisitionErrorFrameID
        IInteger &EventFrameTrigger
        IInteger &EventFrameTriggerTimestamp
        IInteger &EventFrameTriggerFrameID
        IInteger &EventFrameStart
        IInteger &EventFrameStartTimestamp
        IInteger &EventFrameStartFrameID
        IInteger &EventFrameEnd
        IInteger &EventFrameEndTimestamp
        IInteger &EventFrameEndFrameID
        IInteger &EventFrameBurstStart
        IInteger &EventFrameBurstStartTimestamp
        IInteger &EventFrameBurstStartFrameID
        IInteger &EventFrameBurstEnd
        IInteger &EventFrameBurstEndTimestamp
        IInteger &EventFrameBurstEndFrameID
        IInteger &EventFrameTransferStart
        IInteger &EventFrameTransferStartTimestamp
        IInteger &EventFrameTransferStartFrameID
        IInteger &EventFrameTransferEnd
        IInteger &EventFrameTransferEndTimestamp
        IInteger &EventFrameTransferEndFrameID
        IInteger &EventExposureStart
        IInteger &EventExposureStartTimestamp
        IInteger &EventExposureStartFrameID
        IInteger &EventStream0TransferStart
        IInteger &EventStream0TransferStartTimestamp
        IInteger &EventStream0TransferStartFrameID
        IInteger &EventStream0TransferEnd
        IInteger &EventStream0TransferEndTimestamp
        IInteger &EventStream0TransferEndFrameID
        IInteger &EventStream0TransferPause
        IInteger &EventStream0TransferPauseTimestamp
        IInteger &EventStream0TransferPauseFrameID
        IInteger &EventStream0TransferResume
        IInteger &EventStream0TransferResumeTimestamp
        IInteger &EventStream0TransferResumeFrameID
        IInteger &EventStream0TransferBlockStart
        IInteger &EventStream0TransferBlockStartTimestamp
        IInteger &EventStream0TransferBlockStartFrameID
        IInteger &EventStream0TransferBlockEnd
        IInteger &EventStream0TransferBlockEndTimestamp
        IInteger &EventStream0TransferBlockEndFrameID
        IInteger &EventStream0TransferBlockTrigger
        IInteger &EventStream0TransferBlockTriggerTimestamp
        IInteger &EventStream0TransferBlockTriggerFrameID
        IInteger &EventStream0TransferBurstStart
        IInteger &EventStream0TransferBurstStartTimestamp
        IInteger &EventStream0TransferBurstStartFrameID
        IInteger &EventStream0TransferBurstEnd
        IInteger &EventStream0TransferBurstEndTimestamp
        IInteger &EventStream0TransferBurstEndFrameID
        IInteger &EventStream0TransferOverflow
        IInteger &EventStream0TransferOverflowTimestamp
        IInteger &EventStream0TransferOverflowFrameID
        IInteger &EventSequencerSetChange
        IInteger &EventSequencerSetChangeTimestamp
        IInteger &EventSequencerSetChangeFrameID
        IInteger &EventCounter0Start
        IInteger &EventCounter0StartTimestamp
        IInteger &EventCounter0StartFrameID
        IInteger &EventCounter1Start
        IInteger &EventCounter1StartTimestamp
        IInteger &EventCounter1StartFrameID
        IInteger &EventCounter0End
        IInteger &EventCounter0EndTimestamp
        IInteger &EventCounter0EndFrameID
        IInteger &EventCounter1End
        IInteger &EventCounter1EndTimestamp
        IInteger &EventCounter1EndFrameID
        IInteger &EventTimer0Start
        IInteger &EventTimer0StartTimestamp
        IInteger &EventTimer0StartFrameID
        IInteger &EventTimer1Start
        IInteger &EventTimer1StartTimestamp
        IInteger &EventTimer1StartFrameID
        IInteger &EventTimer0End
        IInteger &EventTimer0EndTimestamp
        IInteger &EventTimer0EndFrameID
        IInteger &EventTimer1End
        IInteger &EventTimer1EndTimestamp
        IInteger &EventTimer1EndFrameID
        IInteger &EventEncoder0Stopped
        IInteger &EventEncoder0StoppedTimestamp
        IInteger &EventEncoder0StoppedFrameID
        IInteger &EventEncoder1Stopped
        IInteger &EventEncoder1StoppedTimestamp
        IInteger &EventEncoder1StoppedFrameID
        IInteger &EventEncoder0Restarted
        IInteger &EventEncoder0RestartedTimestamp
        IInteger &EventEncoder0RestartedFrameID
        IInteger &EventEncoder1Restarted
        IInteger &EventEncoder1RestartedTimestamp
        IInteger &EventEncoder1RestartedFrameID
        IInteger &EventLine0RisingEdge
        IInteger &EventLine0RisingEdgeTimestamp
        IInteger &EventLine0RisingEdgeFrameID
        IInteger &EventLine1RisingEdge
        IInteger &EventLine1RisingEdgeTimestamp
        IInteger &EventLine1RisingEdgeFrameID
        IInteger &EventLine0FallingEdge
        IInteger &EventLine0FallingEdgeTimestamp
        IInteger &EventLine0FallingEdgeFrameID
        IInteger &EventLine1FallingEdge
        IInteger &EventLine1FallingEdgeTimestamp
        IInteger &EventLine1FallingEdgeFrameID
        IInteger &EventLine0AnyEdge
        IInteger &EventLine0AnyEdgeTimestamp
        IInteger &EventLine0AnyEdgeFrameID
        IInteger &EventLine1AnyEdge
        IInteger &EventLine1AnyEdgeTimestamp
        IInteger &EventLine1AnyEdgeFrameID
        IInteger &EventLinkTrigger0
        IInteger &EventLinkTrigger0Timestamp
        IInteger &EventLinkTrigger0FrameID
        IInteger &EventLinkTrigger1
        IInteger &EventLinkTrigger1Timestamp
        IInteger &EventLinkTrigger1FrameID
        IInteger &EventActionLate
        IInteger &EventActionLateTimestamp
        IInteger &EventActionLateFrameID
        IInteger &EventLinkSpeedChange
        IInteger &EventLinkSpeedChangeTimestamp
        IInteger &EventLinkSpeedChangeFrameID
        IRegister &FileAccessBuffer
        IInteger &SourceCount
        IEnumerationT[SourceSelectorEnums] &SourceSelector
        IEnumerationT[TransferSelectorEnums] &TransferSelector
        IInteger &TransferBurstCount
        ICommand &TransferAbort
        ICommand &TransferPause
        ICommand &TransferResume
        IEnumerationT[TransferTriggerSelectorEnums] &TransferTriggerSelector
        IEnumerationT[TransferTriggerModeEnums] &TransferTriggerMode
        IEnumerationT[TransferTriggerSourceEnums] &TransferTriggerSource
        IEnumerationT[TransferTriggerActivationEnums] &TransferTriggerActivation
        IEnumerationT[TransferStatusSelectorEnums] &TransferStatusSelector
        IBoolean &TransferStatus
        IEnumerationT[TransferComponentSelectorEnums] &TransferComponentSelector
        IInteger &TransferStreamChannel
        IEnumerationT[Scan3dDistanceUnitEnums] &Scan3dDistanceUnit
        IEnumerationT[Scan3dCoordinateSystemEnums] &Scan3dCoordinateSystem
        IEnumerationT[Scan3dOutputModeEnums] &Scan3dOutputMode
        IEnumerationT[Scan3dCoordinateSystemReferenceEnums] &Scan3dCoordinateSystemReference
        IEnumerationT[Scan3dCoordinateSelectorEnums] &Scan3dCoordinateSelector
        IFloat &Scan3dCoordinateScale
        IFloat &Scan3dCoordinateOffset
        IBoolean &Scan3dInvalidDataFlag
        IFloat &Scan3dInvalidDataValue
        IFloat &Scan3dAxisMin
        IFloat &Scan3dAxisMax
        IEnumerationT[Scan3dCoordinateTransformSelectorEnums] &Scan3dCoordinateTransformSelector
        IFloat &Scan3dTransformValue
        IEnumerationT[Scan3dCoordinateReferenceSelectorEnums] &Scan3dCoordinateReferenceSelector
        IFloat &Scan3dCoordinateReferenceValue
        IInteger &ChunkPartSelector
        IEnumerationT[ChunkImageComponentEnums] &ChunkImageComponent
        IInteger &ChunkPixelDynamicRangeMin
        IInteger &ChunkPixelDynamicRangeMax
        IInteger &ChunkTimestampLatchValue
        IInteger &ChunkLineStatusAll
        IEnumerationT[ChunkCounterSelectorEnums] &ChunkCounterSelector
        IInteger &ChunkCounterValue
        IEnumerationT[ChunkTimerSelectorEnums] &ChunkTimerSelector
        IFloat &ChunkTimerValue
        IEnumerationT[ChunkEncoderSelectorEnums] &ChunkEncoderSelector
        IInteger &ChunkScanLineSelector
        IInteger &ChunkEncoderValue
        IEnumerationT[ChunkEncoderStatusEnums] &ChunkEncoderStatus
        IEnumerationT[ChunkExposureTimeSelectorEnums] &ChunkExposureTimeSelector
        IInteger &ChunkLinePitch
        IEnumerationT[ChunkSourceIDEnums] &ChunkSourceID
        IEnumerationT[ChunkRegionIDEnums] &ChunkRegionID
        IInteger &ChunkTransferBlockID
        IEnumerationT[ChunkTransferStreamIDEnums] &ChunkTransferStreamID
        IInteger &ChunkTransferQueueCurrentBlockCount
        IInteger &ChunkStreamChannelID
        IEnumerationT[ChunkScan3dDistanceUnitEnums] &ChunkScan3dDistanceUnit
        IEnumerationT[ChunkScan3dOutputModeEnums] &ChunkScan3dOutputMode
        IEnumerationT[ChunkScan3dCoordinateSystemEnums] &ChunkScan3dCoordinateSystem
        IEnumerationT[ChunkScan3dCoordinateSystemReferenceEnums] &ChunkScan3dCoordinateSystemReference
        IEnumerationT[ChunkScan3dCoordinateSelectorEnums] &ChunkScan3dCoordinateSelector
        IFloat &ChunkScan3dCoordinateScale
        IFloat &ChunkScan3dCoordinateOffset
        IBoolean &ChunkScan3dInvalidDataFlag
        IFloat &ChunkScan3dInvalidDataValue
        IFloat &ChunkScan3dAxisMin
        IFloat &ChunkScan3dAxisMax
        IEnumerationT[ChunkScan3dCoordinateTransformSelectorEnums] &ChunkScan3dCoordinateTransformSelector
        IFloat &ChunkScan3dTransformValue
        IEnumerationT[ChunkScan3dCoordinateReferenceSelectorEnums] &ChunkScan3dCoordinateReferenceSelector
        IFloat &ChunkScan3dCoordinateReferenceValue
        IInteger &TestPendingAck
        IEnumerationT[DeviceTapGeometryEnums] &DeviceTapGeometry
        IEnumerationT[GevPhysicalLinkConfigurationEnums] &GevPhysicalLinkConfiguration
        IEnumerationT[GevCurrentPhysicalLinkConfigurationEnums] &GevCurrentPhysicalLinkConfiguration
        IInteger &GevActiveLinkCount
        IBoolean &GevPAUSEFrameReception
        IBoolean &GevPAUSEFrameTransmission
        IEnumerationT[GevIPConfigurationStatusEnums] &GevIPConfigurationStatus
        IInteger &GevDiscoveryAckDelay
        IEnumerationT[GevGVCPExtendedStatusCodesSelectorEnums] &GevGVCPExtendedStatusCodesSelector
        IBoolean &GevGVCPExtendedStatusCodes
        IInteger &GevPrimaryApplicationSwitchoverKey
        IEnumerationT[GevGVSPExtendedIDModeEnums] &GevGVSPExtendedIDMode
        IInteger &GevPrimaryApplicationSocket
        IInteger &GevPrimaryApplicationIPAddress
        IBoolean &GevSCCFGPacketResendDestination
        IBoolean &GevSCCFGAllInTransmission
        IInteger &GevSCZoneCount
        IInteger &GevSCZoneDirectionAll
        IBoolean &GevSCZoneConfigurationLock
        IInteger &aPAUSEMACCtrlFramesTransmitted
        IInteger &aPAUSEMACCtrlFramesReceived
        IEnumerationT[ClConfigurationEnums] &ClConfiguration
        IEnumerationT[ClTimeSlotsCountEnums] &ClTimeSlotsCount
        IEnumerationT[CxpLinkConfigurationStatusEnums] &CxpLinkConfigurationStatus
        IEnumerationT[CxpLinkConfigurationPreferredEnums] &CxpLinkConfigurationPreferred
        IEnumerationT[CxpLinkConfigurationEnums] &CxpLinkConfiguration
        IInteger &CxpConnectionSelector
        IEnumerationT[CxpConnectionTestModeEnums] &CxpConnectionTestMode
        IInteger &CxpConnectionTestErrorCount
        IInteger &CxpConnectionTestPacketCount
        ICommand &CxpPoCxpAuto
        ICommand &CxpPoCxpTurnOff
        ICommand &CxpPoCxpTripReset
        IEnumerationT[CxpPoCxpStatusEnums] &CxpPoCxpStatus
        IInteger &ChunkInferenceFrameId
        IInteger &ChunkInferenceResult
        IFloat &ChunkInferenceConfidence
        IRegister &ChunkInferenceBoundingBoxResult


cdef extern from "CameraList.h" namespace "Spinnaker" nogil:
    cdef cppclass CCameraList "Spinnaker::CameraList":
        CameraList() except +raise_spin_exc
        unsigned int GetSize() except +raise_spin_exc
        CameraPtr GetByIndex(unsigned int index) except +raise_spin_exc
        CameraPtr GetBySerial(cstr serialNumber) except +raise_spin_exc
        CameraPtr GetByDeviceID(cstr deviceID) except +raise_spin_exc
        void Clear() except +raise_spin_exc
        void RemoveByIndex(unsigned int index) except +raise_spin_exc
        void RemoveBySerial(cstr serialNumber) except +raise_spin_exc
        void RemoveByDeviceID(cstr deviceID) except +raise_spin_exc
        void Append(const CCameraList& list) except +raise_spin_exc


cdef extern from "TransportLayerInterface.h" namespace "Spinnaker" nogil:
    cdef cppclass TransportLayerInterface:
        IString & InterfaceID
        IString & InterfaceDisplayName
        IEnumerationT[InterfaceTypeEnum] & InterfaceType
        IInteger & GevInterfaceGatewaySelector
        IInteger & GevInterfaceGateway
        IInteger & GevInterfaceMACAddress
        IInteger & GevInterfaceSubnetSelector
        IInteger & GevInterfaceSubnetIPAddress
        IInteger & GevInterfaceSubnetMask
        IInteger & GevInterfaceTransmitLinkSpeed
        IInteger & GevInterfaceReceiveLinkSpeed
        IInteger & GevInterfaceMTU
        IEnumerationT[POEStatusEnum] & POEStatus
        IEnumerationT[FilterDriverStatusEnum] & FilterDriverStatus
        IInteger & GevActionDeviceKey
        IInteger & GevActionGroupKey
        IInteger & GevActionGroupMask
        IInteger & GevActionTime
        ICommand & ActionCommand
        IString & DeviceUnlock
        ICommand & DeviceUpdateList
        IInteger & DeviceCount
        IInteger & DeviceSelector
        IString & DeviceID
        IString & DeviceVendorName
        IString & DeviceModelName
        IString & DeviceSerialNumber
        IEnumerationT[DeviceAccessStatusEnum] & DeviceAccessStatus
        IInteger & GevDeviceIPAddress
        IInteger & GevDeviceSubnetMask
        IInteger & GevDeviceGateway
        IInteger & GevDeviceMACAddress
        IInteger & IncompatibleDeviceCount
        IInteger & IncompatibleDeviceSelector
        IString & IncompatibleDeviceID
        IString & IncompatibleDeviceVendorName
        IString & IncompatibleDeviceModelName
        IInteger & IncompatibleGevDeviceIPAddress
        IInteger & IncompatibleGevDeviceSubnetMask
        IInteger & IncompatibleGevDeviceMACAddress
        ICommand & GevDeviceForceIP
        IInteger & GevDeviceForceIPAddress
        IInteger & GevDeviceForceSubnetMask
        IInteger & GevDeviceForceGateway
        ICommand & GevDeviceAutoForceIP
        IString & HostAdapterName
        IString & HostAdapterVendor
        IString & HostAdapterDriverVersion


cdef extern from "InterfacePtr.h" namespace "Spinnaker" nogil:
    pass


cdef extern from "Interface.h" namespace "Spinnaker" nogil:
    cdef cppclass InterfacePtr:
        InterfacePtr() except +raise_spin_exc
        CInterface * get() const
        cbool IsValid() except +raise_spin_exc

    cdef cppclass CInterface "Spinnaker::Interface":
        CCameraList GetCameras(cbool updateCameras) except +raise_spin_exc
        cbool UpdateCameras() except +raise_spin_exc
        void RegisterEventHandler(CEventHandler& evtHandlerToRegister) except +raise_spin_exc
        void UnregisterEventHandler(CEventHandler& evtHandlerToUnregister) except +raise_spin_exc
        cbool IsInUse() except +raise_spin_exc
        INodeMap& GetTLNodeMap() except +raise_spin_exc
        void SendActionCommand(
                unsigned int deviceKey,
                unsigned int groupKey,
                unsigned int groupMask,
                unsigned long long actionTime,
                unsigned int * pResultSize,
                ActionCommandResult results[]) except +raise_spin_exc
        cbool IsValid() except +raise_spin_exc

        TransportLayerInterface TLInterface


cdef extern from "InterfaceList.h" namespace "Spinnaker" nogil:
    cdef cppclass CInterfaceList "Spinnaker::InterfaceList":
        InterfaceList() except +raise_spin_exc
        unsigned int GetSize() except +raise_spin_exc
        InterfacePtr GetByIndex(unsigned int index) except +raise_spin_exc
        void Clear() except +raise_spin_exc
        void Append(const CInterfaceList * list) except +raise_spin_exc


cdef extern from "EventHandler.h" namespace "Spinnaker" nogil:
    cdef cppclass CEventHandler "Spinnaker::EventHandler":
        EventType GetEventType() except +raise_spin_exc
        const uint8_t * GetEventPayloadData() except +raise_spin_exc
        const size_t GetEventPayloadDataSize() except +raise_spin_exc


cdef extern from "Interface/ISystemEventHandler.h" namespace "Spinnaker" nogil:
    cdef cppclass ISystemEventHandler(CEventHandler):
        pass


cdef extern from "SystemEventHandler.h" namespace "Spinnaker" nogil:
    cdef cppclass CSystemEventHandler "Spinnaker::SystemEventHandler"(ISystemEventHandler):
        pass


cdef extern from "Interface/IInterfaceEventHandler.h" namespace "Spinnaker" nogil:
    cdef cppclass IInterfaceEventHandler(CEventHandler):
        pass


cdef extern from "InterfaceEventHandler.h" namespace "Spinnaker" nogil:
    cdef cppclass CInterfaceEventHandler "Spinnaker::InterfaceEventHandler"(IInterfaceEventHandler):
        pass


cdef extern from "Interface/IDeviceEventHandler.h" namespace "Spinnaker" nogil:
    cdef cppclass IDeviceEventHandler(CEventHandler):
        uint64_t GetDeviceEventId() except +raise_spin_exc
        gcstring GetDeviceEventName() except +raise_spin_exc


cdef extern from "DeviceEventHandler.h" namespace "Spinnaker" nogil:
    cdef cppclass CDeviceEventHandler "Spinnaker::DeviceEventHandler"(IDeviceEventHandler):
        pass


cdef extern from "LoggingEventDataPtr.h" namespace "Spinnaker" nogil:
    pass


cdef extern from "LoggingEventData.h" namespace "Spinnaker" nogil:
    cdef cppclass LoggingEventDataPtr:
        LoggingEventDataPtr() except +raise_spin_exc
        LoggingEventData * get() const
        cbool IsValid() except +raise_spin_exc

    cdef cppclass LoggingEventData:
        const char * GetCategoryName() except +raise_spin_exc
        const char * GetLogMessage() except +raise_spin_exc
        const char * GetNDC() except +raise_spin_exc
        const int GetPriority() except +raise_spin_exc
        const char * GetThreadName() except +raise_spin_exc
        const char * GetTimestamp() except +raise_spin_exc
        const char * GetPriorityName() except +raise_spin_exc


cdef extern from "Interface/ILoggingEventHandler.h" namespace "Spinnaker" nogil:
    cdef cppclass ILoggingEventHandler(CEventHandler):
        pass


cdef extern from "LoggingEventHandler.h" namespace "Spinnaker" nogil:
    cdef cppclass CLoggingEventHandler "Spinnaker::LoggingEventHandler"(ILoggingEventHandler):
        pass


cdef extern from "Interface/IImageEventHandler.h" namespace "Spinnaker" nogil:
    cdef cppclass IImageEventHandler(CEventHandler):
        pass


cdef extern from "ImageEventHandler.h" namespace "Spinnaker" nogil:
    cdef cppclass CImageEventHandler "Spinnaker::ImageEventHandler"(IImageEventHandler):
        pass


cdef extern from "TransportLayerSystem.h" namespace "Spinnaker" nogil:
    cdef cppclass TransportLayerSystem:
        IString & TLID
        IString & TLVendorName
        IString & TLModelName
        IString & TLVersion
        IString & TLFileName
        IString & TLDisplayName
        IString & TLPath
        IEnumerationT[TLTypeEnum] & TLType
        IInteger & GenTLVersionMajor
        IInteger & GenTLVersionMinor
        IInteger & GenTLSFNCVersionMajor
        IInteger & GenTLSFNCVersionMinor
        IInteger & GenTLSFNCVersionSubMinor
        IInteger & GevVersionMajor
        IInteger & GevVersionMinor
        ICommand & InterfaceUpdateList
        IInteger & InterfaceSelector
        IString & InterfaceID
        IString & InterfaceDisplayName
        IInteger & GevInterfaceMACAddress
        IInteger & GevInterfaceDefaultIPAddress
        IInteger & GevInterfaceDefaultSubnetMask
        IInteger & GevInterfaceDefaultGateway
        IBoolean & EnumerateGEVInterfaces
        IBoolean & EnumerateUSBInterfaces
        IBoolean & EnumerateGen2Cameras


cdef extern from "SystemPtr.h" namespace "Spinnaker" nogil:
    pass


cdef extern from "System.h" namespace "Spinnaker" nogil:
    cdef cppclass SystemPtr:
        SystemPtr() except +raise_spin_exc
        CSystem * get() const
        cbool IsValid() except +raise_spin_exc

    cdef cppclass CSystem "Spinnaker::System":
        @staticmethod
        SystemPtr GetInstance() except +raise_spin_exc
        void ReleaseInstance() except +raise_spin_exc
        cbool IsInUse() except +raise_spin_exc
        void SetLoggingEventPriorityLevel(SpinnakerLogLevel level) except +raise_spin_exc
        SpinnakerLogLevel GetLoggingEventPriorityLevel() except +raise_spin_exc
        void UnregisterAllLoggingEventHandlers() except +raise_spin_exc
        CInterfaceList GetInterfaces(cbool updateInterface) except +raise_spin_exc
        void UpdateInterfaceList() except +raise_spin_exc
        cbool UpdateCameras(cbool updateInterfaces) except +raise_spin_exc
        CCameraList GetCameras(cbool updateInterfaces, cbool updateCameras) except +raise_spin_exc
        const LibraryVersion GetLibraryVersion() except +raise_spin_exc
        INodeMap& GetTLNodeMap() except +raise_spin_exc
        void RegisterEventHandler(CEventHandler& evtHandlerToRegister) except +raise_spin_exc
        void UnregisterEventHandler(CEventHandler& evtHandlerToUnregister) except +raise_spin_exc
        void RegisterInterfaceEventHandler(CEventHandler& evtHandlerToRegister, cbool updateInterface) except +raise_spin_exc
        void UnregisterInterfaceEventHandler(CEventHandler& evtHandlerToUnregister) except +raise_spin_exc
        void RegisterLoggingEventHandler(CLoggingEventHandler& handler) except +raise_spin_exc
        void UnregisterLoggingEventHandler(CLoggingEventHandler& handler) except +raise_spin_exc
        void SendActionCommand(
                unsigned int deviceKey,
                unsigned int groupKey,
                unsigned int groupMask,
                unsigned long long actionTime,
                unsigned int * pResultSize,
                ActionCommandResult results[]) except +raise_spin_exc

        TransportLayerSystem TLSystem


cdef extern from "DeviceEventUtility.h" namespace "Spinnaker" nogil:
    cdef cppclass DeviceEventUtility:
        @staticmethod
        void ParseDeviceEventInference(const uint8_t* payloadData, const size_t payloadSize, DeviceEventInferenceData& eventData) except +raise_spin_exc
        @staticmethod
        void ParseDeviceEventExposureEnd(const uint8_t* payloadData, const size_t payloadSize, DeviceEventExposureEndData& eventData) except +raise_spin_exc
