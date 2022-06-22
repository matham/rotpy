"""Camera nodes
===============

Lists all the pre-listed nodes of the :class:`~rotpy.camera.Camera`.
"""
from .node cimport SpinIntNode, SpinFloatNode, SpinBoolNode, SpinStrNode, \
    SpinCommandNode, SpinRegisterNode, SpinEnumDefNode

from .node import SpinIntNode, SpinFloatNode, SpinBoolNode, SpinStrNode, \
    SpinCommandNode, SpinRegisterNode, SpinEnumDefNode
import rotpy.names.camera
import rotpy.names.tl
import rotpy.names.spin
import rotpy.names.geni

__all__ = ('CameraNodes', 'TLDevNodes', 'TLStreamNodes')


cdef class CameraNodes:
    """Lists all the pre-listed nodes of the :class:`~rotpy.camera.Camera`.

    .. warning::

        Do **not** create a :class:`CameraNodes` manually, rather get it
        from :attr:`~rotpy.camera.Camera.camera_nodes` that is automatically
        created when the camera is instantiated.

    .. note::

        Even though the nodes are pre-listed, it is simply a convenience and
        the same nodes can be gotten by name through
        :class:`~rotpy.node.NodeMap`. Additionally, you must check that the
        node is actually available, readable etc, even if it's pre-listed.

        Some nodes are available before :meth:`~rotpy.camera.Camera.init_cam`,
        but other nodes, even those pre-listed, become available only after
        :meth:`~rotpy.camera.Camera.init_cam`.
    """

    def __cinit__(self, camera):
        self._camera = camera
        self._nodes = {}

        self.bool_nodes = ['LUTEnable', 'AcquisitionFrameRateEnable',
                           'EventSerialReceiveOverflow',
                           'LogicBlockLUTOutputValue',
                           'ColorTransformationEnable', 'SaturationEnable',
                           'AasRoiEnable', 'GevCurrentIPConfigurationDHCP',
                           'GevSCCFGUnconditionalStreaming',
                           'GevSCPSDoNotFragment', 'GevGVCPPendingAck',
                           'GevSupportedOption', 'GevCurrentIPConfigurationLLA',
                           'GevIEEE1588', 'GevSCCFGExtendedChunkData',
                           'GevCurrentIPConfigurationPersistentIP',
                           'GevSCPSFireTestPacket', 'GevGVCPHeartbeatDisable',
                           'GevSCPSBigEndian', 'SharpeningEnable',
                           'GammaEnable', 'SharpeningAuto',
                           'BlackLevelClampingEnable',
                           'DefectCorrectStaticEnable', 'UserSetFeatureEnable',
                           'SequencerFeatureEnable',
                           'ChunkSerialReceiveOverflow', 'ChunkModeActive',
                           'ChunkEnable', 'ReverseX', 'ReverseY', 'IspEnable',
                           'AdaptiveCompressionEnable', 'V3_3Enable',
                           'UserOutputValue', 'LineStatus', 'LineInverter',
                           'DeviceRegistersValid', 'ImageComponentEnable',
                           'AcquisitionStatus', 'TransferStatus',
                           'Scan3dInvalidDataFlag',
                           'ChunkScan3dInvalidDataFlag',
                           'GevPAUSEFrameReception',
                           'GevPAUSEFrameTransmission',
                           'GevGVCPExtendedStatusCodes',
                           'GevSCCFGPacketResendDestination',
                           'GevSCCFGAllInTransmission',
                           'GevSCZoneConfigurationLock']
        self.int_nodes = ['LUTIndex', 'LUTValue', 'AcquisitionFrameCount',
                          'AcquisitionBurstFrameCount', 'EventTest',
                          'EventTestTimestamp', 'EventExposureEndFrameID',
                          'EventExposureEnd', 'EventExposureEndTimestamp',
                          'EventError', 'EventErrorTimestamp', 'EventErrorCode',
                          'EventErrorFrameID', 'EventSerialPortReceive',
                          'EventSerialPortReceiveTimestamp',
                          'EventSerialDataLength', 'LogicBlockLUTRowIndex',
                          'LogicBlockLUTOutputValueAll', 'TimestampLatchValue',
                          'MaxDeviceResetTime', 'DeviceTLVersionMinor',
                          'DeviceLinkSpeed', 'LinkUptime',
                          'DeviceEventChannelCount',
                          'DeviceLinkThroughputLimit',
                          'DeviceStreamChannelCount', 'DeviceTLVersionMajor',
                          'EnumerationCount', 'DeviceUptime',
                          'DeviceLinkCurrentThroughput', 'DeviceMaxThroughput',
                          'AasRoiOffsetY', 'AasRoiOffsetX', 'AasRoiHeight',
                          'AasRoiWidth', 'LinkErrorCount',
                          'GevInterfaceSelector', 'GevSCPD',
                          'GevTimestampTickFrequency', 'GevSCPSPacketSize',
                          'GevCurrentDefaultGateway', 'GevMCTT',
                          'GevCurrentSubnetMask', 'GevStreamChannelSelector',
                          'GevCurrentIPAddress', 'GevMCSP',
                          'GevGVCPPendingTimeout', 'GevMACAddress',
                          'GevPersistentSubnetMask', 'GevMCPHostPort',
                          'GevSCPHostPort', 'GevSCPInterfaceIndex', 'GevSCSP',
                          'GevPersistentIPAddress', 'GevHeartbeatTimeout',
                          'GevPersistentDefaultGateway', 'GevMCDA', 'GevSCDA',
                          'GevSCPDirection', 'GevMCRC', 'GevNumberOfInterfaces',
                          'TLParamsLocked', 'PayloadSize',
                          'PacketResendRequestCount', 'BlackLevelRaw',
                          'DefectTableIndex', 'DefectTableCoordinateY',
                          'DefectTableCoordinateX', 'DefectTablePixelCount',
                          'SerialPortDataBits',
                          'SerialTransmitQueueMaxCharacterCount',
                          'SerialReceiveQueueCurrentCharacterCount',
                          'SerialReceiveFramingErrorCount',
                          'SerialTransmitQueueCurrentCharacterCount',
                          'SerialReceiveParityErrorCount',
                          'SerialReceiveQueueMaxCharacterCount',
                          'SequencerSetStart', 'SequencerSetSelector',
                          'SequencerSetActive', 'SequencerSetNext',
                          'SequencerPathSelector', 'TransferBlockCount',
                          'TransferQueueMaxBlockCount',
                          'TransferQueueCurrentBlockCount',
                          'TransferQueueOverflowCount', 'ChunkFrameID',
                          'ChunkCompressionMode', 'ChunkTimestamp',
                          'ChunkExposureEndLineStatusAll', 'ChunkWidth',
                          'ChunkImage', 'ChunkHeight',
                          'ChunkSequencerSetActive', 'ChunkCRC', 'ChunkOffsetX',
                          'ChunkOffsetY', 'ChunkSerialDataLength',
                          'FileAccessOffset', 'FileAccessLength',
                          'FileOperationResult', 'FileSize',
                          'PixelDynamicRangeMin', 'PixelDynamicRangeMax',
                          'OffsetY', 'BinningHorizontal', 'Width', 'WidthMax',
                          'BinningVertical', 'OffsetX', 'HeightMax',
                          'DecimationHorizontal', 'SensorHeight',
                          'DecimationVertical', 'Height', 'SensorWidth',
                          'GuiXmlManifestAddress', 'Test0001',
                          'UserOutputValueAll', 'LineStatusAll', 'CounterValue',
                          'CounterValueAtReset', 'CounterDelay',
                          'CounterDuration', 'DeviceSFNCVersionMajor',
                          'DeviceSFNCVersionMinor', 'DeviceSFNCVersionSubMinor',
                          'DeviceManifestEntrySelector',
                          'DeviceManifestXMLMajorVersion',
                          'DeviceManifestXMLMinorVersion',
                          'DeviceManifestXMLSubMinorVersion',
                          'DeviceManifestSchemaMajorVersion',
                          'DeviceManifestSchemaMinorVersion',
                          'DeviceTLVersionSubMinor', 'DeviceGenCPVersionMajor',
                          'DeviceGenCPVersionMinor', 'DeviceConnectionSelector',
                          'DeviceConnectionSpeed', 'DeviceLinkSelector',
                          'DeviceLinkConnectionCount',
                          'DeviceStreamChannelSelector',
                          'DeviceStreamChannelLink',
                          'DeviceStreamChannelPacketSize', 'Timestamp',
                          'LinePitch', 'PixelFormatInfoID',
                          'ImageCompressionQuality', 'TriggerDivider',
                          'TriggerMultiplier', 'UserOutputValueAllMask',
                          'EncoderDivider', 'EncoderValue',
                          'EncoderValueAtReset', 'ActionDeviceKey',
                          'ActionQueueSize', 'ActionSelector',
                          'ActionGroupMask', 'ActionGroupKey',
                          'EventAcquisitionTrigger',
                          'EventAcquisitionTriggerTimestamp',
                          'EventAcquisitionTriggerFrameID',
                          'EventAcquisitionStart',
                          'EventAcquisitionStartTimestamp',
                          'EventAcquisitionStartFrameID', 'EventAcquisitionEnd',
                          'EventAcquisitionEndTimestamp',
                          'EventAcquisitionEndFrameID',
                          'EventAcquisitionTransferStart',
                          'EventAcquisitionTransferStartTimestamp',
                          'EventAcquisitionTransferStartFrameID',
                          'EventAcquisitionTransferEnd',
                          'EventAcquisitionTransferEndTimestamp',
                          'EventAcquisitionTransferEndFrameID',
                          'EventAcquisitionError',
                          'EventAcquisitionErrorTimestamp',
                          'EventAcquisitionErrorFrameID', 'EventFrameTrigger',
                          'EventFrameTriggerTimestamp',
                          'EventFrameTriggerFrameID', 'EventFrameStart',
                          'EventFrameStartTimestamp', 'EventFrameStartFrameID',
                          'EventFrameEnd', 'EventFrameEndTimestamp',
                          'EventFrameEndFrameID', 'EventFrameBurstStart',
                          'EventFrameBurstStartTimestamp',
                          'EventFrameBurstStartFrameID', 'EventFrameBurstEnd',
                          'EventFrameBurstEndTimestamp',
                          'EventFrameBurstEndFrameID',
                          'EventFrameTransferStart',
                          'EventFrameTransferStartTimestamp',
                          'EventFrameTransferStartFrameID',
                          'EventFrameTransferEnd',
                          'EventFrameTransferEndTimestamp',
                          'EventFrameTransferEndFrameID', 'EventExposureStart',
                          'EventExposureStartTimestamp',
                          'EventExposureStartFrameID',
                          'EventStream0TransferStart',
                          'EventStream0TransferStartTimestamp',
                          'EventStream0TransferStartFrameID',
                          'EventStream0TransferEnd',
                          'EventStream0TransferEndTimestamp',
                          'EventStream0TransferEndFrameID',
                          'EventStream0TransferPause',
                          'EventStream0TransferPauseTimestamp',
                          'EventStream0TransferPauseFrameID',
                          'EventStream0TransferResume',
                          'EventStream0TransferResumeTimestamp',
                          'EventStream0TransferResumeFrameID',
                          'EventStream0TransferBlockStart',
                          'EventStream0TransferBlockStartTimestamp',
                          'EventStream0TransferBlockStartFrameID',
                          'EventStream0TransferBlockEnd',
                          'EventStream0TransferBlockEndTimestamp',
                          'EventStream0TransferBlockEndFrameID',
                          'EventStream0TransferBlockTrigger',
                          'EventStream0TransferBlockTriggerTimestamp',
                          'EventStream0TransferBlockTriggerFrameID',
                          'EventStream0TransferBurstStart',
                          'EventStream0TransferBurstStartTimestamp',
                          'EventStream0TransferBurstStartFrameID',
                          'EventStream0TransferBurstEnd',
                          'EventStream0TransferBurstEndTimestamp',
                          'EventStream0TransferBurstEndFrameID',
                          'EventStream0TransferOverflow',
                          'EventStream0TransferOverflowTimestamp',
                          'EventStream0TransferOverflowFrameID',
                          'EventSequencerSetChange',
                          'EventSequencerSetChangeTimestamp',
                          'EventSequencerSetChangeFrameID',
                          'EventCounter0Start', 'EventCounter0StartTimestamp',
                          'EventCounter0StartFrameID', 'EventCounter1Start',
                          'EventCounter1StartTimestamp',
                          'EventCounter1StartFrameID', 'EventCounter0End',
                          'EventCounter0EndTimestamp',
                          'EventCounter0EndFrameID', 'EventCounter1End',
                          'EventCounter1EndTimestamp',
                          'EventCounter1EndFrameID', 'EventTimer0Start',
                          'EventTimer0StartTimestamp',
                          'EventTimer0StartFrameID', 'EventTimer1Start',
                          'EventTimer1StartTimestamp',
                          'EventTimer1StartFrameID', 'EventTimer0End',
                          'EventTimer0EndTimestamp', 'EventTimer0EndFrameID',
                          'EventTimer1End', 'EventTimer1EndTimestamp',
                          'EventTimer1EndFrameID', 'EventEncoder0Stopped',
                          'EventEncoder0StoppedTimestamp',
                          'EventEncoder0StoppedFrameID', 'EventEncoder1Stopped',
                          'EventEncoder1StoppedTimestamp',
                          'EventEncoder1StoppedFrameID',
                          'EventEncoder0Restarted',
                          'EventEncoder0RestartedTimestamp',
                          'EventEncoder0RestartedFrameID',
                          'EventEncoder1Restarted',
                          'EventEncoder1RestartedTimestamp',
                          'EventEncoder1RestartedFrameID',
                          'EventLine0RisingEdge',
                          'EventLine0RisingEdgeTimestamp',
                          'EventLine0RisingEdgeFrameID', 'EventLine1RisingEdge',
                          'EventLine1RisingEdgeTimestamp',
                          'EventLine1RisingEdgeFrameID',
                          'EventLine0FallingEdge',
                          'EventLine0FallingEdgeTimestamp',
                          'EventLine0FallingEdgeFrameID',
                          'EventLine1FallingEdge',
                          'EventLine1FallingEdgeTimestamp',
                          'EventLine1FallingEdgeFrameID', 'EventLine0AnyEdge',
                          'EventLine0AnyEdgeTimestamp',
                          'EventLine0AnyEdgeFrameID', 'EventLine1AnyEdge',
                          'EventLine1AnyEdgeTimestamp',
                          'EventLine1AnyEdgeFrameID', 'EventLinkTrigger0',
                          'EventLinkTrigger0Timestamp',
                          'EventLinkTrigger0FrameID', 'EventLinkTrigger1',
                          'EventLinkTrigger1Timestamp',
                          'EventLinkTrigger1FrameID', 'EventActionLate',
                          'EventActionLateTimestamp', 'EventActionLateFrameID',
                          'EventLinkSpeedChange',
                          'EventLinkSpeedChangeTimestamp',
                          'EventLinkSpeedChangeFrameID', 'SourceCount',
                          'TransferBurstCount', 'TransferStreamChannel',
                          'ChunkPartSelector', 'ChunkPixelDynamicRangeMin',
                          'ChunkPixelDynamicRangeMax',
                          'ChunkTimestampLatchValue', 'ChunkLineStatusAll',
                          'ChunkCounterValue', 'ChunkScanLineSelector',
                          'ChunkEncoderValue', 'ChunkLinePitch',
                          'ChunkTransferBlockID',
                          'ChunkTransferQueueCurrentBlockCount',
                          'ChunkStreamChannelID', 'TestPendingAck',
                          'GevActiveLinkCount', 'GevDiscoveryAckDelay',
                          'GevPrimaryApplicationSwitchoverKey',
                          'GevPrimaryApplicationSocket',
                          'GevPrimaryApplicationIPAddress', 'GevSCZoneCount',
                          'GevSCZoneDirectionAll',
                          'aPAUSEMACCtrlFramesTransmitted',
                          'aPAUSEMACCtrlFramesReceived',
                          'CxpConnectionSelector',
                          'CxpConnectionTestErrorCount',
                          'CxpConnectionTestPacketCount',
                          'ChunkInferenceFrameId', 'ChunkInferenceResult']
        self.float_nodes = ['ExposureTime', 'AcquisitionResultingFrameRate',
                            'AcquisitionLineRate', 'TriggerDelay',
                            'AcquisitionFrameRate', 'ColorTransformationValue',
                            'Saturation', 'DeviceTemperature',
                            'PowerSupplyCurrent', 'PowerSupplyVoltage',
                            'DeviceLinkBandwidthReserve',
                            'BalanceWhiteAutoLowerLimit',
                            'BalanceWhiteAutoDamping',
                            'AutoExposureGreyValueUpperLimit',
                            'AutoExposureTargetGreyValue',
                            'AutoExposureGainLowerLimit',
                            'AutoExposureGreyValueLowerLimit',
                            'AutoExposureExposureTimeUpperLimit',
                            'AutoExposureGainUpperLimit',
                            'AutoExposureControlLoopDamping',
                            'AutoExposureEVCompensation',
                            'AutoExposureExposureTimeLowerLimit',
                            'BalanceWhiteAutoUpperLimit', 'BalanceRatio',
                            'SharpeningThreshold', 'Sharpening', 'Gain',
                            'BlackLevel', 'Gamma', 'ChunkBlackLevel',
                            'ChunkExposureTime', 'ChunkCompressionRatio',
                            'ChunkGain', 'CompressionRatio', 'LineFilterWidth',
                            'DeviceLinkHeartbeatTimeout',
                            'DeviceLinkCommandTimeout', 'DeviceClockFrequency',
                            'ImageCompressionBitrate', 'WhiteClip',
                            'TimerDuration', 'TimerDelay', 'TimerValue',
                            'EncoderTimeout', 'Scan3dCoordinateScale',
                            'Scan3dCoordinateOffset', 'Scan3dInvalidDataValue',
                            'Scan3dAxisMin', 'Scan3dAxisMax',
                            'Scan3dTransformValue',
                            'Scan3dCoordinateReferenceValue', 'ChunkTimerValue',
                            'ChunkScan3dCoordinateScale',
                            'ChunkScan3dCoordinateOffset',
                            'ChunkScan3dInvalidDataValue', 'ChunkScan3dAxisMin',
                            'ChunkScan3dAxisMax', 'ChunkScan3dTransformValue',
                            'ChunkScan3dCoordinateReferenceValue',
                            'ChunkInferenceConfidence']
        self.str_nodes = ['EventSerialData', 'DeviceUserID',
                          'DeviceSerialNumber', 'DeviceVendorName',
                          'DeviceManufacturerInfo', 'DeviceFirmwareVersion',
                          'DeviceVersion', 'SensorDescription',
                          'DeviceModelName', 'DeviceID', 'GevFirstURL',
                          'GevSecondURL', 'ChunkSerialData', 'DeviceFamilyName',
                          'DeviceManifestPrimaryURL',
                          'DeviceManifestSecondaryURL']
        self.enum_nodes = ['LUTSelector', 'ExposureMode', 'AcquisitionMode',
                           'TriggerSource', 'TriggerActivation',
                           'SensorShutterMode', 'TriggerMode', 'TriggerOverlap',
                           'TriggerSelector', 'ExposureAuto', 'EventSelector',
                           'EventNotification', 'LogicBlockSelector',
                           'LogicBlockLUTInputActivation',
                           'LogicBlockLUTInputSelector',
                           'LogicBlockLUTInputSource', 'LogicBlockLUTSelector',
                           'ColorTransformationSelector',
                           'RgbTransformLightSource',
                           'ColorTransformationValueSelector',
                           'DeviceRegistersEndianness', 'DeviceScanType',
                           'DeviceCharacterSet', 'DeviceTLType',
                           'DevicePowerSupplySelector',
                           'DeviceTemperatureSelector', 'DeviceIndicatorMode',
                           'AutoExposureControlPriority',
                           'AutoExposureMeteringMode',
                           'BalanceWhiteAutoProfile', 'AutoAlgorithmSelector',
                           'AutoExposureTargetGreyValueAuto',
                           'AutoExposureLightingMode', 'GevIEEE1588Status',
                           'GevIEEE1588Mode', 'GevIEEE1588ClockAccuracy',
                           'GevCCP', 'GevSupportedOptionSelector',
                           'BlackLevelSelector', 'BalanceWhiteAuto', 'GainAuto',
                           'BalanceRatioSelector', 'GainSelector',
                           'DefectCorrectionMode', 'UserSetSelector',
                           'UserSetDefault', 'SerialPortBaudRate',
                           'SerialPortParity', 'SerialPortSelector',
                           'SerialPortStopBits', 'SerialPortSource',
                           'SequencerMode', 'SequencerConfigurationValid',
                           'SequencerSetValid', 'SequencerTriggerActivation',
                           'SequencerConfigurationMode',
                           'SequencerTriggerSource', 'TransferQueueMode',
                           'TransferOperationMode', 'TransferControlMode',
                           'ChunkGainSelector', 'ChunkSelector',
                           'ChunkBlackLevelSelector', 'ChunkPixelFormat',
                           'FileOperationStatus', 'FileOpenMode',
                           'FileOperationSelector', 'FileSelector',
                           'BinningSelector', 'TestPatternGeneratorSelector',
                           'CompressionSaturationPriority', 'TestPattern',
                           'PixelColorFilter', 'AdcBitDepth',
                           'DecimationHorizontalMode', 'BinningVerticalMode',
                           'PixelSize', 'DecimationSelector',
                           'ImageCompressionMode', 'BinningHorizontalMode',
                           'PixelFormat', 'DecimationVerticalMode', 'LineMode',
                           'LineSource', 'LineInputFilterSelector',
                           'UserOutputSelector', 'LineFormat', 'LineSelector',
                           'ExposureActiveMode', 'CounterTriggerActivation',
                           'CounterSelector', 'CounterStatus',
                           'CounterTriggerSource', 'CounterResetSource',
                           'CounterEventSource', 'CounterEventActivation',
                           'CounterResetActivation', 'DeviceType',
                           'DeviceConnectionStatus',
                           'DeviceLinkThroughputLimitMode',
                           'DeviceLinkHeartbeatMode', 'DeviceStreamChannelType',
                           'DeviceStreamChannelEndianness',
                           'DeviceClockSelector', 'DeviceSerialPortSelector',
                           'DeviceSerialPortBaudRate', 'SensorTaps',
                           'SensorDigitizationTaps', 'RegionSelector',
                           'RegionMode', 'RegionDestination',
                           'ImageComponentSelector', 'PixelFormatInfoSelector',
                           'Deinterlacing', 'ImageCompressionRateOption',
                           'ImageCompressionJPEGFormatOption',
                           'AcquisitionStatusSelector', 'ExposureTimeMode',
                           'ExposureTimeSelector', 'GainAutoBalance',
                           'BlackLevelAuto', 'BlackLevelAutoBalance',
                           'WhiteClipSelector', 'TimerSelector', 'TimerStatus',
                           'TimerTriggerSource', 'TimerTriggerActivation',
                           'EncoderSelector', 'EncoderSourceA',
                           'EncoderSourceB', 'EncoderMode', 'EncoderOutputMode',
                           'EncoderStatus', 'EncoderResetSource',
                           'EncoderResetActivation', 'SoftwareSignalSelector',
                           'ActionUnconditionalMode', 'SourceSelector',
                           'TransferSelector', 'TransferTriggerSelector',
                           'TransferTriggerMode', 'TransferTriggerSource',
                           'TransferTriggerActivation',
                           'TransferStatusSelector',
                           'TransferComponentSelector', 'Scan3dDistanceUnit',
                           'Scan3dCoordinateSystem', 'Scan3dOutputMode',
                           'Scan3dCoordinateSystemReference',
                           'Scan3dCoordinateSelector',
                           'Scan3dCoordinateTransformSelector',
                           'Scan3dCoordinateReferenceSelector',
                           'ChunkImageComponent', 'ChunkCounterSelector',
                           'ChunkTimerSelector', 'ChunkEncoderSelector',
                           'ChunkEncoderStatus', 'ChunkExposureTimeSelector',
                           'ChunkSourceID', 'ChunkRegionID',
                           'ChunkTransferStreamID', 'ChunkScan3dDistanceUnit',
                           'ChunkScan3dOutputMode',
                           'ChunkScan3dCoordinateSystem',
                           'ChunkScan3dCoordinateSystemReference',
                           'ChunkScan3dCoordinateSelector',
                           'ChunkScan3dCoordinateTransformSelector',
                           'ChunkScan3dCoordinateReferenceSelector',
                           'DeviceTapGeometry', 'GevPhysicalLinkConfiguration',
                           'GevCurrentPhysicalLinkConfiguration',
                           'GevIPConfigurationStatus',
                           'GevGVCPExtendedStatusCodesSelector',
                           'GevGVSPExtendedIDMode', 'ClConfiguration',
                           'ClTimeSlotsCount', 'CxpLinkConfigurationStatus',
                           'CxpLinkConfigurationPreferred',
                           'CxpLinkConfiguration', 'CxpConnectionTestMode',
                           'CxpPoCxpStatus']
        self.command_nodes = ['AcquisitionStop', 'AcquisitionStart',
                              'TriggerSoftware', 'TimestampReset',
                              'TimestampLatch', 'DeviceReset', 'FactoryReset',
                              'DefectTableFactoryRestore', 'DefectTableSave',
                              'DefectTableApply', 'UserSetSave', 'UserSetLoad',
                              'SerialReceiveQueueClear', 'SequencerSetSave',
                              'SequencerSetLoad', 'TransferStart',
                              'TransferStop', 'FileOperationExecute',
                              'TestEventGenerate', 'TriggerEventTest',
                              'DeviceFeaturePersistenceStart',
                              'DeviceFeaturePersistenceEnd',
                              'DeviceRegistersStreamingStart',
                              'DeviceRegistersStreamingEnd',
                              'DeviceRegistersCheck', 'AcquisitionAbort',
                              'AcquisitionArm', 'CounterReset', 'TimerReset',
                              'EncoderReset', 'SoftwareSignalPulse',
                              'TransferAbort', 'TransferPause',
                              'TransferResume', 'CxpPoCxpAuto',
                              'CxpPoCxpTurnOff', 'CxpPoCxpTripReset']
        self.register_nodes = ['LUTValueAll', 'FileAccessBuffer',
                               'ChunkInferenceBoundingBoxResult']

    def __init__(self, camera):
        pass

    @property
    def LUTIndex(self) -> SpinIntNode:
        """Control the index (offset) of the coefficient to access in the
        selected LUT.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("LUTIndex")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().LUTIndex))
            node = self._nodes["LUTIndex"] = node_inst
        return node

    @property
    def LUTEnable(self) -> SpinBoolNode:
        """Activates the selected LUT.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("LUTEnable")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().LUTEnable))
            node = self._nodes["LUTEnable"] = node_inst
        return node

    @property
    def LUTValue(self) -> SpinIntNode:
        """Returns the Value at entry LUTIndex of the LUT selected by
        LUTSelector.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("LUTValue")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().LUTValue))
            node = self._nodes["LUTValue"] = node_inst
        return node

    @property
    def LUTSelector(self) -> SpinEnumDefNode:
        """Selects which LUT to control.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.LUTSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("LUTSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().LUTSelector))
            node_inst.enum_names = rotpy.names.camera.LUTSelector_names
            node_inst.enum_values = rotpy.names.camera.LUTSelector_values
            node = self._nodes["LUTSelector"] = node_inst
        return node

    @property
    def ExposureTime(self) -> SpinFloatNode:
        """Exposure time in microseconds when Exposure Mode is Timed.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("ExposureTime")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ExposureTime))
            node = self._nodes["ExposureTime"] = node_inst
        return node

    @property
    def AcquisitionStop(self) -> SpinCommandNode:
        """This command stops the acquisition of images.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("AcquisitionStop")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AcquisitionStop))
            node = self._nodes["AcquisitionStop"] = node_inst
        return node

    @property
    def AcquisitionResultingFrameRate(self) -> SpinFloatNode:
        """Resulting frame rate in Hertz. If this does not equal the
        Acquisition Frame Rate it is because the Exposure Time is greater
        than the frame time.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("AcquisitionResultingFrameRate")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AcquisitionResultingFrameRate))
            node = self._nodes["AcquisitionResultingFrameRate"] = node_inst
        return node

    @property
    def AcquisitionLineRate(self) -> SpinFloatNode:
        """Controls the rate (in Hertz) at which the Lines in a Frame are
        captured.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("AcquisitionLineRate")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AcquisitionLineRate))
            node = self._nodes["AcquisitionLineRate"] = node_inst
        return node

    @property
    def AcquisitionStart(self) -> SpinCommandNode:
        """This command starts the acquisition of images.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("AcquisitionStart")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AcquisitionStart))
            node = self._nodes["AcquisitionStart"] = node_inst
        return node

    @property
    def TriggerSoftware(self) -> SpinCommandNode:
        """Generates an internal trigger if Trigger Source is set to Software.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("TriggerSoftware")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TriggerSoftware))
            node = self._nodes["TriggerSoftware"] = node_inst
        return node

    @property
    def ExposureMode(self) -> SpinEnumDefNode:
        """Sets the operation mode of the Exposure.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ExposureMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ExposureMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ExposureMode))
            node_inst.enum_names = rotpy.names.camera.ExposureMode_names
            node_inst.enum_values = rotpy.names.camera.ExposureMode_values
            node = self._nodes["ExposureMode"] = node_inst
        return node

    @property
    def AcquisitionMode(self) -> SpinEnumDefNode:
        """Sets the acquisition mode of the device. Continuous: acquires images
        continuously. Multi Frame: acquires a specified number of images
        before stopping acquisition. Single Frame: acquires 1 image before
        stopping acquisition.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.AcquisitionMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("AcquisitionMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AcquisitionMode))
            node_inst.enum_names = rotpy.names.camera.AcquisitionMode_names
            node_inst.enum_values = rotpy.names.camera.AcquisitionMode_values
            node = self._nodes["AcquisitionMode"] = node_inst
        return node

    @property
    def AcquisitionFrameCount(self) -> SpinIntNode:
        """Number of images to acquire during a multi frame acquisition.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("AcquisitionFrameCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AcquisitionFrameCount))
            node = self._nodes["AcquisitionFrameCount"] = node_inst
        return node

    @property
    def TriggerSource(self) -> SpinEnumDefNode:
        """Specifies the internal signal or physical input line to use as the
        trigger source.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.TriggerSource_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("TriggerSource")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TriggerSource))
            node_inst.enum_names = rotpy.names.camera.TriggerSource_names
            node_inst.enum_values = rotpy.names.camera.TriggerSource_values
            node = self._nodes["TriggerSource"] = node_inst
        return node

    @property
    def TriggerActivation(self) -> SpinEnumDefNode:
        """Specifies the activation mode of the trigger.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.TriggerActivation_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("TriggerActivation")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TriggerActivation))
            node_inst.enum_names = rotpy.names.camera.TriggerActivation_names
            node_inst.enum_values = rotpy.names.camera.TriggerActivation_values
            node = self._nodes["TriggerActivation"] = node_inst
        return node

    @property
    def SensorShutterMode(self) -> SpinEnumDefNode:
        """Sets the shutter mode of the device.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.SensorShutterMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("SensorShutterMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SensorShutterMode))
            node_inst.enum_names = rotpy.names.camera.SensorShutterMode_names
            node_inst.enum_values = rotpy.names.camera.SensorShutterMode_values
            node = self._nodes["SensorShutterMode"] = node_inst
        return node

    @property
    def TriggerDelay(self) -> SpinFloatNode:
        """Specifies the delay in microseconds (us) to apply after the trigger
        reception before activating it.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("TriggerDelay")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TriggerDelay))
            node = self._nodes["TriggerDelay"] = node_inst
        return node

    @property
    def TriggerMode(self) -> SpinEnumDefNode:
        """Controls whether or not trigger is active.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.TriggerMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("TriggerMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TriggerMode))
            node_inst.enum_names = rotpy.names.camera.TriggerMode_names
            node_inst.enum_values = rotpy.names.camera.TriggerMode_values
            node = self._nodes["TriggerMode"] = node_inst
        return node

    @property
    def AcquisitionFrameRate(self) -> SpinFloatNode:
        """User controlled acquisition frame rate in Hertz

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("AcquisitionFrameRate")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AcquisitionFrameRate))
            node = self._nodes["AcquisitionFrameRate"] = node_inst
        return node

    @property
    def TriggerOverlap(self) -> SpinEnumDefNode:
        """Specifies the overlap mode of the trigger.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.TriggerOverlap_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("TriggerOverlap")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TriggerOverlap))
            node_inst.enum_names = rotpy.names.camera.TriggerOverlap_names
            node_inst.enum_values = rotpy.names.camera.TriggerOverlap_values
            node = self._nodes["TriggerOverlap"] = node_inst
        return node

    @property
    def TriggerSelector(self) -> SpinEnumDefNode:
        """Selects the type of trigger to configure.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.TriggerSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("TriggerSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TriggerSelector))
            node_inst.enum_names = rotpy.names.camera.TriggerSelector_names
            node_inst.enum_values = rotpy.names.camera.TriggerSelector_values
            node = self._nodes["TriggerSelector"] = node_inst
        return node

    @property
    def AcquisitionFrameRateEnable(self) -> SpinBoolNode:
        """If enabled, AcquisitionFrameRate can be used to manually control the
        frame rate.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("AcquisitionFrameRateEnable")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AcquisitionFrameRateEnable))
            node = self._nodes["AcquisitionFrameRateEnable"] = node_inst
        return node

    @property
    def ExposureAuto(self) -> SpinEnumDefNode:
        """Sets the automatic exposure mode

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ExposureAuto_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ExposureAuto")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ExposureAuto))
            node_inst.enum_names = rotpy.names.camera.ExposureAuto_names
            node_inst.enum_values = rotpy.names.camera.ExposureAuto_values
            node = self._nodes["ExposureAuto"] = node_inst
        return node

    @property
    def AcquisitionBurstFrameCount(self) -> SpinIntNode:
        """This feature is used only if the FrameBurstStart trigger is enabled
        and the FrameBurstEnd trigger is disabled. Note that the total
        number of frames captured is also conditioned by
        AcquisitionFrameCount if AcquisitionMode is MultiFrame and ignored
        if AcquisitionMode is Single.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("AcquisitionBurstFrameCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AcquisitionBurstFrameCount))
            node = self._nodes["AcquisitionBurstFrameCount"] = node_inst
        return node

    @property
    def EventTest(self) -> SpinIntNode:
        """Returns the unique identifier of the Test type of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventTest")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventTest))
            node = self._nodes["EventTest"] = node_inst
        return node

    @property
    def EventTestTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Test Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventTestTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventTestTimestamp))
            node = self._nodes["EventTestTimestamp"] = node_inst
        return node

    @property
    def EventExposureEndFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Exposure End Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventExposureEndFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventExposureEndFrameID))
            node = self._nodes["EventExposureEndFrameID"] = node_inst
        return node

    @property
    def EventExposureEnd(self) -> SpinIntNode:
        """Returns the unique identifier of the Exposure End type of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventExposureEnd")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventExposureEnd))
            node = self._nodes["EventExposureEnd"] = node_inst
        return node

    @property
    def EventExposureEndTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Exposure End Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventExposureEndTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventExposureEndTimestamp))
            node = self._nodes["EventExposureEndTimestamp"] = node_inst
        return node

    @property
    def EventError(self) -> SpinIntNode:
        """Returns the unique identifier of the Error type of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventError")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventError))
            node = self._nodes["EventError"] = node_inst
        return node

    @property
    def EventErrorTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Error Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventErrorTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventErrorTimestamp))
            node = self._nodes["EventErrorTimestamp"] = node_inst
        return node

    @property
    def EventErrorCode(self) -> SpinIntNode:
        """Returns the error code for the error that happened

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventErrorCode")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventErrorCode))
            node = self._nodes["EventErrorCode"] = node_inst
        return node

    @property
    def EventErrorFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Error Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventErrorFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventErrorFrameID))
            node = self._nodes["EventErrorFrameID"] = node_inst
        return node

    @property
    def EventSelector(self) -> SpinEnumDefNode:
        """Selects which Event to enable or disable.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.EventSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("EventSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventSelector))
            node_inst.enum_names = rotpy.names.camera.EventSelector_names
            node_inst.enum_values = rotpy.names.camera.EventSelector_values
            node = self._nodes["EventSelector"] = node_inst
        return node

    @property
    def EventSerialReceiveOverflow(self) -> SpinBoolNode:
        """Returns the status of the event serial receive overflow.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("EventSerialReceiveOverflow")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventSerialReceiveOverflow))
            node = self._nodes["EventSerialReceiveOverflow"] = node_inst
        return node

    @property
    def EventSerialPortReceive(self) -> SpinIntNode:
        """Returns the unique identifier of the Serial Port Receive type of
        Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventSerialPortReceive")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventSerialPortReceive))
            node = self._nodes["EventSerialPortReceive"] = node_inst
        return node

    @property
    def EventSerialPortReceiveTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Serial Port Receive Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventSerialPortReceiveTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventSerialPortReceiveTimestamp))
            node = self._nodes["EventSerialPortReceiveTimestamp"] = node_inst
        return node

    @property
    def EventSerialData(self) -> SpinStrNode:
        """Returns the serial data that was received.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("EventSerialData")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventSerialData))
            node = self._nodes["EventSerialData"] = node_inst
        return node

    @property
    def EventSerialDataLength(self) -> SpinIntNode:
        """Returns the length of the received serial data that was included in
        the event payload.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventSerialDataLength")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventSerialDataLength))
            node = self._nodes["EventSerialDataLength"] = node_inst
        return node

    @property
    def EventNotification(self) -> SpinEnumDefNode:
        """Enables/Disables the selected event.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.EventNotification_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("EventNotification")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventNotification))
            node_inst.enum_names = rotpy.names.camera.EventNotification_names
            node_inst.enum_values = rotpy.names.camera.EventNotification_values
            node = self._nodes["EventNotification"] = node_inst
        return node

    @property
    def LogicBlockLUTRowIndex(self) -> SpinIntNode:
        """Controls the row of the truth table to access in the selected LUT.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("LogicBlockLUTRowIndex")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().LogicBlockLUTRowIndex))
            node = self._nodes["LogicBlockLUTRowIndex"] = node_inst
        return node

    @property
    def LogicBlockSelector(self) -> SpinEnumDefNode:
        """Selects which LogicBlock to configure

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.LogicBlockSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("LogicBlockSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().LogicBlockSelector))
            node_inst.enum_names = rotpy.names.camera.LogicBlockSelector_names
            node_inst.enum_values = rotpy.names.camera.LogicBlockSelector_values
            node = self._nodes["LogicBlockSelector"] = node_inst
        return node

    @property
    def LogicBlockLUTInputActivation(self) -> SpinEnumDefNode:
        """Selects the activation mode of the Logic Input Source signal.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.LogicBlockLUTInputActivation_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("LogicBlockLUTInputActivation")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().LogicBlockLUTInputActivation))
            node_inst.enum_names = rotpy.names.camera.LogicBlockLUTInputActivation_names
            node_inst.enum_values = rotpy.names.camera.LogicBlockLUTInputActivation_values
            node = self._nodes["LogicBlockLUTInputActivation"] = node_inst
        return node

    @property
    def LogicBlockLUTInputSelector(self) -> SpinEnumDefNode:
        """Controls which LogicBlockLUT Input Source & Activation to access.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.LogicBlockLUTInputSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("LogicBlockLUTInputSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().LogicBlockLUTInputSelector))
            node_inst.enum_names = rotpy.names.camera.LogicBlockLUTInputSelector_names
            node_inst.enum_values = rotpy.names.camera.LogicBlockLUTInputSelector_values
            node = self._nodes["LogicBlockLUTInputSelector"] = node_inst
        return node

    @property
    def LogicBlockLUTInputSource(self) -> SpinEnumDefNode:
        """Selects the source for the input into the Logic LUT.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.LogicBlockLUTInputSource_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("LogicBlockLUTInputSource")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().LogicBlockLUTInputSource))
            node_inst.enum_names = rotpy.names.camera.LogicBlockLUTInputSource_names
            node_inst.enum_values = rotpy.names.camera.LogicBlockLUTInputSource_values
            node = self._nodes["LogicBlockLUTInputSource"] = node_inst
        return node

    @property
    def LogicBlockLUTOutputValue(self) -> SpinBoolNode:
        """Controls the output column of the truth table for the selected
        LogicBlockLUTRowIndex.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("LogicBlockLUTOutputValue")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().LogicBlockLUTOutputValue))
            node = self._nodes["LogicBlockLUTOutputValue"] = node_inst
        return node

    @property
    def LogicBlockLUTOutputValueAll(self) -> SpinIntNode:
        """Sets the value of all the output bits in the selected LUT.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("LogicBlockLUTOutputValueAll")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().LogicBlockLUTOutputValueAll))
            node = self._nodes["LogicBlockLUTOutputValueAll"] = node_inst
        return node

    @property
    def LogicBlockLUTSelector(self) -> SpinEnumDefNode:
        """Selects which LogicBlock LUT to configure

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.LogicBlockLUTSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("LogicBlockLUTSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().LogicBlockLUTSelector))
            node_inst.enum_names = rotpy.names.camera.LogicBlockLUTSelector_names
            node_inst.enum_values = rotpy.names.camera.LogicBlockLUTSelector_values
            node = self._nodes["LogicBlockLUTSelector"] = node_inst
        return node

    @property
    def ColorTransformationValue(self) -> SpinFloatNode:
        """Represents the value of the selected Gain factor or Offset inside
        the Transformation matrix in floating point precision.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("ColorTransformationValue")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ColorTransformationValue))
            node = self._nodes["ColorTransformationValue"] = node_inst
        return node

    @property
    def ColorTransformationEnable(self) -> SpinBoolNode:
        """Enables/disables the color transform selected with
        ColorTransformationSelector. For RGB to YUV this is read-only.
        Enabling/disabling RGB to YUV can only be done by changing pixel
        format.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("ColorTransformationEnable")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ColorTransformationEnable))
            node = self._nodes["ColorTransformationEnable"] = node_inst
        return node

    @property
    def ColorTransformationSelector(self) -> SpinEnumDefNode:
        """Selects which Color Transformation module is controlled by the
        various Color Transformation features

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ColorTransformationSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ColorTransformationSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ColorTransformationSelector))
            node_inst.enum_names = rotpy.names.camera.ColorTransformationSelector_names
            node_inst.enum_values = rotpy.names.camera.ColorTransformationSelector_values
            node = self._nodes["ColorTransformationSelector"] = node_inst
        return node

    @property
    def RgbTransformLightSource(self) -> SpinEnumDefNode:
        """Used to select from a set of RGBtoRGB transform matricies calibrated
        for different light sources. Selecting a value also sets the white
        balance ratios (BalanceRatioRed and BalanceRatioBlue), but those can
        be overwritten through manual or auto white balance.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.RgbTransformLightSource_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("RgbTransformLightSource")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().RgbTransformLightSource))
            node_inst.enum_names = rotpy.names.camera.RgbTransformLightSource_names
            node_inst.enum_values = rotpy.names.camera.RgbTransformLightSource_values
            node = self._nodes["RgbTransformLightSource"] = node_inst
        return node

    @property
    def Saturation(self) -> SpinFloatNode:
        """    Controls the color saturation.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("Saturation")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().Saturation))
            node = self._nodes["Saturation"] = node_inst
        return node

    @property
    def SaturationEnable(self) -> SpinBoolNode:
        """    Enables/disables Saturation adjustment.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("SaturationEnable")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SaturationEnable))
            node = self._nodes["SaturationEnable"] = node_inst
        return node

    @property
    def ColorTransformationValueSelector(self) -> SpinEnumDefNode:
        """Selects the Gain factor or Offset of the Transformation matrix to
        access in the selected Color Transformation module

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ColorTransformationValueSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ColorTransformationValueSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ColorTransformationValueSelector))
            node_inst.enum_names = rotpy.names.camera.ColorTransformationValueSelector_names
            node_inst.enum_values = rotpy.names.camera.ColorTransformationValueSelector_values
            node = self._nodes["ColorTransformationValueSelector"] = node_inst
        return node

    @property
    def TimestampLatchValue(self) -> SpinIntNode:
        """Returns the latched value of the timestamp counter.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("TimestampLatchValue")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TimestampLatchValue))
            node = self._nodes["TimestampLatchValue"] = node_inst
        return node

    @property
    def TimestampReset(self) -> SpinCommandNode:
        """Resets the current value of the device timestamp counter.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("TimestampReset")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TimestampReset))
            node = self._nodes["TimestampReset"] = node_inst
        return node

    @property
    def DeviceUserID(self) -> SpinStrNode:
        """User-programmable device identifier.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("DeviceUserID")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceUserID))
            node = self._nodes["DeviceUserID"] = node_inst
        return node

    @property
    def DeviceTemperature(self) -> SpinFloatNode:
        """Device temperature in degrees Celsius (C).

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("DeviceTemperature")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceTemperature))
            node = self._nodes["DeviceTemperature"] = node_inst
        return node

    @property
    def MaxDeviceResetTime(self) -> SpinIntNode:
        """Time to wait until device reset complete (ms).

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("MaxDeviceResetTime")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().MaxDeviceResetTime))
            node = self._nodes["MaxDeviceResetTime"] = node_inst
        return node

    @property
    def DeviceTLVersionMinor(self) -> SpinIntNode:
        """Minor version of the Transport Layer of the device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceTLVersionMinor")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceTLVersionMinor))
            node = self._nodes["DeviceTLVersionMinor"] = node_inst
        return node

    @property
    def DeviceSerialNumber(self) -> SpinStrNode:
        """Device's serial number. This string is a unique identifier of the
        device.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("DeviceSerialNumber")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceSerialNumber))
            node = self._nodes["DeviceSerialNumber"] = node_inst
        return node

    @property
    def DeviceVendorName(self) -> SpinStrNode:
        """Name of the manufacturer of the device.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("DeviceVendorName")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceVendorName))
            node = self._nodes["DeviceVendorName"] = node_inst
        return node

    @property
    def DeviceRegistersEndianness(self) -> SpinEnumDefNode:
        """Endianness of the registers of the device.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.DeviceRegistersEndianness_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("DeviceRegistersEndianness")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceRegistersEndianness))
            node_inst.enum_names = rotpy.names.camera.DeviceRegistersEndianness_names
            node_inst.enum_values = rotpy.names.camera.DeviceRegistersEndianness_values
            node = self._nodes["DeviceRegistersEndianness"] = node_inst
        return node

    @property
    def DeviceManufacturerInfo(self) -> SpinStrNode:
        """Manufacturer information about the device.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("DeviceManufacturerInfo")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceManufacturerInfo))
            node = self._nodes["DeviceManufacturerInfo"] = node_inst
        return node

    @property
    def DeviceLinkSpeed(self) -> SpinIntNode:
        """Indicates the speed of transmission negotiated on the specified
        Link. (Bps)

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceLinkSpeed")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceLinkSpeed))
            node = self._nodes["DeviceLinkSpeed"] = node_inst
        return node

    @property
    def LinkUptime(self) -> SpinIntNode:
        """Time since the last phy negotiation (enumeration).

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("LinkUptime")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().LinkUptime))
            node = self._nodes["LinkUptime"] = node_inst
        return node

    @property
    def DeviceEventChannelCount(self) -> SpinIntNode:
        """Indicates the number of event channels supported by the device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceEventChannelCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceEventChannelCount))
            node = self._nodes["DeviceEventChannelCount"] = node_inst
        return node

    @property
    def TimestampLatch(self) -> SpinCommandNode:
        """Latches the current timestamp counter into TimestampLatchValue.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("TimestampLatch")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TimestampLatch))
            node = self._nodes["TimestampLatch"] = node_inst
        return node

    @property
    def DeviceScanType(self) -> SpinEnumDefNode:
        """Scan type of the sensor of the device.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.DeviceScanType_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("DeviceScanType")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceScanType))
            node_inst.enum_names = rotpy.names.camera.DeviceScanType_names
            node_inst.enum_values = rotpy.names.camera.DeviceScanType_values
            node = self._nodes["DeviceScanType"] = node_inst
        return node

    @property
    def DeviceReset(self) -> SpinCommandNode:
        """This is a command that immediately resets and reboots the device.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("DeviceReset")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceReset))
            node = self._nodes["DeviceReset"] = node_inst
        return node

    @property
    def DeviceCharacterSet(self) -> SpinEnumDefNode:
        """Character set used by the strings of the device`s bootstrap
        registers.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.DeviceCharacterSet_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("DeviceCharacterSet")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceCharacterSet))
            node_inst.enum_names = rotpy.names.camera.DeviceCharacterSet_names
            node_inst.enum_values = rotpy.names.camera.DeviceCharacterSet_values
            node = self._nodes["DeviceCharacterSet"] = node_inst
        return node

    @property
    def DeviceLinkThroughputLimit(self) -> SpinIntNode:
        """Limits the maximum bandwidth of the data that will be streamed out
        by the device on the selected Link. If necessary, delays will be
        uniformly inserted between transport layer packets in order to
        control the peak bandwidth.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceLinkThroughputLimit")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceLinkThroughputLimit))
            node = self._nodes["DeviceLinkThroughputLimit"] = node_inst
        return node

    @property
    def DeviceFirmwareVersion(self) -> SpinStrNode:
        """Version of the firmware on the device.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("DeviceFirmwareVersion")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceFirmwareVersion))
            node = self._nodes["DeviceFirmwareVersion"] = node_inst
        return node

    @property
    def DeviceStreamChannelCount(self) -> SpinIntNode:
        """Indicates the number of streaming channels supported by the device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceStreamChannelCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceStreamChannelCount))
            node = self._nodes["DeviceStreamChannelCount"] = node_inst
        return node

    @property
    def DeviceTLType(self) -> SpinEnumDefNode:
        """Transport Layer type of the device.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.DeviceTLType_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("DeviceTLType")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceTLType))
            node_inst.enum_names = rotpy.names.camera.DeviceTLType_names
            node_inst.enum_values = rotpy.names.camera.DeviceTLType_values
            node = self._nodes["DeviceTLType"] = node_inst
        return node

    @property
    def DeviceVersion(self) -> SpinStrNode:
        """Version of the device.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("DeviceVersion")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceVersion))
            node = self._nodes["DeviceVersion"] = node_inst
        return node

    @property
    def DevicePowerSupplySelector(self) -> SpinEnumDefNode:
        """Selects the power supply source to control or read.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.DevicePowerSupplySelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("DevicePowerSupplySelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DevicePowerSupplySelector))
            node_inst.enum_names = rotpy.names.camera.DevicePowerSupplySelector_names
            node_inst.enum_values = rotpy.names.camera.DevicePowerSupplySelector_values
            node = self._nodes["DevicePowerSupplySelector"] = node_inst
        return node

    @property
    def SensorDescription(self) -> SpinStrNode:
        """Returns Sensor Description

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("SensorDescription")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SensorDescription))
            node = self._nodes["SensorDescription"] = node_inst
        return node

    @property
    def DeviceModelName(self) -> SpinStrNode:
        """Model of the device.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("DeviceModelName")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceModelName))
            node = self._nodes["DeviceModelName"] = node_inst
        return node

    @property
    def DeviceTLVersionMajor(self) -> SpinIntNode:
        """Major version of the Transport Layer of the device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceTLVersionMajor")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceTLVersionMajor))
            node = self._nodes["DeviceTLVersionMajor"] = node_inst
        return node

    @property
    def DeviceTemperatureSelector(self) -> SpinEnumDefNode:
        """Selects the location within the device, where the temperature will
        be measured.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.DeviceTemperatureSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("DeviceTemperatureSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceTemperatureSelector))
            node_inst.enum_names = rotpy.names.camera.DeviceTemperatureSelector_names
            node_inst.enum_values = rotpy.names.camera.DeviceTemperatureSelector_values
            node = self._nodes["DeviceTemperatureSelector"] = node_inst
        return node

    @property
    def EnumerationCount(self) -> SpinIntNode:
        """Number of enumerations since uptime.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EnumerationCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EnumerationCount))
            node = self._nodes["EnumerationCount"] = node_inst
        return node

    @property
    def PowerSupplyCurrent(self) -> SpinFloatNode:
        """Indicates the output current of the selected power supply (A).

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("PowerSupplyCurrent")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().PowerSupplyCurrent))
            node = self._nodes["PowerSupplyCurrent"] = node_inst
        return node

    @property
    def DeviceID(self) -> SpinStrNode:
        """Device identifier (serial number).

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("DeviceID")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceID))
            node = self._nodes["DeviceID"] = node_inst
        return node

    @property
    def DeviceUptime(self) -> SpinIntNode:
        """Total time since the device was powered up in seconds.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceUptime")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceUptime))
            node = self._nodes["DeviceUptime"] = node_inst
        return node

    @property
    def DeviceLinkCurrentThroughput(self) -> SpinIntNode:
        """Current bandwidth of streamed data.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceLinkCurrentThroughput")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceLinkCurrentThroughput))
            node = self._nodes["DeviceLinkCurrentThroughput"] = node_inst
        return node

    @property
    def DeviceMaxThroughput(self) -> SpinIntNode:
        """Maximum bandwidth of the data that can be streamed out of the
        device. This can be used to estimate if the physical connection(s)
        can sustain transfer of free-running images from the camera at its
        maximum speed.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceMaxThroughput")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceMaxThroughput))
            node = self._nodes["DeviceMaxThroughput"] = node_inst
        return node

    @property
    def FactoryReset(self) -> SpinCommandNode:
        """Returns all user tables to factory default

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("FactoryReset")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().FactoryReset))
            node = self._nodes["FactoryReset"] = node_inst
        return node

    @property
    def PowerSupplyVoltage(self) -> SpinFloatNode:
        """Indicates the current voltage of the selected power supply (V).

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("PowerSupplyVoltage")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().PowerSupplyVoltage))
            node = self._nodes["PowerSupplyVoltage"] = node_inst
        return node

    @property
    def DeviceIndicatorMode(self) -> SpinEnumDefNode:
        """Controls the LED behaviour: Inactive (off), Active (current status),
        or Error Status (off unless an error occurs).

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.DeviceIndicatorMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("DeviceIndicatorMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceIndicatorMode))
            node_inst.enum_names = rotpy.names.camera.DeviceIndicatorMode_names
            node_inst.enum_values = rotpy.names.camera.DeviceIndicatorMode_values
            node = self._nodes["DeviceIndicatorMode"] = node_inst
        return node

    @property
    def DeviceLinkBandwidthReserve(self) -> SpinFloatNode:
        """Percentage of streamed data bandwidth reserved for packet resend.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("DeviceLinkBandwidthReserve")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceLinkBandwidthReserve))
            node = self._nodes["DeviceLinkBandwidthReserve"] = node_inst
        return node

    @property
    def AasRoiOffsetY(self) -> SpinIntNode:
        """Controls the y-offset of the ROI used by the auto algorithm that is
        currently selected by the AutoAlgorithmSelector feature.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("AasRoiOffsetY")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AasRoiOffsetY))
            node = self._nodes["AasRoiOffsetY"] = node_inst
        return node

    @property
    def AasRoiOffsetX(self) -> SpinIntNode:
        """Controls the x-offset of the ROI used by the auto algorithm that is
        currently selected by the AutoAlgorithmSelector feature.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("AasRoiOffsetX")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AasRoiOffsetX))
            node = self._nodes["AasRoiOffsetX"] = node_inst
        return node

    @property
    def AutoExposureControlPriority(self) -> SpinEnumDefNode:
        """Selects whether to adjust gain or exposure first. When gain priority
        is selected, the camera fixes the gain to 0 dB, and the exposure is
        adjusted according to the target grey level. If the maximum exposure
        is reached before the target grey level is hit, the gain starts to
        change to meet the target. This mode is used to have the minimum
        noise.      When exposure priority is selected, the camera sets the
        exposure to a small value (default is 5 ms). The gain is adjusted
        according to the target grey level. If maximum gain is reached
        before the target grey level is hit, the exposure starts to change
        to meet the target. This mode is used to capture fast motion.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.AutoExposureControlPriority_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("AutoExposureControlPriority")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AutoExposureControlPriority))
            node_inst.enum_names = rotpy.names.camera.AutoExposureControlPriority_names
            node_inst.enum_values = rotpy.names.camera.AutoExposureControlPriority_values
            node = self._nodes["AutoExposureControlPriority"] = node_inst
        return node

    @property
    def BalanceWhiteAutoLowerLimit(self) -> SpinFloatNode:
        """Controls the minimum value Auto White Balance can set for the
        Red/Blue BalanceRatio.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("BalanceWhiteAutoLowerLimit")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().BalanceWhiteAutoLowerLimit))
            node = self._nodes["BalanceWhiteAutoLowerLimit"] = node_inst
        return node

    @property
    def BalanceWhiteAutoDamping(self) -> SpinFloatNode:
        """Controls how quickly 'BalanceWhiteAuto' adjusts the values for Red
        and Blue BalanceRatio in response to changing conditions.  Higher
        damping means the changes are more gradual.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("BalanceWhiteAutoDamping")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().BalanceWhiteAutoDamping))
            node = self._nodes["BalanceWhiteAutoDamping"] = node_inst
        return node

    @property
    def AasRoiHeight(self) -> SpinIntNode:
        """Controls the width of the ROI used by the auto algorithm that is
        currently selected by the AutoAlgorithmSelector feature.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("AasRoiHeight")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AasRoiHeight))
            node = self._nodes["AasRoiHeight"] = node_inst
        return node

    @property
    def AutoExposureGreyValueUpperLimit(self) -> SpinFloatNode:
        """The highest value in percentage that the target mean may reach.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("AutoExposureGreyValueUpperLimit")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AutoExposureGreyValueUpperLimit))
            node = self._nodes["AutoExposureGreyValueUpperLimit"] = node_inst
        return node

    @property
    def AutoExposureTargetGreyValue(self) -> SpinFloatNode:
        """This is the user-specified target grey level (image mean) to apply
        to the current image. Note that the target grey level is in the
        linear domain before gamma correction is applied.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("AutoExposureTargetGreyValue")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AutoExposureTargetGreyValue))
            node = self._nodes["AutoExposureTargetGreyValue"] = node_inst
        return node

    @property
    def AutoExposureGainLowerLimit(self) -> SpinFloatNode:
        """The smallest gain that auto exposure can set.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("AutoExposureGainLowerLimit")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AutoExposureGainLowerLimit))
            node = self._nodes["AutoExposureGainLowerLimit"] = node_inst
        return node

    @property
    def AutoExposureGreyValueLowerLimit(self) -> SpinFloatNode:
        """The lowest value in percentage that the target mean may reach.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("AutoExposureGreyValueLowerLimit")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AutoExposureGreyValueLowerLimit))
            node = self._nodes["AutoExposureGreyValueLowerLimit"] = node_inst
        return node

    @property
    def AutoExposureMeteringMode(self) -> SpinEnumDefNode:
        """Selects a metering mode: average, spot, or partial metering. a.
        Average: Measures the light from the entire scene uniformly to
        determine the final exposure value. Every portion of the exposed
        area has the same contribution. b. Spot: Measures a small area
        (about 3%) in the center of the scene while the rest of the scene is
        ignored. This mode is used when the scene has a high contrast and
        the object of interest is relatively small. c. Partial: Measures the
        light from a larger area (about 11%) in the center of the scene.
        This mode is used when very dark or bright regions appear at the
        edge of the frame. Note: Metering mode is available only when
        Lighting Mode Selector is Normal.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.AutoExposureMeteringMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("AutoExposureMeteringMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AutoExposureMeteringMode))
            node_inst.enum_names = rotpy.names.camera.AutoExposureMeteringMode_names
            node_inst.enum_values = rotpy.names.camera.AutoExposureMeteringMode_values
            node = self._nodes["AutoExposureMeteringMode"] = node_inst
        return node

    @property
    def AutoExposureExposureTimeUpperLimit(self) -> SpinFloatNode:
        """The largest exposure time that auto exposure can set.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("AutoExposureExposureTimeUpperLimit")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AutoExposureExposureTimeUpperLimit))
            node = self._nodes["AutoExposureExposureTimeUpperLimit"] = node_inst
        return node

    @property
    def AutoExposureGainUpperLimit(self) -> SpinFloatNode:
        """The largest gain that auto exposure can set.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("AutoExposureGainUpperLimit")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AutoExposureGainUpperLimit))
            node = self._nodes["AutoExposureGainUpperLimit"] = node_inst
        return node

    @property
    def AutoExposureControlLoopDamping(self) -> SpinFloatNode:
        """It controls how fast the exposure and gain get settled. If the value
        is too small, it may cause the system to be unstable.    Range is
        from 0.0 to 1.0. Default = 0.2.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("AutoExposureControlLoopDamping")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AutoExposureControlLoopDamping))
            node = self._nodes["AutoExposureControlLoopDamping"] = node_inst
        return node

    @property
    def AutoExposureEVCompensation(self) -> SpinFloatNode:
        """The EV compensation value used in the exposure compensation. This
        allows you to adjust the resultant image intensity with one control.
        A positive value makes the image brighter. A negative value makes
        the image darker. Range from -3 to 3 with a step of 1/3. Default =
        0.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("AutoExposureEVCompensation")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AutoExposureEVCompensation))
            node = self._nodes["AutoExposureEVCompensation"] = node_inst
        return node

    @property
    def AutoExposureExposureTimeLowerLimit(self) -> SpinFloatNode:
        """The smallest exposure time that auto exposure can set.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("AutoExposureExposureTimeLowerLimit")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AutoExposureExposureTimeLowerLimit))
            node = self._nodes["AutoExposureExposureTimeLowerLimit"] = node_inst
        return node

    @property
    def BalanceWhiteAutoProfile(self) -> SpinEnumDefNode:
        """Selects the profile used by BalanceWhiteAuto.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.BalanceWhiteAutoProfile_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("BalanceWhiteAutoProfile")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().BalanceWhiteAutoProfile))
            node_inst.enum_names = rotpy.names.camera.BalanceWhiteAutoProfile_names
            node_inst.enum_values = rotpy.names.camera.BalanceWhiteAutoProfile_values
            node = self._nodes["BalanceWhiteAutoProfile"] = node_inst
        return node

    @property
    def AutoAlgorithmSelector(self) -> SpinEnumDefNode:
        """Selects which Auto Algorithm is controlled by the RoiEnable,
        OffsetX, OffsetY, Width, Height features.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.AutoAlgorithmSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("AutoAlgorithmSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AutoAlgorithmSelector))
            node_inst.enum_names = rotpy.names.camera.AutoAlgorithmSelector_names
            node_inst.enum_values = rotpy.names.camera.AutoAlgorithmSelector_values
            node = self._nodes["AutoAlgorithmSelector"] = node_inst
        return node

    @property
    def AutoExposureTargetGreyValueAuto(self) -> SpinEnumDefNode:
        """This indicates whether the target image grey level is automatically
        set by the camera or manually set by the user. Note that the target
        grey level is in the linear domain before gamma correction is
        applied.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.AutoExposureTargetGreyValueAuto_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("AutoExposureTargetGreyValueAuto")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AutoExposureTargetGreyValueAuto))
            node_inst.enum_names = rotpy.names.camera.AutoExposureTargetGreyValueAuto_names
            node_inst.enum_values = rotpy.names.camera.AutoExposureTargetGreyValueAuto_values
            node = self._nodes["AutoExposureTargetGreyValueAuto"] = node_inst
        return node

    @property
    def AasRoiEnable(self) -> SpinBoolNode:
        """Controls whether a user-specified ROI is used for auto algorithm
        that is currently selected by the AutoAlgorithmSelector feature.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("AasRoiEnable")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AasRoiEnable))
            node = self._nodes["AasRoiEnable"] = node_inst
        return node

    @property
    def AutoExposureLightingMode(self) -> SpinEnumDefNode:
        """Selects a lighting mode: Backlight, Frontlight or Normal (default).
        a. Backlight compensation: used when a strong light is coming from
        the back of the object. b. Frontlight compensation: used when a
        strong light is shining in the front of the object while the
        background is dark. c. Normal lighting: used when the object is not
        under backlight or frontlight conditions. When normal lighting is
        selected, metering modes are available.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.AutoExposureLightingMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("AutoExposureLightingMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AutoExposureLightingMode))
            node_inst.enum_names = rotpy.names.camera.AutoExposureLightingMode_names
            node_inst.enum_values = rotpy.names.camera.AutoExposureLightingMode_values
            node = self._nodes["AutoExposureLightingMode"] = node_inst
        return node

    @property
    def AasRoiWidth(self) -> SpinIntNode:
        """Controls the width of the ROI used by the auto algorithm that is
        currently selected by the AutoAlgorithmSelector feature.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("AasRoiWidth")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AasRoiWidth))
            node = self._nodes["AasRoiWidth"] = node_inst
        return node

    @property
    def BalanceWhiteAutoUpperLimit(self) -> SpinFloatNode:
        """Controls the maximum value Auto White Balance can set the Red/Blue
        BalanceRatio.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("BalanceWhiteAutoUpperLimit")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().BalanceWhiteAutoUpperLimit))
            node = self._nodes["BalanceWhiteAutoUpperLimit"] = node_inst
        return node

    @property
    def LinkErrorCount(self) -> SpinIntNode:
        """Counts the number of error on the link.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("LinkErrorCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().LinkErrorCount))
            node = self._nodes["LinkErrorCount"] = node_inst
        return node

    @property
    def GevCurrentIPConfigurationDHCP(self) -> SpinBoolNode:
        """Controls whether the DHCP IP configuration scheme is activated on
        the given logical link.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("GevCurrentIPConfigurationDHCP")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevCurrentIPConfigurationDHCP))
            node = self._nodes["GevCurrentIPConfigurationDHCP"] = node_inst
        return node

    @property
    def GevInterfaceSelector(self) -> SpinIntNode:
        """Selects which logical link to control.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevInterfaceSelector")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevInterfaceSelector))
            node = self._nodes["GevInterfaceSelector"] = node_inst
        return node

    @property
    def GevSCPD(self) -> SpinIntNode:
        """Controls the delay (in GEV timestamp counter unit) to insert between
        each packet for this stream channel. This can be used as a crude
        flow-control mechanism if the application or the network
        infrastructure cannot keep up with the packets coming from the
        device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevSCPD")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevSCPD))
            node = self._nodes["GevSCPD"] = node_inst
        return node

    @property
    def GevTimestampTickFrequency(self) -> SpinIntNode:
        """Indicates the number of timestamp ticks in 1 second (frequency in
        Hz).

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevTimestampTickFrequency")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevTimestampTickFrequency))
            node = self._nodes["GevTimestampTickFrequency"] = node_inst
        return node

    @property
    def GevSCPSPacketSize(self) -> SpinIntNode:
        """Specifies the stream packet size (in bytes) to send on this channel.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevSCPSPacketSize")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevSCPSPacketSize))
            node = self._nodes["GevSCPSPacketSize"] = node_inst
        return node

    @property
    def GevCurrentDefaultGateway(self) -> SpinIntNode:
        """Reports the default gateway IP address to be used on the given
        logical link.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevCurrentDefaultGateway")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevCurrentDefaultGateway))
            node = self._nodes["GevCurrentDefaultGateway"] = node_inst
        return node

    @property
    def GevSCCFGUnconditionalStreaming(self) -> SpinBoolNode:
        """Enables the camera to continue to stream, for this stream channel,
        if its control channel is closed or regardless of the reception of
        any ICMP messages (such as destination unreachable messages).

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("GevSCCFGUnconditionalStreaming")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevSCCFGUnconditionalStreaming))
            node = self._nodes["GevSCCFGUnconditionalStreaming"] = node_inst
        return node

    @property
    def GevMCTT(self) -> SpinIntNode:
        """Indicates the transmission timeout of the message channel.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevMCTT")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevMCTT))
            node = self._nodes["GevMCTT"] = node_inst
        return node

    @property
    def GevSCPSDoNotFragment(self) -> SpinBoolNode:
        """The state of this feature is copied into the "do not fragment" bit
        of the IP header of each stream packet.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("GevSCPSDoNotFragment")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevSCPSDoNotFragment))
            node = self._nodes["GevSCPSDoNotFragment"] = node_inst
        return node

    @property
    def GevCurrentSubnetMask(self) -> SpinIntNode:
        """Reports the subnet mask of the given logical link.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevCurrentSubnetMask")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevCurrentSubnetMask))
            node = self._nodes["GevCurrentSubnetMask"] = node_inst
        return node

    @property
    def GevStreamChannelSelector(self) -> SpinIntNode:
        """Selects the stream channel to control.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevStreamChannelSelector")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevStreamChannelSelector))
            node = self._nodes["GevStreamChannelSelector"] = node_inst
        return node

    @property
    def GevCurrentIPAddress(self) -> SpinIntNode:
        """Reports the IP address for the given logical link.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevCurrentIPAddress")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevCurrentIPAddress))
            node = self._nodes["GevCurrentIPAddress"] = node_inst
        return node

    @property
    def GevMCSP(self) -> SpinIntNode:
        """Indicates the source port of the message channel.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevMCSP")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevMCSP))
            node = self._nodes["GevMCSP"] = node_inst
        return node

    @property
    def GevGVCPPendingTimeout(self) -> SpinIntNode:
        """Indicates the longest GVCP command execution time before the device
        returns a PENDING_ACK in milliseconds.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevGVCPPendingTimeout")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevGVCPPendingTimeout))
            node = self._nodes["GevGVCPPendingTimeout"] = node_inst
        return node

    @property
    def GevIEEE1588Status(self) -> SpinEnumDefNode:
        """Provides the status of the IEEE 1588 clock.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.GevIEEE1588Status_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("GevIEEE1588Status")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevIEEE1588Status))
            node_inst.enum_names = rotpy.names.camera.GevIEEE1588Status_names
            node_inst.enum_values = rotpy.names.camera.GevIEEE1588Status_values
            node = self._nodes["GevIEEE1588Status"] = node_inst
        return node

    @property
    def GevFirstURL(self) -> SpinStrNode:
        """The first choice of URL for the XML device description file.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("GevFirstURL")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevFirstURL))
            node = self._nodes["GevFirstURL"] = node_inst
        return node

    @property
    def GevMACAddress(self) -> SpinIntNode:
        """MAC address of the logical link.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevMACAddress")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevMACAddress))
            node = self._nodes["GevMACAddress"] = node_inst
        return node

    @property
    def GevPersistentSubnetMask(self) -> SpinIntNode:
        """Controls the Persistent subnet mask associated with the Persistent
        IP address on this logical link.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevPersistentSubnetMask")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevPersistentSubnetMask))
            node = self._nodes["GevPersistentSubnetMask"] = node_inst
        return node

    @property
    def GevMCPHostPort(self) -> SpinIntNode:
        """The port to which the device must send messages

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevMCPHostPort")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevMCPHostPort))
            node = self._nodes["GevMCPHostPort"] = node_inst
        return node

    @property
    def GevSCPHostPort(self) -> SpinIntNode:
        """Controls the port of the selected channel to which a GVSP
        transmitter must send data stream or the port from which a GVSP
        receiver may receive data stream.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevSCPHostPort")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevSCPHostPort))
            node = self._nodes["GevSCPHostPort"] = node_inst
        return node

    @property
    def GevGVCPPendingAck(self) -> SpinBoolNode:
        """Enables the generation of PENDING_ACK.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("GevGVCPPendingAck")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevGVCPPendingAck))
            node = self._nodes["GevGVCPPendingAck"] = node_inst
        return node

    @property
    def GevSCPInterfaceIndex(self) -> SpinIntNode:
        """Index of the logical link to use.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevSCPInterfaceIndex")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevSCPInterfaceIndex))
            node = self._nodes["GevSCPInterfaceIndex"] = node_inst
        return node

    @property
    def GevSupportedOption(self) -> SpinBoolNode:
        """Returns if the selected GEV option is supported.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("GevSupportedOption")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevSupportedOption))
            node = self._nodes["GevSupportedOption"] = node_inst
        return node

    @property
    def GevIEEE1588Mode(self) -> SpinEnumDefNode:
        """Provides the mode of the IEEE 1588 clock.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.GevIEEE1588Mode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("GevIEEE1588Mode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevIEEE1588Mode))
            node_inst.enum_names = rotpy.names.camera.GevIEEE1588Mode_names
            node_inst.enum_values = rotpy.names.camera.GevIEEE1588Mode_values
            node = self._nodes["GevIEEE1588Mode"] = node_inst
        return node

    @property
    def GevCurrentIPConfigurationLLA(self) -> SpinBoolNode:
        """Controls whether the Link Local Address IP configuration scheme is
        activated on the given logical link.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("GevCurrentIPConfigurationLLA")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevCurrentIPConfigurationLLA))
            node = self._nodes["GevCurrentIPConfigurationLLA"] = node_inst
        return node

    @property
    def GevSCSP(self) -> SpinIntNode:
        """Indicates the source port of the stream channel.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevSCSP")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevSCSP))
            node = self._nodes["GevSCSP"] = node_inst
        return node

    @property
    def GevIEEE1588(self) -> SpinBoolNode:
        """Enables the IEEE 1588 Precision Time Protocol to control the
        timestamp register.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("GevIEEE1588")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevIEEE1588))
            node = self._nodes["GevIEEE1588"] = node_inst
        return node

    @property
    def GevSCCFGExtendedChunkData(self) -> SpinBoolNode:
        """Enables cameras to use the extended chunk data payload type for this
        stream channel.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("GevSCCFGExtendedChunkData")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevSCCFGExtendedChunkData))
            node = self._nodes["GevSCCFGExtendedChunkData"] = node_inst
        return node

    @property
    def GevPersistentIPAddress(self) -> SpinIntNode:
        """Controls the Persistent IP address for this logical link.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevPersistentIPAddress")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevPersistentIPAddress))
            node = self._nodes["GevPersistentIPAddress"] = node_inst
        return node

    @property
    def GevCurrentIPConfigurationPersistentIP(self) -> SpinBoolNode:
        """Controls whether the PersistentIP configuration scheme is activated
        on the given logical link.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("GevCurrentIPConfigurationPersistentIP")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevCurrentIPConfigurationPersistentIP))
            node = self._nodes["GevCurrentIPConfigurationPersistentIP"] = node_inst
        return node

    @property
    def GevIEEE1588ClockAccuracy(self) -> SpinEnumDefNode:
        """Indicates the expected accuracy of the device clock when it is the
        grandmaster, or in the event it becomes the grandmaster.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.GevIEEE1588ClockAccuracy_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("GevIEEE1588ClockAccuracy")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevIEEE1588ClockAccuracy))
            node_inst.enum_names = rotpy.names.camera.GevIEEE1588ClockAccuracy_names
            node_inst.enum_values = rotpy.names.camera.GevIEEE1588ClockAccuracy_values
            node = self._nodes["GevIEEE1588ClockAccuracy"] = node_inst
        return node

    @property
    def GevHeartbeatTimeout(self) -> SpinIntNode:
        """Indicates the current heartbeat timeout in milliseconds.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevHeartbeatTimeout")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevHeartbeatTimeout))
            node = self._nodes["GevHeartbeatTimeout"] = node_inst
        return node

    @property
    def GevPersistentDefaultGateway(self) -> SpinIntNode:
        """Controls the persistent default gateway for this logical link.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevPersistentDefaultGateway")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevPersistentDefaultGateway))
            node = self._nodes["GevPersistentDefaultGateway"] = node_inst
        return node

    @property
    def GevCCP(self) -> SpinEnumDefNode:
        """Controls the device access privilege of an application.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.GevCCP_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("GevCCP")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevCCP))
            node_inst.enum_names = rotpy.names.camera.GevCCP_names
            node_inst.enum_values = rotpy.names.camera.GevCCP_values
            node = self._nodes["GevCCP"] = node_inst
        return node

    @property
    def GevMCDA(self) -> SpinIntNode:
        """Controls the destination IP address of the message channel

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevMCDA")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevMCDA))
            node = self._nodes["GevMCDA"] = node_inst
        return node

    @property
    def GevSCDA(self) -> SpinIntNode:
        """Controls the destination IP address of the selected stream channel
        to which a GVSP transmitter must send data stream or the destination
        IP address from which a GVSP receiver may receive data stream.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevSCDA")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevSCDA))
            node = self._nodes["GevSCDA"] = node_inst
        return node

    @property
    def GevSCPDirection(self) -> SpinIntNode:
        """Transmit or Receive of the channel

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevSCPDirection")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevSCPDirection))
            node = self._nodes["GevSCPDirection"] = node_inst
        return node

    @property
    def GevSCPSFireTestPacket(self) -> SpinBoolNode:
        """Sends a test packet.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("GevSCPSFireTestPacket")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevSCPSFireTestPacket))
            node = self._nodes["GevSCPSFireTestPacket"] = node_inst
        return node

    @property
    def GevSecondURL(self) -> SpinStrNode:
        """The second choice of URL to the XML device description file.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("GevSecondURL")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevSecondURL))
            node = self._nodes["GevSecondURL"] = node_inst
        return node

    @property
    def GevSupportedOptionSelector(self) -> SpinEnumDefNode:
        """Selects the GEV option to interrogate for existing support.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.GevSupportedOptionSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("GevSupportedOptionSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevSupportedOptionSelector))
            node_inst.enum_names = rotpy.names.camera.GevSupportedOptionSelector_names
            node_inst.enum_values = rotpy.names.camera.GevSupportedOptionSelector_values
            node = self._nodes["GevSupportedOptionSelector"] = node_inst
        return node

    @property
    def GevGVCPHeartbeatDisable(self) -> SpinBoolNode:
        """Disables the GVCP heartbeat.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("GevGVCPHeartbeatDisable")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevGVCPHeartbeatDisable))
            node = self._nodes["GevGVCPHeartbeatDisable"] = node_inst
        return node

    @property
    def GevMCRC(self) -> SpinIntNode:
        """Indicates the number of retries of the message channel.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevMCRC")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevMCRC))
            node = self._nodes["GevMCRC"] = node_inst
        return node

    @property
    def GevSCPSBigEndian(self) -> SpinBoolNode:
        """Endianness of multi-byte pixel data for this stream.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("GevSCPSBigEndian")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevSCPSBigEndian))
            node = self._nodes["GevSCPSBigEndian"] = node_inst
        return node

    @property
    def GevNumberOfInterfaces(self) -> SpinIntNode:
        """Indicates the number of physical network interfaces supported by
        this device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevNumberOfInterfaces")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevNumberOfInterfaces))
            node = self._nodes["GevNumberOfInterfaces"] = node_inst
        return node

    @property
    def TLParamsLocked(self) -> SpinIntNode:
        """

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("TLParamsLocked")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLParamsLocked))
            node = self._nodes["TLParamsLocked"] = node_inst
        return node

    @property
    def PayloadSize(self) -> SpinIntNode:
        """Provides the number of bytes transferred for each image or chunk on
        the stream channel.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("PayloadSize")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().PayloadSize))
            node = self._nodes["PayloadSize"] = node_inst
        return node

    @property
    def PacketResendRequestCount(self) -> SpinIntNode:
        """Counts the number of resend requests received from the host.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("PacketResendRequestCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().PacketResendRequestCount))
            node = self._nodes["PacketResendRequestCount"] = node_inst
        return node

    @property
    def SharpeningEnable(self) -> SpinBoolNode:
        """Enables/disables the sharpening feature. Sharpening is disabled by
        default.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("SharpeningEnable")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SharpeningEnable))
            node = self._nodes["SharpeningEnable"] = node_inst
        return node

    @property
    def BlackLevelSelector(self) -> SpinEnumDefNode:
        """Selects which black level to control.  Only All can be set by the
        user. Analog and Digital are read-only.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.BlackLevelSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("BlackLevelSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().BlackLevelSelector))
            node_inst.enum_names = rotpy.names.camera.BlackLevelSelector_names
            node_inst.enum_values = rotpy.names.camera.BlackLevelSelector_values
            node = self._nodes["BlackLevelSelector"] = node_inst
        return node

    @property
    def GammaEnable(self) -> SpinBoolNode:
        """Enables/disables gamma correction.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("GammaEnable")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GammaEnable))
            node = self._nodes["GammaEnable"] = node_inst
        return node

    @property
    def SharpeningAuto(self) -> SpinBoolNode:
        """Enables/disables the auto sharpening feature. When enabled, the
        camera automatically determines the sharpening threshold based on
        the noise level of the camera.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("SharpeningAuto")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SharpeningAuto))
            node = self._nodes["SharpeningAuto"] = node_inst
        return node

    @property
    def BlackLevelClampingEnable(self) -> SpinBoolNode:
        """Enable the black level auto clamping feature which performing dark
        current compensation.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("BlackLevelClampingEnable")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().BlackLevelClampingEnable))
            node = self._nodes["BlackLevelClampingEnable"] = node_inst
        return node

    @property
    def BalanceRatio(self) -> SpinFloatNode:
        """Controls the balance ratio of the selected color relative to green.
        Used for white balancing.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("BalanceRatio")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().BalanceRatio))
            node = self._nodes["BalanceRatio"] = node_inst
        return node

    @property
    def BalanceWhiteAuto(self) -> SpinEnumDefNode:
        """White Balance compensates for color shifts caused by different
        lighting conditions. It can be automatically or manually controlled.
        For manual control, set to Off. For automatic control, set to Once
        or Continuous.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.BalanceWhiteAuto_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("BalanceWhiteAuto")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().BalanceWhiteAuto))
            node_inst.enum_names = rotpy.names.camera.BalanceWhiteAuto_names
            node_inst.enum_values = rotpy.names.camera.BalanceWhiteAuto_values
            node = self._nodes["BalanceWhiteAuto"] = node_inst
        return node

    @property
    def SharpeningThreshold(self) -> SpinFloatNode:
        """Controls the minimum intensity gradient change to invoke sharpening.
        When "Sharpening Auto" is enabled, this is determined automatically
        by the device.       The threshold is specified as a fraction of the
        total intensity range, and ranges from 0 to 0.25. A threshold higher
        than 25% produces little to no difference than 25%. High thresholds
        sharpen only areas with significant intensity changes. Low
        thresholds sharpen more areas.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("SharpeningThreshold")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SharpeningThreshold))
            node = self._nodes["SharpeningThreshold"] = node_inst
        return node

    @property
    def GainAuto(self) -> SpinEnumDefNode:
        """Sets the automatic gain mode. Set to Off for manual control. Set to
        Once for a single automatic adjustment then return to Off. Set to
        Continuous for constant adjustment. In automatic modes, the camera
        adjusts the gain to maximize the dynamic range.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.GainAuto_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("GainAuto")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GainAuto))
            node_inst.enum_names = rotpy.names.camera.GainAuto_names
            node_inst.enum_values = rotpy.names.camera.GainAuto_values
            node = self._nodes["GainAuto"] = node_inst
        return node

    @property
    def Sharpening(self) -> SpinFloatNode:
        """Controls the amount to sharpen a signal. The sharpened amount is
        proportional to the difference between a pixel and its neighbors. A
        negative value smooths out the difference, while a positive value
        amplifies the difference. You can boost by a maximum of 8x, but
        smoothing is limited to 1x  (in float). Default value: 2.0

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("Sharpening")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().Sharpening))
            node = self._nodes["Sharpening"] = node_inst
        return node

    @property
    def Gain(self) -> SpinFloatNode:
        """Controls the amplification of the video signal in dB.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("Gain")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().Gain))
            node = self._nodes["Gain"] = node_inst
        return node

    @property
    def BalanceRatioSelector(self) -> SpinEnumDefNode:
        """Selects a balance ratio to configure once a balance ratio control
        has been selected.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.BalanceRatioSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("BalanceRatioSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().BalanceRatioSelector))
            node_inst.enum_names = rotpy.names.camera.BalanceRatioSelector_names
            node_inst.enum_values = rotpy.names.camera.BalanceRatioSelector_values
            node = self._nodes["BalanceRatioSelector"] = node_inst
        return node

    @property
    def GainSelector(self) -> SpinEnumDefNode:
        """    Selects which gain to control. The All selection is a total
        amplification across all channels (or taps).

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.GainSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("GainSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GainSelector))
            node_inst.enum_names = rotpy.names.camera.GainSelector_names
            node_inst.enum_values = rotpy.names.camera.GainSelector_values
            node = self._nodes["GainSelector"] = node_inst
        return node

    @property
    def BlackLevel(self) -> SpinFloatNode:
        """Controls the offset of the video signal in percent.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("BlackLevel")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().BlackLevel))
            node = self._nodes["BlackLevel"] = node_inst
        return node

    @property
    def BlackLevelRaw(self) -> SpinIntNode:
        """Controls the offset of the video signal in camera specific units.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("BlackLevelRaw")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().BlackLevelRaw))
            node = self._nodes["BlackLevelRaw"] = node_inst
        return node

    @property
    def Gamma(self) -> SpinFloatNode:
        """      Controls the gamma correction of pixel intensity.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("Gamma")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().Gamma))
            node = self._nodes["Gamma"] = node_inst
        return node

    @property
    def DefectTableIndex(self) -> SpinIntNode:
        """Controls the offset of the element to access in the defective pixel
        location table.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DefectTableIndex")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DefectTableIndex))
            node = self._nodes["DefectTableIndex"] = node_inst
        return node

    @property
    def DefectTableFactoryRestore(self) -> SpinCommandNode:
        """    Restores the Defective Pixel Table to its factory default state,
        which was calibrated during manufacturing. This permanently
        overwrites any changes made to the defect table.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("DefectTableFactoryRestore")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DefectTableFactoryRestore))
            node = self._nodes["DefectTableFactoryRestore"] = node_inst
        return node

    @property
    def DefectTableCoordinateY(self) -> SpinIntNode:
        """Returns the Y coordinate of the defective pixel at DefectTableIndex
        within the defective pixel table. Changes made do not take effect in
        captured images until the command DefectTableApply is written.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DefectTableCoordinateY")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DefectTableCoordinateY))
            node = self._nodes["DefectTableCoordinateY"] = node_inst
        return node

    @property
    def DefectTableSave(self) -> SpinCommandNode:
        """    Saves the current defective pixel table non-volatile memory,
        so that it is preserved when the camera boots up.   This overwrites
        the existing defective pixel table.     The new table is loaded
        whenever the camera     powers up.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("DefectTableSave")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DefectTableSave))
            node = self._nodes["DefectTableSave"] = node_inst
        return node

    @property
    def DefectCorrectionMode(self) -> SpinEnumDefNode:
        """    Controls the method used for replacing defective pixels.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.DefectCorrectionMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("DefectCorrectionMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DefectCorrectionMode))
            node_inst.enum_names = rotpy.names.camera.DefectCorrectionMode_names
            node_inst.enum_values = rotpy.names.camera.DefectCorrectionMode_values
            node = self._nodes["DefectCorrectionMode"] = node_inst
        return node

    @property
    def DefectTableCoordinateX(self) -> SpinIntNode:
        """Returns the X coordinate of the defective pixel at DefectTableIndex
        within the defective pixel table. Changes made do not take effect in
        captured images until the command DefectTableApply is written.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DefectTableCoordinateX")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DefectTableCoordinateX))
            node = self._nodes["DefectTableCoordinateX"] = node_inst
        return node

    @property
    def DefectTablePixelCount(self) -> SpinIntNode:
        """The number of defective pixel locations in the current table.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DefectTablePixelCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DefectTablePixelCount))
            node = self._nodes["DefectTablePixelCount"] = node_inst
        return node

    @property
    def DefectCorrectStaticEnable(self) -> SpinBoolNode:
        """Enables/Disables table-based defective pixel correction.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("DefectCorrectStaticEnable")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DefectCorrectStaticEnable))
            node = self._nodes["DefectCorrectStaticEnable"] = node_inst
        return node

    @property
    def DefectTableApply(self) -> SpinCommandNode:
        """    Applies the current defect table, so that any changes made
        affect images captured by the camera.   This writes the table to
        volatile memory, so changes to the     table are lost if the camera
        loses power. To save the   table to non-volatile memory, use
        DefectTableSave.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("DefectTableApply")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DefectTableApply))
            node = self._nodes["DefectTableApply"] = node_inst
        return node

    @property
    def UserSetFeatureEnable(self) -> SpinBoolNode:
        """    Whether or not the selected feature is saved to user sets.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("UserSetFeatureEnable")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().UserSetFeatureEnable))
            node = self._nodes["UserSetFeatureEnable"] = node_inst
        return node

    @property
    def UserSetSave(self) -> SpinCommandNode:
        """Saves the User Set specified by UserSetSelector to the non-volatile
        memory of the device.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("UserSetSave")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().UserSetSave))
            node = self._nodes["UserSetSave"] = node_inst
        return node

    @property
    def UserSetSelector(self) -> SpinEnumDefNode:
        """Selects the feature User Set to load, save or configure.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.UserSetSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("UserSetSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().UserSetSelector))
            node_inst.enum_names = rotpy.names.camera.UserSetSelector_names
            node_inst.enum_values = rotpy.names.camera.UserSetSelector_values
            node = self._nodes["UserSetSelector"] = node_inst
        return node

    @property
    def UserSetLoad(self) -> SpinCommandNode:
        """Loads the User Set specified by UserSetSelector to the device and
        makes it active.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("UserSetLoad")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().UserSetLoad))
            node = self._nodes["UserSetLoad"] = node_inst
        return node

    @property
    def UserSetDefault(self) -> SpinEnumDefNode:
        """Selects the feature User Set to load and make active by default when
        the device is restarted.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.UserSetDefault_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("UserSetDefault")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().UserSetDefault))
            node_inst.enum_names = rotpy.names.camera.UserSetDefault_names
            node_inst.enum_values = rotpy.names.camera.UserSetDefault_values
            node = self._nodes["UserSetDefault"] = node_inst
        return node

    @property
    def SerialPortBaudRate(self) -> SpinEnumDefNode:
        """This feature controls the baud rate used by the selected serial
        port.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.SerialPortBaudRate_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("SerialPortBaudRate")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SerialPortBaudRate))
            node_inst.enum_names = rotpy.names.camera.SerialPortBaudRate_names
            node_inst.enum_values = rotpy.names.camera.SerialPortBaudRate_values
            node = self._nodes["SerialPortBaudRate"] = node_inst
        return node

    @property
    def SerialPortDataBits(self) -> SpinIntNode:
        """This feature controls the number of data bits used by the selected
        serial port.  Possible values that can be used are between 5 and 9.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("SerialPortDataBits")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SerialPortDataBits))
            node = self._nodes["SerialPortDataBits"] = node_inst
        return node

    @property
    def SerialPortParity(self) -> SpinEnumDefNode:
        """This feature controls the parity used by the selected serial port.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.SerialPortParity_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("SerialPortParity")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SerialPortParity))
            node_inst.enum_names = rotpy.names.camera.SerialPortParity_names
            node_inst.enum_values = rotpy.names.camera.SerialPortParity_values
            node = self._nodes["SerialPortParity"] = node_inst
        return node

    @property
    def SerialTransmitQueueMaxCharacterCount(self) -> SpinIntNode:
        """>Returns the maximum number of characters in the serial port
        transmit queue.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("SerialTransmitQueueMaxCharacterCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SerialTransmitQueueMaxCharacterCount))
            node = self._nodes["SerialTransmitQueueMaxCharacterCount"] = node_inst
        return node

    @property
    def SerialReceiveQueueCurrentCharacterCount(self) -> SpinIntNode:
        """Returns the number of characters currently in the serial port
        receive queue.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("SerialReceiveQueueCurrentCharacterCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SerialReceiveQueueCurrentCharacterCount))
            node = self._nodes["SerialReceiveQueueCurrentCharacterCount"] = node_inst
        return node

    @property
    def SerialPortSelector(self) -> SpinEnumDefNode:
        """Selects which serial port of the device to control.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.SerialPortSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("SerialPortSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SerialPortSelector))
            node_inst.enum_names = rotpy.names.camera.SerialPortSelector_names
            node_inst.enum_values = rotpy.names.camera.SerialPortSelector_values
            node = self._nodes["SerialPortSelector"] = node_inst
        return node

    @property
    def SerialPortStopBits(self) -> SpinEnumDefNode:
        """This feature controls the number of stop bits used by the selected
        serial port.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.SerialPortStopBits_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("SerialPortStopBits")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SerialPortStopBits))
            node_inst.enum_names = rotpy.names.camera.SerialPortStopBits_names
            node_inst.enum_values = rotpy.names.camera.SerialPortStopBits_values
            node = self._nodes["SerialPortStopBits"] = node_inst
        return node

    @property
    def SerialReceiveQueueClear(self) -> SpinCommandNode:
        """This is a command that clears the device serial port receive queue.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("SerialReceiveQueueClear")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SerialReceiveQueueClear))
            node = self._nodes["SerialReceiveQueueClear"] = node_inst
        return node

    @property
    def SerialReceiveFramingErrorCount(self) -> SpinIntNode:
        """Returns the number of framing errors that have occurred on the
        serial port.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("SerialReceiveFramingErrorCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SerialReceiveFramingErrorCount))
            node = self._nodes["SerialReceiveFramingErrorCount"] = node_inst
        return node

    @property
    def SerialTransmitQueueCurrentCharacterCount(self) -> SpinIntNode:
        """Returns the number of characters currently in the serial port
        transmit queue.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("SerialTransmitQueueCurrentCharacterCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SerialTransmitQueueCurrentCharacterCount))
            node = self._nodes["SerialTransmitQueueCurrentCharacterCount"] = node_inst
        return node

    @property
    def SerialReceiveParityErrorCount(self) -> SpinIntNode:
        """Returns the number of parity errors that have occurred on the serial
        port.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("SerialReceiveParityErrorCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SerialReceiveParityErrorCount))
            node = self._nodes["SerialReceiveParityErrorCount"] = node_inst
        return node

    @property
    def SerialPortSource(self) -> SpinEnumDefNode:
        """Specifies the physical input Line on which to receive serial data.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.SerialPortSource_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("SerialPortSource")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SerialPortSource))
            node_inst.enum_names = rotpy.names.camera.SerialPortSource_names
            node_inst.enum_values = rotpy.names.camera.SerialPortSource_values
            node = self._nodes["SerialPortSource"] = node_inst
        return node

    @property
    def SerialReceiveQueueMaxCharacterCount(self) -> SpinIntNode:
        """>Returns the maximum number of characters in the serial port receive
        queue.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("SerialReceiveQueueMaxCharacterCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SerialReceiveQueueMaxCharacterCount))
            node = self._nodes["SerialReceiveQueueMaxCharacterCount"] = node_inst
        return node

    @property
    def SequencerSetStart(self) -> SpinIntNode:
        """Sets the first sequencer set to be used.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("SequencerSetStart")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SequencerSetStart))
            node = self._nodes["SequencerSetStart"] = node_inst
        return node

    @property
    def SequencerMode(self) -> SpinEnumDefNode:
        """Controls whether or not a sequencer is active.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.SequencerMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("SequencerMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SequencerMode))
            node_inst.enum_names = rotpy.names.camera.SequencerMode_names
            node_inst.enum_values = rotpy.names.camera.SequencerMode_values
            node = self._nodes["SequencerMode"] = node_inst
        return node

    @property
    def SequencerConfigurationValid(self) -> SpinEnumDefNode:
        """Display whether the current sequencer configuration is valid to run.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.SequencerConfigurationValid_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("SequencerConfigurationValid")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SequencerConfigurationValid))
            node_inst.enum_names = rotpy.names.camera.SequencerConfigurationValid_names
            node_inst.enum_values = rotpy.names.camera.SequencerConfigurationValid_values
            node = self._nodes["SequencerConfigurationValid"] = node_inst
        return node

    @property
    def SequencerSetValid(self) -> SpinEnumDefNode:
        """Displays whether the currently selected sequencer set's register
        contents are valid to use.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.SequencerSetValid_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("SequencerSetValid")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SequencerSetValid))
            node_inst.enum_names = rotpy.names.camera.SequencerSetValid_names
            node_inst.enum_values = rotpy.names.camera.SequencerSetValid_values
            node = self._nodes["SequencerSetValid"] = node_inst
        return node

    @property
    def SequencerSetSelector(self) -> SpinIntNode:
        """Selects the sequencer set to which subsequent settings apply.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("SequencerSetSelector")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SequencerSetSelector))
            node = self._nodes["SequencerSetSelector"] = node_inst
        return node

    @property
    def SequencerTriggerActivation(self) -> SpinEnumDefNode:
        """Specifies the activation mode of the sequencer trigger.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.SequencerTriggerActivation_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("SequencerTriggerActivation")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SequencerTriggerActivation))
            node_inst.enum_names = rotpy.names.camera.SequencerTriggerActivation_names
            node_inst.enum_values = rotpy.names.camera.SequencerTriggerActivation_values
            node = self._nodes["SequencerTriggerActivation"] = node_inst
        return node

    @property
    def SequencerConfigurationMode(self) -> SpinEnumDefNode:
        """Controls whether or not a sequencer is in configuration mode.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.SequencerConfigurationMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("SequencerConfigurationMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SequencerConfigurationMode))
            node_inst.enum_names = rotpy.names.camera.SequencerConfigurationMode_names
            node_inst.enum_values = rotpy.names.camera.SequencerConfigurationMode_values
            node = self._nodes["SequencerConfigurationMode"] = node_inst
        return node

    @property
    def SequencerSetSave(self) -> SpinCommandNode:
        """Saves the current device configuration to the currently selected
        sequencer set.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("SequencerSetSave")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SequencerSetSave))
            node = self._nodes["SequencerSetSave"] = node_inst
        return node

    @property
    def SequencerTriggerSource(self) -> SpinEnumDefNode:
        """Specifies the internal signal or physical input line to use as the
        sequencer trigger source.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.SequencerTriggerSource_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("SequencerTriggerSource")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SequencerTriggerSource))
            node_inst.enum_names = rotpy.names.camera.SequencerTriggerSource_names
            node_inst.enum_values = rotpy.names.camera.SequencerTriggerSource_values
            node = self._nodes["SequencerTriggerSource"] = node_inst
        return node

    @property
    def SequencerSetActive(self) -> SpinIntNode:
        """Displays the currently active sequencer set.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("SequencerSetActive")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SequencerSetActive))
            node = self._nodes["SequencerSetActive"] = node_inst
        return node

    @property
    def SequencerSetNext(self) -> SpinIntNode:
        """Specifies the next sequencer set.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("SequencerSetNext")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SequencerSetNext))
            node = self._nodes["SequencerSetNext"] = node_inst
        return node

    @property
    def SequencerSetLoad(self) -> SpinCommandNode:
        """Loads currently selected sequencer to the current device
        configuration.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("SequencerSetLoad")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SequencerSetLoad))
            node = self._nodes["SequencerSetLoad"] = node_inst
        return node

    @property
    def SequencerPathSelector(self) -> SpinIntNode:
        """Selects branching path to be used for subsequent settings.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("SequencerPathSelector")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SequencerPathSelector))
            node = self._nodes["SequencerPathSelector"] = node_inst
        return node

    @property
    def SequencerFeatureEnable(self) -> SpinBoolNode:
        """Enables the selected feature and makes it active in all sequencer
        sets.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("SequencerFeatureEnable")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SequencerFeatureEnable))
            node = self._nodes["SequencerFeatureEnable"] = node_inst
        return node

    @property
    def TransferBlockCount(self) -> SpinIntNode:
        """Specifies the number of data blocks (images) that the device should
        stream before stopping. This feature is only active if the Transfer
        Operation Mode is set to Multi Block.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("TransferBlockCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TransferBlockCount))
            node = self._nodes["TransferBlockCount"] = node_inst
        return node

    @property
    def TransferStart(self) -> SpinCommandNode:
        """Starts the streaming of data blocks (images) out of the device. This
        feature is available when the Transfer Control Mode is set to User
        Controlled.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("TransferStart")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TransferStart))
            node = self._nodes["TransferStart"] = node_inst
        return node

    @property
    def TransferQueueMaxBlockCount(self) -> SpinIntNode:
        """Returns the maximum number of data blocks (images) in the transfer
        queue

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("TransferQueueMaxBlockCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TransferQueueMaxBlockCount))
            node = self._nodes["TransferQueueMaxBlockCount"] = node_inst
        return node

    @property
    def TransferQueueCurrentBlockCount(self) -> SpinIntNode:
        """Returns number of data blocks (images) currently in the transfer
        queue.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("TransferQueueCurrentBlockCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TransferQueueCurrentBlockCount))
            node = self._nodes["TransferQueueCurrentBlockCount"] = node_inst
        return node

    @property
    def TransferQueueMode(self) -> SpinEnumDefNode:
        """Specifies the operation mode of the transfer queue.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.TransferQueueMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("TransferQueueMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TransferQueueMode))
            node_inst.enum_names = rotpy.names.camera.TransferQueueMode_names
            node_inst.enum_values = rotpy.names.camera.TransferQueueMode_values
            node = self._nodes["TransferQueueMode"] = node_inst
        return node

    @property
    def TransferOperationMode(self) -> SpinEnumDefNode:
        """Selects the operation mode of the transfer. Continuous is similar to
        Basic/Automatic but you can start/stop the transfer while
        acquisition runs independently. Multi Block transmits a specified
        number of blocks and then stops.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.TransferOperationMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("TransferOperationMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TransferOperationMode))
            node_inst.enum_names = rotpy.names.camera.TransferOperationMode_names
            node_inst.enum_values = rotpy.names.camera.TransferOperationMode_values
            node = self._nodes["TransferOperationMode"] = node_inst
        return node

    @property
    def TransferStop(self) -> SpinCommandNode:
        """Stops the streaming of data block (images). The current block
        transmission is completed. This feature is available when the
        Transfer Control Mode is set to User Controlled.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("TransferStop")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TransferStop))
            node = self._nodes["TransferStop"] = node_inst
        return node

    @property
    def TransferQueueOverflowCount(self) -> SpinIntNode:
        """Returns number of images that have been lost before being
        transmitted because the transmit queue hasn't been cleared fast
        enough.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("TransferQueueOverflowCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TransferQueueOverflowCount))
            node = self._nodes["TransferQueueOverflowCount"] = node_inst
        return node

    @property
    def TransferControlMode(self) -> SpinEnumDefNode:
        """Selects the control method for the transfers. Basic and Automatic
        start transmitting data as soon as there is enough data to fill a
        link layer packet. User Controlled allows you to directly control
        the transfer of blocks.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.TransferControlMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("TransferControlMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TransferControlMode))
            node_inst.enum_names = rotpy.names.camera.TransferControlMode_names
            node_inst.enum_values = rotpy.names.camera.TransferControlMode_values
            node = self._nodes["TransferControlMode"] = node_inst
        return node

    @property
    def ChunkBlackLevel(self) -> SpinFloatNode:
        """Returns the black level used to capture the image.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("ChunkBlackLevel")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkBlackLevel))
            node = self._nodes["ChunkBlackLevel"] = node_inst
        return node

    @property
    def ChunkFrameID(self) -> SpinIntNode:
        """Returns the image frame ID.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ChunkFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkFrameID))
            node = self._nodes["ChunkFrameID"] = node_inst
        return node

    @property
    def ChunkSerialData(self) -> SpinStrNode:
        """Returns the serial data that was received.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("ChunkSerialData")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkSerialData))
            node = self._nodes["ChunkSerialData"] = node_inst
        return node

    @property
    def ChunkExposureTime(self) -> SpinFloatNode:
        """Returns the exposure time used to capture the image.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("ChunkExposureTime")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkExposureTime))
            node = self._nodes["ChunkExposureTime"] = node_inst
        return node

    @property
    def ChunkCompressionMode(self) -> SpinIntNode:
        """Returns the compression mode of the last image payload.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ChunkCompressionMode")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkCompressionMode))
            node = self._nodes["ChunkCompressionMode"] = node_inst
        return node

    @property
    def ChunkCompressionRatio(self) -> SpinFloatNode:
        """Returns the compression ratio of the last image payload.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("ChunkCompressionRatio")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkCompressionRatio))
            node = self._nodes["ChunkCompressionRatio"] = node_inst
        return node

    @property
    def ChunkSerialReceiveOverflow(self) -> SpinBoolNode:
        """Returns the status of the chunk serial receive overflow.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("ChunkSerialReceiveOverflow")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkSerialReceiveOverflow))
            node = self._nodes["ChunkSerialReceiveOverflow"] = node_inst
        return node

    @property
    def ChunkTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the image.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ChunkTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkTimestamp))
            node = self._nodes["ChunkTimestamp"] = node_inst
        return node

    @property
    def ChunkModeActive(self) -> SpinBoolNode:
        """Activates the inclusion of Chunk data in the payload of the image.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("ChunkModeActive")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkModeActive))
            node = self._nodes["ChunkModeActive"] = node_inst
        return node

    @property
    def ChunkExposureEndLineStatusAll(self) -> SpinIntNode:
        """Returns the status of all the I/O lines at the end of exposure
        event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ChunkExposureEndLineStatusAll")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkExposureEndLineStatusAll))
            node = self._nodes["ChunkExposureEndLineStatusAll"] = node_inst
        return node

    @property
    def ChunkGainSelector(self) -> SpinEnumDefNode:
        """Selects which gain to retrieve

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ChunkGainSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ChunkGainSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkGainSelector))
            node_inst.enum_names = rotpy.names.camera.ChunkGainSelector_names
            node_inst.enum_values = rotpy.names.camera.ChunkGainSelector_values
            node = self._nodes["ChunkGainSelector"] = node_inst
        return node

    @property
    def ChunkSelector(self) -> SpinEnumDefNode:
        """Selects which chunk data to enable or disable.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ChunkSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ChunkSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkSelector))
            node_inst.enum_names = rotpy.names.camera.ChunkSelector_names
            node_inst.enum_values = rotpy.names.camera.ChunkSelector_values
            node = self._nodes["ChunkSelector"] = node_inst
        return node

    @property
    def ChunkBlackLevelSelector(self) -> SpinEnumDefNode:
        """Selects which black level to retrieve

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ChunkBlackLevelSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ChunkBlackLevelSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkBlackLevelSelector))
            node_inst.enum_names = rotpy.names.camera.ChunkBlackLevelSelector_names
            node_inst.enum_values = rotpy.names.camera.ChunkBlackLevelSelector_values
            node = self._nodes["ChunkBlackLevelSelector"] = node_inst
        return node

    @property
    def ChunkWidth(self) -> SpinIntNode:
        """Returns the width of the image included in the payload.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ChunkWidth")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkWidth))
            node = self._nodes["ChunkWidth"] = node_inst
        return node

    @property
    def ChunkImage(self) -> SpinIntNode:
        """Returns the image payload.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ChunkImage")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkImage))
            node = self._nodes["ChunkImage"] = node_inst
        return node

    @property
    def ChunkHeight(self) -> SpinIntNode:
        """Returns the height of the image included in the payload.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ChunkHeight")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkHeight))
            node = self._nodes["ChunkHeight"] = node_inst
        return node

    @property
    def ChunkPixelFormat(self) -> SpinEnumDefNode:
        """Format of the pixel provided by the camera

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ChunkPixelFormat_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ChunkPixelFormat")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkPixelFormat))
            node_inst.enum_names = rotpy.names.camera.ChunkPixelFormat_names
            node_inst.enum_values = rotpy.names.camera.ChunkPixelFormat_values
            node = self._nodes["ChunkPixelFormat"] = node_inst
        return node

    @property
    def ChunkGain(self) -> SpinFloatNode:
        """Returns the gain used to capture the image.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("ChunkGain")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkGain))
            node = self._nodes["ChunkGain"] = node_inst
        return node

    @property
    def ChunkSequencerSetActive(self) -> SpinIntNode:
        """Returns the index of the active set of the running sequencer
        included in the payload.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ChunkSequencerSetActive")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkSequencerSetActive))
            node = self._nodes["ChunkSequencerSetActive"] = node_inst
        return node

    @property
    def ChunkCRC(self) -> SpinIntNode:
        """Returns the CRC of the image payload.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ChunkCRC")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkCRC))
            node = self._nodes["ChunkCRC"] = node_inst
        return node

    @property
    def ChunkOffsetX(self) -> SpinIntNode:
        """Returns the Offset X of the image included in the payload.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ChunkOffsetX")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkOffsetX))
            node = self._nodes["ChunkOffsetX"] = node_inst
        return node

    @property
    def ChunkOffsetY(self) -> SpinIntNode:
        """Returns the Offset Y of the image included in the payload.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ChunkOffsetY")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkOffsetY))
            node = self._nodes["ChunkOffsetY"] = node_inst
        return node

    @property
    def ChunkEnable(self) -> SpinBoolNode:
        """Enables the inclusion of the selected Chunk data in the payload of
        the image.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("ChunkEnable")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkEnable))
            node = self._nodes["ChunkEnable"] = node_inst
        return node

    @property
    def ChunkSerialDataLength(self) -> SpinIntNode:
        """Returns the length of the received serial data that was included in
        the payload.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ChunkSerialDataLength")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkSerialDataLength))
            node = self._nodes["ChunkSerialDataLength"] = node_inst
        return node

    @property
    def FileAccessOffset(self) -> SpinIntNode:
        """Controls the Offset of the mapping between the device file storage
        and the FileAccessBuffer.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("FileAccessOffset")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().FileAccessOffset))
            node = self._nodes["FileAccessOffset"] = node_inst
        return node

    @property
    def FileAccessLength(self) -> SpinIntNode:
        """Controls the Length of the mapping between the device file storage
        and the FileAccessBuffer.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("FileAccessLength")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().FileAccessLength))
            node = self._nodes["FileAccessLength"] = node_inst
        return node

    @property
    def FileOperationStatus(self) -> SpinEnumDefNode:
        """Represents the file operation execution status.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.FileOperationStatus_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("FileOperationStatus")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().FileOperationStatus))
            node_inst.enum_names = rotpy.names.camera.FileOperationStatus_names
            node_inst.enum_values = rotpy.names.camera.FileOperationStatus_values
            node = self._nodes["FileOperationStatus"] = node_inst
        return node

    @property
    def FileOperationExecute(self) -> SpinCommandNode:
        """This is a command that executes the selected file operation on the
        selected file.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("FileOperationExecute")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().FileOperationExecute))
            node = self._nodes["FileOperationExecute"] = node_inst
        return node

    @property
    def FileOpenMode(self) -> SpinEnumDefNode:
        """The mode of the file when it is opened. The file can be opened for
        reading, writting or both. This must be set before opening the file.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.FileOpenMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("FileOpenMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().FileOpenMode))
            node_inst.enum_names = rotpy.names.camera.FileOpenMode_names
            node_inst.enum_values = rotpy.names.camera.FileOpenMode_values
            node = self._nodes["FileOpenMode"] = node_inst
        return node

    @property
    def FileOperationResult(self) -> SpinIntNode:
        """Represents the file operation result. For Read or Write operations,
        the number of successfully read/written bytes is returned.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("FileOperationResult")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().FileOperationResult))
            node = self._nodes["FileOperationResult"] = node_inst
        return node

    @property
    def FileOperationSelector(self) -> SpinEnumDefNode:
        """Sets operation to execute on the selected file when the execute
        command is given.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.FileOperationSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("FileOperationSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().FileOperationSelector))
            node_inst.enum_names = rotpy.names.camera.FileOperationSelector_names
            node_inst.enum_values = rotpy.names.camera.FileOperationSelector_values
            node = self._nodes["FileOperationSelector"] = node_inst
        return node

    @property
    def FileSelector(self) -> SpinEnumDefNode:
        """Selects which file is being operated on. This must be set before
        performing any file operations.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.FileSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("FileSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().FileSelector))
            node_inst.enum_names = rotpy.names.camera.FileSelector_names
            node_inst.enum_values = rotpy.names.camera.FileSelector_values
            node = self._nodes["FileSelector"] = node_inst
        return node

    @property
    def FileSize(self) -> SpinIntNode:
        """Represents the size of the selected file in bytes.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("FileSize")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().FileSize))
            node = self._nodes["FileSize"] = node_inst
        return node

    @property
    def BinningSelector(self) -> SpinEnumDefNode:
        """Selects which binning engine is controlled by the BinningHorizontal
        and BinningVertical features.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.BinningSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("BinningSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().BinningSelector))
            node_inst.enum_names = rotpy.names.camera.BinningSelector_names
            node_inst.enum_values = rotpy.names.camera.BinningSelector_values
            node = self._nodes["BinningSelector"] = node_inst
        return node

    @property
    def PixelDynamicRangeMin(self) -> SpinIntNode:
        """    Minimum value that can be returned during the digitization
        process. This corresponds to the darkest value of the camera. For
        color cameras, this returns the smallest value that each color
        component can take.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("PixelDynamicRangeMin")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().PixelDynamicRangeMin))
            node = self._nodes["PixelDynamicRangeMin"] = node_inst
        return node

    @property
    def PixelDynamicRangeMax(self) -> SpinIntNode:
        """    Maximum value that can be returned during the digitization
        process. This corresponds to the brightest value of the camera. For
        color cameras, this returns the biggest value that each color
        component can take.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("PixelDynamicRangeMax")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().PixelDynamicRangeMax))
            node = self._nodes["PixelDynamicRangeMax"] = node_inst
        return node

    @property
    def OffsetY(self) -> SpinIntNode:
        """Vertical offset from the origin to the ROI (in pixels).

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("OffsetY")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().OffsetY))
            node = self._nodes["OffsetY"] = node_inst
        return node

    @property
    def BinningHorizontal(self) -> SpinIntNode:
        """Number of horizontal photo-sensitive cells to combine together. This
        reduces the horizontal resolution (width) of the image. A value of 1
        indicates that no horizontal binning is performed by the camera.
        This value must be 1 for decimation to be active.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("BinningHorizontal")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().BinningHorizontal))
            node = self._nodes["BinningHorizontal"] = node_inst
        return node

    @property
    def Width(self) -> SpinIntNode:
        """Width of the image provided by the device (in pixels).

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("Width")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().Width))
            node = self._nodes["Width"] = node_inst
        return node

    @property
    def TestPatternGeneratorSelector(self) -> SpinEnumDefNode:
        """Selects which test pattern generator is controlled by the
        TestPattern feature.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.TestPatternGeneratorSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("TestPatternGeneratorSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TestPatternGeneratorSelector))
            node_inst.enum_names = rotpy.names.camera.TestPatternGeneratorSelector_names
            node_inst.enum_values = rotpy.names.camera.TestPatternGeneratorSelector_values
            node = self._nodes["TestPatternGeneratorSelector"] = node_inst
        return node

    @property
    def CompressionRatio(self) -> SpinFloatNode:
        """Reports the ratio between the uncompressed image size and compressed
        image size.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("CompressionRatio")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().CompressionRatio))
            node = self._nodes["CompressionRatio"] = node_inst
        return node

    @property
    def CompressionSaturationPriority(self) -> SpinEnumDefNode:
        """When FrameRate is enabled, camera drops frames if datarate is
        saturated. If FrameRate is disabled, camera adjusts the framerate to
        match the maximum achievable datarate.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.CompressionSaturationPriority_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("CompressionSaturationPriority")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().CompressionSaturationPriority))
            node_inst.enum_names = rotpy.names.camera.CompressionSaturationPriority_names
            node_inst.enum_values = rotpy.names.camera.CompressionSaturationPriority_values
            node = self._nodes["CompressionSaturationPriority"] = node_inst
        return node

    @property
    def ReverseX(self) -> SpinBoolNode:
        """    Horizontally flips the image sent by the device. The region of
        interest is applied after flipping. For color cameras the bayer
        pixel format is affected. For example, BayerRG16 changes to
        BayerGR16.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("ReverseX")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ReverseX))
            node = self._nodes["ReverseX"] = node_inst
        return node

    @property
    def ReverseY(self) -> SpinBoolNode:
        """    Vertically flips the image sent by the device. The region of
        interest is applied after flipping. For color cameras the bayer
        pixel format is affected. For example, BayerRG16 changes to
        BayerGB16.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("ReverseY")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ReverseY))
            node = self._nodes["ReverseY"] = node_inst
        return node

    @property
    def TestPattern(self) -> SpinEnumDefNode:
        """Selects the type of test pattern that is generated by the device as
        image source.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.TestPattern_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("TestPattern")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TestPattern))
            node_inst.enum_names = rotpy.names.camera.TestPattern_names
            node_inst.enum_values = rotpy.names.camera.TestPattern_values
            node = self._nodes["TestPattern"] = node_inst
        return node

    @property
    def PixelColorFilter(self) -> SpinEnumDefNode:
        """    Type of color filter that is applied to the image. Only applies
        to Bayer pixel formats. All others have no color filter.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.PixelColorFilter_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("PixelColorFilter")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().PixelColorFilter))
            node_inst.enum_names = rotpy.names.camera.PixelColorFilter_names
            node_inst.enum_values = rotpy.names.camera.PixelColorFilter_values
            node = self._nodes["PixelColorFilter"] = node_inst
        return node

    @property
    def WidthMax(self) -> SpinIntNode:
        """Maximum width of the image (in pixels). The dimension is calculated
        after horizontal binning. WidthMax does not take into account the
        current Region of interest (Width or OffsetX).

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("WidthMax")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().WidthMax))
            node = self._nodes["WidthMax"] = node_inst
        return node

    @property
    def AdcBitDepth(self) -> SpinEnumDefNode:
        """Selects which ADC bit depth to use. A higher ADC bit depth results
        in better image quality but slower maximum frame rate.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.AdcBitDepth_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("AdcBitDepth")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AdcBitDepth))
            node_inst.enum_names = rotpy.names.camera.AdcBitDepth_names
            node_inst.enum_values = rotpy.names.camera.AdcBitDepth_values
            node = self._nodes["AdcBitDepth"] = node_inst
        return node

    @property
    def BinningVertical(self) -> SpinIntNode:
        """Number of vertical photo-sensitive cells to combine together. This
        reduces the vertical resolution (height) of the image. A value of 1
        indicates that no vertical binning is performed by the camera. This
        value must be 1 for decimation to be active.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("BinningVertical")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().BinningVertical))
            node = self._nodes["BinningVertical"] = node_inst
        return node

    @property
    def DecimationHorizontalMode(self) -> SpinEnumDefNode:
        """The mode used to reduce the horizontal resolution when
        DecimationHorizontal is used. The current implementation only
        supports a single decimation mode: Discard.  Average should be
        achieved via Binning.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.DecimationHorizontalMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("DecimationHorizontalMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DecimationHorizontalMode))
            node_inst.enum_names = rotpy.names.camera.DecimationHorizontalMode_names
            node_inst.enum_values = rotpy.names.camera.DecimationHorizontalMode_values
            node = self._nodes["DecimationHorizontalMode"] = node_inst
        return node

    @property
    def BinningVerticalMode(self) -> SpinEnumDefNode:
        """

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.BinningVerticalMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("BinningVerticalMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().BinningVerticalMode))
            node_inst.enum_names = rotpy.names.camera.BinningVerticalMode_names
            node_inst.enum_values = rotpy.names.camera.BinningVerticalMode_values
            node = self._nodes["BinningVerticalMode"] = node_inst
        return node

    @property
    def OffsetX(self) -> SpinIntNode:
        """Horizontal offset from the origin to the ROI (in pixels).

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("OffsetX")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().OffsetX))
            node = self._nodes["OffsetX"] = node_inst
        return node

    @property
    def HeightMax(self) -> SpinIntNode:
        """Maximum height of the image (in pixels). This dimension is
        calculated after vertical binning. HeightMax does not take into
        account the current Region of interest (Height or OffsetY).

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("HeightMax")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().HeightMax))
            node = self._nodes["HeightMax"] = node_inst
        return node

    @property
    def DecimationHorizontal(self) -> SpinIntNode:
        """Horizontal decimation of the image.  This reduces the horizontal
        resolution (width) of the image by only retaining a single pixel
        within a window whose size is the decimation factor specified here.
        A value of 1 indicates that no horizontal decimation is performed by
        the camera. This value must be 1 for binning to be active.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DecimationHorizontal")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DecimationHorizontal))
            node = self._nodes["DecimationHorizontal"] = node_inst
        return node

    @property
    def PixelSize(self) -> SpinEnumDefNode:
        """    Total size in bits of a pixel of the image.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.PixelSize_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("PixelSize")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().PixelSize))
            node_inst.enum_names = rotpy.names.camera.PixelSize_names
            node_inst.enum_values = rotpy.names.camera.PixelSize_values
            node = self._nodes["PixelSize"] = node_inst
        return node

    @property
    def SensorHeight(self) -> SpinIntNode:
        """Effective height of the sensor in pixels.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("SensorHeight")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SensorHeight))
            node = self._nodes["SensorHeight"] = node_inst
        return node

    @property
    def DecimationSelector(self) -> SpinEnumDefNode:
        """Selects which decimation layer is controlled by the
        DecimationHorizontal and DecimationVertical features.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.DecimationSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("DecimationSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DecimationSelector))
            node_inst.enum_names = rotpy.names.camera.DecimationSelector_names
            node_inst.enum_values = rotpy.names.camera.DecimationSelector_values
            node = self._nodes["DecimationSelector"] = node_inst
        return node

    @property
    def IspEnable(self) -> SpinBoolNode:
        """Controls whether the image processing core is used for optional
        pixel format mode (i.e. mono).

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("IspEnable")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().IspEnable))
            node = self._nodes["IspEnable"] = node_inst
        return node

    @property
    def AdaptiveCompressionEnable(self) -> SpinBoolNode:
        """Controls whether lossless compression adapts to the image content.
        If disabled, a fixed encoding table is used.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("AdaptiveCompressionEnable")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AdaptiveCompressionEnable))
            node = self._nodes["AdaptiveCompressionEnable"] = node_inst
        return node

    @property
    def ImageCompressionMode(self) -> SpinEnumDefNode:
        """

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ImageCompressionMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ImageCompressionMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ImageCompressionMode))
            node_inst.enum_names = rotpy.names.camera.ImageCompressionMode_names
            node_inst.enum_values = rotpy.names.camera.ImageCompressionMode_values
            node = self._nodes["ImageCompressionMode"] = node_inst
        return node

    @property
    def DecimationVertical(self) -> SpinIntNode:
        """Vertical decimation of the image.  This reduces the vertical
        resolution (height) of the image by only retaining a single pixel
        within a window whose size is the decimation factor specified here.
        A value of 1 indicates that no vertical decimation is performed by
        the camera. This value must be 1 for binning to be active.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DecimationVertical")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DecimationVertical))
            node = self._nodes["DecimationVertical"] = node_inst
        return node

    @property
    def Height(self) -> SpinIntNode:
        """Height of the image provided by the device (in pixels).

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("Height")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().Height))
            node = self._nodes["Height"] = node_inst
        return node

    @property
    def BinningHorizontalMode(self) -> SpinEnumDefNode:
        """

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.BinningHorizontalMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("BinningHorizontalMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().BinningHorizontalMode))
            node_inst.enum_names = rotpy.names.camera.BinningHorizontalMode_names
            node_inst.enum_values = rotpy.names.camera.BinningHorizontalMode_values
            node = self._nodes["BinningHorizontalMode"] = node_inst
        return node

    @property
    def PixelFormat(self) -> SpinEnumDefNode:
        """    Format of the pixel provided by the camera.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.PixelFormat_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("PixelFormat")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().PixelFormat))
            node_inst.enum_names = rotpy.names.camera.PixelFormat_names
            node_inst.enum_values = rotpy.names.camera.PixelFormat_values
            node = self._nodes["PixelFormat"] = node_inst
        return node

    @property
    def SensorWidth(self) -> SpinIntNode:
        """Effective width of the sensor in pixels.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("SensorWidth")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SensorWidth))
            node = self._nodes["SensorWidth"] = node_inst
        return node

    @property
    def DecimationVerticalMode(self) -> SpinEnumDefNode:
        """The mode used to reduce the vertical resolution when
        DecimationVertical is used. The current implementation only supports
        a single decimation mode: Discard.  Average should be achieved via
        Binning.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.DecimationVerticalMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("DecimationVerticalMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DecimationVerticalMode))
            node_inst.enum_names = rotpy.names.camera.DecimationVerticalMode_names
            node_inst.enum_values = rotpy.names.camera.DecimationVerticalMode_values
            node = self._nodes["DecimationVerticalMode"] = node_inst
        return node

    @property
    def TestEventGenerate(self) -> SpinCommandNode:
        """This command generates a test event and sends it to the host.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("TestEventGenerate")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TestEventGenerate))
            node = self._nodes["TestEventGenerate"] = node_inst
        return node

    @property
    def TriggerEventTest(self) -> SpinCommandNode:
        """This command generates a test event and sends it to the host.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("TriggerEventTest")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TriggerEventTest))
            node = self._nodes["TriggerEventTest"] = node_inst
        return node

    @property
    def GuiXmlManifestAddress(self) -> SpinIntNode:
        """Location of the GUI XML manifest table.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GuiXmlManifestAddress")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GuiXmlManifestAddress))
            node = self._nodes["GuiXmlManifestAddress"] = node_inst
        return node

    @property
    def Test0001(self) -> SpinIntNode:
        """For testing only.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("Test0001")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().Test0001))
            node = self._nodes["Test0001"] = node_inst
        return node

    @property
    def V3_3Enable(self) -> SpinBoolNode:
        """Internally generated 3.3V rail. Enable to supply external circuits
        with power. This is different than standard logic outputs in that it
        is comparatively slow to switch but can supply a more significant
        amount of power. This is only available on some pins.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("V3_3Enable")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().V3_3Enable))
            node = self._nodes["V3_3Enable"] = node_inst
        return node

    @property
    def LineMode(self) -> SpinEnumDefNode:
        """Controls if the physical Line is used to Input or Output a signal.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.LineMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("LineMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().LineMode))
            node_inst.enum_names = rotpy.names.camera.LineMode_names
            node_inst.enum_values = rotpy.names.camera.LineMode_values
            node = self._nodes["LineMode"] = node_inst
        return node

    @property
    def LineSource(self) -> SpinEnumDefNode:
        """Selects which internal acquisition or I/O source signal to output on
        the selected line. LineMode must be Output.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.LineSource_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("LineSource")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().LineSource))
            node_inst.enum_names = rotpy.names.camera.LineSource_names
            node_inst.enum_values = rotpy.names.camera.LineSource_values
            node = self._nodes["LineSource"] = node_inst
        return node

    @property
    def LineInputFilterSelector(self) -> SpinEnumDefNode:
        """Selects the kind of input filter to configure: Deglitch or Debounce.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.LineInputFilterSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("LineInputFilterSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().LineInputFilterSelector))
            node_inst.enum_names = rotpy.names.camera.LineInputFilterSelector_names
            node_inst.enum_values = rotpy.names.camera.LineInputFilterSelector_values
            node = self._nodes["LineInputFilterSelector"] = node_inst
        return node

    @property
    def UserOutputValue(self) -> SpinBoolNode:
        """Value of the selected user output, either logic high (enabled) or
        logic low (disabled).

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("UserOutputValue")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().UserOutputValue))
            node = self._nodes["UserOutputValue"] = node_inst
        return node

    @property
    def UserOutputValueAll(self) -> SpinIntNode:
        """Returns the current status of all the user output status bits in a
        hexadecimal representation (UserOutput 0 status corresponds to bit
        0, UserOutput 1 status with bit 1, etc). This allows simultaneous
        reading of all user output statuses at once.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("UserOutputValueAll")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().UserOutputValueAll))
            node = self._nodes["UserOutputValueAll"] = node_inst
        return node

    @property
    def UserOutputSelector(self) -> SpinEnumDefNode:
        """Selects which bit of the User Output register is set by
        UserOutputValue.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.UserOutputSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("UserOutputSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().UserOutputSelector))
            node_inst.enum_names = rotpy.names.camera.UserOutputSelector_names
            node_inst.enum_values = rotpy.names.camera.UserOutputSelector_values
            node = self._nodes["UserOutputSelector"] = node_inst
        return node

    @property
    def LineStatus(self) -> SpinBoolNode:
        """Returns the current status of the selected input or output Line

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("LineStatus")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().LineStatus))
            node = self._nodes["LineStatus"] = node_inst
        return node

    @property
    def LineFormat(self) -> SpinEnumDefNode:
        """Displays the current electrical format of the selected physical
        input or output Line.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.LineFormat_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("LineFormat")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().LineFormat))
            node_inst.enum_names = rotpy.names.camera.LineFormat_names
            node_inst.enum_values = rotpy.names.camera.LineFormat_values
            node = self._nodes["LineFormat"] = node_inst
        return node

    @property
    def LineStatusAll(self) -> SpinIntNode:
        """Returns the current status of all the line status bits in a
        hexadecimal representation (Line 0 status corresponds to bit 0, Line
        1 status with bit 1, etc). This allows simultaneous reading of all
        line statuses at once.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("LineStatusAll")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().LineStatusAll))
            node = self._nodes["LineStatusAll"] = node_inst
        return node

    @property
    def LineSelector(self) -> SpinEnumDefNode:
        """Selects the physical line (or pin) of the external device connector
        to configure

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.LineSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("LineSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().LineSelector))
            node_inst.enum_names = rotpy.names.camera.LineSelector_names
            node_inst.enum_values = rotpy.names.camera.LineSelector_values
            node = self._nodes["LineSelector"] = node_inst
        return node

    @property
    def ExposureActiveMode(self) -> SpinEnumDefNode:
        """Control sensor active exposure mode.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ExposureActiveMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ExposureActiveMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ExposureActiveMode))
            node_inst.enum_names = rotpy.names.camera.ExposureActiveMode_names
            node_inst.enum_values = rotpy.names.camera.ExposureActiveMode_values
            node = self._nodes["ExposureActiveMode"] = node_inst
        return node

    @property
    def LineInverter(self) -> SpinBoolNode:
        """Controls the inversion of the signal of the selected input or output
        line.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("LineInverter")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().LineInverter))
            node = self._nodes["LineInverter"] = node_inst
        return node

    @property
    def LineFilterWidth(self) -> SpinFloatNode:
        """Filter width in microseconds for the selected line and filter
        combination

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("LineFilterWidth")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().LineFilterWidth))
            node = self._nodes["LineFilterWidth"] = node_inst
        return node

    @property
    def CounterTriggerActivation(self) -> SpinEnumDefNode:
        """Selects the activation mode of the trigger to start the counter.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.CounterTriggerActivation_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("CounterTriggerActivation")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().CounterTriggerActivation))
            node_inst.enum_names = rotpy.names.camera.CounterTriggerActivation_names
            node_inst.enum_values = rotpy.names.camera.CounterTriggerActivation_values
            node = self._nodes["CounterTriggerActivation"] = node_inst
        return node

    @property
    def CounterValue(self) -> SpinIntNode:
        """Current counter value

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("CounterValue")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().CounterValue))
            node = self._nodes["CounterValue"] = node_inst
        return node

    @property
    def CounterSelector(self) -> SpinEnumDefNode:
        """Selects which counter to configure

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.CounterSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("CounterSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().CounterSelector))
            node_inst.enum_names = rotpy.names.camera.CounterSelector_names
            node_inst.enum_values = rotpy.names.camera.CounterSelector_values
            node = self._nodes["CounterSelector"] = node_inst
        return node

    @property
    def CounterValueAtReset(self) -> SpinIntNode:
        """Value of the selected Counter when it was reset by a trigger.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("CounterValueAtReset")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().CounterValueAtReset))
            node = self._nodes["CounterValueAtReset"] = node_inst
        return node

    @property
    def CounterStatus(self) -> SpinEnumDefNode:
        """Returns the current status of the counter.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.CounterStatus_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("CounterStatus")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().CounterStatus))
            node_inst.enum_names = rotpy.names.camera.CounterStatus_names
            node_inst.enum_values = rotpy.names.camera.CounterStatus_values
            node = self._nodes["CounterStatus"] = node_inst
        return node

    @property
    def CounterTriggerSource(self) -> SpinEnumDefNode:
        """Selects the source of the trigger to start the counter

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.CounterTriggerSource_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("CounterTriggerSource")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().CounterTriggerSource))
            node_inst.enum_names = rotpy.names.camera.CounterTriggerSource_names
            node_inst.enum_values = rotpy.names.camera.CounterTriggerSource_values
            node = self._nodes["CounterTriggerSource"] = node_inst
        return node

    @property
    def CounterDelay(self) -> SpinIntNode:
        """Sets the delay (or number of events) before the CounterStart event
        is generated.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("CounterDelay")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().CounterDelay))
            node = self._nodes["CounterDelay"] = node_inst
        return node

    @property
    def CounterResetSource(self) -> SpinEnumDefNode:
        """Selects the signal that will be the source to reset the counter.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.CounterResetSource_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("CounterResetSource")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().CounterResetSource))
            node_inst.enum_names = rotpy.names.camera.CounterResetSource_names
            node_inst.enum_values = rotpy.names.camera.CounterResetSource_values
            node = self._nodes["CounterResetSource"] = node_inst
        return node

    @property
    def CounterEventSource(self) -> SpinEnumDefNode:
        """Selects the event that will increment the counter

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.CounterEventSource_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("CounterEventSource")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().CounterEventSource))
            node_inst.enum_names = rotpy.names.camera.CounterEventSource_names
            node_inst.enum_values = rotpy.names.camera.CounterEventSource_values
            node = self._nodes["CounterEventSource"] = node_inst
        return node

    @property
    def CounterEventActivation(self) -> SpinEnumDefNode:
        """Selects the activation mode of the event to increment the Counter.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.CounterEventActivation_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("CounterEventActivation")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().CounterEventActivation))
            node_inst.enum_names = rotpy.names.camera.CounterEventActivation_names
            node_inst.enum_values = rotpy.names.camera.CounterEventActivation_values
            node = self._nodes["CounterEventActivation"] = node_inst
        return node

    @property
    def CounterDuration(self) -> SpinIntNode:
        """Sets the duration (or number of events) before the CounterEnd event
        is generated.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("CounterDuration")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().CounterDuration))
            node = self._nodes["CounterDuration"] = node_inst
        return node

    @property
    def CounterResetActivation(self) -> SpinEnumDefNode:
        """Selects the Activation mode of the Counter Reset Source signal.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.CounterResetActivation_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("CounterResetActivation")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().CounterResetActivation))
            node_inst.enum_names = rotpy.names.camera.CounterResetActivation_names
            node_inst.enum_values = rotpy.names.camera.CounterResetActivation_values
            node = self._nodes["CounterResetActivation"] = node_inst
        return node

    @property
    def DeviceType(self) -> SpinEnumDefNode:
        """Returns the device type.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.DeviceType_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("DeviceType")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceType))
            node_inst.enum_names = rotpy.names.camera.DeviceType_names
            node_inst.enum_values = rotpy.names.camera.DeviceType_values
            node = self._nodes["DeviceType"] = node_inst
        return node

    @property
    def DeviceFamilyName(self) -> SpinStrNode:
        """Identifier of the product family of the device.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("DeviceFamilyName")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceFamilyName))
            node = self._nodes["DeviceFamilyName"] = node_inst
        return node

    @property
    def DeviceSFNCVersionMajor(self) -> SpinIntNode:
        """Major version of the Standard Features Naming Convention that was
        used to create the device's GenICam XML.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceSFNCVersionMajor")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceSFNCVersionMajor))
            node = self._nodes["DeviceSFNCVersionMajor"] = node_inst
        return node

    @property
    def DeviceSFNCVersionMinor(self) -> SpinIntNode:
        """Minor version of the Standard Features Naming Convention that was
        used to create the device's GenICam XML.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceSFNCVersionMinor")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceSFNCVersionMinor))
            node = self._nodes["DeviceSFNCVersionMinor"] = node_inst
        return node

    @property
    def DeviceSFNCVersionSubMinor(self) -> SpinIntNode:
        """Sub minor version of Standard Features Naming Convention that was
        used to create the device's GenICam XML.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceSFNCVersionSubMinor")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceSFNCVersionSubMinor))
            node = self._nodes["DeviceSFNCVersionSubMinor"] = node_inst
        return node

    @property
    def DeviceManifestEntrySelector(self) -> SpinIntNode:
        """Selects the manifest entry to reference.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceManifestEntrySelector")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceManifestEntrySelector))
            node = self._nodes["DeviceManifestEntrySelector"] = node_inst
        return node

    @property
    def DeviceManifestXMLMajorVersion(self) -> SpinIntNode:
        """Indicates the major version number of the GenICam XML file of the
        selected manifest entry.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceManifestXMLMajorVersion")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceManifestXMLMajorVersion))
            node = self._nodes["DeviceManifestXMLMajorVersion"] = node_inst
        return node

    @property
    def DeviceManifestXMLMinorVersion(self) -> SpinIntNode:
        """Indicates the minor version number of the GenICam XML file of the
        selected manifest entry.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceManifestXMLMinorVersion")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceManifestXMLMinorVersion))
            node = self._nodes["DeviceManifestXMLMinorVersion"] = node_inst
        return node

    @property
    def DeviceManifestXMLSubMinorVersion(self) -> SpinIntNode:
        """Indicates the subminor version number of the GenICam XML file of the
        selected manifest entry.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceManifestXMLSubMinorVersion")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceManifestXMLSubMinorVersion))
            node = self._nodes["DeviceManifestXMLSubMinorVersion"] = node_inst
        return node

    @property
    def DeviceManifestSchemaMajorVersion(self) -> SpinIntNode:
        """Indicates the major version number of the schema file of the
        selected manifest entry.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceManifestSchemaMajorVersion")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceManifestSchemaMajorVersion))
            node = self._nodes["DeviceManifestSchemaMajorVersion"] = node_inst
        return node

    @property
    def DeviceManifestSchemaMinorVersion(self) -> SpinIntNode:
        """Indicates the minor version number of the schema file of the
        selected manifest entry.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceManifestSchemaMinorVersion")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceManifestSchemaMinorVersion))
            node = self._nodes["DeviceManifestSchemaMinorVersion"] = node_inst
        return node

    @property
    def DeviceManifestPrimaryURL(self) -> SpinStrNode:
        """Indicates the first URL to the GenICam XML device description file
        of the selected manifest entry.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("DeviceManifestPrimaryURL")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceManifestPrimaryURL))
            node = self._nodes["DeviceManifestPrimaryURL"] = node_inst
        return node

    @property
    def DeviceManifestSecondaryURL(self) -> SpinStrNode:
        """Indicates the second URL to the GenICam XML device description file
        of the selected manifest entry.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("DeviceManifestSecondaryURL")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceManifestSecondaryURL))
            node = self._nodes["DeviceManifestSecondaryURL"] = node_inst
        return node

    @property
    def DeviceTLVersionSubMinor(self) -> SpinIntNode:
        """Sub minor version of the Transport Layer of the device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceTLVersionSubMinor")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceTLVersionSubMinor))
            node = self._nodes["DeviceTLVersionSubMinor"] = node_inst
        return node

    @property
    def DeviceGenCPVersionMajor(self) -> SpinIntNode:
        """Major version of the GenCP protocol supported by the device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceGenCPVersionMajor")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceGenCPVersionMajor))
            node = self._nodes["DeviceGenCPVersionMajor"] = node_inst
        return node

    @property
    def DeviceGenCPVersionMinor(self) -> SpinIntNode:
        """Minor version of the GenCP protocol supported by the device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceGenCPVersionMinor")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceGenCPVersionMinor))
            node = self._nodes["DeviceGenCPVersionMinor"] = node_inst
        return node

    @property
    def DeviceConnectionSelector(self) -> SpinIntNode:
        """Selects which Connection of the device to control.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceConnectionSelector")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceConnectionSelector))
            node = self._nodes["DeviceConnectionSelector"] = node_inst
        return node

    @property
    def DeviceConnectionSpeed(self) -> SpinIntNode:
        """Indicates the speed of transmission of the specified Connection

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceConnectionSpeed")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceConnectionSpeed))
            node = self._nodes["DeviceConnectionSpeed"] = node_inst
        return node

    @property
    def DeviceConnectionStatus(self) -> SpinEnumDefNode:
        """Indicates the status of the specified Connection.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.DeviceConnectionStatus_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("DeviceConnectionStatus")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceConnectionStatus))
            node_inst.enum_names = rotpy.names.camera.DeviceConnectionStatus_names
            node_inst.enum_values = rotpy.names.camera.DeviceConnectionStatus_values
            node = self._nodes["DeviceConnectionStatus"] = node_inst
        return node

    @property
    def DeviceLinkSelector(self) -> SpinIntNode:
        """Selects which Link of the device to control.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceLinkSelector")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceLinkSelector))
            node = self._nodes["DeviceLinkSelector"] = node_inst
        return node

    @property
    def DeviceLinkThroughputLimitMode(self) -> SpinEnumDefNode:
        """Controls if the DeviceLinkThroughputLimit is active. When disabled,
        lower level TL specific features are expected to control the
        throughput. When enabled, DeviceLinkThroughputLimit controls the
        overall throughput.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.DeviceLinkThroughputLimitMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("DeviceLinkThroughputLimitMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceLinkThroughputLimitMode))
            node_inst.enum_names = rotpy.names.camera.DeviceLinkThroughputLimitMode_names
            node_inst.enum_values = rotpy.names.camera.DeviceLinkThroughputLimitMode_values
            node = self._nodes["DeviceLinkThroughputLimitMode"] = node_inst
        return node

    @property
    def DeviceLinkConnectionCount(self) -> SpinIntNode:
        """Returns the number of physical connection of the device used by a
        particular Link.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceLinkConnectionCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceLinkConnectionCount))
            node = self._nodes["DeviceLinkConnectionCount"] = node_inst
        return node

    @property
    def DeviceLinkHeartbeatMode(self) -> SpinEnumDefNode:
        """Activate or deactivate the Link's heartbeat.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.DeviceLinkHeartbeatMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("DeviceLinkHeartbeatMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceLinkHeartbeatMode))
            node_inst.enum_names = rotpy.names.camera.DeviceLinkHeartbeatMode_names
            node_inst.enum_values = rotpy.names.camera.DeviceLinkHeartbeatMode_values
            node = self._nodes["DeviceLinkHeartbeatMode"] = node_inst
        return node

    @property
    def DeviceLinkHeartbeatTimeout(self) -> SpinFloatNode:
        """Controls the current heartbeat timeout of the specific Link.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("DeviceLinkHeartbeatTimeout")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceLinkHeartbeatTimeout))
            node = self._nodes["DeviceLinkHeartbeatTimeout"] = node_inst
        return node

    @property
    def DeviceLinkCommandTimeout(self) -> SpinFloatNode:
        """Indicates the command timeout of the specified Link. This
        corresponds to the maximum response time of the device for a command
        sent on that link.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("DeviceLinkCommandTimeout")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceLinkCommandTimeout))
            node = self._nodes["DeviceLinkCommandTimeout"] = node_inst
        return node

    @property
    def DeviceStreamChannelSelector(self) -> SpinIntNode:
        """Selects the stream channel to control.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceStreamChannelSelector")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceStreamChannelSelector))
            node = self._nodes["DeviceStreamChannelSelector"] = node_inst
        return node

    @property
    def DeviceStreamChannelType(self) -> SpinEnumDefNode:
        """Reports the type of the stream channel.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.DeviceStreamChannelType_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("DeviceStreamChannelType")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceStreamChannelType))
            node_inst.enum_names = rotpy.names.camera.DeviceStreamChannelType_names
            node_inst.enum_values = rotpy.names.camera.DeviceStreamChannelType_values
            node = self._nodes["DeviceStreamChannelType"] = node_inst
        return node

    @property
    def DeviceStreamChannelLink(self) -> SpinIntNode:
        """Index of device's Link to use for streaming the specifed stream
        channel.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceStreamChannelLink")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceStreamChannelLink))
            node = self._nodes["DeviceStreamChannelLink"] = node_inst
        return node

    @property
    def DeviceStreamChannelEndianness(self) -> SpinEnumDefNode:
        """Endianness of multi-byte pixel data for this stream.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.DeviceStreamChannelEndianness_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("DeviceStreamChannelEndianness")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceStreamChannelEndianness))
            node_inst.enum_names = rotpy.names.camera.DeviceStreamChannelEndianness_names
            node_inst.enum_values = rotpy.names.camera.DeviceStreamChannelEndianness_values
            node = self._nodes["DeviceStreamChannelEndianness"] = node_inst
        return node

    @property
    def DeviceStreamChannelPacketSize(self) -> SpinIntNode:
        """Specifies the stream packet size, in bytes, to send on the selected
        channel for a Transmitter or specifies the maximum packet size
        supported by a receiver.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceStreamChannelPacketSize")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceStreamChannelPacketSize))
            node = self._nodes["DeviceStreamChannelPacketSize"] = node_inst
        return node

    @property
    def DeviceFeaturePersistenceStart(self) -> SpinCommandNode:
        """Indicate to the device and GenICam XML to get ready for persisting
        of all streamable features.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("DeviceFeaturePersistenceStart")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceFeaturePersistenceStart))
            node = self._nodes["DeviceFeaturePersistenceStart"] = node_inst
        return node

    @property
    def DeviceFeaturePersistenceEnd(self) -> SpinCommandNode:
        """Indicate to the device the end of feature persistence.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("DeviceFeaturePersistenceEnd")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceFeaturePersistenceEnd))
            node = self._nodes["DeviceFeaturePersistenceEnd"] = node_inst
        return node

    @property
    def DeviceRegistersStreamingStart(self) -> SpinCommandNode:
        """Prepare the device for registers streaming without checking for
        consistency.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("DeviceRegistersStreamingStart")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceRegistersStreamingStart))
            node = self._nodes["DeviceRegistersStreamingStart"] = node_inst
        return node

    @property
    def DeviceRegistersStreamingEnd(self) -> SpinCommandNode:
        """Announce the end of registers streaming. This will do a register set
        validation for consistency and activate it. This will also update
        the DeviceRegistersValid flag.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("DeviceRegistersStreamingEnd")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceRegistersStreamingEnd))
            node = self._nodes["DeviceRegistersStreamingEnd"] = node_inst
        return node

    @property
    def DeviceRegistersCheck(self) -> SpinCommandNode:
        """Perform the validation of the current register set for consistency.
        This will update the DeviceRegistersValid flag.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("DeviceRegistersCheck")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceRegistersCheck))
            node = self._nodes["DeviceRegistersCheck"] = node_inst
        return node

    @property
    def DeviceRegistersValid(self) -> SpinBoolNode:
        """Returns if the current register set is valid and consistent.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("DeviceRegistersValid")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceRegistersValid))
            node = self._nodes["DeviceRegistersValid"] = node_inst
        return node

    @property
    def DeviceClockSelector(self) -> SpinEnumDefNode:
        """Selects the clock frequency to access from the device.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.DeviceClockSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("DeviceClockSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceClockSelector))
            node_inst.enum_names = rotpy.names.camera.DeviceClockSelector_names
            node_inst.enum_values = rotpy.names.camera.DeviceClockSelector_values
            node = self._nodes["DeviceClockSelector"] = node_inst
        return node

    @property
    def DeviceClockFrequency(self) -> SpinFloatNode:
        """Returns the frequency of the selected Clock.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("DeviceClockFrequency")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceClockFrequency))
            node = self._nodes["DeviceClockFrequency"] = node_inst
        return node

    @property
    def DeviceSerialPortSelector(self) -> SpinEnumDefNode:
        """Selects which serial port of the device to control.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.DeviceSerialPortSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("DeviceSerialPortSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceSerialPortSelector))
            node_inst.enum_names = rotpy.names.camera.DeviceSerialPortSelector_names
            node_inst.enum_values = rotpy.names.camera.DeviceSerialPortSelector_values
            node = self._nodes["DeviceSerialPortSelector"] = node_inst
        return node

    @property
    def DeviceSerialPortBaudRate(self) -> SpinEnumDefNode:
        """This feature controls the baud rate used by the selected serial
        port.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.DeviceSerialPortBaudRate_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("DeviceSerialPortBaudRate")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceSerialPortBaudRate))
            node_inst.enum_names = rotpy.names.camera.DeviceSerialPortBaudRate_names
            node_inst.enum_values = rotpy.names.camera.DeviceSerialPortBaudRate_values
            node = self._nodes["DeviceSerialPortBaudRate"] = node_inst
        return node

    @property
    def Timestamp(self) -> SpinIntNode:
        """Reports the current value of the device timestamp counter.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("Timestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().Timestamp))
            node = self._nodes["Timestamp"] = node_inst
        return node

    @property
    def SensorTaps(self) -> SpinEnumDefNode:
        """Number of taps of the camera sensor.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.SensorTaps_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("SensorTaps")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SensorTaps))
            node_inst.enum_names = rotpy.names.camera.SensorTaps_names
            node_inst.enum_values = rotpy.names.camera.SensorTaps_values
            node = self._nodes["SensorTaps"] = node_inst
        return node

    @property
    def SensorDigitizationTaps(self) -> SpinEnumDefNode:
        """Number of digitized samples outputted simultaneously by the camera
        A/D conversion stage.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.SensorDigitizationTaps_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("SensorDigitizationTaps")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SensorDigitizationTaps))
            node_inst.enum_names = rotpy.names.camera.SensorDigitizationTaps_names
            node_inst.enum_values = rotpy.names.camera.SensorDigitizationTaps_values
            node = self._nodes["SensorDigitizationTaps"] = node_inst
        return node

    @property
    def RegionSelector(self) -> SpinEnumDefNode:
        """Selects the Region of interest to control. The RegionSelector
        feature allows devices that are able to extract multiple regions out
        of an image, to configure the features of those individual regions
        independently.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.RegionSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("RegionSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().RegionSelector))
            node_inst.enum_names = rotpy.names.camera.RegionSelector_names
            node_inst.enum_values = rotpy.names.camera.RegionSelector_values
            node = self._nodes["RegionSelector"] = node_inst
        return node

    @property
    def RegionMode(self) -> SpinEnumDefNode:
        """Controls if the selected Region of interest is active and streaming.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.RegionMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("RegionMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().RegionMode))
            node_inst.enum_names = rotpy.names.camera.RegionMode_names
            node_inst.enum_values = rotpy.names.camera.RegionMode_values
            node = self._nodes["RegionMode"] = node_inst
        return node

    @property
    def RegionDestination(self) -> SpinEnumDefNode:
        """Control the destination of the selected region.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.RegionDestination_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("RegionDestination")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().RegionDestination))
            node_inst.enum_names = rotpy.names.camera.RegionDestination_names
            node_inst.enum_values = rotpy.names.camera.RegionDestination_values
            node = self._nodes["RegionDestination"] = node_inst
        return node

    @property
    def ImageComponentSelector(self) -> SpinEnumDefNode:
        """Selects a component to activate data streaming from.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ImageComponentSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ImageComponentSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ImageComponentSelector))
            node_inst.enum_names = rotpy.names.camera.ImageComponentSelector_names
            node_inst.enum_values = rotpy.names.camera.ImageComponentSelector_values
            node = self._nodes["ImageComponentSelector"] = node_inst
        return node

    @property
    def ImageComponentEnable(self) -> SpinBoolNode:
        """Controls if the selected component streaming is active.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("ImageComponentEnable")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ImageComponentEnable))
            node = self._nodes["ImageComponentEnable"] = node_inst
        return node

    @property
    def LinePitch(self) -> SpinIntNode:
        """Total number of bytes between 2 successive lines. This feature is
        used to facilitate alignment of image data.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("LinePitch")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().LinePitch))
            node = self._nodes["LinePitch"] = node_inst
        return node

    @property
    def PixelFormatInfoSelector(self) -> SpinEnumDefNode:
        """Select the pixel format for which the information will be returned.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.PixelFormatInfoSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("PixelFormatInfoSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().PixelFormatInfoSelector))
            node_inst.enum_names = rotpy.names.camera.PixelFormatInfoSelector_names
            node_inst.enum_values = rotpy.names.camera.PixelFormatInfoSelector_values
            node = self._nodes["PixelFormatInfoSelector"] = node_inst
        return node

    @property
    def PixelFormatInfoID(self) -> SpinIntNode:
        """Returns the value used by the streaming channels to identify the
        selected pixel format.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("PixelFormatInfoID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().PixelFormatInfoID))
            node = self._nodes["PixelFormatInfoID"] = node_inst
        return node

    @property
    def Deinterlacing(self) -> SpinEnumDefNode:
        """Controls how the device performs de-interlacing.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.Deinterlacing_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("Deinterlacing")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().Deinterlacing))
            node_inst.enum_names = rotpy.names.camera.Deinterlacing_names
            node_inst.enum_values = rotpy.names.camera.Deinterlacing_values
            node = self._nodes["Deinterlacing"] = node_inst
        return node

    @property
    def ImageCompressionRateOption(self) -> SpinEnumDefNode:
        """Two rate controlling options are offered: fixed bit rate or fixed
        quality. The exact implementation to achieve one or the other is
        vendor-specific.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ImageCompressionRateOption_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ImageCompressionRateOption")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ImageCompressionRateOption))
            node_inst.enum_names = rotpy.names.camera.ImageCompressionRateOption_names
            node_inst.enum_values = rotpy.names.camera.ImageCompressionRateOption_values
            node = self._nodes["ImageCompressionRateOption"] = node_inst
        return node

    @property
    def ImageCompressionQuality(self) -> SpinIntNode:
        """Control the quality of the produced compressed stream.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ImageCompressionQuality")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ImageCompressionQuality))
            node = self._nodes["ImageCompressionQuality"] = node_inst
        return node

    @property
    def ImageCompressionBitrate(self) -> SpinFloatNode:
        """Control the rate of the produced compressed stream.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("ImageCompressionBitrate")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ImageCompressionBitrate))
            node = self._nodes["ImageCompressionBitrate"] = node_inst
        return node

    @property
    def ImageCompressionJPEGFormatOption(self) -> SpinEnumDefNode:
        """When JPEG is selected as the compression format, a device might
        optionally offer better control over JPEG-specific options through
        this feature.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ImageCompressionJPEGFormatOption_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ImageCompressionJPEGFormatOption")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ImageCompressionJPEGFormatOption))
            node_inst.enum_names = rotpy.names.camera.ImageCompressionJPEGFormatOption_names
            node_inst.enum_values = rotpy.names.camera.ImageCompressionJPEGFormatOption_values
            node = self._nodes["ImageCompressionJPEGFormatOption"] = node_inst
        return node

    @property
    def AcquisitionAbort(self) -> SpinCommandNode:
        """Aborts the Acquisition immediately. This will end the capture
        without completing the current Frame or waiting on a trigger. If no
        Acquisition is in progress, the command is ignored.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("AcquisitionAbort")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AcquisitionAbort))
            node = self._nodes["AcquisitionAbort"] = node_inst
        return node

    @property
    def AcquisitionArm(self) -> SpinCommandNode:
        """Arms the device before an AcquisitionStart command. This optional
        command validates all the current features for consistency and
        prepares the device for a fast start of the Acquisition.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("AcquisitionArm")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AcquisitionArm))
            node = self._nodes["AcquisitionArm"] = node_inst
        return node

    @property
    def AcquisitionStatusSelector(self) -> SpinEnumDefNode:
        """Selects the internal acquisition signal to read using
        AcquisitionStatus.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.AcquisitionStatusSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("AcquisitionStatusSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AcquisitionStatusSelector))
            node_inst.enum_names = rotpy.names.camera.AcquisitionStatusSelector_names
            node_inst.enum_values = rotpy.names.camera.AcquisitionStatusSelector_values
            node = self._nodes["AcquisitionStatusSelector"] = node_inst
        return node

    @property
    def AcquisitionStatus(self) -> SpinBoolNode:
        """Reads the state of the internal acquisition signal selected using
        AcquisitionStatusSelector.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("AcquisitionStatus")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().AcquisitionStatus))
            node = self._nodes["AcquisitionStatus"] = node_inst
        return node

    @property
    def TriggerDivider(self) -> SpinIntNode:
        """Specifies a division factor for the incoming trigger pulses.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("TriggerDivider")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TriggerDivider))
            node = self._nodes["TriggerDivider"] = node_inst
        return node

    @property
    def TriggerMultiplier(self) -> SpinIntNode:
        """Specifies a multiplication factor for the incoming trigger pulses.
        It is used generally used in conjunction with TriggerDivider to
        control the ratio of triggers that are accepted.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("TriggerMultiplier")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TriggerMultiplier))
            node = self._nodes["TriggerMultiplier"] = node_inst
        return node

    @property
    def ExposureTimeMode(self) -> SpinEnumDefNode:
        """Sets the configuration mode of the ExposureTime feature.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ExposureTimeMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ExposureTimeMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ExposureTimeMode))
            node_inst.enum_names = rotpy.names.camera.ExposureTimeMode_names
            node_inst.enum_values = rotpy.names.camera.ExposureTimeMode_values
            node = self._nodes["ExposureTimeMode"] = node_inst
        return node

    @property
    def ExposureTimeSelector(self) -> SpinEnumDefNode:
        """Selects which exposure time is controlled by the ExposureTime
        feature. This allows for independent control over the exposure
        components.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ExposureTimeSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ExposureTimeSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ExposureTimeSelector))
            node_inst.enum_names = rotpy.names.camera.ExposureTimeSelector_names
            node_inst.enum_values = rotpy.names.camera.ExposureTimeSelector_values
            node = self._nodes["ExposureTimeSelector"] = node_inst
        return node

    @property
    def GainAutoBalance(self) -> SpinEnumDefNode:
        """Sets the mode for automatic gain balancing between the sensor color
        channels or taps. The gain coefficients of each channel or tap are
        adjusted so they are matched.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.GainAutoBalance_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("GainAutoBalance")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GainAutoBalance))
            node_inst.enum_names = rotpy.names.camera.GainAutoBalance_names
            node_inst.enum_values = rotpy.names.camera.GainAutoBalance_values
            node = self._nodes["GainAutoBalance"] = node_inst
        return node

    @property
    def BlackLevelAuto(self) -> SpinEnumDefNode:
        """Controls the mode for automatic black level adjustment. The exact
        algorithm used to implement this adjustment is device-specific.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.BlackLevelAuto_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("BlackLevelAuto")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().BlackLevelAuto))
            node_inst.enum_names = rotpy.names.camera.BlackLevelAuto_names
            node_inst.enum_values = rotpy.names.camera.BlackLevelAuto_values
            node = self._nodes["BlackLevelAuto"] = node_inst
        return node

    @property
    def BlackLevelAutoBalance(self) -> SpinEnumDefNode:
        """Controls the mode for automatic black level balancing between the
        sensor color channels or taps. The black level coefficients of each
        channel are adjusted so they are matched.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.BlackLevelAutoBalance_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("BlackLevelAutoBalance")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().BlackLevelAutoBalance))
            node_inst.enum_names = rotpy.names.camera.BlackLevelAutoBalance_names
            node_inst.enum_values = rotpy.names.camera.BlackLevelAutoBalance_values
            node = self._nodes["BlackLevelAutoBalance"] = node_inst
        return node

    @property
    def WhiteClipSelector(self) -> SpinEnumDefNode:
        """Selects which White Clip to control.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.WhiteClipSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("WhiteClipSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().WhiteClipSelector))
            node_inst.enum_names = rotpy.names.camera.WhiteClipSelector_names
            node_inst.enum_values = rotpy.names.camera.WhiteClipSelector_values
            node = self._nodes["WhiteClipSelector"] = node_inst
        return node

    @property
    def WhiteClip(self) -> SpinFloatNode:
        """Controls the maximal intensity taken by the video signal before
        being clipped as an absolute physical value. The video signal will
        never exceed the white clipping point: it will saturate at that
        level.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("WhiteClip")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().WhiteClip))
            node = self._nodes["WhiteClip"] = node_inst
        return node

    @property
    def LUTValueAll(self) -> SpinRegisterNode:
        """Accesses all the LUT coefficients in a single access without using
        individual LUTIndex.

        :Property type: :class:`~rotpy.node.SpinRegisterNode`.
        :Visibility: ``default``.
        """
        cdef SpinRegisterNode node_inst
        node = self._nodes.get("LUTValueAll")
        if node is None:
            node_inst = SpinRegisterNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().LUTValueAll))
            node = self._nodes["LUTValueAll"] = node_inst
        return node

    @property
    def UserOutputValueAllMask(self) -> SpinIntNode:
        """Sets the write mask to apply to the value specified by
        UserOutputValueAll before writing it in the User Output register. If
        the UserOutputValueAllMask feature is present, setting the user
        Output register using UserOutputValueAll will only change the bits
        that have a corresponding bit in the mask set to one.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("UserOutputValueAllMask")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().UserOutputValueAllMask))
            node = self._nodes["UserOutputValueAllMask"] = node_inst
        return node

    @property
    def CounterReset(self) -> SpinCommandNode:
        """Does a software reset of the selected Counter and starts it. The
        counter starts counting events immediately after the reset unless a
        Counter trigger is active. CounterReset can be used to reset the
        Counter independently from the CounterResetSource. To disable the
        counter temporarily, set CounterEventSource to Off.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("CounterReset")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().CounterReset))
            node = self._nodes["CounterReset"] = node_inst
        return node

    @property
    def TimerSelector(self) -> SpinEnumDefNode:
        """Selects which Timer to configure.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.TimerSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("TimerSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TimerSelector))
            node_inst.enum_names = rotpy.names.camera.TimerSelector_names
            node_inst.enum_values = rotpy.names.camera.TimerSelector_values
            node = self._nodes["TimerSelector"] = node_inst
        return node

    @property
    def TimerDuration(self) -> SpinFloatNode:
        """Sets the duration (in microseconds) of the Timer pulse.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("TimerDuration")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TimerDuration))
            node = self._nodes["TimerDuration"] = node_inst
        return node

    @property
    def TimerDelay(self) -> SpinFloatNode:
        """Sets the duration (in microseconds) of the delay to apply at the
        reception of a trigger before starting the Timer.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("TimerDelay")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TimerDelay))
            node = self._nodes["TimerDelay"] = node_inst
        return node

    @property
    def TimerReset(self) -> SpinCommandNode:
        """Does a software reset of the selected timer and starts it. The timer
        starts immediately after the reset unless a timer trigger is active.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("TimerReset")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TimerReset))
            node = self._nodes["TimerReset"] = node_inst
        return node

    @property
    def TimerValue(self) -> SpinFloatNode:
        """Reads or writes the current value (in microseconds) of the selected
        Timer.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("TimerValue")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TimerValue))
            node = self._nodes["TimerValue"] = node_inst
        return node

    @property
    def TimerStatus(self) -> SpinEnumDefNode:
        """Returns the current status of the Timer.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.TimerStatus_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("TimerStatus")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TimerStatus))
            node_inst.enum_names = rotpy.names.camera.TimerStatus_names
            node_inst.enum_values = rotpy.names.camera.TimerStatus_values
            node = self._nodes["TimerStatus"] = node_inst
        return node

    @property
    def TimerTriggerSource(self) -> SpinEnumDefNode:
        """Selects the source of the trigger to start the Timer.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.TimerTriggerSource_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("TimerTriggerSource")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TimerTriggerSource))
            node_inst.enum_names = rotpy.names.camera.TimerTriggerSource_names
            node_inst.enum_values = rotpy.names.camera.TimerTriggerSource_values
            node = self._nodes["TimerTriggerSource"] = node_inst
        return node

    @property
    def TimerTriggerActivation(self) -> SpinEnumDefNode:
        """Selects the activation mode of the trigger to start the Timer.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.TimerTriggerActivation_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("TimerTriggerActivation")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TimerTriggerActivation))
            node_inst.enum_names = rotpy.names.camera.TimerTriggerActivation_names
            node_inst.enum_values = rotpy.names.camera.TimerTriggerActivation_values
            node = self._nodes["TimerTriggerActivation"] = node_inst
        return node

    @property
    def EncoderSelector(self) -> SpinEnumDefNode:
        """Selects which Encoder to configure.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.EncoderSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("EncoderSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EncoderSelector))
            node_inst.enum_names = rotpy.names.camera.EncoderSelector_names
            node_inst.enum_values = rotpy.names.camera.EncoderSelector_values
            node = self._nodes["EncoderSelector"] = node_inst
        return node

    @property
    def EncoderSourceA(self) -> SpinEnumDefNode:
        """Selects the signal which will be the source of the A input of the
        Encoder.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.EncoderSourceA_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("EncoderSourceA")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EncoderSourceA))
            node_inst.enum_names = rotpy.names.camera.EncoderSourceA_names
            node_inst.enum_values = rotpy.names.camera.EncoderSourceA_values
            node = self._nodes["EncoderSourceA"] = node_inst
        return node

    @property
    def EncoderSourceB(self) -> SpinEnumDefNode:
        """Selects the signal which will be the source of the B input of the
        Encoder.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.EncoderSourceB_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("EncoderSourceB")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EncoderSourceB))
            node_inst.enum_names = rotpy.names.camera.EncoderSourceB_names
            node_inst.enum_values = rotpy.names.camera.EncoderSourceB_values
            node = self._nodes["EncoderSourceB"] = node_inst
        return node

    @property
    def EncoderMode(self) -> SpinEnumDefNode:
        """Selects if the count of encoder uses FourPhase mode with jitter
        filtering or the HighResolution mode without jitter filtering.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.EncoderMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("EncoderMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EncoderMode))
            node_inst.enum_names = rotpy.names.camera.EncoderMode_names
            node_inst.enum_values = rotpy.names.camera.EncoderMode_values
            node = self._nodes["EncoderMode"] = node_inst
        return node

    @property
    def EncoderDivider(self) -> SpinIntNode:
        """Sets how many Encoder increment/decrements that are needed generate
        an Encoder output pulse signal.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EncoderDivider")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EncoderDivider))
            node = self._nodes["EncoderDivider"] = node_inst
        return node

    @property
    def EncoderOutputMode(self) -> SpinEnumDefNode:
        """Selects the conditions for the Encoder interface to generate a valid
        Encoder output signal.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.EncoderOutputMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("EncoderOutputMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EncoderOutputMode))
            node_inst.enum_names = rotpy.names.camera.EncoderOutputMode_names
            node_inst.enum_values = rotpy.names.camera.EncoderOutputMode_values
            node = self._nodes["EncoderOutputMode"] = node_inst
        return node

    @property
    def EncoderStatus(self) -> SpinEnumDefNode:
        """Returns the motion status of the encoder.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.EncoderStatus_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("EncoderStatus")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EncoderStatus))
            node_inst.enum_names = rotpy.names.camera.EncoderStatus_names
            node_inst.enum_values = rotpy.names.camera.EncoderStatus_values
            node = self._nodes["EncoderStatus"] = node_inst
        return node

    @property
    def EncoderTimeout(self) -> SpinFloatNode:
        """Sets the maximum time interval between encoder counter increments
        before the status turns to static.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("EncoderTimeout")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EncoderTimeout))
            node = self._nodes["EncoderTimeout"] = node_inst
        return node

    @property
    def EncoderResetSource(self) -> SpinEnumDefNode:
        """Selects the signals that will be the source to reset the Encoder.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.EncoderResetSource_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("EncoderResetSource")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EncoderResetSource))
            node_inst.enum_names = rotpy.names.camera.EncoderResetSource_names
            node_inst.enum_values = rotpy.names.camera.EncoderResetSource_values
            node = self._nodes["EncoderResetSource"] = node_inst
        return node

    @property
    def EncoderResetActivation(self) -> SpinEnumDefNode:
        """Selects the Activation mode of the Encoder Reset Source signal.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.EncoderResetActivation_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("EncoderResetActivation")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EncoderResetActivation))
            node_inst.enum_names = rotpy.names.camera.EncoderResetActivation_names
            node_inst.enum_values = rotpy.names.camera.EncoderResetActivation_values
            node = self._nodes["EncoderResetActivation"] = node_inst
        return node

    @property
    def EncoderReset(self) -> SpinCommandNode:
        """Does a software reset of the selected Encoder and starts it. The
        Encoder starts counting events immediately after the reset.
        EncoderReset can be used to reset the Encoder independently from the
        EncoderResetSource.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("EncoderReset")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EncoderReset))
            node = self._nodes["EncoderReset"] = node_inst
        return node

    @property
    def EncoderValue(self) -> SpinIntNode:
        """Reads or writes the current value of the position counter of the
        selected Encoder.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EncoderValue")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EncoderValue))
            node = self._nodes["EncoderValue"] = node_inst
        return node

    @property
    def EncoderValueAtReset(self) -> SpinIntNode:
        """Reads the value of the of the position counter of the selected
        Encoder when it was reset by a signal or by an explicit EncoderReset
        command.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EncoderValueAtReset")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EncoderValueAtReset))
            node = self._nodes["EncoderValueAtReset"] = node_inst
        return node

    @property
    def SoftwareSignalSelector(self) -> SpinEnumDefNode:
        """Selects which Software Signal features to control.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.SoftwareSignalSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("SoftwareSignalSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SoftwareSignalSelector))
            node_inst.enum_names = rotpy.names.camera.SoftwareSignalSelector_names
            node_inst.enum_values = rotpy.names.camera.SoftwareSignalSelector_values
            node = self._nodes["SoftwareSignalSelector"] = node_inst
        return node

    @property
    def SoftwareSignalPulse(self) -> SpinCommandNode:
        """Generates a pulse signal that can be used as a software trigger.
        This command can be used to trigger other modules that accept a
        SoftwareSignal as trigger source.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("SoftwareSignalPulse")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SoftwareSignalPulse))
            node = self._nodes["SoftwareSignalPulse"] = node_inst
        return node

    @property
    def ActionUnconditionalMode(self) -> SpinEnumDefNode:
        """Enables the unconditional action command mode where action commands
        are processed even when the primary control channel is closed.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ActionUnconditionalMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ActionUnconditionalMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ActionUnconditionalMode))
            node_inst.enum_names = rotpy.names.camera.ActionUnconditionalMode_names
            node_inst.enum_values = rotpy.names.camera.ActionUnconditionalMode_values
            node = self._nodes["ActionUnconditionalMode"] = node_inst
        return node

    @property
    def ActionDeviceKey(self) -> SpinIntNode:
        """Provides the device key that allows the device to check the validity
        of action commands. The device internal assertion of an action
        signal is only authorized if the ActionDeviceKey and the action
        device key value in the protocol message are equal.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ActionDeviceKey")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ActionDeviceKey))
            node = self._nodes["ActionDeviceKey"] = node_inst
        return node

    @property
    def ActionQueueSize(self) -> SpinIntNode:
        """Indicates the size of the scheduled action commands queue. This
        number represents the maximum number of scheduled action commands
        that can be pending at a given point in time.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ActionQueueSize")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ActionQueueSize))
            node = self._nodes["ActionQueueSize"] = node_inst
        return node

    @property
    def ActionSelector(self) -> SpinIntNode:
        """Selects to which Action Signal further Action settings apply.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ActionSelector")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ActionSelector))
            node = self._nodes["ActionSelector"] = node_inst
        return node

    @property
    def ActionGroupMask(self) -> SpinIntNode:
        """Provides the mask that the device will use to validate the action on
        reception of the action protocol message.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ActionGroupMask")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ActionGroupMask))
            node = self._nodes["ActionGroupMask"] = node_inst
        return node

    @property
    def ActionGroupKey(self) -> SpinIntNode:
        """Provides the key that the device will use to validate the action on
        reception of the action protocol message.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ActionGroupKey")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ActionGroupKey))
            node = self._nodes["ActionGroupKey"] = node_inst
        return node

    @property
    def EventAcquisitionTrigger(self) -> SpinIntNode:
        """Returns the unique Identifier of the Acquisition Trigger type of
        Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventAcquisitionTrigger")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventAcquisitionTrigger))
            node = self._nodes["EventAcquisitionTrigger"] = node_inst
        return node

    @property
    def EventAcquisitionTriggerTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Acquisition Trigger Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventAcquisitionTriggerTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventAcquisitionTriggerTimestamp))
            node = self._nodes["EventAcquisitionTriggerTimestamp"] = node_inst
        return node

    @property
    def EventAcquisitionTriggerFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Acquisition Trigger Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventAcquisitionTriggerFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventAcquisitionTriggerFrameID))
            node = self._nodes["EventAcquisitionTriggerFrameID"] = node_inst
        return node

    @property
    def EventAcquisitionStart(self) -> SpinIntNode:
        """Returns the unique Identifier of the Acquisition Start type of
        Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventAcquisitionStart")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventAcquisitionStart))
            node = self._nodes["EventAcquisitionStart"] = node_inst
        return node

    @property
    def EventAcquisitionStartTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Acquisition Start Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventAcquisitionStartTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventAcquisitionStartTimestamp))
            node = self._nodes["EventAcquisitionStartTimestamp"] = node_inst
        return node

    @property
    def EventAcquisitionStartFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Acquisition Start Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventAcquisitionStartFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventAcquisitionStartFrameID))
            node = self._nodes["EventAcquisitionStartFrameID"] = node_inst
        return node

    @property
    def EventAcquisitionEnd(self) -> SpinIntNode:
        """Returns the unique Identifier of the Acquisition End type of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventAcquisitionEnd")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventAcquisitionEnd))
            node = self._nodes["EventAcquisitionEnd"] = node_inst
        return node

    @property
    def EventAcquisitionEndTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Acquisition End Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventAcquisitionEndTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventAcquisitionEndTimestamp))
            node = self._nodes["EventAcquisitionEndTimestamp"] = node_inst
        return node

    @property
    def EventAcquisitionEndFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Acquisition End Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventAcquisitionEndFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventAcquisitionEndFrameID))
            node = self._nodes["EventAcquisitionEndFrameID"] = node_inst
        return node

    @property
    def EventAcquisitionTransferStart(self) -> SpinIntNode:
        """Returns the unique Identifier of the Acquisition Transfer Start type
        of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventAcquisitionTransferStart")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventAcquisitionTransferStart))
            node = self._nodes["EventAcquisitionTransferStart"] = node_inst
        return node

    @property
    def EventAcquisitionTransferStartTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Acquisition Transfer Start Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventAcquisitionTransferStartTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventAcquisitionTransferStartTimestamp))
            node = self._nodes["EventAcquisitionTransferStartTimestamp"] = node_inst
        return node

    @property
    def EventAcquisitionTransferStartFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Acquisition Transfer Start Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventAcquisitionTransferStartFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventAcquisitionTransferStartFrameID))
            node = self._nodes["EventAcquisitionTransferStartFrameID"] = node_inst
        return node

    @property
    def EventAcquisitionTransferEnd(self) -> SpinIntNode:
        """Returns the unique Identifier of the Acquisition Transfer End type
        of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventAcquisitionTransferEnd")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventAcquisitionTransferEnd))
            node = self._nodes["EventAcquisitionTransferEnd"] = node_inst
        return node

    @property
    def EventAcquisitionTransferEndTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Acquisition Transfer End Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventAcquisitionTransferEndTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventAcquisitionTransferEndTimestamp))
            node = self._nodes["EventAcquisitionTransferEndTimestamp"] = node_inst
        return node

    @property
    def EventAcquisitionTransferEndFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Acquisition Transfer End Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventAcquisitionTransferEndFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventAcquisitionTransferEndFrameID))
            node = self._nodes["EventAcquisitionTransferEndFrameID"] = node_inst
        return node

    @property
    def EventAcquisitionError(self) -> SpinIntNode:
        """Returns the unique Identifier of the Acquisition Error type of
        Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventAcquisitionError")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventAcquisitionError))
            node = self._nodes["EventAcquisitionError"] = node_inst
        return node

    @property
    def EventAcquisitionErrorTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Acquisition Error Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventAcquisitionErrorTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventAcquisitionErrorTimestamp))
            node = self._nodes["EventAcquisitionErrorTimestamp"] = node_inst
        return node

    @property
    def EventAcquisitionErrorFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Acquisition Error Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventAcquisitionErrorFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventAcquisitionErrorFrameID))
            node = self._nodes["EventAcquisitionErrorFrameID"] = node_inst
        return node

    @property
    def EventFrameTrigger(self) -> SpinIntNode:
        """Returns the unique Identifier of the FrameTrigger type of Event. It
        can be used to register a callback function to be notified of the
        event occurrence. Its value uniquely identifies the type event
        received.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventFrameTrigger")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventFrameTrigger))
            node = self._nodes["EventFrameTrigger"] = node_inst
        return node

    @property
    def EventFrameTriggerTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the FrameTrigger Event. It can be used to
        determine precisely when the event occurred.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventFrameTriggerTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventFrameTriggerTimestamp))
            node = self._nodes["EventFrameTriggerTimestamp"] = node_inst
        return node

    @property
    def EventFrameTriggerFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the FrameTrigger Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventFrameTriggerFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventFrameTriggerFrameID))
            node = self._nodes["EventFrameTriggerFrameID"] = node_inst
        return node

    @property
    def EventFrameStart(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame Start type of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventFrameStart")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventFrameStart))
            node = self._nodes["EventFrameStart"] = node_inst
        return node

    @property
    def EventFrameStartTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Frame Start Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventFrameStartTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventFrameStartTimestamp))
            node = self._nodes["EventFrameStartTimestamp"] = node_inst
        return node

    @property
    def EventFrameStartFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Frame Start Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventFrameStartFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventFrameStartFrameID))
            node = self._nodes["EventFrameStartFrameID"] = node_inst
        return node

    @property
    def EventFrameEnd(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame End type of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventFrameEnd")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventFrameEnd))
            node = self._nodes["EventFrameEnd"] = node_inst
        return node

    @property
    def EventFrameEndTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Frame End Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventFrameEndTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventFrameEndTimestamp))
            node = self._nodes["EventFrameEndTimestamp"] = node_inst
        return node

    @property
    def EventFrameEndFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Frame End Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventFrameEndFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventFrameEndFrameID))
            node = self._nodes["EventFrameEndFrameID"] = node_inst
        return node

    @property
    def EventFrameBurstStart(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame Burst Start type of
        Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventFrameBurstStart")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventFrameBurstStart))
            node = self._nodes["EventFrameBurstStart"] = node_inst
        return node

    @property
    def EventFrameBurstStartTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Frame Burst Start Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventFrameBurstStartTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventFrameBurstStartTimestamp))
            node = self._nodes["EventFrameBurstStartTimestamp"] = node_inst
        return node

    @property
    def EventFrameBurstStartFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Frame Burst Start Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventFrameBurstStartFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventFrameBurstStartFrameID))
            node = self._nodes["EventFrameBurstStartFrameID"] = node_inst
        return node

    @property
    def EventFrameBurstEnd(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame Burst End type of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventFrameBurstEnd")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventFrameBurstEnd))
            node = self._nodes["EventFrameBurstEnd"] = node_inst
        return node

    @property
    def EventFrameBurstEndTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Frame Burst End Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventFrameBurstEndTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventFrameBurstEndTimestamp))
            node = self._nodes["EventFrameBurstEndTimestamp"] = node_inst
        return node

    @property
    def EventFrameBurstEndFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Frame Burst End Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventFrameBurstEndFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventFrameBurstEndFrameID))
            node = self._nodes["EventFrameBurstEndFrameID"] = node_inst
        return node

    @property
    def EventFrameTransferStart(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame Transfer Start type of
        Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventFrameTransferStart")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventFrameTransferStart))
            node = self._nodes["EventFrameTransferStart"] = node_inst
        return node

    @property
    def EventFrameTransferStartTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Frame Transfer Start Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventFrameTransferStartTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventFrameTransferStartTimestamp))
            node = self._nodes["EventFrameTransferStartTimestamp"] = node_inst
        return node

    @property
    def EventFrameTransferStartFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Frame Transfer Start Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventFrameTransferStartFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventFrameTransferStartFrameID))
            node = self._nodes["EventFrameTransferStartFrameID"] = node_inst
        return node

    @property
    def EventFrameTransferEnd(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame Transfer End type of
        Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventFrameTransferEnd")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventFrameTransferEnd))
            node = self._nodes["EventFrameTransferEnd"] = node_inst
        return node

    @property
    def EventFrameTransferEndTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Frame Transfer End Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventFrameTransferEndTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventFrameTransferEndTimestamp))
            node = self._nodes["EventFrameTransferEndTimestamp"] = node_inst
        return node

    @property
    def EventFrameTransferEndFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Frame Transfer End Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventFrameTransferEndFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventFrameTransferEndFrameID))
            node = self._nodes["EventFrameTransferEndFrameID"] = node_inst
        return node

    @property
    def EventExposureStart(self) -> SpinIntNode:
        """Returns the unique Identifier of the Exposure Start type of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventExposureStart")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventExposureStart))
            node = self._nodes["EventExposureStart"] = node_inst
        return node

    @property
    def EventExposureStartTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Exposure Start Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventExposureStartTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventExposureStartTimestamp))
            node = self._nodes["EventExposureStartTimestamp"] = node_inst
        return node

    @property
    def EventExposureStartFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Exposure Start Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventExposureStartFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventExposureStartFrameID))
            node = self._nodes["EventExposureStartFrameID"] = node_inst
        return node

    @property
    def EventStream0TransferStart(self) -> SpinIntNode:
        """Returns the unique Identifier of the Stream 0 Transfer Start type of
        Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferStart")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferStart))
            node = self._nodes["EventStream0TransferStart"] = node_inst
        return node

    @property
    def EventStream0TransferStartTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Stream 0 Transfer Start Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferStartTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferStartTimestamp))
            node = self._nodes["EventStream0TransferStartTimestamp"] = node_inst
        return node

    @property
    def EventStream0TransferStartFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Stream 0 Transfer Start Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferStartFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferStartFrameID))
            node = self._nodes["EventStream0TransferStartFrameID"] = node_inst
        return node

    @property
    def EventStream0TransferEnd(self) -> SpinIntNode:
        """Returns the unique Identifier of the Stream 0 Transfer End type of
        Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferEnd")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferEnd))
            node = self._nodes["EventStream0TransferEnd"] = node_inst
        return node

    @property
    def EventStream0TransferEndTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Stream 0 Transfer End Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferEndTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferEndTimestamp))
            node = self._nodes["EventStream0TransferEndTimestamp"] = node_inst
        return node

    @property
    def EventStream0TransferEndFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Stream 0 Transfer End Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferEndFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferEndFrameID))
            node = self._nodes["EventStream0TransferEndFrameID"] = node_inst
        return node

    @property
    def EventStream0TransferPause(self) -> SpinIntNode:
        """Returns the unique Identifier of the Stream 0 Transfer Pause type of
        Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferPause")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferPause))
            node = self._nodes["EventStream0TransferPause"] = node_inst
        return node

    @property
    def EventStream0TransferPauseTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Stream 0 Transfer Pause Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferPauseTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferPauseTimestamp))
            node = self._nodes["EventStream0TransferPauseTimestamp"] = node_inst
        return node

    @property
    def EventStream0TransferPauseFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Stream 0 Transfer Pause Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferPauseFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferPauseFrameID))
            node = self._nodes["EventStream0TransferPauseFrameID"] = node_inst
        return node

    @property
    def EventStream0TransferResume(self) -> SpinIntNode:
        """Returns the unique Identifier of the Stream 0 Transfer Resume type
        of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferResume")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferResume))
            node = self._nodes["EventStream0TransferResume"] = node_inst
        return node

    @property
    def EventStream0TransferResumeTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Stream 0 Transfer Resume Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferResumeTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferResumeTimestamp))
            node = self._nodes["EventStream0TransferResumeTimestamp"] = node_inst
        return node

    @property
    def EventStream0TransferResumeFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Stream 0 Transfer Resume Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferResumeFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferResumeFrameID))
            node = self._nodes["EventStream0TransferResumeFrameID"] = node_inst
        return node

    @property
    def EventStream0TransferBlockStart(self) -> SpinIntNode:
        """Returns the unique Identifier of the Stream 0 Transfer Block Start
        type of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferBlockStart")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferBlockStart))
            node = self._nodes["EventStream0TransferBlockStart"] = node_inst
        return node

    @property
    def EventStream0TransferBlockStartTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Stream 0 Transfer Block Start Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferBlockStartTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferBlockStartTimestamp))
            node = self._nodes["EventStream0TransferBlockStartTimestamp"] = node_inst
        return node

    @property
    def EventStream0TransferBlockStartFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Stream 0 Transfer Block Start Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferBlockStartFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferBlockStartFrameID))
            node = self._nodes["EventStream0TransferBlockStartFrameID"] = node_inst
        return node

    @property
    def EventStream0TransferBlockEnd(self) -> SpinIntNode:
        """Returns the unique Identifier of the Stream 0 Transfer Block End
        type of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferBlockEnd")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferBlockEnd))
            node = self._nodes["EventStream0TransferBlockEnd"] = node_inst
        return node

    @property
    def EventStream0TransferBlockEndTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Stream 0 Transfer Block End Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferBlockEndTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferBlockEndTimestamp))
            node = self._nodes["EventStream0TransferBlockEndTimestamp"] = node_inst
        return node

    @property
    def EventStream0TransferBlockEndFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Stream 0 Transfer Block End Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferBlockEndFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferBlockEndFrameID))
            node = self._nodes["EventStream0TransferBlockEndFrameID"] = node_inst
        return node

    @property
    def EventStream0TransferBlockTrigger(self) -> SpinIntNode:
        """Returns the unique Identifier of the Stream 0 Transfer Block Trigger
        type of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferBlockTrigger")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferBlockTrigger))
            node = self._nodes["EventStream0TransferBlockTrigger"] = node_inst
        return node

    @property
    def EventStream0TransferBlockTriggerTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Stream 0 Transfer Block Trigger Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferBlockTriggerTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferBlockTriggerTimestamp))
            node = self._nodes["EventStream0TransferBlockTriggerTimestamp"] = node_inst
        return node

    @property
    def EventStream0TransferBlockTriggerFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Stream 0 Transfer Block Trigger Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferBlockTriggerFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferBlockTriggerFrameID))
            node = self._nodes["EventStream0TransferBlockTriggerFrameID"] = node_inst
        return node

    @property
    def EventStream0TransferBurstStart(self) -> SpinIntNode:
        """Returns the unique Identifier of the Stream 0 Transfer Burst Start
        type of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferBurstStart")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferBurstStart))
            node = self._nodes["EventStream0TransferBurstStart"] = node_inst
        return node

    @property
    def EventStream0TransferBurstStartTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Stream 0 Transfer Burst Start Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferBurstStartTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferBurstStartTimestamp))
            node = self._nodes["EventStream0TransferBurstStartTimestamp"] = node_inst
        return node

    @property
    def EventStream0TransferBurstStartFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Stream 0 Transfer Burst Start Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferBurstStartFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferBurstStartFrameID))
            node = self._nodes["EventStream0TransferBurstStartFrameID"] = node_inst
        return node

    @property
    def EventStream0TransferBurstEnd(self) -> SpinIntNode:
        """Returns the unique Identifier of the Stream 0 Transfer Burst End
        type of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferBurstEnd")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferBurstEnd))
            node = self._nodes["EventStream0TransferBurstEnd"] = node_inst
        return node

    @property
    def EventStream0TransferBurstEndTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Stream 0 Transfer Burst End Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferBurstEndTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferBurstEndTimestamp))
            node = self._nodes["EventStream0TransferBurstEndTimestamp"] = node_inst
        return node

    @property
    def EventStream0TransferBurstEndFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Stream 0 Transfer Burst End Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferBurstEndFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferBurstEndFrameID))
            node = self._nodes["EventStream0TransferBurstEndFrameID"] = node_inst
        return node

    @property
    def EventStream0TransferOverflow(self) -> SpinIntNode:
        """Returns the unique Identifier of the Stream 0 Transfer Overflow type
        of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferOverflow")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferOverflow))
            node = self._nodes["EventStream0TransferOverflow"] = node_inst
        return node

    @property
    def EventStream0TransferOverflowTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Stream 0 Transfer Overflow Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferOverflowTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferOverflowTimestamp))
            node = self._nodes["EventStream0TransferOverflowTimestamp"] = node_inst
        return node

    @property
    def EventStream0TransferOverflowFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Stream 0 Transfer Overflow Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventStream0TransferOverflowFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventStream0TransferOverflowFrameID))
            node = self._nodes["EventStream0TransferOverflowFrameID"] = node_inst
        return node

    @property
    def EventSequencerSetChange(self) -> SpinIntNode:
        """Returns the unique Identifier of the Sequencer Set Change type of
        Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventSequencerSetChange")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventSequencerSetChange))
            node = self._nodes["EventSequencerSetChange"] = node_inst
        return node

    @property
    def EventSequencerSetChangeTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Sequencer Set Change Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventSequencerSetChangeTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventSequencerSetChangeTimestamp))
            node = self._nodes["EventSequencerSetChangeTimestamp"] = node_inst
        return node

    @property
    def EventSequencerSetChangeFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Sequencer Set Change Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventSequencerSetChangeFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventSequencerSetChangeFrameID))
            node = self._nodes["EventSequencerSetChangeFrameID"] = node_inst
        return node

    @property
    def EventCounter0Start(self) -> SpinIntNode:
        """Returns the unique Identifier of the Counter 0 Start type of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventCounter0Start")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventCounter0Start))
            node = self._nodes["EventCounter0Start"] = node_inst
        return node

    @property
    def EventCounter0StartTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Counter 0 Start Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventCounter0StartTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventCounter0StartTimestamp))
            node = self._nodes["EventCounter0StartTimestamp"] = node_inst
        return node

    @property
    def EventCounter0StartFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Counter 0 Start Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventCounter0StartFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventCounter0StartFrameID))
            node = self._nodes["EventCounter0StartFrameID"] = node_inst
        return node

    @property
    def EventCounter1Start(self) -> SpinIntNode:
        """Returns the unique Identifier of the Counter 1 Start type of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventCounter1Start")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventCounter1Start))
            node = self._nodes["EventCounter1Start"] = node_inst
        return node

    @property
    def EventCounter1StartTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Counter 1 Start Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventCounter1StartTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventCounter1StartTimestamp))
            node = self._nodes["EventCounter1StartTimestamp"] = node_inst
        return node

    @property
    def EventCounter1StartFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Counter 1 Start Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventCounter1StartFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventCounter1StartFrameID))
            node = self._nodes["EventCounter1StartFrameID"] = node_inst
        return node

    @property
    def EventCounter0End(self) -> SpinIntNode:
        """Returns the unique Identifier of the Counter 0 End type of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventCounter0End")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventCounter0End))
            node = self._nodes["EventCounter0End"] = node_inst
        return node

    @property
    def EventCounter0EndTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Counter 0 End Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventCounter0EndTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventCounter0EndTimestamp))
            node = self._nodes["EventCounter0EndTimestamp"] = node_inst
        return node

    @property
    def EventCounter0EndFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Counter 0 End Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventCounter0EndFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventCounter0EndFrameID))
            node = self._nodes["EventCounter0EndFrameID"] = node_inst
        return node

    @property
    def EventCounter1End(self) -> SpinIntNode:
        """Returns the unique Identifier of the Counter 1 End type of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventCounter1End")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventCounter1End))
            node = self._nodes["EventCounter1End"] = node_inst
        return node

    @property
    def EventCounter1EndTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Counter 1 End Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventCounter1EndTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventCounter1EndTimestamp))
            node = self._nodes["EventCounter1EndTimestamp"] = node_inst
        return node

    @property
    def EventCounter1EndFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Counter 1 End Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventCounter1EndFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventCounter1EndFrameID))
            node = self._nodes["EventCounter1EndFrameID"] = node_inst
        return node

    @property
    def EventTimer0Start(self) -> SpinIntNode:
        """Returns the unique Identifier of the Timer 0 Start type of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventTimer0Start")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventTimer0Start))
            node = self._nodes["EventTimer0Start"] = node_inst
        return node

    @property
    def EventTimer0StartTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Timer 0 Start Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventTimer0StartTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventTimer0StartTimestamp))
            node = self._nodes["EventTimer0StartTimestamp"] = node_inst
        return node

    @property
    def EventTimer0StartFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Timer 0 Start Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventTimer0StartFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventTimer0StartFrameID))
            node = self._nodes["EventTimer0StartFrameID"] = node_inst
        return node

    @property
    def EventTimer1Start(self) -> SpinIntNode:
        """Returns the unique Identifier of the Timer 1 Start type of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventTimer1Start")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventTimer1Start))
            node = self._nodes["EventTimer1Start"] = node_inst
        return node

    @property
    def EventTimer1StartTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Timer 1 Start Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventTimer1StartTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventTimer1StartTimestamp))
            node = self._nodes["EventTimer1StartTimestamp"] = node_inst
        return node

    @property
    def EventTimer1StartFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Timer 1 Start Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventTimer1StartFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventTimer1StartFrameID))
            node = self._nodes["EventTimer1StartFrameID"] = node_inst
        return node

    @property
    def EventTimer0End(self) -> SpinIntNode:
        """Returns the unique Identifier of the Timer 0 End type of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventTimer0End")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventTimer0End))
            node = self._nodes["EventTimer0End"] = node_inst
        return node

    @property
    def EventTimer0EndTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Timer 0 End Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventTimer0EndTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventTimer0EndTimestamp))
            node = self._nodes["EventTimer0EndTimestamp"] = node_inst
        return node

    @property
    def EventTimer0EndFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Timer 0 End Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventTimer0EndFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventTimer0EndFrameID))
            node = self._nodes["EventTimer0EndFrameID"] = node_inst
        return node

    @property
    def EventTimer1End(self) -> SpinIntNode:
        """Returns the unique Identifier of the Timer 1 End type of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventTimer1End")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventTimer1End))
            node = self._nodes["EventTimer1End"] = node_inst
        return node

    @property
    def EventTimer1EndTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Timer 1 End Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventTimer1EndTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventTimer1EndTimestamp))
            node = self._nodes["EventTimer1EndTimestamp"] = node_inst
        return node

    @property
    def EventTimer1EndFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Timer 1 End Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventTimer1EndFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventTimer1EndFrameID))
            node = self._nodes["EventTimer1EndFrameID"] = node_inst
        return node

    @property
    def EventEncoder0Stopped(self) -> SpinIntNode:
        """Returns the unique Identifier of the Encoder 0 Stopped type of
        Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventEncoder0Stopped")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventEncoder0Stopped))
            node = self._nodes["EventEncoder0Stopped"] = node_inst
        return node

    @property
    def EventEncoder0StoppedTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Encoder 0 Stopped Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventEncoder0StoppedTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventEncoder0StoppedTimestamp))
            node = self._nodes["EventEncoder0StoppedTimestamp"] = node_inst
        return node

    @property
    def EventEncoder0StoppedFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Encoder 0 Stopped Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventEncoder0StoppedFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventEncoder0StoppedFrameID))
            node = self._nodes["EventEncoder0StoppedFrameID"] = node_inst
        return node

    @property
    def EventEncoder1Stopped(self) -> SpinIntNode:
        """Returns the unique Identifier of the Encoder 1 Stopped type of
        Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventEncoder1Stopped")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventEncoder1Stopped))
            node = self._nodes["EventEncoder1Stopped"] = node_inst
        return node

    @property
    def EventEncoder1StoppedTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Encoder 1 Stopped Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventEncoder1StoppedTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventEncoder1StoppedTimestamp))
            node = self._nodes["EventEncoder1StoppedTimestamp"] = node_inst
        return node

    @property
    def EventEncoder1StoppedFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Encoder 1 Stopped Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventEncoder1StoppedFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventEncoder1StoppedFrameID))
            node = self._nodes["EventEncoder1StoppedFrameID"] = node_inst
        return node

    @property
    def EventEncoder0Restarted(self) -> SpinIntNode:
        """Returns the unique Identifier of the Encoder 0 Restarted type of
        Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventEncoder0Restarted")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventEncoder0Restarted))
            node = self._nodes["EventEncoder0Restarted"] = node_inst
        return node

    @property
    def EventEncoder0RestartedTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Encoder 0 Restarted Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventEncoder0RestartedTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventEncoder0RestartedTimestamp))
            node = self._nodes["EventEncoder0RestartedTimestamp"] = node_inst
        return node

    @property
    def EventEncoder0RestartedFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Encoder 0 Restarted Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventEncoder0RestartedFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventEncoder0RestartedFrameID))
            node = self._nodes["EventEncoder0RestartedFrameID"] = node_inst
        return node

    @property
    def EventEncoder1Restarted(self) -> SpinIntNode:
        """Returns the unique Identifier of the Encoder 1 Restarted type of
        Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventEncoder1Restarted")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventEncoder1Restarted))
            node = self._nodes["EventEncoder1Restarted"] = node_inst
        return node

    @property
    def EventEncoder1RestartedTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Encoder 1 Restarted Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventEncoder1RestartedTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventEncoder1RestartedTimestamp))
            node = self._nodes["EventEncoder1RestartedTimestamp"] = node_inst
        return node

    @property
    def EventEncoder1RestartedFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Encoder 1 Restarted Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventEncoder1RestartedFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventEncoder1RestartedFrameID))
            node = self._nodes["EventEncoder1RestartedFrameID"] = node_inst
        return node

    @property
    def EventLine0RisingEdge(self) -> SpinIntNode:
        """Returns the unique Identifier of the Line 0 Rising Edge type of
        Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventLine0RisingEdge")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventLine0RisingEdge))
            node = self._nodes["EventLine0RisingEdge"] = node_inst
        return node

    @property
    def EventLine0RisingEdgeTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Line 0 Rising Edge Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventLine0RisingEdgeTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventLine0RisingEdgeTimestamp))
            node = self._nodes["EventLine0RisingEdgeTimestamp"] = node_inst
        return node

    @property
    def EventLine0RisingEdgeFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Line 0 Rising Edge Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventLine0RisingEdgeFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventLine0RisingEdgeFrameID))
            node = self._nodes["EventLine0RisingEdgeFrameID"] = node_inst
        return node

    @property
    def EventLine1RisingEdge(self) -> SpinIntNode:
        """Returns the unique Identifier of the Line 1 Rising Edge type of
        Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventLine1RisingEdge")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventLine1RisingEdge))
            node = self._nodes["EventLine1RisingEdge"] = node_inst
        return node

    @property
    def EventLine1RisingEdgeTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Line 1 Rising Edge Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventLine1RisingEdgeTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventLine1RisingEdgeTimestamp))
            node = self._nodes["EventLine1RisingEdgeTimestamp"] = node_inst
        return node

    @property
    def EventLine1RisingEdgeFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Line 1 Rising Edge Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventLine1RisingEdgeFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventLine1RisingEdgeFrameID))
            node = self._nodes["EventLine1RisingEdgeFrameID"] = node_inst
        return node

    @property
    def EventLine0FallingEdge(self) -> SpinIntNode:
        """Returns the unique Identifier of the Line 0 Falling Edge type of
        Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventLine0FallingEdge")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventLine0FallingEdge))
            node = self._nodes["EventLine0FallingEdge"] = node_inst
        return node

    @property
    def EventLine0FallingEdgeTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Line 0 Falling Edge Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventLine0FallingEdgeTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventLine0FallingEdgeTimestamp))
            node = self._nodes["EventLine0FallingEdgeTimestamp"] = node_inst
        return node

    @property
    def EventLine0FallingEdgeFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Line 0 Falling Edge Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventLine0FallingEdgeFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventLine0FallingEdgeFrameID))
            node = self._nodes["EventLine0FallingEdgeFrameID"] = node_inst
        return node

    @property
    def EventLine1FallingEdge(self) -> SpinIntNode:
        """Returns the unique Identifier of the Line 1 Falling Edge type of
        Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventLine1FallingEdge")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventLine1FallingEdge))
            node = self._nodes["EventLine1FallingEdge"] = node_inst
        return node

    @property
    def EventLine1FallingEdgeTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Line 1 Falling Edge Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventLine1FallingEdgeTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventLine1FallingEdgeTimestamp))
            node = self._nodes["EventLine1FallingEdgeTimestamp"] = node_inst
        return node

    @property
    def EventLine1FallingEdgeFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Line 1 Falling Edge Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventLine1FallingEdgeFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventLine1FallingEdgeFrameID))
            node = self._nodes["EventLine1FallingEdgeFrameID"] = node_inst
        return node

    @property
    def EventLine0AnyEdge(self) -> SpinIntNode:
        """Returns the unique Identifier of the Line 0 Any Edge type of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventLine0AnyEdge")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventLine0AnyEdge))
            node = self._nodes["EventLine0AnyEdge"] = node_inst
        return node

    @property
    def EventLine0AnyEdgeTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Line 0 Any Edge Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventLine0AnyEdgeTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventLine0AnyEdgeTimestamp))
            node = self._nodes["EventLine0AnyEdgeTimestamp"] = node_inst
        return node

    @property
    def EventLine0AnyEdgeFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Line 0 Any Edge Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventLine0AnyEdgeFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventLine0AnyEdgeFrameID))
            node = self._nodes["EventLine0AnyEdgeFrameID"] = node_inst
        return node

    @property
    def EventLine1AnyEdge(self) -> SpinIntNode:
        """Returns the unique Identifier of the Line 1 Any Edge type of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventLine1AnyEdge")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventLine1AnyEdge))
            node = self._nodes["EventLine1AnyEdge"] = node_inst
        return node

    @property
    def EventLine1AnyEdgeTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Line 1 Any Edge Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventLine1AnyEdgeTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventLine1AnyEdgeTimestamp))
            node = self._nodes["EventLine1AnyEdgeTimestamp"] = node_inst
        return node

    @property
    def EventLine1AnyEdgeFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Line 1 Any Edge Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventLine1AnyEdgeFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventLine1AnyEdgeFrameID))
            node = self._nodes["EventLine1AnyEdgeFrameID"] = node_inst
        return node

    @property
    def EventLinkTrigger0(self) -> SpinIntNode:
        """Returns the unique Identifier of the Link Trigger 0 type of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventLinkTrigger0")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventLinkTrigger0))
            node = self._nodes["EventLinkTrigger0"] = node_inst
        return node

    @property
    def EventLinkTrigger0Timestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Link Trigger 0 Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventLinkTrigger0Timestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventLinkTrigger0Timestamp))
            node = self._nodes["EventLinkTrigger0Timestamp"] = node_inst
        return node

    @property
    def EventLinkTrigger0FrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Link Trigger 0 Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventLinkTrigger0FrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventLinkTrigger0FrameID))
            node = self._nodes["EventLinkTrigger0FrameID"] = node_inst
        return node

    @property
    def EventLinkTrigger1(self) -> SpinIntNode:
        """Returns the unique Identifier of the Link Trigger 1 type of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventLinkTrigger1")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventLinkTrigger1))
            node = self._nodes["EventLinkTrigger1"] = node_inst
        return node

    @property
    def EventLinkTrigger1Timestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Link Trigger 1 Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventLinkTrigger1Timestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventLinkTrigger1Timestamp))
            node = self._nodes["EventLinkTrigger1Timestamp"] = node_inst
        return node

    @property
    def EventLinkTrigger1FrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Link Trigger 1 Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventLinkTrigger1FrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventLinkTrigger1FrameID))
            node = self._nodes["EventLinkTrigger1FrameID"] = node_inst
        return node

    @property
    def EventActionLate(self) -> SpinIntNode:
        """Returns the unique Identifier of the Action Late type of Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventActionLate")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventActionLate))
            node = self._nodes["EventActionLate"] = node_inst
        return node

    @property
    def EventActionLateTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Action Late Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventActionLateTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventActionLateTimestamp))
            node = self._nodes["EventActionLateTimestamp"] = node_inst
        return node

    @property
    def EventActionLateFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Action Late Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventActionLateFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventActionLateFrameID))
            node = self._nodes["EventActionLateFrameID"] = node_inst
        return node

    @property
    def EventLinkSpeedChange(self) -> SpinIntNode:
        """Returns the unique Identifier of the Link Speed Change type of
        Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventLinkSpeedChange")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventLinkSpeedChange))
            node = self._nodes["EventLinkSpeedChange"] = node_inst
        return node

    @property
    def EventLinkSpeedChangeTimestamp(self) -> SpinIntNode:
        """Returns the Timestamp of the Link Speed Change Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventLinkSpeedChangeTimestamp")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventLinkSpeedChangeTimestamp))
            node = self._nodes["EventLinkSpeedChangeTimestamp"] = node_inst
        return node

    @property
    def EventLinkSpeedChangeFrameID(self) -> SpinIntNode:
        """Returns the unique Identifier of the Frame (or image) that generated
        the Link Speed Change Event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("EventLinkSpeedChangeFrameID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().EventLinkSpeedChangeFrameID))
            node = self._nodes["EventLinkSpeedChangeFrameID"] = node_inst
        return node

    @property
    def FileAccessBuffer(self) -> SpinRegisterNode:
        """Defines the intermediate access buffer that allows the exchange of
        data between the device file storage and the application.

        :Property type: :class:`~rotpy.node.SpinRegisterNode`.
        :Visibility: ``default``.
        """
        cdef SpinRegisterNode node_inst
        node = self._nodes.get("FileAccessBuffer")
        if node is None:
            node_inst = SpinRegisterNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().FileAccessBuffer))
            node = self._nodes["FileAccessBuffer"] = node_inst
        return node

    @property
    def SourceCount(self) -> SpinIntNode:
        """Controls or returns the number of sources supported by the device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("SourceCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SourceCount))
            node = self._nodes["SourceCount"] = node_inst
        return node

    @property
    def SourceSelector(self) -> SpinEnumDefNode:
        """Selects the source to control.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.SourceSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("SourceSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().SourceSelector))
            node_inst.enum_names = rotpy.names.camera.SourceSelector_names
            node_inst.enum_values = rotpy.names.camera.SourceSelector_values
            node = self._nodes["SourceSelector"] = node_inst
        return node

    @property
    def TransferSelector(self) -> SpinEnumDefNode:
        """Selects which stream transfers are currently controlled by the
        selected Transfer features.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.TransferSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("TransferSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TransferSelector))
            node_inst.enum_names = rotpy.names.camera.TransferSelector_names
            node_inst.enum_values = rotpy.names.camera.TransferSelector_values
            node = self._nodes["TransferSelector"] = node_inst
        return node

    @property
    def TransferBurstCount(self) -> SpinIntNode:
        """Number of Block(s) to transfer for each TransferBurstStart trigger.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("TransferBurstCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TransferBurstCount))
            node = self._nodes["TransferBurstCount"] = node_inst
        return node

    @property
    def TransferAbort(self) -> SpinCommandNode:
        """Aborts immediately the streaming of data block(s). Aborting the
        transfer will result in the lost of the data that is present or
        currently entering in the block queue. However, the next new block
        received will be stored in the queue and transferred to the host
        when the streaming is restarted. If implemented, this feature should
        be available when the TransferControlMode is set to
        "UserControlled".

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("TransferAbort")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TransferAbort))
            node = self._nodes["TransferAbort"] = node_inst
        return node

    @property
    def TransferPause(self) -> SpinCommandNode:
        """Pauses the streaming of data Block(s). Pausing the streaming will
        immediately suspend the ongoing data transfer even if a block is
        partially transfered. The device will resume its transmission at the
        reception of a TransferResume command.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("TransferPause")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TransferPause))
            node = self._nodes["TransferPause"] = node_inst
        return node

    @property
    def TransferResume(self) -> SpinCommandNode:
        """Resumes a data Blocks streaming that was previously paused by a
        TransferPause command.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("TransferResume")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TransferResume))
            node = self._nodes["TransferResume"] = node_inst
        return node

    @property
    def TransferTriggerSelector(self) -> SpinEnumDefNode:
        """Selects the type of transfer trigger to configure.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.TransferTriggerSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("TransferTriggerSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TransferTriggerSelector))
            node_inst.enum_names = rotpy.names.camera.TransferTriggerSelector_names
            node_inst.enum_values = rotpy.names.camera.TransferTriggerSelector_values
            node = self._nodes["TransferTriggerSelector"] = node_inst
        return node

    @property
    def TransferTriggerMode(self) -> SpinEnumDefNode:
        """Controls if the selected trigger is active.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.TransferTriggerMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("TransferTriggerMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TransferTriggerMode))
            node_inst.enum_names = rotpy.names.camera.TransferTriggerMode_names
            node_inst.enum_values = rotpy.names.camera.TransferTriggerMode_values
            node = self._nodes["TransferTriggerMode"] = node_inst
        return node

    @property
    def TransferTriggerSource(self) -> SpinEnumDefNode:
        """Specifies the signal to use as the trigger source for transfers.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.TransferTriggerSource_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("TransferTriggerSource")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TransferTriggerSource))
            node_inst.enum_names = rotpy.names.camera.TransferTriggerSource_names
            node_inst.enum_values = rotpy.names.camera.TransferTriggerSource_values
            node = self._nodes["TransferTriggerSource"] = node_inst
        return node

    @property
    def TransferTriggerActivation(self) -> SpinEnumDefNode:
        """Specifies the activation mode of the transfer control trigger.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.TransferTriggerActivation_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("TransferTriggerActivation")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TransferTriggerActivation))
            node_inst.enum_names = rotpy.names.camera.TransferTriggerActivation_names
            node_inst.enum_values = rotpy.names.camera.TransferTriggerActivation_values
            node = self._nodes["TransferTriggerActivation"] = node_inst
        return node

    @property
    def TransferStatusSelector(self) -> SpinEnumDefNode:
        """Selects which status of the transfer module to read.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.TransferStatusSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("TransferStatusSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TransferStatusSelector))
            node_inst.enum_names = rotpy.names.camera.TransferStatusSelector_names
            node_inst.enum_values = rotpy.names.camera.TransferStatusSelector_values
            node = self._nodes["TransferStatusSelector"] = node_inst
        return node

    @property
    def TransferStatus(self) -> SpinBoolNode:
        """Reads the status of the Transfer module signal selected by
        TransferStatusSelector.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("TransferStatus")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TransferStatus))
            node = self._nodes["TransferStatus"] = node_inst
        return node

    @property
    def TransferComponentSelector(self) -> SpinEnumDefNode:
        """Selects the color component for the control of the
        TransferStreamChannel feature.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.TransferComponentSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("TransferComponentSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TransferComponentSelector))
            node_inst.enum_names = rotpy.names.camera.TransferComponentSelector_names
            node_inst.enum_values = rotpy.names.camera.TransferComponentSelector_values
            node = self._nodes["TransferComponentSelector"] = node_inst
        return node

    @property
    def TransferStreamChannel(self) -> SpinIntNode:
        """Selects the streaming channel that will be used to transfer the
        selected stream of data. In general, this feature can be omitted and
        the default streaming channel will be used.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("TransferStreamChannel")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TransferStreamChannel))
            node = self._nodes["TransferStreamChannel"] = node_inst
        return node

    @property
    def Scan3dDistanceUnit(self) -> SpinEnumDefNode:
        """Specifies the unit used when delivering calibrated distance data.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.Scan3dDistanceUnit_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("Scan3dDistanceUnit")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().Scan3dDistanceUnit))
            node_inst.enum_names = rotpy.names.camera.Scan3dDistanceUnit_names
            node_inst.enum_values = rotpy.names.camera.Scan3dDistanceUnit_values
            node = self._nodes["Scan3dDistanceUnit"] = node_inst
        return node

    @property
    def Scan3dCoordinateSystem(self) -> SpinEnumDefNode:
        """Specifies the Coordinate system to use for the device.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.Scan3dCoordinateSystem_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("Scan3dCoordinateSystem")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().Scan3dCoordinateSystem))
            node_inst.enum_names = rotpy.names.camera.Scan3dCoordinateSystem_names
            node_inst.enum_values = rotpy.names.camera.Scan3dCoordinateSystem_values
            node = self._nodes["Scan3dCoordinateSystem"] = node_inst
        return node

    @property
    def Scan3dOutputMode(self) -> SpinEnumDefNode:
        """Controls the Calibration and data organization of the device, naming
        the coordinates transmitted.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.Scan3dOutputMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("Scan3dOutputMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().Scan3dOutputMode))
            node_inst.enum_names = rotpy.names.camera.Scan3dOutputMode_names
            node_inst.enum_values = rotpy.names.camera.Scan3dOutputMode_values
            node = self._nodes["Scan3dOutputMode"] = node_inst
        return node

    @property
    def Scan3dCoordinateSystemReference(self) -> SpinEnumDefNode:
        """Defines coordinate system reference location.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.Scan3dCoordinateSystemReference_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("Scan3dCoordinateSystemReference")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().Scan3dCoordinateSystemReference))
            node_inst.enum_names = rotpy.names.camera.Scan3dCoordinateSystemReference_names
            node_inst.enum_values = rotpy.names.camera.Scan3dCoordinateSystemReference_values
            node = self._nodes["Scan3dCoordinateSystemReference"] = node_inst
        return node

    @property
    def Scan3dCoordinateSelector(self) -> SpinEnumDefNode:
        """Selects the individual coordinates in the vectors for 3D
        information/transformation.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.Scan3dCoordinateSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("Scan3dCoordinateSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().Scan3dCoordinateSelector))
            node_inst.enum_names = rotpy.names.camera.Scan3dCoordinateSelector_names
            node_inst.enum_values = rotpy.names.camera.Scan3dCoordinateSelector_values
            node = self._nodes["Scan3dCoordinateSelector"] = node_inst
        return node

    @property
    def Scan3dCoordinateScale(self) -> SpinFloatNode:
        """Scale factor when transforming a pixel from relative coordinates to
        world coordinates.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("Scan3dCoordinateScale")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().Scan3dCoordinateScale))
            node = self._nodes["Scan3dCoordinateScale"] = node_inst
        return node

    @property
    def Scan3dCoordinateOffset(self) -> SpinFloatNode:
        """Offset when transforming a pixel from relative coordinates to world
        coordinates.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("Scan3dCoordinateOffset")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().Scan3dCoordinateOffset))
            node = self._nodes["Scan3dCoordinateOffset"] = node_inst
        return node

    @property
    def Scan3dInvalidDataFlag(self) -> SpinBoolNode:
        """Enables the definition of a non-valid flag value in the data stream.
        Note that the confidence output is an alternate recommended way to
        identify non-valid pixels. Using an Scan3dInvalidDataValue may give
        processing penalties due to special handling.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("Scan3dInvalidDataFlag")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().Scan3dInvalidDataFlag))
            node = self._nodes["Scan3dInvalidDataFlag"] = node_inst
        return node

    @property
    def Scan3dInvalidDataValue(self) -> SpinFloatNode:
        """Value which identifies a non-valid pixel if Scan3dInvalidDataFlag is
        enabled.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("Scan3dInvalidDataValue")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().Scan3dInvalidDataValue))
            node = self._nodes["Scan3dInvalidDataValue"] = node_inst
        return node

    @property
    def Scan3dAxisMin(self) -> SpinFloatNode:
        """Minimum valid transmitted coordinate value of the selected Axis.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("Scan3dAxisMin")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().Scan3dAxisMin))
            node = self._nodes["Scan3dAxisMin"] = node_inst
        return node

    @property
    def Scan3dAxisMax(self) -> SpinFloatNode:
        """Maximum valid transmitted coordinate value of the selected Axis.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("Scan3dAxisMax")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().Scan3dAxisMax))
            node = self._nodes["Scan3dAxisMax"] = node_inst
        return node

    @property
    def Scan3dCoordinateTransformSelector(self) -> SpinEnumDefNode:
        """Sets the index to read/write a coordinate transform value.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.Scan3dCoordinateTransformSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("Scan3dCoordinateTransformSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().Scan3dCoordinateTransformSelector))
            node_inst.enum_names = rotpy.names.camera.Scan3dCoordinateTransformSelector_names
            node_inst.enum_values = rotpy.names.camera.Scan3dCoordinateTransformSelector_values
            node = self._nodes["Scan3dCoordinateTransformSelector"] = node_inst
        return node

    @property
    def Scan3dTransformValue(self) -> SpinFloatNode:
        """Specifies the transform value selected. For translations
        (Scan3dCoordinateTransformSelector = TranslationX/Y/Z) it is
        expressed in the distance unit of the system, for rotations
        (Scan3dCoordinateTransformSelector =RotationX/Y/Z) in degrees.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("Scan3dTransformValue")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().Scan3dTransformValue))
            node = self._nodes["Scan3dTransformValue"] = node_inst
        return node

    @property
    def Scan3dCoordinateReferenceSelector(self) -> SpinEnumDefNode:
        """Sets the index to read a coordinate system reference value defining
        the transform of a point from the current (Anchor or Transformed)
        system to the reference system.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.Scan3dCoordinateReferenceSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("Scan3dCoordinateReferenceSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().Scan3dCoordinateReferenceSelector))
            node_inst.enum_names = rotpy.names.camera.Scan3dCoordinateReferenceSelector_names
            node_inst.enum_values = rotpy.names.camera.Scan3dCoordinateReferenceSelector_values
            node = self._nodes["Scan3dCoordinateReferenceSelector"] = node_inst
        return node

    @property
    def Scan3dCoordinateReferenceValue(self) -> SpinFloatNode:
        """Returns the reference value selected. Reads the value of a rotation
        or translation value for the current (Anchor or Transformed)
        coordinate system transformation to the Reference system.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("Scan3dCoordinateReferenceValue")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().Scan3dCoordinateReferenceValue))
            node = self._nodes["Scan3dCoordinateReferenceValue"] = node_inst
        return node

    @property
    def ChunkPartSelector(self) -> SpinIntNode:
        """Selects the part to access in chunk data in a multipart
        transmission.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ChunkPartSelector")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkPartSelector))
            node = self._nodes["ChunkPartSelector"] = node_inst
        return node

    @property
    def ChunkImageComponent(self) -> SpinEnumDefNode:
        """Returns the component of the payload image. This can be used to
        identify the image component of a generic part in a multipart
        transfer.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ChunkImageComponent_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ChunkImageComponent")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkImageComponent))
            node_inst.enum_names = rotpy.names.camera.ChunkImageComponent_names
            node_inst.enum_values = rotpy.names.camera.ChunkImageComponent_values
            node = self._nodes["ChunkImageComponent"] = node_inst
        return node

    @property
    def ChunkPixelDynamicRangeMin(self) -> SpinIntNode:
        """Returns the minimum value of dynamic range of the image included in
        the payload.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ChunkPixelDynamicRangeMin")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkPixelDynamicRangeMin))
            node = self._nodes["ChunkPixelDynamicRangeMin"] = node_inst
        return node

    @property
    def ChunkPixelDynamicRangeMax(self) -> SpinIntNode:
        """Returns the maximum value of dynamic range of the image included in
        the payload.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ChunkPixelDynamicRangeMax")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkPixelDynamicRangeMax))
            node = self._nodes["ChunkPixelDynamicRangeMax"] = node_inst
        return node

    @property
    def ChunkTimestampLatchValue(self) -> SpinIntNode:
        """Returns the last Timestamp latched with the TimestampLatch command.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ChunkTimestampLatchValue")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkTimestampLatchValue))
            node = self._nodes["ChunkTimestampLatchValue"] = node_inst
        return node

    @property
    def ChunkLineStatusAll(self) -> SpinIntNode:
        """Returns the status of all the I/O lines at the time of the
        FrameStart internal event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ChunkLineStatusAll")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkLineStatusAll))
            node = self._nodes["ChunkLineStatusAll"] = node_inst
        return node

    @property
    def ChunkCounterSelector(self) -> SpinEnumDefNode:
        """Selects which counter to retrieve data from.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ChunkCounterSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ChunkCounterSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkCounterSelector))
            node_inst.enum_names = rotpy.names.camera.ChunkCounterSelector_names
            node_inst.enum_values = rotpy.names.camera.ChunkCounterSelector_values
            node = self._nodes["ChunkCounterSelector"] = node_inst
        return node

    @property
    def ChunkCounterValue(self) -> SpinIntNode:
        """Returns the value of the selected Chunk counter at the time of the
        FrameStart event.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ChunkCounterValue")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkCounterValue))
            node = self._nodes["ChunkCounterValue"] = node_inst
        return node

    @property
    def ChunkTimerSelector(self) -> SpinEnumDefNode:
        """Selects which Timer to retrieve data from.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ChunkTimerSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ChunkTimerSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkTimerSelector))
            node_inst.enum_names = rotpy.names.camera.ChunkTimerSelector_names
            node_inst.enum_values = rotpy.names.camera.ChunkTimerSelector_values
            node = self._nodes["ChunkTimerSelector"] = node_inst
        return node

    @property
    def ChunkTimerValue(self) -> SpinFloatNode:
        """Returns the value of the selected Timer at the time of the
        FrameStart internal event.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("ChunkTimerValue")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkTimerValue))
            node = self._nodes["ChunkTimerValue"] = node_inst
        return node

    @property
    def ChunkEncoderSelector(self) -> SpinEnumDefNode:
        """Selects which Encoder to retrieve data from.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ChunkEncoderSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ChunkEncoderSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkEncoderSelector))
            node_inst.enum_names = rotpy.names.camera.ChunkEncoderSelector_names
            node_inst.enum_values = rotpy.names.camera.ChunkEncoderSelector_values
            node = self._nodes["ChunkEncoderSelector"] = node_inst
        return node

    @property
    def ChunkScanLineSelector(self) -> SpinIntNode:
        """Index for vector representation of one chunk value per line in an
        image.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ChunkScanLineSelector")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkScanLineSelector))
            node = self._nodes["ChunkScanLineSelector"] = node_inst
        return node

    @property
    def ChunkEncoderValue(self) -> SpinIntNode:
        """Returns the counter's value of the selected Encoder at the time of
        the FrameStart in area scan mode or the counter's value at the time
        of the LineStart selected by ChunkScanLineSelector in LineScan mode.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ChunkEncoderValue")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkEncoderValue))
            node = self._nodes["ChunkEncoderValue"] = node_inst
        return node

    @property
    def ChunkEncoderStatus(self) -> SpinEnumDefNode:
        """Returns the motion status of the selected encoder.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ChunkEncoderStatus_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ChunkEncoderStatus")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkEncoderStatus))
            node_inst.enum_names = rotpy.names.camera.ChunkEncoderStatus_names
            node_inst.enum_values = rotpy.names.camera.ChunkEncoderStatus_values
            node = self._nodes["ChunkEncoderStatus"] = node_inst
        return node

    @property
    def ChunkExposureTimeSelector(self) -> SpinEnumDefNode:
        """Selects which exposure time is read by the ChunkExposureTime
        feature.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ChunkExposureTimeSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ChunkExposureTimeSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkExposureTimeSelector))
            node_inst.enum_names = rotpy.names.camera.ChunkExposureTimeSelector_names
            node_inst.enum_values = rotpy.names.camera.ChunkExposureTimeSelector_values
            node = self._nodes["ChunkExposureTimeSelector"] = node_inst
        return node

    @property
    def ChunkLinePitch(self) -> SpinIntNode:
        """Returns the LinePitch of the image included in the payload.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ChunkLinePitch")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkLinePitch))
            node = self._nodes["ChunkLinePitch"] = node_inst
        return node

    @property
    def ChunkSourceID(self) -> SpinEnumDefNode:
        """Returns the identifier of Source that the image comes from.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ChunkSourceID_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ChunkSourceID")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkSourceID))
            node_inst.enum_names = rotpy.names.camera.ChunkSourceID_names
            node_inst.enum_values = rotpy.names.camera.ChunkSourceID_values
            node = self._nodes["ChunkSourceID"] = node_inst
        return node

    @property
    def ChunkRegionID(self) -> SpinEnumDefNode:
        """Returns the identifier of Region that the image comes from.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ChunkRegionID_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ChunkRegionID")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkRegionID))
            node_inst.enum_names = rotpy.names.camera.ChunkRegionID_names
            node_inst.enum_values = rotpy.names.camera.ChunkRegionID_values
            node = self._nodes["ChunkRegionID"] = node_inst
        return node

    @property
    def ChunkTransferBlockID(self) -> SpinIntNode:
        """Returns the unique identifier of the transfer block used to
        transport the payload.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ChunkTransferBlockID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkTransferBlockID))
            node = self._nodes["ChunkTransferBlockID"] = node_inst
        return node

    @property
    def ChunkTransferStreamID(self) -> SpinEnumDefNode:
        """Returns identifier of the stream that generated this block.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ChunkTransferStreamID_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ChunkTransferStreamID")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkTransferStreamID))
            node_inst.enum_names = rotpy.names.camera.ChunkTransferStreamID_names
            node_inst.enum_values = rotpy.names.camera.ChunkTransferStreamID_values
            node = self._nodes["ChunkTransferStreamID"] = node_inst
        return node

    @property
    def ChunkTransferQueueCurrentBlockCount(self) -> SpinIntNode:
        """Returns the current number of blocks in the transfer queue.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ChunkTransferQueueCurrentBlockCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkTransferQueueCurrentBlockCount))
            node = self._nodes["ChunkTransferQueueCurrentBlockCount"] = node_inst
        return node

    @property
    def ChunkStreamChannelID(self) -> SpinIntNode:
        """Returns identifier of the stream channel used to carry the block.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ChunkStreamChannelID")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkStreamChannelID))
            node = self._nodes["ChunkStreamChannelID"] = node_inst
        return node

    @property
    def ChunkScan3dDistanceUnit(self) -> SpinEnumDefNode:
        """Returns the Distance Unit of the payload image.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ChunkScan3dDistanceUnit_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ChunkScan3dDistanceUnit")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkScan3dDistanceUnit))
            node_inst.enum_names = rotpy.names.camera.ChunkScan3dDistanceUnit_names
            node_inst.enum_values = rotpy.names.camera.ChunkScan3dDistanceUnit_values
            node = self._nodes["ChunkScan3dDistanceUnit"] = node_inst
        return node

    @property
    def ChunkScan3dOutputMode(self) -> SpinEnumDefNode:
        """Returns the Calibrated Mode of the payload image.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ChunkScan3dOutputMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ChunkScan3dOutputMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkScan3dOutputMode))
            node_inst.enum_names = rotpy.names.camera.ChunkScan3dOutputMode_names
            node_inst.enum_values = rotpy.names.camera.ChunkScan3dOutputMode_values
            node = self._nodes["ChunkScan3dOutputMode"] = node_inst
        return node

    @property
    def ChunkScan3dCoordinateSystem(self) -> SpinEnumDefNode:
        """Returns the Coordinate System of the image included in the payload.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ChunkScan3dCoordinateSystem_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ChunkScan3dCoordinateSystem")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkScan3dCoordinateSystem))
            node_inst.enum_names = rotpy.names.camera.ChunkScan3dCoordinateSystem_names
            node_inst.enum_values = rotpy.names.camera.ChunkScan3dCoordinateSystem_values
            node = self._nodes["ChunkScan3dCoordinateSystem"] = node_inst
        return node

    @property
    def ChunkScan3dCoordinateSystemReference(self) -> SpinEnumDefNode:
        """Returns the Coordinate System Position of the image included in the
        payload.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ChunkScan3dCoordinateSystemReference_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ChunkScan3dCoordinateSystemReference")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkScan3dCoordinateSystemReference))
            node_inst.enum_names = rotpy.names.camera.ChunkScan3dCoordinateSystemReference_names
            node_inst.enum_values = rotpy.names.camera.ChunkScan3dCoordinateSystemReference_values
            node = self._nodes["ChunkScan3dCoordinateSystemReference"] = node_inst
        return node

    @property
    def ChunkScan3dCoordinateSelector(self) -> SpinEnumDefNode:
        """Selects which Coordinate to retrieve data from.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ChunkScan3dCoordinateSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ChunkScan3dCoordinateSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkScan3dCoordinateSelector))
            node_inst.enum_names = rotpy.names.camera.ChunkScan3dCoordinateSelector_names
            node_inst.enum_values = rotpy.names.camera.ChunkScan3dCoordinateSelector_values
            node = self._nodes["ChunkScan3dCoordinateSelector"] = node_inst
        return node

    @property
    def ChunkScan3dCoordinateScale(self) -> SpinFloatNode:
        """Returns the Scale for the selected coordinate axis of the image
        included in the payload.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("ChunkScan3dCoordinateScale")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkScan3dCoordinateScale))
            node = self._nodes["ChunkScan3dCoordinateScale"] = node_inst
        return node

    @property
    def ChunkScan3dCoordinateOffset(self) -> SpinFloatNode:
        """Returns the Offset for the selected coordinate axis of the image
        included in the payload.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("ChunkScan3dCoordinateOffset")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkScan3dCoordinateOffset))
            node = self._nodes["ChunkScan3dCoordinateOffset"] = node_inst
        return node

    @property
    def ChunkScan3dInvalidDataFlag(self) -> SpinBoolNode:
        """Returns if a specific non-valid data flag is used in the data
        stream.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("ChunkScan3dInvalidDataFlag")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkScan3dInvalidDataFlag))
            node = self._nodes["ChunkScan3dInvalidDataFlag"] = node_inst
        return node

    @property
    def ChunkScan3dInvalidDataValue(self) -> SpinFloatNode:
        """Returns the Invalid Data Value used for the image included in the
        payload.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("ChunkScan3dInvalidDataValue")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkScan3dInvalidDataValue))
            node = self._nodes["ChunkScan3dInvalidDataValue"] = node_inst
        return node

    @property
    def ChunkScan3dAxisMin(self) -> SpinFloatNode:
        """Returns the Minimum Axis value for the selected coordinate axis of
        the image included in the payload.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("ChunkScan3dAxisMin")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkScan3dAxisMin))
            node = self._nodes["ChunkScan3dAxisMin"] = node_inst
        return node

    @property
    def ChunkScan3dAxisMax(self) -> SpinFloatNode:
        """Returns the Maximum Axis value for the selected coordinate axis of
        the image included in the payload.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("ChunkScan3dAxisMax")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkScan3dAxisMax))
            node = self._nodes["ChunkScan3dAxisMax"] = node_inst
        return node

    @property
    def ChunkScan3dCoordinateTransformSelector(self) -> SpinEnumDefNode:
        """Selector for transform values.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ChunkScan3dCoordinateTransformSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ChunkScan3dCoordinateTransformSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkScan3dCoordinateTransformSelector))
            node_inst.enum_names = rotpy.names.camera.ChunkScan3dCoordinateTransformSelector_names
            node_inst.enum_values = rotpy.names.camera.ChunkScan3dCoordinateTransformSelector_values
            node = self._nodes["ChunkScan3dCoordinateTransformSelector"] = node_inst
        return node

    @property
    def ChunkScan3dTransformValue(self) -> SpinFloatNode:
        """Returns the transform value.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("ChunkScan3dTransformValue")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkScan3dTransformValue))
            node = self._nodes["ChunkScan3dTransformValue"] = node_inst
        return node

    @property
    def ChunkScan3dCoordinateReferenceSelector(self) -> SpinEnumDefNode:
        """Selector to read a coordinate system reference value defining the
        transform of a point from one system to the other.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ChunkScan3dCoordinateReferenceSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ChunkScan3dCoordinateReferenceSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkScan3dCoordinateReferenceSelector))
            node_inst.enum_names = rotpy.names.camera.ChunkScan3dCoordinateReferenceSelector_names
            node_inst.enum_values = rotpy.names.camera.ChunkScan3dCoordinateReferenceSelector_values
            node = self._nodes["ChunkScan3dCoordinateReferenceSelector"] = node_inst
        return node

    @property
    def ChunkScan3dCoordinateReferenceValue(self) -> SpinFloatNode:
        """Reads the value of a position or pose coordinate for the anchor or
        transformed coordinate systems relative to the reference point.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("ChunkScan3dCoordinateReferenceValue")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkScan3dCoordinateReferenceValue))
            node = self._nodes["ChunkScan3dCoordinateReferenceValue"] = node_inst
        return node

    @property
    def TestPendingAck(self) -> SpinIntNode:
        """Tests the device's pending acknowledge feature. When this feature is
        written, the device waits a time period corresponding to the value
        of TestPendingAck before acknowledging the write.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("TestPendingAck")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TestPendingAck))
            node = self._nodes["TestPendingAck"] = node_inst
        return node

    @property
    def DeviceTapGeometry(self) -> SpinEnumDefNode:
        """This device tap geometry feature describes the geometrical
        properties characterizing the taps of a camera as presented at the
        output of the device.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.DeviceTapGeometry_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("DeviceTapGeometry")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().DeviceTapGeometry))
            node_inst.enum_names = rotpy.names.camera.DeviceTapGeometry_names
            node_inst.enum_values = rotpy.names.camera.DeviceTapGeometry_values
            node = self._nodes["DeviceTapGeometry"] = node_inst
        return node

    @property
    def GevPhysicalLinkConfiguration(self) -> SpinEnumDefNode:
        """Controls the principal physical link configuration to use on next
        restart/power-up of the device.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.GevPhysicalLinkConfiguration_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("GevPhysicalLinkConfiguration")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevPhysicalLinkConfiguration))
            node_inst.enum_names = rotpy.names.camera.GevPhysicalLinkConfiguration_names
            node_inst.enum_values = rotpy.names.camera.GevPhysicalLinkConfiguration_values
            node = self._nodes["GevPhysicalLinkConfiguration"] = node_inst
        return node

    @property
    def GevCurrentPhysicalLinkConfiguration(self) -> SpinEnumDefNode:
        """Indicates the current physical link configuration of the device.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.GevCurrentPhysicalLinkConfiguration_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("GevCurrentPhysicalLinkConfiguration")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevCurrentPhysicalLinkConfiguration))
            node_inst.enum_names = rotpy.names.camera.GevCurrentPhysicalLinkConfiguration_names
            node_inst.enum_values = rotpy.names.camera.GevCurrentPhysicalLinkConfiguration_values
            node = self._nodes["GevCurrentPhysicalLinkConfiguration"] = node_inst
        return node

    @property
    def GevActiveLinkCount(self) -> SpinIntNode:
        """Indicates the current number of active logical links.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevActiveLinkCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevActiveLinkCount))
            node = self._nodes["GevActiveLinkCount"] = node_inst
        return node

    @property
    def GevPAUSEFrameReception(self) -> SpinBoolNode:
        """Controls whether incoming PAUSE Frames are handled on the given
        logical link.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("GevPAUSEFrameReception")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevPAUSEFrameReception))
            node = self._nodes["GevPAUSEFrameReception"] = node_inst
        return node

    @property
    def GevPAUSEFrameTransmission(self) -> SpinBoolNode:
        """Controls whether PAUSE Frames can be generated on the given logical
        link.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("GevPAUSEFrameTransmission")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevPAUSEFrameTransmission))
            node = self._nodes["GevPAUSEFrameTransmission"] = node_inst
        return node

    @property
    def GevIPConfigurationStatus(self) -> SpinEnumDefNode:
        """Reports the current IP configuration status.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.GevIPConfigurationStatus_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("GevIPConfigurationStatus")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevIPConfigurationStatus))
            node_inst.enum_names = rotpy.names.camera.GevIPConfigurationStatus_names
            node_inst.enum_values = rotpy.names.camera.GevIPConfigurationStatus_values
            node = self._nodes["GevIPConfigurationStatus"] = node_inst
        return node

    @property
    def GevDiscoveryAckDelay(self) -> SpinIntNode:
        """Indicates the maximum randomized delay the device will wait to
        acknowledge a discovery command.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevDiscoveryAckDelay")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevDiscoveryAckDelay))
            node = self._nodes["GevDiscoveryAckDelay"] = node_inst
        return node

    @property
    def GevGVCPExtendedStatusCodesSelector(self) -> SpinEnumDefNode:
        """Selects the GigE Vision version to control extended status codes
        for.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.GevGVCPExtendedStatusCodesSelector_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("GevGVCPExtendedStatusCodesSelector")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevGVCPExtendedStatusCodesSelector))
            node_inst.enum_names = rotpy.names.camera.GevGVCPExtendedStatusCodesSelector_names
            node_inst.enum_values = rotpy.names.camera.GevGVCPExtendedStatusCodesSelector_values
            node = self._nodes["GevGVCPExtendedStatusCodesSelector"] = node_inst
        return node

    @property
    def GevGVCPExtendedStatusCodes(self) -> SpinBoolNode:
        """Enables the generation of extended status codes.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("GevGVCPExtendedStatusCodes")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevGVCPExtendedStatusCodes))
            node = self._nodes["GevGVCPExtendedStatusCodes"] = node_inst
        return node

    @property
    def GevPrimaryApplicationSwitchoverKey(self) -> SpinIntNode:
        """Controls the key to use to authenticate primary application
        switchover requests.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevPrimaryApplicationSwitchoverKey")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevPrimaryApplicationSwitchoverKey))
            node = self._nodes["GevPrimaryApplicationSwitchoverKey"] = node_inst
        return node

    @property
    def GevGVSPExtendedIDMode(self) -> SpinEnumDefNode:
        """Enables the extended IDs mode.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.GevGVSPExtendedIDMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("GevGVSPExtendedIDMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevGVSPExtendedIDMode))
            node_inst.enum_names = rotpy.names.camera.GevGVSPExtendedIDMode_names
            node_inst.enum_values = rotpy.names.camera.GevGVSPExtendedIDMode_values
            node = self._nodes["GevGVSPExtendedIDMode"] = node_inst
        return node

    @property
    def GevPrimaryApplicationSocket(self) -> SpinIntNode:
        """Returns the UDP source port of the primary application.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevPrimaryApplicationSocket")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevPrimaryApplicationSocket))
            node = self._nodes["GevPrimaryApplicationSocket"] = node_inst
        return node

    @property
    def GevPrimaryApplicationIPAddress(self) -> SpinIntNode:
        """Returns the address of the primary application.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevPrimaryApplicationIPAddress")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevPrimaryApplicationIPAddress))
            node = self._nodes["GevPrimaryApplicationIPAddress"] = node_inst
        return node

    @property
    def GevSCCFGPacketResendDestination(self) -> SpinBoolNode:
        """Enables the alternate IP destination for stream packets resent due
        to a packet resend request. When True, the source IP address
        provided in the packet resend command packet is used. When False,
        the value set in the GevSCDA[GevStreamChannelSelector] feature is
        used.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("GevSCCFGPacketResendDestination")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevSCCFGPacketResendDestination))
            node = self._nodes["GevSCCFGPacketResendDestination"] = node_inst
        return node

    @property
    def GevSCCFGAllInTransmission(self) -> SpinBoolNode:
        """Enables the selected GVSP transmitter to use the single packet per
        data block All-in Transmission mode.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("GevSCCFGAllInTransmission")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevSCCFGAllInTransmission))
            node = self._nodes["GevSCCFGAllInTransmission"] = node_inst
        return node

    @property
    def GevSCZoneCount(self) -> SpinIntNode:
        """Reports the number of zones per block transmitted on the selected
        stream channel.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevSCZoneCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevSCZoneCount))
            node = self._nodes["GevSCZoneCount"] = node_inst
        return node

    @property
    def GevSCZoneDirectionAll(self) -> SpinIntNode:
        """Reports the transmission direction of each zone transmitted on the
        selected stream channel.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevSCZoneDirectionAll")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevSCZoneDirectionAll))
            node = self._nodes["GevSCZoneDirectionAll"] = node_inst
        return node

    @property
    def GevSCZoneConfigurationLock(self) -> SpinBoolNode:
        """Controls whether the selected stream channel multi-zone
        configuration is locked. When locked, the GVSP transmitter is not
        allowed to change the number of zones and their direction during
        block acquisition and transmission.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("GevSCZoneConfigurationLock")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().GevSCZoneConfigurationLock))
            node = self._nodes["GevSCZoneConfigurationLock"] = node_inst
        return node

    @property
    def aPAUSEMACCtrlFramesTransmitted(self) -> SpinIntNode:
        """Reports the number of transmitted PAUSE frames.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("aPAUSEMACCtrlFramesTransmitted")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().aPAUSEMACCtrlFramesTransmitted))
            node = self._nodes["aPAUSEMACCtrlFramesTransmitted"] = node_inst
        return node

    @property
    def aPAUSEMACCtrlFramesReceived(self) -> SpinIntNode:
        """Reports the number of received PAUSE frames.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("aPAUSEMACCtrlFramesReceived")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().aPAUSEMACCtrlFramesReceived))
            node = self._nodes["aPAUSEMACCtrlFramesReceived"] = node_inst
        return node

    @property
    def ClConfiguration(self) -> SpinEnumDefNode:
        """This Camera Link specific feature describes the configuration used
        by the camera. It helps especially when a camera is capable of
        operation in a non-standard configuration, and when the features
        PixelSize, SensorDigitizationTaps, and DeviceTapGeometry do not
        provide enough information for interpretation of the image data
        provided by the camera.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ClConfiguration_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ClConfiguration")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ClConfiguration))
            node_inst.enum_names = rotpy.names.camera.ClConfiguration_names
            node_inst.enum_values = rotpy.names.camera.ClConfiguration_values
            node = self._nodes["ClConfiguration"] = node_inst
        return node

    @property
    def ClTimeSlotsCount(self) -> SpinEnumDefNode:
        """This Camera Link specific feature describes the time multiplexing of
        the camera link connection to transfer more than the configuration
        allows, in one single clock.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.ClTimeSlotsCount_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("ClTimeSlotsCount")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ClTimeSlotsCount))
            node_inst.enum_names = rotpy.names.camera.ClTimeSlotsCount_names
            node_inst.enum_values = rotpy.names.camera.ClTimeSlotsCount_values
            node = self._nodes["ClTimeSlotsCount"] = node_inst
        return node

    @property
    def CxpLinkConfigurationStatus(self) -> SpinEnumDefNode:
        """This feature indicates the current and active Link configuration
        used by the Device.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.CxpLinkConfigurationStatus_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("CxpLinkConfigurationStatus")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().CxpLinkConfigurationStatus))
            node_inst.enum_names = rotpy.names.camera.CxpLinkConfigurationStatus_names
            node_inst.enum_values = rotpy.names.camera.CxpLinkConfigurationStatus_values
            node = self._nodes["CxpLinkConfigurationStatus"] = node_inst
        return node

    @property
    def CxpLinkConfigurationPreferred(self) -> SpinEnumDefNode:
        """Provides the Link configuration that allows the Transmitter Device
        to operate in its default mode.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.CxpLinkConfigurationPreferred_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("CxpLinkConfigurationPreferred")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().CxpLinkConfigurationPreferred))
            node_inst.enum_names = rotpy.names.camera.CxpLinkConfigurationPreferred_names
            node_inst.enum_values = rotpy.names.camera.CxpLinkConfigurationPreferred_values
            node = self._nodes["CxpLinkConfigurationPreferred"] = node_inst
        return node

    @property
    def CxpLinkConfiguration(self) -> SpinEnumDefNode:
        """This feature allows specifying the Link configuration for the
        communication between the Receiver and Transmitter Device. In most
        cases this feature does not need to be written because automatic
        discovery will set configuration correctly to the value returned by
        CxpLinkConfigurationPreferred. Note that the currently active
        configuration of the Link can be read using
        CxpLinkConfigurationStatus.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.CxpLinkConfiguration_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("CxpLinkConfiguration")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().CxpLinkConfiguration))
            node_inst.enum_names = rotpy.names.camera.CxpLinkConfiguration_names
            node_inst.enum_values = rotpy.names.camera.CxpLinkConfiguration_values
            node = self._nodes["CxpLinkConfiguration"] = node_inst
        return node

    @property
    def CxpConnectionSelector(self) -> SpinIntNode:
        """Selects the CoaXPress physical connection to control.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("CxpConnectionSelector")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().CxpConnectionSelector))
            node = self._nodes["CxpConnectionSelector"] = node_inst
        return node

    @property
    def CxpConnectionTestMode(self) -> SpinEnumDefNode:
        """Enables the test mode for an individual physical connection of the
        Device.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.CxpConnectionTestMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("CxpConnectionTestMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().CxpConnectionTestMode))
            node_inst.enum_names = rotpy.names.camera.CxpConnectionTestMode_names
            node_inst.enum_values = rotpy.names.camera.CxpConnectionTestMode_values
            node = self._nodes["CxpConnectionTestMode"] = node_inst
        return node

    @property
    def CxpConnectionTestErrorCount(self) -> SpinIntNode:
        """Reports the current connection error count for test packets recieved
        by the device on the connection selected by CxpConnectionSelector.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("CxpConnectionTestErrorCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().CxpConnectionTestErrorCount))
            node = self._nodes["CxpConnectionTestErrorCount"] = node_inst
        return node

    @property
    def CxpConnectionTestPacketCount(self) -> SpinIntNode:
        """Reports the current count for test packets recieved by the device on
        the connection selected by CxpConnectionSelector.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("CxpConnectionTestPacketCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().CxpConnectionTestPacketCount))
            node = self._nodes["CxpConnectionTestPacketCount"] = node_inst
        return node

    @property
    def CxpPoCxpAuto(self) -> SpinCommandNode:
        """Activate automatic control of the Power over CoaXPress (PoCXP) for
        the Link.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("CxpPoCxpAuto")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().CxpPoCxpAuto))
            node = self._nodes["CxpPoCxpAuto"] = node_inst
        return node

    @property
    def CxpPoCxpTurnOff(self) -> SpinCommandNode:
        """Disable Power over CoaXPress (PoCXP) for the Link.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("CxpPoCxpTurnOff")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().CxpPoCxpTurnOff))
            node = self._nodes["CxpPoCxpTurnOff"] = node_inst
        return node

    @property
    def CxpPoCxpTripReset(self) -> SpinCommandNode:
        """Reset the Power over CoaXPress (PoCXP) Link after an over-current
        trip on the Device connection(s).

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("CxpPoCxpTripReset")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().CxpPoCxpTripReset))
            node = self._nodes["CxpPoCxpTripReset"] = node_inst
        return node

    @property
    def CxpPoCxpStatus(self) -> SpinEnumDefNode:
        """Returns the Power over CoaXPress (PoCXP) status of the Device.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.camera.CxpPoCxpStatus_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("CxpPoCxpStatus")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().CxpPoCxpStatus))
            node_inst.enum_names = rotpy.names.camera.CxpPoCxpStatus_names
            node_inst.enum_values = rotpy.names.camera.CxpPoCxpStatus_values
            node = self._nodes["CxpPoCxpStatus"] = node_inst
        return node

    @property
    def ChunkInferenceFrameId(self) -> SpinIntNode:
        """Returns the frame ID associated with the most recent inference
        result.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ChunkInferenceFrameId")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkInferenceFrameId))
            node = self._nodes["ChunkInferenceFrameId"] = node_inst
        return node

    @property
    def ChunkInferenceResult(self) -> SpinIntNode:
        """Returns the chunk data inference result.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("ChunkInferenceResult")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkInferenceResult))
            node = self._nodes["ChunkInferenceResult"] = node_inst
        return node

    @property
    def ChunkInferenceConfidence(self) -> SpinFloatNode:
        """Returns the chunk data inference confidence percentage.

        :Property type: :class:`~rotpy.node.SpinFloatNode`.
        :Visibility: ``default``.
        """
        cdef SpinFloatNode node_inst
        node = self._nodes.get("ChunkInferenceConfidence")
        if node is None:
            node_inst = SpinFloatNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkInferenceConfidence))
            node = self._nodes["ChunkInferenceConfidence"] = node_inst
        return node

    @property
    def ChunkInferenceBoundingBoxResult(self) -> SpinRegisterNode:
        """Returns the chunk inference bounding box result data.

        :Property type: :class:`~rotpy.node.SpinRegisterNode`.
        :Visibility: ``default``.
        """
        cdef SpinRegisterNode node_inst
        node = self._nodes.get("ChunkInferenceBoundingBoxResult")
        if node is None:
            node_inst = SpinRegisterNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().ChunkInferenceBoundingBoxResult))
            node = self._nodes["ChunkInferenceBoundingBoxResult"] = node_inst
        return node


cdef class TLDevNodes:
    """Lists all the pre-listed nodes of the :class:`~rotpy.camera.Camera`
    transport layer device.

    .. warning::

        Do **not** create a :class:`TLDevNodes` manually, rather get it
        from :attr:`~rotpy.camera.Camera.tl_dev_nodes` that is automatically
        created when the camera is instantiated.

    .. note::

        Even though the nodes are pre-listed, it is simply a convenience and
        the same nodes can be gotten by name through
        :class:`~rotpy.node.NodeMap`. Additionally, you must check that the
        node is actually available, readable etc, even if it's pre-listed.

        Some nodes are available before :meth:`~rotpy.camera.Camera.init_cam`,
        but other nodes, even those pre-listed, become available only after
        :meth:`~rotpy.camera.Camera.init_cam`.
    """

    def __cinit__(self, camera):
        self._camera = camera
        self._nodes = {}
        self.bool_nodes = ['DeviceIsUpdater', 'GevDeviceModeIsBigEndian',
                           'GevDeviceIsWrongSubnet',
                           'DeviceMulticastMonitorMode', 'DeviceU3VProtocol']
        self.int_nodes = ['GevDeviceIPAddress', 'GevDeviceSubnetMask',
                          'GevDeviceMACAddress', 'GevDeviceGateway',
                          'DeviceLinkSpeed', 'GevVersionMajor',
                          'GevVersionMinor', 'GevDeviceReadAndWriteTimeout',
                          'GevDeviceMaximumRetryCount', 'GevDevicePort',
                          'GevDeviceMaximumPacketSize',
                          'GevDeviceForceIPAddress', 'GevDeviceForceSubnetMask',
                          'GevDeviceForceGateway']
        self.float_nodes = []
        self.str_nodes = ['DeviceID', 'DeviceSerialNumber', 'DeviceVendorName',
                          'DeviceModelName', 'DeviceDisplayName',
                          'DeviceVersion', 'DeviceUserID',
                          'DeviceDriverVersion', 'GUIXMLPath', 'GenICamXMLPath',
                          'DeviceInstanceId', 'DeviceLocation', 'DevicePortId']
        self.enum_nodes = ['DeviceType', 'DeviceAccessStatus', 'GevCCP',
                           'GUIXMLLocation', 'GenICamXMLLocation',
                           'DeviceEndianessMechanism', 'DeviceCurrentSpeed']
        self.command_nodes = ['GevDeviceDiscoverMaximumPacketSize',
                              'GevDeviceAutoForceIP', 'GevDeviceForceIP']
        self.register_nodes = []

    def __init__(self, camera):
        pass

    @property
    def DeviceID(self) -> SpinStrNode:
        """Interface-wide unique identifier of this device.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("DeviceID")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.DeviceID))
            node = self._nodes["DeviceID"] = node_inst
        return node

    @property
    def DeviceSerialNumber(self) -> SpinStrNode:
        """Serial number of the remote device.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("DeviceSerialNumber")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.DeviceSerialNumber))
            node = self._nodes["DeviceSerialNumber"] = node_inst
        return node

    @property
    def DeviceVendorName(self) -> SpinStrNode:
        """Name of the remote device vendor.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("DeviceVendorName")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.DeviceVendorName))
            node = self._nodes["DeviceVendorName"] = node_inst
        return node

    @property
    def DeviceModelName(self) -> SpinStrNode:
        """Name of the remote device model.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("DeviceModelName")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.DeviceModelName))
            node = self._nodes["DeviceModelName"] = node_inst
        return node

    @property
    def DeviceType(self) -> SpinEnumDefNode:
        """Transport layer type of the device.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.tl.DeviceType_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("DeviceType")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.DeviceType))
            node_inst.enum_names = rotpy.names.tl.DeviceType_names
            node_inst.enum_values = rotpy.names.tl.DeviceType_values
            node = self._nodes["DeviceType"] = node_inst
        return node

    @property
    def DeviceDisplayName(self) -> SpinStrNode:
        """User readable name of the device. If this is not defined in the
        device this should be "VENDOR MODEL (ID)".

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("DeviceDisplayName")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.DeviceDisplayName))
            node = self._nodes["DeviceDisplayName"] = node_inst
        return node

    @property
    def DeviceAccessStatus(self) -> SpinEnumDefNode:
        """Gets the access status the transport layer Producer has on the
        device.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.tl.DeviceAccessStatus_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("DeviceAccessStatus")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.DeviceAccessStatus))
            node_inst.enum_names = rotpy.names.tl.DeviceAccessStatus_names
            node_inst.enum_values = rotpy.names.tl.DeviceAccessStatus_values
            node = self._nodes["DeviceAccessStatus"] = node_inst
        return node

    @property
    def DeviceVersion(self) -> SpinStrNode:
        """Version of the device.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("DeviceVersion")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.DeviceVersion))
            node = self._nodes["DeviceVersion"] = node_inst
        return node

    @property
    def DeviceUserID(self) -> SpinStrNode:
        """User Defined Name.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("DeviceUserID")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.DeviceUserID))
            node = self._nodes["DeviceUserID"] = node_inst
        return node

    @property
    def DeviceDriverVersion(self) -> SpinStrNode:
        """Version of the device driver.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("DeviceDriverVersion")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.DeviceDriverVersion))
            node = self._nodes["DeviceDriverVersion"] = node_inst
        return node

    @property
    def DeviceIsUpdater(self) -> SpinBoolNode:
        """Indicates whether the device is in updater mode.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("DeviceIsUpdater")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.DeviceIsUpdater))
            node = self._nodes["DeviceIsUpdater"] = node_inst
        return node

    @property
    def GevCCP(self) -> SpinEnumDefNode:
        """Controls the device access privilege of an application.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.tl.GevCCP_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("GevCCP")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.GevCCP))
            node_inst.enum_names = rotpy.names.tl.GevCCP_names
            node_inst.enum_values = rotpy.names.tl.GevCCP_values
            node = self._nodes["GevCCP"] = node_inst
        return node

    @property
    def GUIXMLLocation(self) -> SpinEnumDefNode:
        """Sets the location to load GUI XML.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.tl.GUIXMLLocation_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("GUIXMLLocation")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.GUIXMLLocation))
            node_inst.enum_names = rotpy.names.tl.GUIXMLLocation_names
            node_inst.enum_values = rotpy.names.tl.GUIXMLLocation_values
            node = self._nodes["GUIXMLLocation"] = node_inst
        return node

    @property
    def GUIXMLPath(self) -> SpinStrNode:
        """GUI XML Path.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("GUIXMLPath")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.GUIXMLPath))
            node = self._nodes["GUIXMLPath"] = node_inst
        return node

    @property
    def GenICamXMLLocation(self) -> SpinEnumDefNode:
        """Sets the location to load GenICam XML.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.tl.GenICamXMLLocation_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("GenICamXMLLocation")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.GenICamXMLLocation))
            node_inst.enum_names = rotpy.names.tl.GenICamXMLLocation_names
            node_inst.enum_values = rotpy.names.tl.GenICamXMLLocation_values
            node = self._nodes["GenICamXMLLocation"] = node_inst
        return node

    @property
    def GenICamXMLPath(self) -> SpinStrNode:
        """GenICam XML Path.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("GenICamXMLPath")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.GenICamXMLPath))
            node = self._nodes["GenICamXMLPath"] = node_inst
        return node

    @property
    def GevDeviceIPAddress(self) -> SpinIntNode:
        """Current IP address of the GVCP interface of the selected remote
        device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevDeviceIPAddress")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.GevDeviceIPAddress))
            node = self._nodes["GevDeviceIPAddress"] = node_inst
        return node

    @property
    def GevDeviceSubnetMask(self) -> SpinIntNode:
        """Current subnet mask of the GVCP interface of the selected remote
        device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevDeviceSubnetMask")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.GevDeviceSubnetMask))
            node = self._nodes["GevDeviceSubnetMask"] = node_inst
        return node

    @property
    def GevDeviceMACAddress(self) -> SpinIntNode:
        """48-bit MAC address of the GVCP interface of the selected remote
        device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevDeviceMACAddress")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.GevDeviceMACAddress))
            node = self._nodes["GevDeviceMACAddress"] = node_inst
        return node

    @property
    def GevDeviceGateway(self) -> SpinIntNode:
        """Current gateway IP address of the GVCP interface of the remote
        device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevDeviceGateway")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.GevDeviceGateway))
            node = self._nodes["GevDeviceGateway"] = node_inst
        return node

    @property
    def DeviceLinkSpeed(self) -> SpinIntNode:
        """Indicates the speed of transmission negotiated by the given network
        interface in Mbps.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceLinkSpeed")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.DeviceLinkSpeed))
            node = self._nodes["DeviceLinkSpeed"] = node_inst
        return node

    @property
    def GevVersionMajor(self) -> SpinIntNode:
        """Major version of the specification.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevVersionMajor")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.GevVersionMajor))
            node = self._nodes["GevVersionMajor"] = node_inst
        return node

    @property
    def GevVersionMinor(self) -> SpinIntNode:
        """Minor version of the specification.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevVersionMinor")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.GevVersionMinor))
            node = self._nodes["GevVersionMinor"] = node_inst
        return node

    @property
    def GevDeviceModeIsBigEndian(self) -> SpinBoolNode:
        """This represents the endianness of all device's registers (bootstrap
        registers and manufacturer-specific registers).

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("GevDeviceModeIsBigEndian")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.GevDeviceModeIsBigEndian))
            node = self._nodes["GevDeviceModeIsBigEndian"] = node_inst
        return node

    @property
    def GevDeviceReadAndWriteTimeout(self) -> SpinIntNode:
        """The timeout in us for read/write operations to the camera.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevDeviceReadAndWriteTimeout")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.GevDeviceReadAndWriteTimeout))
            node = self._nodes["GevDeviceReadAndWriteTimeout"] = node_inst
        return node

    @property
    def GevDeviceMaximumRetryCount(self) -> SpinIntNode:
        """Maximum number of times to retry a read/write operation.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevDeviceMaximumRetryCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.GevDeviceMaximumRetryCount))
            node = self._nodes["GevDeviceMaximumRetryCount"] = node_inst
        return node

    @property
    def GevDevicePort(self) -> SpinIntNode:
        """Current IP port of the GVCP interface of the selected remote device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevDevicePort")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.GevDevicePort))
            node = self._nodes["GevDevicePort"] = node_inst
        return node

    @property
    def GevDeviceDiscoverMaximumPacketSize(self) -> SpinCommandNode:
        """Discovers and updates the maximum packet size that can be safely
        used by the device on the current interface.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("GevDeviceDiscoverMaximumPacketSize")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.GevDeviceDiscoverMaximumPacketSize))
            node = self._nodes["GevDeviceDiscoverMaximumPacketSize"] = node_inst
        return node

    @property
    def GevDeviceMaximumPacketSize(self) -> SpinIntNode:
        """The maximum packet size that can be safely used by the device on the
        current interface.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevDeviceMaximumPacketSize")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.GevDeviceMaximumPacketSize))
            node = self._nodes["GevDeviceMaximumPacketSize"] = node_inst
        return node

    @property
    def GevDeviceIsWrongSubnet(self) -> SpinBoolNode:
        """Indicates whether the device is on the wrong subnet.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("GevDeviceIsWrongSubnet")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.GevDeviceIsWrongSubnet))
            node = self._nodes["GevDeviceIsWrongSubnet"] = node_inst
        return node

    @property
    def GevDeviceAutoForceIP(self) -> SpinCommandNode:
        """Forces the camera to be on the same subnet as its corresponding
        interface.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("GevDeviceAutoForceIP")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.GevDeviceAutoForceIP))
            node = self._nodes["GevDeviceAutoForceIP"] = node_inst
        return node

    @property
    def GevDeviceForceIP(self) -> SpinCommandNode:
        """Apply the force IP settings (GevDeviceForceIPAddress,
        GevDeviceForceSubnetMask and GevDeviceForceGateway) in the Device
        using ForceIP command.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("GevDeviceForceIP")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.GevDeviceForceIP))
            node = self._nodes["GevDeviceForceIP"] = node_inst
        return node

    @property
    def GevDeviceForceIPAddress(self) -> SpinIntNode:
        """Static IP address to set for the GVCP interface of the remote
        device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevDeviceForceIPAddress")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.GevDeviceForceIPAddress))
            node = self._nodes["GevDeviceForceIPAddress"] = node_inst
        return node

    @property
    def GevDeviceForceSubnetMask(self) -> SpinIntNode:
        """Static subnet mask to set for GVCP interface of the remote device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevDeviceForceSubnetMask")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.GevDeviceForceSubnetMask))
            node = self._nodes["GevDeviceForceSubnetMask"] = node_inst
        return node

    @property
    def GevDeviceForceGateway(self) -> SpinIntNode:
        """Static gateway IP address to set for the GVCP interface of the
        remote device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevDeviceForceGateway")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.GevDeviceForceGateway))
            node = self._nodes["GevDeviceForceGateway"] = node_inst
        return node

    @property
    def DeviceMulticastMonitorMode(self) -> SpinBoolNode:
        """Controls and indicates if the device is operating in as a Multicast
        Monitor.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("DeviceMulticastMonitorMode")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.DeviceMulticastMonitorMode))
            node = self._nodes["DeviceMulticastMonitorMode"] = node_inst
        return node

    @property
    def DeviceEndianessMechanism(self) -> SpinEnumDefNode:
        """Identifies the endianness handling mode.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.tl.DeviceEndianessMechanism_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("DeviceEndianessMechanism")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.DeviceEndianessMechanism))
            node_inst.enum_names = rotpy.names.tl.DeviceEndianessMechanism_names
            node_inst.enum_values = rotpy.names.tl.DeviceEndianessMechanism_values
            node = self._nodes["DeviceEndianessMechanism"] = node_inst
        return node

    @property
    def DeviceInstanceId(self) -> SpinStrNode:
        """

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("DeviceInstanceId")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.DeviceInstanceId))
            node = self._nodes["DeviceInstanceId"] = node_inst
        return node

    @property
    def DeviceLocation(self) -> SpinStrNode:
        """Device Location.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("DeviceLocation")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.DeviceLocation))
            node = self._nodes["DeviceLocation"] = node_inst
        return node

    @property
    def DeviceCurrentSpeed(self) -> SpinEnumDefNode:
        """The USB Speed that the device is currently operating at.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.tl.DeviceCurrentSpeed_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("DeviceCurrentSpeed")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.DeviceCurrentSpeed))
            node_inst.enum_names = rotpy.names.tl.DeviceCurrentSpeed_names
            node_inst.enum_values = rotpy.names.tl.DeviceCurrentSpeed_values
            node = self._nodes["DeviceCurrentSpeed"] = node_inst
        return node

    @property
    def DeviceU3VProtocol(self) -> SpinBoolNode:
        """Indicates whether the device is communicating in U3V Protocol.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("DeviceU3VProtocol")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.DeviceU3VProtocol))
            node = self._nodes["DeviceU3VProtocol"] = node_inst
        return node

    @property
    def DevicePortId(self) -> SpinStrNode:
        """Device Port ID.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("DevicePortId")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLDevice.DevicePortId))
            node = self._nodes["DevicePortId"] = node_inst
        return node


cdef class TLStreamNodes:
    """Lists all the pre-listed nodes of the :class:`~rotpy.camera.Camera`
    transport layer stream.

    .. warning::

        Do **not** create a :class:`TLStreamNodes` manually, rather get it
        from :attr:`~rotpy.camera.Camera.tl_stream_nodes` that is automatically
        created when the camera is instantiated.

    .. note::

        Even though the nodes are pre-listed, it is simply a convenience and
        the same nodes can be gotten by name through
        :class:`~rotpy.node.NodeMap`. Additionally, you must check that the
        node is actually available, readable etc, even if it's pre-listed.

        Some nodes are available before :meth:`~rotpy.camera.Camera.init_cam`,
        but other nodes, even those pre-listed, become available only after
        :meth:`~rotpy.camera.Camera.init_cam`.
    """

    def __cinit__(self, camera):
        self._camera = camera
        self._nodes = {}
        self.bool_nodes = ['StreamIsGrabbing', 'StreamCRCCheckEnable',
                           'StreamPacketResendEnable', 'GevPacketResendMode']
        self.int_nodes = ['StreamBufferCountManual', 'StreamBufferCountResult',
                          'StreamBufferCountMax', 'StreamAnnounceBufferMinimum',
                          'StreamAnnouncedBufferCount',
                          'StreamStartedFrameCount',
                          'StreamDeliveredFrameCount',
                          'StreamReceivedFrameCount',
                          'StreamIncompleteFrameCount', 'StreamLostFrameCount',
                          'StreamDroppedFrameCount', 'StreamInputBufferCount',
                          'StreamOutputBufferCount', 'StreamChunkCountMaximum',
                          'StreamBufferAlignment', 'StreamReceivedPacketCount',
                          'StreamMissedPacketCount',
                          'StreamPacketResendTimeout',
                          'StreamPacketResendMaxRequests',
                          'StreamPacketResendRequestCount',
                          'StreamPacketResendRequestSuccessCount',
                          'StreamPacketResendRequestedPacketCount',
                          'StreamPacketResendReceivedPacketCount',
                          'GevMaximumNumberResendRequests',
                          'GevPacketResendTimeout', 'GevTotalPacketCount',
                          'GevFailedPacketCount', 'GevResendPacketCount',
                          'StreamFailedBufferCount', 'GevResendRequestCount',
                          'StreamBlockTransferSize']
        self.float_nodes = []
        self.str_nodes = ['StreamID']
        self.enum_nodes = ['StreamType', 'StreamMode', 'StreamBufferCountMode',
                           'StreamBufferHandlingMode']
        self.command_nodes = []
        self.register_nodes = []

    def __init__(self, camera):
        pass

    @property
    def StreamID(self) -> SpinStrNode:
        """Device unique ID for the data stream, e.g. a GUID.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("StreamID")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamID))
            node = self._nodes["StreamID"] = node_inst
        return node

    @property
    def StreamType(self) -> SpinEnumDefNode:
        """Stream type of the device.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.tl.StreamType_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("StreamType")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamType))
            node_inst.enum_names = rotpy.names.tl.StreamType_names
            node_inst.enum_values = rotpy.names.tl.StreamType_values
            node = self._nodes["StreamType"] = node_inst
        return node

    @property
    def StreamMode(self) -> SpinEnumDefNode:
        """Stream mode of the device.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.tl.StreamMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("StreamMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamMode))
            node_inst.enum_names = rotpy.names.tl.StreamMode_names
            node_inst.enum_values = rotpy.names.tl.StreamMode_values
            node = self._nodes["StreamMode"] = node_inst
        return node

    @property
    def StreamBufferCountManual(self) -> SpinIntNode:
        """Controls the number of buffers to be used on this stream upon
        acquisition start when in manual mode.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("StreamBufferCountManual")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamBufferCountManual))
            node = self._nodes["StreamBufferCountManual"] = node_inst
        return node

    @property
    def StreamBufferCountResult(self) -> SpinIntNode:
        """Displays the number of buffers to be used on this stream upon
        acquisition start. Recalculated on acquisition start if in auto
        mode.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("StreamBufferCountResult")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamBufferCountResult))
            node = self._nodes["StreamBufferCountResult"] = node_inst
        return node

    @property
    def StreamBufferCountMax(self) -> SpinIntNode:
        """Controls the maximum number of buffers that should be used on this
        stream. This value is calculated based on the available system
        memory.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("StreamBufferCountMax")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamBufferCountMax))
            node = self._nodes["StreamBufferCountMax"] = node_inst
        return node

    @property
    def StreamBufferCountMode(self) -> SpinEnumDefNode:
        """Controls access to setting the number of buffers used for the
        stream.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.tl.StreamBufferCountMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("StreamBufferCountMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamBufferCountMode))
            node_inst.enum_names = rotpy.names.tl.StreamBufferCountMode_names
            node_inst.enum_values = rotpy.names.tl.StreamBufferCountMode_values
            node = self._nodes["StreamBufferCountMode"] = node_inst
        return node

    @property
    def StreamBufferHandlingMode(self) -> SpinEnumDefNode:
        """Available buffer handling modes of this data stream:

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.tl.StreamBufferHandlingMode_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("StreamBufferHandlingMode")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamBufferHandlingMode))
            node_inst.enum_names = rotpy.names.tl.StreamBufferHandlingMode_names
            node_inst.enum_values = rotpy.names.tl.StreamBufferHandlingMode_values
            node = self._nodes["StreamBufferHandlingMode"] = node_inst
        return node

    @property
    def StreamAnnounceBufferMinimum(self) -> SpinIntNode:
        """Minimal number of buffers to announce to enable selected buffer
        handling mode.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("StreamAnnounceBufferMinimum")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamAnnounceBufferMinimum))
            node = self._nodes["StreamAnnounceBufferMinimum"] = node_inst
        return node

    @property
    def StreamAnnouncedBufferCount(self) -> SpinIntNode:
        """Number of announced (known) buffers on this stream. This value is
        volatile. It may change if additional buffers are announced and/or
        buffers are revoked by the GenTL Consumer.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("StreamAnnouncedBufferCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamAnnouncedBufferCount))
            node = self._nodes["StreamAnnouncedBufferCount"] = node_inst
        return node

    @property
    def StreamStartedFrameCount(self) -> SpinIntNode:
        """Number of frames started in the acquisition engine. This number is
        incremented every time in case of a new buffer is started and then
        to be filled (data written to) regardless even if the buffer is
        later delivered to the user or discarded for any reason. This number
        is initialized with 0 at at the time of the stream is opened. It is
        not reset until the stream is closed.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("StreamStartedFrameCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamStartedFrameCount))
            node = self._nodes["StreamStartedFrameCount"] = node_inst
        return node

    @property
    def StreamDeliveredFrameCount(self) -> SpinIntNode:
        """Number of delivered frames since last acquisition start. It is not
        reset until the stream is closed.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("StreamDeliveredFrameCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamDeliveredFrameCount))
            node = self._nodes["StreamDeliveredFrameCount"] = node_inst
        return node

    @property
    def StreamReceivedFrameCount(self) -> SpinIntNode:
        """Number of successful GVSP data blocks received. Only valid while
        stream is active.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("StreamReceivedFrameCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamReceivedFrameCount))
            node = self._nodes["StreamReceivedFrameCount"] = node_inst
        return node

    @property
    def StreamIncompleteFrameCount(self) -> SpinIntNode:
        """Displays number of images with missing packet.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("StreamIncompleteFrameCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamIncompleteFrameCount))
            node = self._nodes["StreamIncompleteFrameCount"] = node_inst
        return node

    @property
    def StreamLostFrameCount(self) -> SpinIntNode:
        """Number of lost frames due to queue underrun. This number is
        initialized with zero at the time the stream is opened and
        incremented every time the data could not be acquired because there
        was no buffer in the input buffer pool. It is not reset until the
        stream is closed.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("StreamLostFrameCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamLostFrameCount))
            node = self._nodes["StreamLostFrameCount"] = node_inst
        return node

    @property
    def StreamDroppedFrameCount(self) -> SpinIntNode:
        """Number of dropped frames due to queue overrun. This number is
        initialized with zero at the time the stream is opened and
        incremented every time old data is dropped from the output list for
        new data. It is not reset until the stream is closed.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("StreamDroppedFrameCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamDroppedFrameCount))
            node = self._nodes["StreamDroppedFrameCount"] = node_inst
        return node

    @property
    def StreamInputBufferCount(self) -> SpinIntNode:
        """Number of buffers in the input buffer pool plus the buffers(s)
        currently being filled.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("StreamInputBufferCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamInputBufferCount))
            node = self._nodes["StreamInputBufferCount"] = node_inst
        return node

    @property
    def StreamOutputBufferCount(self) -> SpinIntNode:
        """Number of buffers in the output buffer queue.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("StreamOutputBufferCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamOutputBufferCount))
            node = self._nodes["StreamOutputBufferCount"] = node_inst
        return node

    @property
    def StreamIsGrabbing(self) -> SpinBoolNode:
        """Flag indicating whether the acquisition engine is started or not.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("StreamIsGrabbing")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamIsGrabbing))
            node = self._nodes["StreamIsGrabbing"] = node_inst
        return node

    @property
    def StreamChunkCountMaximum(self) -> SpinIntNode:
        """Maximum number of chunks to be expected in a buffer.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("StreamChunkCountMaximum")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamChunkCountMaximum))
            node = self._nodes["StreamChunkCountMaximum"] = node_inst
        return node

    @property
    def StreamBufferAlignment(self) -> SpinIntNode:
        """Alignment size in bytes of the buffer passed to DSAnnounceBuffer.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("StreamBufferAlignment")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamBufferAlignment))
            node = self._nodes["StreamBufferAlignment"] = node_inst
        return node

    @property
    def StreamCRCCheckEnable(self) -> SpinBoolNode:
        """Enables or disables CRC checks on received images.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("StreamCRCCheckEnable")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamCRCCheckEnable))
            node = self._nodes["StreamCRCCheckEnable"] = node_inst
        return node

    @property
    def StreamReceivedPacketCount(self) -> SpinIntNode:
        """Displays number of packets received on this stream.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("StreamReceivedPacketCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamReceivedPacketCount))
            node = self._nodes["StreamReceivedPacketCount"] = node_inst
        return node

    @property
    def StreamMissedPacketCount(self) -> SpinIntNode:
        """Displays number of packets missed by this stream. Successful resent
        packets are not counted as a missed packet.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("StreamMissedPacketCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamMissedPacketCount))
            node = self._nodes["StreamMissedPacketCount"] = node_inst
        return node

    @property
    def StreamPacketResendEnable(self) -> SpinBoolNode:
        """Enables or disables the packet resend mechanism.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("StreamPacketResendEnable")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamPacketResendEnable))
            node = self._nodes["StreamPacketResendEnable"] = node_inst
        return node

    @property
    def StreamPacketResendTimeout(self) -> SpinIntNode:
        """Time in milliseconds to wait after the image trailer is received and
        before the image is completed by the driver.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("StreamPacketResendTimeout")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamPacketResendTimeout))
            node = self._nodes["StreamPacketResendTimeout"] = node_inst
        return node

    @property
    def StreamPacketResendMaxRequests(self) -> SpinIntNode:
        """Maximum number of resend requests per image. Each resend request
        consists of a span of consecutive packet IDs.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("StreamPacketResendMaxRequests")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamPacketResendMaxRequests))
            node = self._nodes["StreamPacketResendMaxRequests"] = node_inst
        return node

    @property
    def StreamPacketResendRequestCount(self) -> SpinIntNode:
        """Displays number of packet resend requests transmitted to the camera.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("StreamPacketResendRequestCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamPacketResendRequestCount))
            node = self._nodes["StreamPacketResendRequestCount"] = node_inst
        return node

    @property
    def StreamPacketResendRequestSuccessCount(self) -> SpinIntNode:
        """Displays number of packet resend requests successfully transmitted
        to the camera.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("StreamPacketResendRequestSuccessCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamPacketResendRequestSuccessCount))
            node = self._nodes["StreamPacketResendRequestSuccessCount"] = node_inst
        return node

    @property
    def StreamPacketResendRequestedPacketCount(self) -> SpinIntNode:
        """Displays number of packets requested to be retransmitted on this
        stream.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("StreamPacketResendRequestedPacketCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamPacketResendRequestedPacketCount))
            node = self._nodes["StreamPacketResendRequestedPacketCount"] = node_inst
        return node

    @property
    def StreamPacketResendReceivedPacketCount(self) -> SpinIntNode:
        """Displays number of retransmitted packets received on this stream.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("StreamPacketResendReceivedPacketCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamPacketResendReceivedPacketCount))
            node = self._nodes["StreamPacketResendReceivedPacketCount"] = node_inst
        return node

    @property
    def GevPacketResendMode(self) -> SpinBoolNode:
        """DEPRECATED; Replaced by StreamPacketResendEnable. Enables or
        disables the packet resend mechanism.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("GevPacketResendMode")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.GevPacketResendMode))
            node = self._nodes["GevPacketResendMode"] = node_inst
        return node

    @property
    def GevMaximumNumberResendRequests(self) -> SpinIntNode:
        """DEPRECATED; Replaced by StreamPacketResendMaxRequests. Maximum
        number of resend requests per image. Each resend request consists of
        a span of consecutive packet IDs.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevMaximumNumberResendRequests")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.GevMaximumNumberResendRequests))
            node = self._nodes["GevMaximumNumberResendRequests"] = node_inst
        return node

    @property
    def GevPacketResendTimeout(self) -> SpinIntNode:
        """DEPRECATED; Replaced by StreamPacketResendTimeout. Time in
        milliseconds to wait after the image trailer is received and before
        the image is completed by the driver.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevPacketResendTimeout")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.GevPacketResendTimeout))
            node = self._nodes["GevPacketResendTimeout"] = node_inst
        return node

    @property
    def GevTotalPacketCount(self) -> SpinIntNode:
        """DEPRECATED; Replaced by StreamReceivedPacketCount. Displays number
        of packets received on this stream.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevTotalPacketCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.GevTotalPacketCount))
            node = self._nodes["GevTotalPacketCount"] = node_inst
        return node

    @property
    def GevFailedPacketCount(self) -> SpinIntNode:
        """DEPRECATED; Replaced by StreamMissedPacketCount. Displays number of
        packets missed by this stream. Successful resent packets are not
        counted as a missed packet.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevFailedPacketCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.GevFailedPacketCount))
            node = self._nodes["GevFailedPacketCount"] = node_inst
        return node

    @property
    def GevResendPacketCount(self) -> SpinIntNode:
        """DEPRECATED; Replaced by StreamPacketResendReceivedPacketCount.
        Displays number of packets received after retransmit request on this
        stream.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevResendPacketCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.GevResendPacketCount))
            node = self._nodes["GevResendPacketCount"] = node_inst
        return node

    @property
    def StreamFailedBufferCount(self) -> SpinIntNode:
        """DEPRECATED; Replaced by StreamIncompleteFrameCount. Displays number
        of images with missing packet.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("StreamFailedBufferCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamFailedBufferCount))
            node = self._nodes["StreamFailedBufferCount"] = node_inst
        return node

    @property
    def GevResendRequestCount(self) -> SpinIntNode:
        """DEPRECATED; Replaced by StreamPacketResendRequestedPacketCount.
        Displays number of packets requested to be retransmitted on this
        stream.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevResendRequestCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.GevResendRequestCount))
            node = self._nodes["GevResendRequestCount"] = node_inst
        return node

    @property
    def StreamBlockTransferSize(self) -> SpinIntNode:
        """Controls the image breakup size that should be used on this stream.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("StreamBlockTransferSize")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._camera._camera.get().TLStream.StreamBlockTransferSize))
            node = self._nodes["StreamBlockTransferSize"] = node_inst
        return node
