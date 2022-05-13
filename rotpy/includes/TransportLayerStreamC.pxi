cdef extern from "TransportLayerStreamC.h" nogil:

    cdef struct _quickSpinTLStream:
        quickSpinStringNode StreamID
        quickSpinEnumerationNode StreamType
        quickSpinEnumerationNode StreamMode
        quickSpinIntegerNode StreamBufferCountManual
        quickSpinIntegerNode StreamBufferCountResult
        quickSpinIntegerNode StreamBufferCountMax
        quickSpinEnumerationNode StreamBufferCountMode
        quickSpinEnumerationNode StreamBufferHandlingMode
        quickSpinIntegerNode StreamAnnounceBufferMinimum
        quickSpinIntegerNode StreamAnnouncedBufferCount
        quickSpinIntegerNode StreamStartedFrameCount
        quickSpinIntegerNode StreamDeliveredFrameCount
        quickSpinIntegerNode StreamReceivedFrameCount
        quickSpinIntegerNode StreamIncompleteFrameCount
        quickSpinIntegerNode StreamLostFrameCount
        quickSpinIntegerNode StreamDroppedFrameCount
        quickSpinIntegerNode StreamInputBufferCount
        quickSpinIntegerNode StreamOutputBufferCount
        quickSpinBooleanNode StreamIsGrabbing
        quickSpinIntegerNode StreamChunkCountMaximum
        quickSpinIntegerNode StreamBufferAlignment
        quickSpinBooleanNode StreamCRCCheckEnable
        quickSpinIntegerNode StreamReceivedPacketCount
        quickSpinIntegerNode StreamMissedPacketCount
        quickSpinBooleanNode StreamPacketResendEnable
        quickSpinIntegerNode StreamPacketResendTimeout
        quickSpinIntegerNode StreamPacketResendMaxRequests
        quickSpinIntegerNode StreamPacketResendRequestCount
        quickSpinIntegerNode StreamPacketResendRequestSuccessCount
        quickSpinIntegerNode StreamPacketResendRequestedPacketCount
        quickSpinIntegerNode StreamPacketResendReceivedPacketCount
        quickSpinBooleanNode GevPacketResendMode
        quickSpinIntegerNode GevMaximumNumberResendRequests
        quickSpinIntegerNode GevPacketResendTimeout
        quickSpinIntegerNode GevTotalPacketCount
        quickSpinIntegerNode GevFailedPacketCount
        quickSpinIntegerNode GevResendPacketCount
        quickSpinIntegerNode StreamFailedBufferCount
        quickSpinIntegerNode GevResendRequestCount
        quickSpinIntegerNode StreamBlockTransferSize
    ctypedef _quickSpinTLStream quickSpinTLStream
