cdef extern from "SpinnakerDefsC.h" nogil:

    ctypedef uint8_t bool8_t

    ctypedef void* spinSystem

    ctypedef void* spinInterfaceList

    ctypedef void* spinInterface

    ctypedef void* spinCameraList

    ctypedef void* spinCamera

    ctypedef void* spinImage

    ctypedef void* spinImageStatistics

    ctypedef void* spinDeviceEventHandler

    ctypedef void* spinImageEventHandler

    ctypedef void* spinDeviceArrivalEventHandler

    ctypedef void* spinDeviceRemovalEventHandler

    ctypedef void* spinInterfaceEventHandler

    ctypedef void* spinLogEventHandler

    ctypedef void* spinLogEventData

    ctypedef void* spinDeviceEventData

    ctypedef void* spinVideo

    ctypedef void (*spinDeviceEventFunction)(const spinDeviceEventData hEventData, const char* pEventName, void* pUserData)

    ctypedef void (*spinImageEventFunction)(const spinImage hImage, void* pUserData)

    ctypedef void (*spinArrivalEventFunction)(uint64_t deviceSerialNumber, void* pUserData)

    ctypedef void (*spinRemovalEventFunction)(uint64_t deviceSerialNumber, void* pUserData)

    ctypedef void (*spinLogEventFunction)(const spinLogEventData hEventData, void* pUserData)

    cpdef enum _spinError:
        SPINNAKER_ERR_SUCCESS = 0
        SPINNAKER_ERR_ERROR = -1001
        SPINNAKER_ERR_NOT_INITIALIZED = -1002
        SPINNAKER_ERR_NOT_IMPLEMENTED = -1003
        SPINNAKER_ERR_RESOURCE_IN_USE = -1004
        SPINNAKER_ERR_ACCESS_DENIED = -1005
        SPINNAKER_ERR_INVALID_HANDLE = -1006
        SPINNAKER_ERR_INVALID_ID = -1007
        SPINNAKER_ERR_NO_DATA = -1008
        SPINNAKER_ERR_INVALID_PARAMETER = -1009
        SPINNAKER_ERR_IO = -1010
        SPINNAKER_ERR_TIMEOUT = -1011
        SPINNAKER_ERR_ABORT = -1012
        SPINNAKER_ERR_INVALID_BUFFER = -1013
        SPINNAKER_ERR_NOT_AVAILABLE = -1014
        SPINNAKER_ERR_INVALID_ADDRESS = -1015
        SPINNAKER_ERR_BUFFER_TOO_SMALL = -1016
        SPINNAKER_ERR_INVALID_INDEX = -1017
        SPINNAKER_ERR_PARSING_CHUNK_DATA = -1018
        SPINNAKER_ERR_INVALID_VALUE = -1019
        SPINNAKER_ERR_RESOURCE_EXHAUSTED = -1020
        SPINNAKER_ERR_OUT_OF_MEMORY = -1021
        SPINNAKER_ERR_BUSY = -1022
        GENICAM_ERR_INVALID_ARGUMENT = -2001
        GENICAM_ERR_OUT_OF_RANGE = -2002
        GENICAM_ERR_PROPERTY = -2003
        GENICAM_ERR_RUN_TIME = -2004
        GENICAM_ERR_LOGICAL = -2005
        GENICAM_ERR_ACCESS = -2006
        GENICAM_ERR_TIMEOUT = -2007
        GENICAM_ERR_DYNAMIC_CAST = -2008
        GENICAM_ERR_GENERIC = -2009
        GENICAM_ERR_BAD_ALLOCATION = -2010
        SPINNAKER_ERR_IM_CONVERT = -3001
        SPINNAKER_ERR_IM_COPY = -3002
        SPINNAKER_ERR_IM_MALLOC = -3003
        SPINNAKER_ERR_IM_NOT_SUPPORTED = -3004
        SPINNAKER_ERR_IM_HISTOGRAM_RANGE = -3005
        SPINNAKER_ERR_IM_HISTOGRAM_MEAN = -3006
        SPINNAKER_ERR_IM_MIN_MAX = -3007
        SPINNAKER_ERR_IM_COLOR_CONVERSION = -3008
        SPINNAKER_ERR_CUSTOM_ID = -10000
    ctypedef _spinError spinError

    cpdef enum _spinColorProcessingAlgorithm:
        DEFAULT
        NO_COLOR_PROCESSING
        NEAREST_NEIGHBOR
        NEAREST_NEIGHBOR_AVG
        BILINEAR
        EDGE_SENSING
        HQ_LINEAR
        IPP
        DIRECTIONAL_FILTER
        RIGOROUS
        WEIGHTED_DIRECTIONAL_FILTER
    ctypedef _spinColorProcessingAlgorithm spinColorProcessingAlgorithm

    cpdef enum _spinStatisticsChannel:
        GREY
        RED
        GREEN
        BLUE
        HUE
        SATURATION
        LIGHTNESS
        NUM_STATISTICS_CHANNELS
    ctypedef _spinStatisticsChannel spinStatisticsChannel

    cpdef enum _spinImageFileFormat:
        FROM_FILE_EXT = -1
        PGM
        PPM
        BMP
        JPEG
        JPEG2000
        TIFF
        PNG
        RAW
        IMAGE_FILE_FORMAT_FORCE_32BITS = 0x7FFFFFFF
    ctypedef _spinImageFileFormat spinImageFileFormat

    cpdef enum _spinPixelFormatNamespaceID:
        SPINNAKER_PIXELFORMAT_NAMESPACE_UNKNOWN = 0
        SPINNAKER_PIXELFORMAT_NAMESPACE_GEV = 1
        SPINNAKER_PIXELFORMAT_NAMESPACE_IIDC = 2
        SPINNAKER_PIXELFORMAT_NAMESPACE_PFNC_16BIT = 3
        SPINNAKER_PIXELFORMAT_NAMESPACE_PFNC_32BIT = 4
        SPINNAKER_PIXELFORMAT_NAMESPACE_CUSTOM_ID = 1000
    ctypedef _spinPixelFormatNamespaceID spinPixelFormatNamespaceID

    cpdef enum _spinImageStatus:
        IMAGE_UNKNOWN_ERROR = -1
        IMAGE_NO_ERROR = 0
        IMAGE_CRC_CHECK_FAILED = 1
        IMAGE_DATA_OVERFLOW = 2
        IMAGE_MISSING_PACKETS = 3
        IMAGE_LEADER_BUFFER_SIZE_INCONSISTENT = 4
        IMAGE_TRAILER_BUFFER_SIZE_INCONSISTENT = 5
        IMAGE_PACKETID_INCONSISTENT = 6
        IMAGE_MISSING_LEADER = 7
        IMAGE_MISSING_TRAILER = 8
        IMAGE_DATA_INCOMPLETE = 9
        IMAGE_INFO_INCONSISTENT = 10
        IMAGE_CHUNK_DATA_INVALID = 11
        IMAGE_NO_SYSTEM_RESOURCES = 12
    ctypedef _spinImageStatus spinImageStatus

    cpdef enum _spinLogLevel:
        LOG_LEVEL_OFF = -1
        LOG_LEVEL_FATAL = 0
        LOG_LEVEL_ALERT = 100
        LOG_LEVEL_CRIT = 200
        LOG_LEVEL_ERROR = 300
        LOG_LEVEL_WARN = 400
        LOG_LEVEL_NOTICE = 500
        LOG_LEVEL_INFO = 600
        LOG_LEVEL_DEBUG = 700
        LOG_LEVEL_NOTSET = 800
    ctypedef _spinLogLevel spinnakerLogLevel

    cpdef enum _spinPayloadTypeInfoIDs:
        PAYLOAD_TYPE_UNKNOWN = 0
        PAYLOAD_TYPE_IMAGE = 1
        PAYLOAD_TYPE_RAW_DATA = 2
        PAYLOAD_TYPE_FILE = 3
        PAYLOAD_TYPE_CHUNK_DATA = 4
        PAYLOAD_TYPE_JPEG = 5
        PAYLOAD_TYPE_JPEG2000 = 6
        PAYLOAD_TYPE_H264 = 7
        PAYLOAD_TYPE_CHUNK_ONLY = 8
        PAYLOAD_TYPE_DEVICE_SPECIFIC = 9
        PAYLOAD_TYPE_MULTI_PART = 10
        PAYLOAD_TYPE_CUSTOM_ID = 1000
        PAYLOAD_TYPE_EXTENDED_CHUNK = 1001
        PAYLOAD_TYPE_LOSSLESS_COMPRESSED = 1002
        PAYLOAD_TYPE_LOSSY_COMPRESSED = 1003
        PAYLOAD_TYPE_JPEG_LOSSLESS_COMPRESSED = 1004
        PAYLOAD_TYPE_CHUNK_DATA_LOSSLESS_COMPRESSED = 1005
        PAYLOAD_TYPE_CHUNK_DATA_LOSSY_COMPRESSED = 1006
    ctypedef _spinPayloadTypeInfoIDs spinPayloadTypeInfoIDs

    cdef struct _spinPNGOption:
        bool8_t interlaced
        unsigned int compressionLevel
        unsigned int reserved[16]
    ctypedef _spinPNGOption spinPNGOption

    cdef struct _spinPPMOption:
        bool8_t binaryFile
        unsigned int reserved[16]
    ctypedef _spinPPMOption spinPPMOption

    cdef struct _spinPGMOption:
        bool8_t binaryFile
        unsigned int reserved[16]
    ctypedef _spinPGMOption spinPGMOption

    cpdef enum CompressionMethod:
        NONE = 1
        PACKBITS
        DEFLATE
        ADOBE_DEFLATE
        CCITTFAX3
        CCITTFAX4
        LZW
        JPG
    ctypedef CompressionMethod spinCompressionMethod

    cdef struct _spinTIFFOption:
        spinCompressionMethod compression
        unsigned int reserved[16]
    ctypedef _spinTIFFOption spinTIFFOption

    cdef struct _spinJPEGOption:
        bool8_t progressive
        unsigned int quality
        unsigned int reserved[16]
    ctypedef _spinJPEGOption spinJPEGOption

    cdef struct _spinJPG2Option:
        unsigned int quality
        unsigned int reserved[16]
    ctypedef _spinJPG2Option spinJPG2Option

    cdef struct _spinBMPOption:
        bool8_t indexedColor_8bit
        unsigned int reserved[16]
    ctypedef _spinBMPOption spinBMPOption

    cdef struct _spinMJPGOptionEx:
        float frameRate
        unsigned int quality
        unsigned int width
        unsigned int height
        unsigned int reserved[192]
    ctypedef _spinMJPGOptionEx spinMJPGOptionEx

    cdef struct _spinH264Option:
        float frameRate
        unsigned int width
        unsigned int height
        unsigned int bitrate
        unsigned int reserved[256]
    ctypedef _spinH264Option spinH264Option

    cdef struct _spinAVIOptionEx:
        float frameRate
        unsigned int width
        unsigned int height
        unsigned int reserved[192]
    ctypedef _spinAVIOptionEx spinAVIOptionEx

    cdef struct _spinLibraryVersion:
        unsigned int major
        unsigned int minor
        unsigned int type
        unsigned int build
    ctypedef _spinLibraryVersion spinLibraryVersion

    cpdef enum _actionCommandStatus:
        ACTION_COMMAND_STATUS_OK = 0
        ACTION_COMMAND_STATUS_NO_REF_TIME = 0x8013
        ACTION_COMMAND_STATUS_OVERFLOW = 0x8015
        ACTION_COMMAND_STATUS_ACTION_LATE = 0x8016
        ACTION_COMMAND_STATUS_ERROR = 0x8FFF
    ctypedef _actionCommandStatus actionCommandStatus

    cdef struct _actionCommandResult:
        unsigned int DeviceAddress
        actionCommandStatus Status
    ctypedef _actionCommandResult actionCommandResult
