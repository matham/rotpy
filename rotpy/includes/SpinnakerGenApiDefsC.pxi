cdef extern from "SpinnakerGenApiDefsC.h" nogil:

    ctypedef void* spinNodeMapHandle

    ctypedef void* spinNodeHandle

    ctypedef void* spinNodeCallbackHandle

    ctypedef void (*spinNodeCallbackFunction)(spinNodeHandle hNode)

    cdef enum _spinNodeType:
        ValueNode
        BaseNode
        IntegerNode
        BooleanNode
        FloatNode
        CommandNode
        StringNode
        RegisterNode
        EnumerationNode
        EnumEntryNode
        CategoryNode
        PortNode
        UnknownNode = -1
    ctypedef _spinNodeType spinNodeType

    cdef enum _spinSign:
        Signed
        Unsigned
        _UndefinedSign
    ctypedef _spinSign spinSign

    cdef enum _spinAccessMode:
        NI
        NA
        WO
        RO
        RW
        _UndefinedAccesMode
        _CycleDetectAccesMode
    ctypedef _spinAccessMode spinAccessMode

    cdef enum _spinVisibility:
        Beginner = 0
        Expert = 1
        Guru = 2
        Invisible = 3
        _UndefinedVisibility = 99
    ctypedef _spinVisibility spinVisibility

    cdef enum _spinCachingMode:
        NoCache
        WriteThrough
        WriteAround
        _UndefinedCachingMode
    ctypedef _spinCachingMode spinCachingMode

    cdef enum _spinRepresentation:
        Linear
        Logarithmic
        Boolean
        PureNumber
        HexNumber
        IPV4Address
        MACAddress
        _UndefinedRepresentation
    ctypedef _spinRepresentation spinRepresentation

    cdef enum _spinEndianess:
        BigEndian
        LittleEndian
        _UndefinedEndian
    ctypedef _spinEndianess spinEndianess

    cdef enum _spinNameSpace:
        Custom
        Standard
        _UndefinedNameSpace
    ctypedef _spinNameSpace spinNameSpace

    cdef enum _spinStandardNameSpace:
        None
        GEV
        IIDC
        CL
        USB
        _UndefinedStandardNameSpace
    ctypedef _spinStandardNameSpace spinStandardNameSpace

    cdef enum _spinYesNo:
        Yes = 1
        No = 0
        _UndefinedYesNo = 2
    ctypedef _spinYesNo spinYesNo

    cdef enum _spinSlope:
        Increasing
        Decreasing
        Varying
        Automatic
        _UndefinedESlope
    ctypedef _spinSlope spinSlope

    cdef enum _spinXMLValidation:
        xvLoad = 0x00000001L
        xvCycles = 0x00000002L
        xvSFNC = 0x00000004L
        xvDefault = 0x00000000L
        xvAll = 0xffffffffL
        _UndefinedEXMLValidation = 0x8000000L
    ctypedef _spinXMLValidation spinXMLValidation

    cdef enum _spinDisplayNotation:
        fnAutomatic
        fnFixed
        fnScientific
        _UndefinedEDisplayNotation
    ctypedef _spinDisplayNotation spinDisplayNotation

    cdef enum _spinInterfaceType:
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
    ctypedef _spinInterfaceType spinInterfaceType

    cdef enum _spinLinkType:
        ctAllDependingNodes
        ctAllTerminalNodes
        ctInvalidators
        ctReadingChildren
        ctWritingChildren
        ctDependingChildren
    ctypedef _spinLinkType spinLinkType

    cdef enum _spinIncMode:
        noIncrement
        fixedIncrement
        listIncrement
    ctypedef _spinIncMode spinIncMode

    cdef enum _spinInputDirection:
        idFrom
        idTo
        idNone
    ctypedef _spinInputDirection spinInputDirection
