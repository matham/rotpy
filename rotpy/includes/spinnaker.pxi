from libcpp cimport bool as cbool
from libcpp.string cimport string as cstr
from libc.stdint cimport int64_t, uint64_t, uint8_t, uint32_t

cdef extern from "SpinGenApi/GCString.h" namespace "Spinnaker::GenICam" nogil:
    cdef cppclass gcstring:
        gcstring() except +
        const char * c_str() except +
        gcstring& assign(const char * pc, size_t n) except +


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
