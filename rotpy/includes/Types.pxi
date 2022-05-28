
cdef extern from "SpinGenApi/Types.h" namespace "Spinnaker::GenApi" nogil:
    cpdef enum _ESign:
        Signed
        Unsigned
        _UndefinedSign
    ctypedef _ESign ESign

    cpdef enum _EAccessMode:
        NI
        NA
        WO
        RO
        RW
        _UndefinedAccesMode
        _CycleDetectAccesMode
    ctypedef _EAccessMode EAccessMode

    cpdef enum _EVisibility:
        Beginner = 0
        Expert = 1
        Guru = 2
        Invisible = 3
        _UndefinedVisibility = 99
    ctypedef _EVisibility EVisibility

    cpdef enum _ECachingMode:
        NoCache
        WriteThrough
        WriteAround
        _UndefinedCachingMode
    ctypedef _ECachingMode ECachingMode

    cpdef enum _ERepresentation:
        Linear
        Logarithmic
        Boolean
        PureNumber
        HexNumber
        IPV4Address
        MACAddress
        _UndefinedRepresentation
    ctypedef _ERepresentation ERepresentation

    cpdef enum _EEndianess:
        BigEndian
        LittleEndian
        _UndefinedEndian
    ctypedef _EEndianess EEndianess

    cpdef enum _ENameSpace:
        Custom
        Standard
        _UndefinedNameSpace
    ctypedef _ENameSpace ENameSpace

    cpdef enum _EStandardNameSpace:
        # none "None"
        GEV
        IIDC
        CL
        USB
        _UndefinedStandardNameSpace
    ctypedef _EStandardNameSpace EStandardNameSpace

    cpdef enum _EYesNo:
        Yes = 1
        No = 0
        _UndefinedYesNo = 2
    ctypedef _EYesNo EYesNo

    # ctypedef GenICam::gcstring_vector StringList_t

    cpdef enum _ESlope:
        Increasing
        Decreasing
        Varying
        Automatic
        _UndefinedESlope
    ctypedef _ESlope ESlope

    cpdef enum _EXMLValidation:
        xvLoad = 0x00000001L
        xvCycles = 0x00000002L
        xvSFNC = 0x00000004L
        xvDefault = 0x00000000L
        xvAll = 0xffffffffL
        _UndefinedEXMLValidation = 0x8000000L
    ctypedef _EXMLValidation EXMLValidation

    cpdef enum _EDisplayNotation:
        fnAutomatic
        fnFixed
        fnScientific
        _UndefinedEDisplayNotation
    ctypedef _EDisplayNotation EDisplayNotation

    cpdef enum _EInterfaceType:
        intfIValue
        intfIBase
        intfIInteger
        intfIBoolean
        intfICommand
        intfIFloat
        intfIString
        intfIRegister
        intfICategory
        intfIEnumeration
        intfIEnumEntry
        intfIPort
    ctypedef _EInterfaceType EInterfaceType

    cpdef enum _ELinkType:
        ctParentNodes
        ctReadingChildren
        ctWritingChildren
        ctInvalidatingChildren
        ctDependingNodes
        ctTerminalNodes
    ctypedef _ELinkType ELinkType

    cpdef enum _EIncMode:
        noIncrement
        fixedIncrement
        listIncrement
    ctypedef _EIncMode EIncMode

    cpdef enum _EInputDirection:
        idFrom
        idTo
        idNone
    ctypedef _EInputDirection EInputDirection

    cpdef enum _EGenApiSchemaVersion:
        v1_0 = 1
        v1_1 = 2
        _Undefined = -1
    ctypedef _EGenApiSchemaVersion EGenApiSchemaVersion
