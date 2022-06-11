from libcpp cimport bool as cbool
from libcpp.string cimport string as cstr
from libc.stdint cimport int64_t, uint64_t, uint8_t, uint32_t

cdef extern from "SpinGenApi/GCString.h" namespace "Spinnaker::GenICam" nogil:
    cdef cppclass gcstring:
        gcstring() except +
        const char * c_str() except +
        gcstring& assign(const char * pc, size_t n) except +
        cbool operator ==(const char * pc) except +


cdef extern from "SpinGenApi/GCStringVector.h" namespace "Spinnaker::GenICam" nogil:
    cdef cppclass gcstring_vector:
        gcstring& at(size_t uiIndex) except +
        size_t size() except +


cdef extern from "SpinGenApi/Autovector.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass int64_autovector_t:
        int64_t& operator[](size_t uiIndex) except +
        size_t size() except +

    cdef cppclass double_autovector_t:
        double& operator[](size_t uiIndex) except +
        size_t size() except +


cdef extern from "SpinGenApi/INode.h" namespace "Spinnaker::GenApi" nogil:
    pass


cdef extern from "SpinGenApi/Container.h" namespace "Spinnaker::GenApi" nogil:
    ctypedef value_vector FeatureList_t


cdef extern from "SpinGenApi/Reference.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass IReference:
        void SetReference(INode * pBase) except +

    cdef cppclass IEnumReference:
        void SetEnumReference(int Index, gcstring Name) except +
        void SetNumEnums(int NumEnums) except +


cdef extern from "SpinGenApi/Base.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass IBase:
        EAccessMode GetAccessMode() except +


cdef extern from "SpinGenApi/ISelector.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass ISelector(IBase):
        cbool IsSelector() except +
        void GetSelectedFeatures(FeatureList_t&) except +
        void GetSelectingFeatures(FeatureList_t&) except +


cdef extern from "SpinGenApi/INode.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass INode(ISelector, IReference):
        gcstring GetName(cbool FullQualified) except +
        EInterfaceType GetPrincipalInterfaceType() except +
        ENameSpace GetNameSpace() except +
        EVisibility GetVisibility() except +
        void InvalidateNode() except +
        ECachingMode GetCachingMode() except +
        gcstring GetToolTip() except +
        gcstring GetDescription() except +
        gcstring GetDisplayName() except +
        gcstring GetDeviceName() except +
        gcstring GetDocuURL() except +
        cbool IsDeprecated() except +
        cbool IsFeature() except +
        INode * GetCastAlias() except +
        INode * GetAlias() except +
        void ImposeVisibility(EVisibility ImposedVisibility) except +
        void ImposeAccessMode(EAccessMode ImposedAccessMode) except +
        cbool IsStreamable() except +
        gcstring GetEventID() except +
        INodeMap * GetNodeMap() except +
        int64_t GetPollingTime() except +
        EYesNo IsAccessModeCacheable() except +
        cbool IsCachable() except +
        void GetPropertyNames(gcstring_vector& PropertyNames) except +
        cbool GetProperty(const gcstring& PropertyName, gcstring& ValueStr, gcstring& AttributeStr) except +

    ctypedef node_vector NodeList_t


cdef extern from "SpinGenApi/IValue.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass IValue(INode):
        INode* GetNode() except +
        gcstring ToString(cbool Verify, cbool IgnoreCache) except +
        void FromString(const gcstring& ValueStr, cbool Verify) except +
        cbool IsValueCacheValid() except +


cdef extern from "SpinGenApi/IInteger.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass IInteger(IValue):
        void SetValue(int64_t Value, cbool Verify) except +
        int64_t GetValue(cbool Verify, cbool IgnoreCache) except +
        int64_t GetMin() except +
        int64_t GetMax() except +
        EIncMode GetIncMode() except +
        int64_t GetInc() except +
        int64_autovector_t GetListOfValidValues(cbool bounded) except +
        ERepresentation GetRepresentation() except +
        gcstring GetUnit() except +
        void ImposeMin(int64_t Value) except +
        void ImposeMax(int64_t Value) except +


cdef extern from "SpinGenApi/IFloat.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass IFloat(IValue):
        void SetValue(double Value, cbool Verify) except +
        double GetValue(cbool Verify, cbool IgnoreCache) except +
        double GetMin() except +
        double GetMax() except +
        cbool HasInc() except +
        EIncMode GetIncMode() except +
        double GetInc() except +
        double_autovector_t GetListOfValidValues(cbool bounded) except +
        ERepresentation GetRepresentation() except +
        gcstring GetUnit() except +
        void ImposeMin(double Value) except +
        void ImposeMax(double Value) except +
        EDisplayNotation GetDisplayNotation() except +
        int64_t GetDisplayPrecision() except +


cdef extern from "SpinGenApi/IBoolean.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass IBoolean(IValue):
        void SetValue(cbool Value, cbool Verify) except +
        cbool GetValue(cbool Verify, cbool IgnoreCache) except +


cdef extern from "SpinGenApi/IString.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass IString(IValue):
        void SetValue(const gcstring& Value, cbool Verify) except +
        gcstring GetValue(cbool Verify, cbool IgnoreCache) except +
        int64_t GetMaxLength() except +


cdef extern from "SpinGenApi/ICommand.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass ICommand(IValue):
        void Execute(cbool Verify) except +
        cbool IsDone(cbool Verify) except +


cdef extern from "SpinGenApi/IRegister.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass IRegister(IValue):
        void Set(const uint8_t* pBuffer, int64_t Length, cbool Verify) except +
        void Get(uint8_t * pBuffer, int64_t Length, cbool Verify, cbool IgnoreCache) except +
        int64_t GetLength() except +
        int64_t GetAddress() except +


cdef extern from "SpinGenApi/Container.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass node_vector:
        INode*& at(size_t uiIndex) except +
        size_t size() except +

    cdef cppclass value_vector:
        IValue*& at(size_t uiIndex) except +
        size_t size() except +


cdef extern from "SpinGenApi/Types.h" namespace "Spinnaker::GenApi" nogil:
    ctypedef gcstring_vector StringList_t


cdef extern from "SpinGenApi/IEnumeration.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass IEnumeration(IValue):
        void GetSymbolics(StringList_t& Symbolics) except +
        void GetEntries(NodeList_t& Entries) except +
        void SetIntValue(int64_t Value, cbool Verify) except +
        int64_t GetIntValue(cbool Verify, cbool IgnoreCache) except +
        IEnumEntry* GetEntryByName(const gcstring& Symbolic) except +
        IEnumEntry* GetEntry(const int64_t IntValue) except +
        IEnumEntry* GetCurrentEntry(cbool Verify, cbool IgnoreCache) except +


cdef extern from "SpinGenApi/IEnumerationT.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass IEnumerationT[EnumT](IEnumeration, IEnumReference):
        void SetValue(EnumT Value, cbool Verify) except +
        EnumT GetValue(cbool Verify, cbool IgnoreCache) except +
        IEnumeration* operator=(const gcstring& ValueStr) except +
        IEnumEntry* GetEntry(const int64_t IntValue) except +
        IEnumEntry* GetEntry(const EnumT Value) except +
        IEnumEntry* GetCurrentEntry(cbool Verify, cbool IgnoreCache) except +


cdef extern from "SpinGenApi/IEnumEntry.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass IEnumEntry(IValue):
        int64_t GetValue() except +
        gcstring GetSymbolic() except +
        double GetNumericValue() except +
        cbool IsSelfClearing() except +


cdef extern from "SpinGenApi/ICategory.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass ICategory(IValue):
        void GetFeatures(FeatureList_t& Features) except +


cdef extern from "SpinGenApi/IPort.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass IPort(IBase):
        void Read(void * pBuffer, int64_t Address, int64_t Length) except +
        void Write(const void * pBuffer, int64_t Address, int64_t Length) except +


cdef extern from "SpinGenApi/INodeMap.h" namespace "Spinnaker::GenApi" nogil:
    cdef cppclass INodeMap:
        void GetNodes(NodeList_t& Nodes) except +
        INode * GetNode(const gcstring& Name) except +
        void InvalidateNodes() except +
        # cbool Connect(IPort * pPort, const gcstring& PortName) except +
        # cbool Connect(IPort * pPort) except +
        gcstring GetDeviceName() except +
        void Poll(int64_t ElapsedTime) except +
        uint64_t GetNumNodes() except +


cdef extern from "Exception.h" namespace "Spinnaker" nogil:
    cdef cppclass CException "Spinnaker::Exception":
        Exception() except +
        const char * GetFullErrorMessage() except +
        const char * GetErrorMessage() except +
        const char * GetFileName() except +
        const char * GetFunctionName() except +
        const char * GetBuildDate() except +
        const char * GetBuildTime() except +
        int GetLineNumber() except +
        Error GetError() except +


cdef extern from "Image.h" namespace "Spinnaker" nogil:
    cdef cppclass ImagePtr:
        ImagePtr() except +
        CImage * get() const
        cbool IsValid() except +

    cdef cppclass CImage "Spinnaker::Image":
        @staticmethod
        ImagePtr Create0 "Create"() except +
        @staticmethod
        ImagePtr Create1 "Create"(const ImagePtr image) except +
        @staticmethod
        ImagePtr Create6 "Create"(
            size_t width,
            size_t height,
            size_t offsetX,
            size_t offsetY,
            PixelFormatEnums pixelFormat,
            void* pData
        ) except +
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
        ) except +
        @staticmethod
        void SetDefaultColorProcessing(ColorProcessingAlgorithm colorAlgorithm) except +
        @staticmethod
        ColorProcessingAlgorithm GetDefaultColorProcessing() except +
        @staticmethod
        void SetNumDecompressionThreads(unsigned int numThreads) except +
        @staticmethod
        unsigned int GetNumDecompressionThreads() except +
        @staticmethod
        const char * GetImageStatusDescription(ImageStatus status) except +

        ColorProcessingAlgorithm GetColorProcessing() except +
        ImagePtr Convert(PixelFormatEnums format, ColorProcessingAlgorithm colorAlgorithm) except +
        void Convert(
            ImagePtr destinationImage,
            PixelFormatEnums format,
            ColorProcessingAlgorithm colorAlgorithm
        ) except +
        void ResetImage(
            size_t width,
            size_t height,
            size_t offsetX,
            size_t offsetY,
            PixelFormatEnums pixelFormat
        ) except +
        void ResetImage(
            size_t width,
            size_t height,
            size_t offsetX,
            size_t offsetY,
            PixelFormatEnums pixelFormat,
            void* pData
        ) except +
        void ResetImage(
            size_t width,
            size_t height,
            size_t offsetX,
            size_t offsetY,
            PixelFormatEnums pixelFormat,
            void* pData,
            PayloadTypeInfoIDs dataPayloadType,
            size_t dataSize
        ) except +
        void Release() except +
        uint64_t GetID() except +
        void * GetData() except +
        float GetDataAbsoluteMax() except +
        float GetDataAbsoluteMin() except +
        void * GetPrivateData() except +
        size_t GetBufferSize() except +
        void DeepCopy(const ImagePtr pSrcImage) except +
        size_t GetWidth() except +
        size_t GetHeight() except +
        size_t GetStride() except +
        size_t GetBitsPerPixel() except +
        size_t GetNumChannels() except +
        size_t GetXOffset() except +
        size_t GetYOffset() except +
        size_t GetXPadding() except +
        size_t GetYPadding() except +
        uint64_t GetFrameID() except +
        size_t GetPayloadType() except +
        PayloadTypeInfoIDs GetTLPayloadType() except +
        uint64_t GetTLPixelFormat() except +
        PixelFormatNamespaceID GetTLPixelFormatNamespace() except +
        gcstring GetPixelFormatName() except +
        PixelFormatEnums GetPixelFormat() except +
        PixelFormatIntType GetPixelFormatIntType() except +
        cbool IsIncomplete() except +
        size_t GetValidPayloadSize() except +
        uint64_t GetChunkLayoutId() except +
        uint64_t GetTimeStamp() except +
        cbool HasCRC() except +
        cbool CheckCRC() except +
        size_t GetImageSize() except +
        cbool IsInUse() except +
        ImageStatus GetImageStatus() except +
        cbool IsCompressed() except +


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
        CameraPtr() except +
        CCamera * get() const
        cbool IsValid() except +

    cdef cppclass CCamera "Spinnaker::Camera":
        void Init() except +
        void DeInit() except +
        cbool IsInitialized() except +
        cbool IsValid() except +
        void ReadPort(uint64_t iAddress, void * pBuffer, size_t iSize) except +
        void WritePort(uint64_t iAddress, const void * pBuffer, size_t iSize) except +
        void BeginAcquisition() except +
        void EndAcquisition() except +
        unsigned int DiscoverMaxPacketSize() except +
        void ForceIP() except +
        EAccessMode GetAccessMode() except +
        BufferOwnership GetBufferOwnership() except +
        void SetBufferOwnership(const BufferOwnership mode) except +
        uint64_t GetUserBufferCount() except +
        uint64_t GetUserBufferSize() except +
        uint64_t GetUserBufferTotalSize() except +
        gcstring GetUniqueID() except +
        cbool IsStreaming() except +
        gcstring GetGuiXml() except +
        unsigned int GetNumImagesInUse() except +
        unsigned int GetNumDataStreams() except +
        ImagePtr GetNextImage(uint64_t grabTimeout, uint64_t streamID) except +
        INodeMap& GetNodeMap() except +
        INodeMap& GetTLDeviceNodeMap() except +
        INodeMap& GetTLStreamNodeMap() except +
        void RegisterEventHandler(CEventHandler& evtHandlerToRegister) except +
        void RegisterEventHandler(CEventHandler& evtHandlerToRegister, const gcstring &eventName) except +
        void UnregisterEventHandler(CEventHandler& evtHandlerToUnregister) except +

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
        CameraList() except +
        unsigned int GetSize() except +
        CameraPtr GetByIndex(unsigned int index) except +
        CameraPtr GetBySerial(cstr serialNumber) except +
        CameraPtr GetByDeviceID(cstr deviceID) except +
        void Clear() except +
        void RemoveByIndex(unsigned int index) except +
        void RemoveBySerial(cstr serialNumber) except +
        void RemoveByDeviceID(cstr deviceID) except +
        void Append(const CCameraList& list) except +


cdef extern from "InterfacePtr.h" namespace "Spinnaker" nogil:
    pass


cdef extern from "Interface.h" namespace "Spinnaker" nogil:
    cdef cppclass InterfacePtr:
        InterfacePtr() except +
        CInterface * get() const
        cbool IsValid() except +

    cdef cppclass CInterface "Spinnaker::Interface":
        # CameraList GetCameras(cbool updateCameras) except +
        # cbool UpdateCameras() except +
        # void RegisterEventHandler(EventHandler& evtHandlerToRegister) except +
        # void UnregisterEventHandler(EventHandler& evtHandlerToUnregister) except +
        cbool IsInUse() except +
        # void SendActionCommand(
        #         unsigned int deviceKey,
        #         unsigned int groupKey,
        #         unsigned int groupMask,
        #         unsigned long long actionTime,
        #         unsigned int * pResultSize,
        #         ActionCommandResult results[]) except +
        # cbool IsValid() except +


cdef extern from "InterfaceList.h" namespace "Spinnaker" nogil:
    cdef cppclass CInterfaceList "Spinnaker::InterfaceList":
        InterfaceList() except +
        unsigned int GetSize() except +
        InterfacePtr GetByIndex(unsigned int index) except +
        void Clear() except +
        void Append(const CInterfaceList * list) except +


cdef extern from "EventHandler.h" namespace "Spinnaker" nogil:
    cdef cppclass CEventHandler "Spinnaker::EventHandler":
        EventType GetEventType() except +
        const uint8_t * GetEventPayloadData() except +
        const size_t GetEventPayloadDataSize() except +


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
        uint64_t GetDeviceEventId() except +
        gcstring GetDeviceEventName() except +


cdef extern from "DeviceEventHandler.h" namespace "Spinnaker" nogil:
    cdef cppclass CDeviceEventHandler "Spinnaker::DeviceEventHandler"(IDeviceEventHandler):
        pass


cdef extern from "LoggingEventDataPtr.h" namespace "Spinnaker" nogil:
    pass


cdef extern from "LoggingEventData.h" namespace "Spinnaker" nogil:
    cdef cppclass LoggingEventDataPtr:
        LoggingEventDataPtr() except +
        LoggingEventData * get() const
        cbool IsValid() except +

    cdef cppclass LoggingEventData:
        const char * GetCategoryName() except +
        const char * GetLogMessage() except +
        const char * GetNDC() except +
        const int GetPriority() except +
        const char * GetThreadName() except +
        const char * GetTimestamp() except +
        const char * GetPriorityName() except +


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


cdef extern from "SystemPtr.h" namespace "Spinnaker" nogil:
    pass


cdef extern from "System.h" namespace "Spinnaker" nogil:
    cdef cppclass SystemPtr:
        SystemPtr() except +
        CSystem * get() const
        cbool IsValid() except +

    cdef cppclass CSystem "Spinnaker::System":
        @staticmethod
        SystemPtr GetInstance() except +
        void ReleaseInstance() except +
        cbool IsInUse() except +
        void SetLoggingEventPriorityLevel(SpinnakerLogLevel level) except +
        SpinnakerLogLevel GetLoggingEventPriorityLevel() except +
        void UnregisterAllLoggingEventHandlers() except +
        CInterfaceList GetInterfaces(cbool updateInterface) except +
        void UpdateInterfaceList() except +
        cbool UpdateCameras(cbool updateInterfaces) except +
        CCameraList GetCameras(cbool updateInterfaces, cbool updateCameras) except +
        const LibraryVersion GetLibraryVersion() except +
        INodeMap& GetTLNodeMap() except +
        void RegisterEventHandler(CEventHandler& evtHandlerToRegister) except +
        void UnregisterEventHandler(CEventHandler& evtHandlerToUnregister) except +
        void RegisterInterfaceEventHandler(CEventHandler& evtHandlerToRegister, cbool updateInterface) except +
        void UnregisterInterfaceEventHandler(CEventHandler& evtHandlerToUnregister) except +
        void RegisterLoggingEventHandler(CLoggingEventHandler& handler) except +
        void UnregisterLoggingEventHandler(CLoggingEventHandler& handler) except +
        void SendActionCommand(
                unsigned int deviceKey,
                unsigned int groupKey,
                unsigned int groupMask,
                unsigned long long actionTime,
                unsigned int * pResultSize,
                ActionCommandResult results[]) except +


cdef extern from "DeviceEventUtility.h" namespace "Spinnaker" nogil:
    cdef cppclass DeviceEventUtility:
        @staticmethod
        void ParseDeviceEventInference(const uint8_t* payloadData, const size_t payloadSize, DeviceEventInferenceData& eventData) except +
        @staticmethod
        void ParseDeviceEventExposureEnd(const uint8_t* payloadData, const size_t payloadSize, DeviceEventExposureEndData& eventData) except +
