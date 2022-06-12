from libcpp cimport bool as cbool
from libcpp.string cimport string as cstr
from libc.stdint cimport int64_t, uint64_t, uint8_t, uint32_t


cdef extern from "SpinnakerDefs.h" namespace "Spinnaker::TIFFOption" nogil:
    cpdef enum CompressionMethod:
        NONE = 1
        PACKBITS
        DEFLATE
        ADOBE_DEFLATE
        CCITTFAX3
        CCITTFAX4
        LZW
        JPEG_ENC "Spinnaker::TIFFOption::JPEG"


cdef extern from "SpinnakerDefs.h" namespace "Spinnaker" nogil:

    const uint64_t EVENT_TIMEOUT_NONE = 0
    const uint64_t EVENT_TIMEOUT_INFINITE = 0xFFFFFFFFFFFFFFFF

    cpdef enum Error:
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
        SPINNAKER_ERR_IM_DECOMPRESSION = -3009
        SPINNAKER_ERR_CUSTOM_ID = -10000

    cpdef enum EventType:
        SPINNAKER_EVENT_ARRIVAL_REMOVAL
        SPINNAKER_EVENT_DEVICE
        SPINNAKER_EVENT_DEVICE_SPECIFIC
        SPINNAKER_EVENT_NEW_BUFFER
        SPINNAKER_EVENT_LOGGING_EVENT
        SPINNAKER_EVENT_UNKNOWN
        SPINNAKER_EVENT_INTERFACE_ARRIVAL_REMOVAL

    cpdef enum PixelFormatNamespaceID:
        SPINNAKER_PIXELFORMAT_NAMESPACE_UNKNOWN = 0
        SPINNAKER_PIXELFORMAT_NAMESPACE_GEV = 1
        SPINNAKER_PIXELFORMAT_NAMESPACE_IIDC = 2
        SPINNAKER_PIXELFORMAT_NAMESPACE_PFNC_16BIT = 3
        SPINNAKER_PIXELFORMAT_NAMESPACE_PFNC_32BIT = 4
        SPINNAKER_PIXELFORMAT_NAMESPACE_CUSTOM_ID = 1000

    cpdef enum ColorProcessingAlgorithm:
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

    cpdef enum ImageFileFormat:
        FROM_FILE_EXT = -1
        PGM
        PPM
        BMP
        JPEG
        JPEG2000
        TIFF
        PNG
        RAW
        JPEG12_C
        IMAGE_FILE_FORMAT_FORCE_32BITS = 0x7FFFFFFF

    cpdef enum ImageStatus:
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

    cdef struct PNGOption:
        cbool interlaced
        unsigned int compressionLevel
        unsigned int reserved[16]

    cdef struct PPMOption:
        cbool binaryFile
        unsigned int reserved[16]

    cdef struct PGMOption:
        cbool binaryFile
        unsigned int reserved[16]

    cdef struct TIFFOption:
        CompressionMethod compression
        unsigned int reserved[16]

    cdef struct JPEGOption:
        cbool progressive
        unsigned int quality
        unsigned int reserved[16]

    cdef struct JPG2Option:
        unsigned int quality
        unsigned int reserved[16]

    cdef struct BMPOption:
        cbool indexedColor_8bit
        unsigned int reserved[16]

    cdef struct LibraryVersion:
        unsigned int major
        unsigned int minor
        unsigned int type
        unsigned int build

    cpdef enum StatisticsChannel:
        GREY
        RED
        GREEN
        BLUE
        HUE
        SATURATION
        LIGHTNESS
        NUM_STATISTICS_CHANNELS

    cpdef enum SpinnakerLogLevel:
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

    cpdef enum PayloadTypeInfoIDs:
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

    cpdef enum ActionCommandStatus:
        ACTION_COMMAND_STATUS_OK = 0
        ACTION_COMMAND_STATUS_NO_REF_TIME = 0x8013
        ACTION_COMMAND_STATUS_OVERFLOW = 0x8015
        ACTION_COMMAND_STATUS_ACTION_LATE = 0x8016
        ACTION_COMMAND_STATUS_ERROR = 0x8FFF

    cdef struct ActionCommandResult:
        unsigned int DeviceAddress
        ActionCommandStatus Status

    cpdef enum PixelFormatIntType:
        IntType_UINT8
        IntType_INT8
        IntType_UINT10
        IntType_UINT10p
        IntType_UINT10P
        IntType_UINT12
        IntType_UINT12p
        IntType_UINT12P
        IntType_UINT14
        IntType_UINT16
        IntType_INT16
        IntType_FLOAT32
        IntType_UNKNOWN

    cpdef enum BufferOwnership:
        BUFFER_OWNERSHIP_SYSTEM
        BUFFER_OWNERSHIP_USER

    cpdef enum CCMColorTemperature:
        TUNGSTEN_2800K
        WARM_FLUORESCENT_3000K
        COOL_FLUORESCENT_4000K
        SUNNY_5000K
        CLOUDY_6500K
        SHADE_8000K
        GENERAL

    cpdef enum CCMType:
        LINEAR
        ADVANCED

    cpdef enum CCMSensor:
        IMX250

    cpdef enum CCMColorSpace:
        OFF
        sRGB

    cpdef enum CCMApplication:
        CCM_APPLICATION_GENERIC
        CCM_APPLICATION_MICROSCOPY

    struct CCMSettings:
        CCMColorTemperature ColorTemperature
        CCMType Type
        CCMSensor Sensor
        cstr CustomCCMCode
        CCMColorSpace ColorSpace
        CCMApplication Application

    cdef struct DeviceEventInferenceData:
        uint32_t result
        float confidence
        uint64_t frameID

    cdef struct DeviceEventExposureEndData:
        uint64_t frameID
