cdef extern from "SpinnakerGenApiDefsC.h" nogil:

    ctypedef void* spinNodeMapHandle

    ctypedef void* spinNodeHandle

    ctypedef void* spinNodeCallbackHandle

    ctypedef void (*spinNodeCallbackFunction)(spinNodeHandle hNode)

    cpdef enum _spinNodeType:
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

    cpdef enum _spinSign:
        Signed
        Unsigned
        _UndefinedSign
    ctypedef _spinSign spinSign

    cpdef enum _spinAccessMode:
        NI
        NA
        WO
        RO
        RW
        _UndefinedAccesMode
        _CycleDetectAccesMode
    ctypedef _spinAccessMode spinAccessMode

    cpdef enum _spinVisibility:
        Beginner = 0
        Expert = 1
        Guru = 2
        Invisible = 3
        _UndefinedVisibility = 99
    ctypedef _spinVisibility spinVisibility

    cpdef enum _spinCachingMode:
        NoCache
        WriteThrough
        WriteAround
        _UndefinedCachingMode
    ctypedef _spinCachingMode spinCachingMode

    cpdef enum _spinRepresentation:
        Linear
        Logarithmic
        Boolean
        PureNumber
        HexNumber
        IPV4Address
        MACAddress
        _UndefinedRepresentation
    ctypedef _spinRepresentation spinRepresentation

    cpdef enum _spinEndianess:
        BigEndian
        LittleEndian
        _UndefinedEndian
    ctypedef _spinEndianess spinEndianess

    cpdef enum _spinNameSpace:
        Custom
        Standard
        _UndefinedNameSpace
    ctypedef _spinNameSpace spinNameSpace

    cpdef enum _spinStandardNameSpace:
        none "None"
        GEV
        IIDC
        CL
        USB
        _UndefinedStandardNameSpace
    ctypedef _spinStandardNameSpace spinStandardNameSpace

    cpdef enum _spinYesNo:
        Yes = 1
        No = 0
        _UndefinedYesNo = 2
    ctypedef _spinYesNo spinYesNo

    cpdef enum _spinSlope:
        Increasing
        Decreasing
        Varying
        Automatic
        _UndefinedESlope
    ctypedef _spinSlope spinSlope

    cpdef enum _spinXMLValidation:
        xvLoad = 0x00000001L
        xvCycles = 0x00000002L
        xvSFNC = 0x00000004L
        xvDefault = 0x00000000L
        xvAll = 0xffffffffL
        _UndefinedEXMLValidation = 0x8000000L
    ctypedef _spinXMLValidation spinXMLValidation

    cpdef enum _spinDisplayNotation:
        fnAutomatic
        fnFixed
        fnScientific
        _UndefinedEDisplayNotation
    ctypedef _spinDisplayNotation spinDisplayNotation

    cpdef enum _spinInterfaceType:
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

    cpdef enum _spinLinkType:
        ctAllDependingNodes
        ctAllTerminalNodes
        ctInvalidators
        ctReadingChildren
        ctWritingChildren
        ctDependingChildren
    ctypedef _spinLinkType spinLinkType

    cpdef enum _spinIncMode:
        noIncrement
        fixedIncrement
        listIncrement
    ctypedef _spinIncMode spinIncMode

    cpdef enum _spinInputDirection:
        idFrom
        idTo
        idNone
    ctypedef _spinInputDirection spinInputDirection
