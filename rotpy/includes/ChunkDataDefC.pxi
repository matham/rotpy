cdef extern from "ChunkDataDefC.h" nogil:

    cdef struct _spinChunkData:
        double m_blackLevel
        int64_t m_frameID
        double m_exposureTime
        int64_t m_compressionMode
        double m_compressionRatio
        int64_t m_timestamp
        int64_t m_exposureEndLineStatusAll
        int64_t m_width
        int64_t m_image
        int64_t m_height
        double m_gain
        int64_t m_sequencerSetActive
        int64_t m_cRC
        int64_t m_offsetX
        int64_t m_offsetY
        int64_t m_serialDataLength
        int64_t m_partSelector
        int64_t m_pixelDynamicRangeMin
        int64_t m_pixelDynamicRangeMax
        int64_t m_timestampLatchValue
        int64_t m_lineStatusAll
        int64_t m_counterValue
        double m_timerValue
        int64_t m_scanLineSelector
        int64_t m_encoderValue
        int64_t m_linePitch
        int64_t m_transferBlockID
        int64_t m_transferQueueCurrentBlockCount
        int64_t m_streamChannelID
        double m_scan3dCoordinateScale
        double m_scan3dCoordinateOffset
        double m_scan3dInvalidDataValue
        double m_scan3dAxisMin
        double m_scan3dAxisMax
        double m_scan3dTransformValue
        double m_scan3dCoordinateReferenceValue
        int64_t m_inferenceFrameId
        int64_t m_inferenceResult
        double m_inferenceConfidence
    ctypedef _spinChunkData spinChunkData
