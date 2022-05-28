from libcpp cimport bool as cbool
from libcpp.string cimport string as cstr
from libc.stdint cimport int64_t, uint64_t, uint8_t, uint32_t

cdef extern from "SpinGenApi/GCString.h" namespace "Spinnaker::GenICam" nogil:
    cdef cppclass gcstring:
        gcstring() except +
        const char * c_str() except +


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
