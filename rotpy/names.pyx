from ._interface import Error, EventType, PixelFormatNamespaceID, \
    ColorProcessingAlgorithm, ImageFileFormat, ImageStatus, \
    StatisticsChannel, SpinnakerLogLevel, PayloadTypeInfoIDs, \
    ActionCommandStatus, PixelFormatIntType, BufferOwnership, \
    CCMColorTemperature, CCMType, CCMSensor, CCMColorSpace, CCMApplication, \
    _ESign, _EAccessMode, _EVisibility, _ECachingMode, _ERepresentation, \
    _EEndianess, _ENameSpace, _EStandardNameSpace, _EYesNo, _ESlope, \
    _EXMLValidation, _EDisplayNotation, _EInterfaceType, _ELinkType, \
    _EIncMode, _EInputDirection, _EGenApiSchemaVersion, LUTSelectorEnums, \
    ExposureModeEnums, AcquisitionModeEnums, TriggerSourceEnums, \
    TriggerActivationEnums, SensorShutterModeEnums, TriggerModeEnums, \
    TriggerOverlapEnums, TriggerSelectorEnums, ExposureAutoEnums, \
    EventSelectorEnums, EventNotificationEnums, LogicBlockSelectorEnums, \
    LogicBlockLUTInputActivationEnums, LogicBlockLUTInputSelectorEnums, \
    LogicBlockLUTInputSourceEnums, LogicBlockLUTSelectorEnums, \
    ColorTransformationSelectorEnums, RgbTransformLightSourceEnums, \
    ColorTransformationValueSelectorEnums, DeviceRegistersEndiannessEnums, \
    DeviceScanTypeEnums, DeviceCharacterSetEnums, DeviceTLTypeEnums, \
    DevicePowerSupplySelectorEnums, DeviceTemperatureSelectorEnums, \
    DeviceIndicatorModeEnums, AutoExposureControlPriorityEnums, \
    AutoExposureMeteringModeEnums, BalanceWhiteAutoProfileEnums, \
    AutoAlgorithmSelectorEnums, AutoExposureTargetGreyValueAutoEnums, \
    AutoExposureLightingModeEnums, GevIEEE1588StatusEnums, GevIEEE1588ModeEnums, \
    GevIEEE1588ClockAccuracyEnums, GevCCPEnums, GevSupportedOptionSelectorEnums, \
    BlackLevelSelectorEnums, BalanceWhiteAutoEnums, GainAutoEnums, \
    BalanceRatioSelectorEnums, GainSelectorEnums, DefectCorrectionModeEnums, \
    UserSetSelectorEnums, UserSetDefaultEnums, SerialPortBaudRateEnums, \
    SerialPortParityEnums, SerialPortSelectorEnums, SerialPortStopBitsEnums, \
    SerialPortSourceEnums, SequencerModeEnums, SequencerConfigurationValidEnums, \
    SequencerSetValidEnums, SequencerTriggerActivationEnums, \
    SequencerConfigurationModeEnums, SequencerTriggerSourceEnums, \
    TransferQueueModeEnums, TransferOperationModeEnums, \
    TransferControlModeEnums, ChunkGainSelectorEnums, ChunkSelectorEnums, \
    ChunkBlackLevelSelectorEnums, ChunkPixelFormatEnums, \
    FileOperationStatusEnums, FileOpenModeEnums, FileOperationSelectorEnums, \
    FileSelectorEnums, BinningSelectorEnums, TestPatternGeneratorSelectorEnums, \
    CompressionSaturationPriorityEnums, TestPatternEnums, PixelColorFilterEnums, \
    AdcBitDepthEnums, DecimationHorizontalModeEnums, BinningVerticalModeEnums, \
    PixelSizeEnums, DecimationSelectorEnums, ImageCompressionModeEnums, \
    BinningHorizontalModeEnums, PixelFormatEnums, DecimationVerticalModeEnums, \
    LineModeEnums, LineSourceEnums, LineInputFilterSelectorEnums, \
    UserOutputSelectorEnums, LineFormatEnums, LineSelectorEnums, \
    ExposureActiveModeEnums, CounterTriggerActivationEnums, \
    CounterSelectorEnums, CounterStatusEnums, CounterTriggerSourceEnums, \
    CounterResetSourceEnums, CounterEventSourceEnums, \
    CounterEventActivationEnums, CounterResetActivationEnums, DeviceTypeEnums, \
    DeviceConnectionStatusEnums, DeviceLinkThroughputLimitModeEnums, \
    DeviceLinkHeartbeatModeEnums, DeviceStreamChannelTypeEnums, \
    DeviceStreamChannelEndiannessEnums, DeviceClockSelectorEnums, \
    DeviceSerialPortSelectorEnums, DeviceSerialPortBaudRateEnums, \
    SensorTapsEnums, SensorDigitizationTapsEnums, RegionSelectorEnums, \
    RegionModeEnums, RegionDestinationEnums, ImageComponentSelectorEnums, \
    PixelFormatInfoSelectorEnums, DeinterlacingEnums, \
    ImageCompressionRateOptionEnums, ImageCompressionJPEGFormatOptionEnums, \
    AcquisitionStatusSelectorEnums, ExposureTimeModeEnums, \
    ExposureTimeSelectorEnums, GainAutoBalanceEnums, BlackLevelAutoEnums, \
    BlackLevelAutoBalanceEnums, WhiteClipSelectorEnums, TimerSelectorEnums, \
    TimerStatusEnums, TimerTriggerSourceEnums, TimerTriggerActivationEnums, \
    EncoderSelectorEnums, EncoderSourceAEnums, EncoderSourceBEnums, \
    EncoderModeEnums, EncoderOutputModeEnums, EncoderStatusEnums, \
    EncoderResetSourceEnums, EncoderResetActivationEnums, \
    SoftwareSignalSelectorEnums, ActionUnconditionalModeEnums, \
    SourceSelectorEnums, TransferSelectorEnums, TransferTriggerSelectorEnums, \
    TransferTriggerModeEnums, TransferTriggerSourceEnums, \
    TransferTriggerActivationEnums, TransferStatusSelectorEnums, \
    TransferComponentSelectorEnums, Scan3dDistanceUnitEnums, \
    Scan3dCoordinateSystemEnums, Scan3dOutputModeEnums, \
    Scan3dCoordinateSystemReferenceEnums, Scan3dCoordinateSelectorEnums, \
    Scan3dCoordinateTransformSelectorEnums, \
    Scan3dCoordinateReferenceSelectorEnums, ChunkImageComponentEnums, \
    ChunkCounterSelectorEnums, ChunkTimerSelectorEnums, \
    ChunkEncoderSelectorEnums, ChunkEncoderStatusEnums, \
    ChunkExposureTimeSelectorEnums, ChunkSourceIDEnums, ChunkRegionIDEnums, \
    ChunkTransferStreamIDEnums, ChunkScan3dDistanceUnitEnums, \
    ChunkScan3dOutputModeEnums, ChunkScan3dCoordinateSystemEnums, \
    ChunkScan3dCoordinateSystemReferenceEnums, \
    ChunkScan3dCoordinateSelectorEnums, \
    ChunkScan3dCoordinateTransformSelectorEnums, \
    ChunkScan3dCoordinateReferenceSelectorEnums, DeviceTapGeometryEnums, \
    GevPhysicalLinkConfigurationEnums, GevCurrentPhysicalLinkConfigurationEnums, \
    GevIPConfigurationStatusEnums, GevGVCPExtendedStatusCodesSelectorEnums, \
    GevGVSPExtendedIDModeEnums, ClConfigurationEnums, ClTimeSlotsCountEnums, \
    CxpLinkConfigurationStatusEnums, CxpLinkConfigurationPreferredEnums, \
    CxpLinkConfigurationEnums, CxpConnectionTestModeEnums, CxpPoCxpStatusEnums
from enum import Enum

__all__ = (
    'error_code_names', 'error_code_values', 'event_names', 'event_values',
    'pix_fmt_namespace_names', 'pix_fmt_namespace_values',
    'color_processing_algo_names', 'color_processing_algo_values',
    'img_file_fmt_names', 'img_file_fmt_values', 'img_status_names',
    'img_status_values', # 'compression_names', 'compression_values',
    'stats_channel_names', 'stats_channel_values', 'log_level_names',
    'log_level_values', 'payload_type_names', 'payload_type_values',
    'cmd_status_names', 'cmd_status_values', 'pix_fmt_int_names',
    'pix_fmt_int_values', 'buffer_owner_names', 'buffer_owner_values',
    'img_correction_temp_names', 'img_correction_temp_values',
    'img_correction_type_names', 'img_correction_type_values',
    'img_correction_sensor_names', 'img_correction_sensor_values',
    'img_correction_space_names', 'img_correction_space_values',
    'img_correction_app_names', 'img_correction_app_values', 'int_sign_names',
    'int_sign_values', 'access_mode_names', 'access_mode_values',
    'Visibility_names',
    'Visibility_values', 'CachingMode_names', 'CachingMode_values',
    'Representation_names', 'Representation_values', 'Endianess_names',
    'Endianess_values', 'NameSpace_names', 'NameSpace_values',
    'StandardNameSpace_names', 'StandardNameSpace_values', 'YesNo_names',
    'YesNo_values', 'Slope_names', 'Slope_values', 'XMLValidation_names',
    'XMLValidation_values', 'DisplayNotation_names', 'DisplayNotation_values',
    'InterfaceType_names', 'InterfaceType_values', 'LinkType_names',
    'LinkType_values', 'IncMode_names', 'IncMode_values',
    'InputDirection_names', 'InputDirection_values',
    'GenApiSchemaVersion_names', 'GenApiSchemaVersion_values',
    'LUTSelector_names', 'LUTSelector_values', 'ExposureMode_names',
    'ExposureMode_values', 'AcquisitionMode_names', 'AcquisitionMode_values',
    'TriggerSource_names', 'TriggerSource_values', 'TriggerActivation_names',
    'TriggerActivation_values', 'SensorShutterMode_names',
    'SensorShutterMode_values', 'TriggerMode_names', 'TriggerMode_values',
    'TriggerOverlap_names', 'TriggerOverlap_values', 'TriggerSelector_names',
    'TriggerSelector_values', 'ExposureAuto_names', 'ExposureAuto_values',
    'EventSelector_names', 'EventSelector_values', 'EventNotification_names',
    'EventNotification_values', 'LogicBlockSelector_names',
    'LogicBlockSelector_values', 'LogicBlockLUTInputActivation_names',
    'LogicBlockLUTInputActivation_values', 'LogicBlockLUTInputSelector_names',
    'LogicBlockLUTInputSelector_values', 'LogicBlockLUTInputSource_names',
    'LogicBlockLUTInputSource_values', 'LogicBlockLUTSelector_names',
    'LogicBlockLUTSelector_values', 'ColorTransformationSelector_names',
    'ColorTransformationSelector_values', 'RgbTransformLightSource_names',
    'RgbTransformLightSource_values', 'ColorTransformationValueSelector_names',
    'ColorTransformationValueSelector_values',
    'DeviceRegistersEndianness_names', 'DeviceRegistersEndianness_values',
    'DeviceScanType_names', 'DeviceScanType_values', 'DeviceCharacterSet_names',
    'DeviceCharacterSet_values', 'DeviceTLType_names', 'DeviceTLType_values',
    'DevicePowerSupplySelector_names', 'DevicePowerSupplySelector_values',
    'DeviceTemperatureSelector_names', 'DeviceTemperatureSelector_values',
    'DeviceIndicatorMode_names', 'DeviceIndicatorMode_values',
    'AutoExposureControlPriority_names', 'AutoExposureControlPriority_values',
    'AutoExposureMeteringMode_names', 'AutoExposureMeteringMode_values',
    'BalanceWhiteAutoProfile_names', 'BalanceWhiteAutoProfile_values',
    'AutoAlgorithmSelector_names', 'AutoAlgorithmSelector_values',
    'AutoExposureTargetGreyValueAuto_names',
    'AutoExposureTargetGreyValueAuto_values', 'AutoExposureLightingMode_names',
    'AutoExposureLightingMode_values', 'GevIEEE1588Status_names',
    'GevIEEE1588Status_values', 'GevIEEE1588Mode_names',
    'GevIEEE1588Mode_values', 'GevIEEE1588ClockAccuracy_names',
    'GevIEEE1588ClockAccuracy_values', 'GevCCP_names', 'GevCCP_values',
    'GevSupportedOptionSelector_names', 'GevSupportedOptionSelector_values',
    'BlackLevelSelector_names', 'BlackLevelSelector_values',
    'BalanceWhiteAuto_names', 'BalanceWhiteAuto_values', 'GainAuto_names',
    'GainAuto_values', 'BalanceRatioSelector_names',
    'BalanceRatioSelector_values', 'GainSelector_names', 'GainSelector_values',
    'DefectCorrectionMode_names', 'DefectCorrectionMode_values',
    'UserSetSelector_names', 'UserSetSelector_values', 'UserSetDefault_names',
    'UserSetDefault_values', 'SerialPortBaudRate_names',
    'SerialPortBaudRate_values', 'SerialPortParity_names',
    'SerialPortParity_values', 'SerialPortSelector_names',
    'SerialPortSelector_values', 'SerialPortStopBits_names',
    'SerialPortStopBits_values', 'SerialPortSource_names',
    'SerialPortSource_values', 'SequencerMode_names', 'SequencerMode_values',
    'SequencerConfigurationValid_names', 'SequencerConfigurationValid_values',
    'SequencerSetValid_names', 'SequencerSetValid_values',
    'SequencerTriggerActivation_names', 'SequencerTriggerActivation_values',
    'SequencerConfigurationMode_names', 'SequencerConfigurationMode_values',
    'SequencerTriggerSource_names', 'SequencerTriggerSource_values',
    'TransferQueueMode_names', 'TransferQueueMode_values',
    'TransferOperationMode_names', 'TransferOperationMode_values',
    'TransferControlMode_names', 'TransferControlMode_values',
    'ChunkGainSelector_names', 'ChunkGainSelector_values',
    'ChunkSelector_names', 'ChunkSelector_values',
    'ChunkBlackLevelSelector_names', 'ChunkBlackLevelSelector_values',
    'ChunkPixelFormat_names', 'ChunkPixelFormat_values',
    'FileOperationStatus_names', 'FileOperationStatus_values',
    'FileOpenMode_names', 'FileOpenMode_values', 'FileOperationSelector_names',
    'FileOperationSelector_values', 'FileSelector_names', 'FileSelector_values',
    'BinningSelector_names', 'BinningSelector_values',
    'TestPatternGeneratorSelector_names', 'TestPatternGeneratorSelector_values',
    'CompressionSaturationPriority_names',
    'CompressionSaturationPriority_values', 'TestPattern_names',
    'TestPattern_values', 'PixelColorFilter_names', 'PixelColorFilter_values',
    'AdcBitDepth_names', 'AdcBitDepth_values', 'DecimationHorizontalMode_names',
    'DecimationHorizontalMode_values', 'BinningVerticalMode_names',
    'BinningVerticalMode_values', 'PixelSize_names', 'PixelSize_values',
    'DecimationSelector_names', 'DecimationSelector_values',
    'ImageCompressionMode_names', 'ImageCompressionMode_values',
    'BinningHorizontalMode_names', 'BinningHorizontalMode_values',
    'PixelFormat_names', 'PixelFormat_values', 'DecimationVerticalMode_names',
    'DecimationVerticalMode_values', 'LineMode_names', 'LineMode_values',
    'LineSource_names', 'LineSource_values', 'LineInputFilterSelector_names',
    'LineInputFilterSelector_values', 'UserOutputSelector_names',
    'UserOutputSelector_values', 'LineFormat_names', 'LineFormat_values',
    'LineSelector_names', 'LineSelector_values', 'ExposureActiveMode_names',
    'ExposureActiveMode_values', 'CounterTriggerActivation_names',
    'CounterTriggerActivation_values', 'CounterSelector_names',
    'CounterSelector_values', 'CounterStatus_names', 'CounterStatus_values',
    'CounterTriggerSource_names', 'CounterTriggerSource_values',
    'CounterResetSource_names', 'CounterResetSource_values',
    'CounterEventSource_names', 'CounterEventSource_values',
    'CounterEventActivation_names', 'CounterEventActivation_values',
    'CounterResetActivation_names', 'CounterResetActivation_values',
    'DeviceType_names', 'DeviceType_values', 'DeviceConnectionStatus_names',
    'DeviceConnectionStatus_values', 'DeviceLinkThroughputLimitMode_names',
    'DeviceLinkThroughputLimitMode_values', 'DeviceLinkHeartbeatMode_names',
    'DeviceLinkHeartbeatMode_values', 'DeviceStreamChannelType_names',
    'DeviceStreamChannelType_values', 'DeviceStreamChannelEndianness_names',
    'DeviceStreamChannelEndianness_values', 'DeviceClockSelector_names',
    'DeviceClockSelector_values', 'DeviceSerialPortSelector_names',
    'DeviceSerialPortSelector_values', 'DeviceSerialPortBaudRate_names',
    'DeviceSerialPortBaudRate_values', 'SensorTaps_names', 'SensorTaps_values',
    'SensorDigitizationTaps_names', 'SensorDigitizationTaps_values',
    'RegionSelector_names', 'RegionSelector_values', 'RegionMode_names',
    'RegionMode_values', 'RegionDestination_names', 'RegionDestination_values',
    'ImageComponentSelector_names', 'ImageComponentSelector_values',
    'PixelFormatInfoSelector_names', 'PixelFormatInfoSelector_values',
    'Deinterlacing_names', 'Deinterlacing_values',
    'ImageCompressionRateOption_names', 'ImageCompressionRateOption_values',
    'ImageCompressionJPEGFormatOption_names',
    'ImageCompressionJPEGFormatOption_values',
    'AcquisitionStatusSelector_names', 'AcquisitionStatusSelector_values',
    'ExposureTimeMode_names', 'ExposureTimeMode_values',
    'ExposureTimeSelector_names', 'ExposureTimeSelector_values',
    'GainAutoBalance_names', 'GainAutoBalance_values', 'BlackLevelAuto_names',
    'BlackLevelAuto_values', 'BlackLevelAutoBalance_names',
    'BlackLevelAutoBalance_values', 'WhiteClipSelector_names',
    'WhiteClipSelector_values', 'TimerSelector_names', 'TimerSelector_values',
    'TimerStatus_names', 'TimerStatus_values', 'TimerTriggerSource_names',
    'TimerTriggerSource_values', 'TimerTriggerActivation_names',
    'TimerTriggerActivation_values', 'EncoderSelector_names',
    'EncoderSelector_values', 'EncoderSourceA_names', 'EncoderSourceA_values',
    'EncoderSourceB_names', 'EncoderSourceB_values', 'EncoderMode_names',
    'EncoderMode_values', 'EncoderOutputMode_names', 'EncoderOutputMode_values',
    'EncoderStatus_names', 'EncoderStatus_values', 'EncoderResetSource_names',
    'EncoderResetSource_values', 'EncoderResetActivation_names',
    'EncoderResetActivation_values', 'SoftwareSignalSelector_names',
    'SoftwareSignalSelector_values', 'ActionUnconditionalMode_names',
    'ActionUnconditionalMode_values', 'SourceSelector_names',
    'SourceSelector_values', 'TransferSelector_names',
    'TransferSelector_values', 'TransferTriggerSelector_names',
    'TransferTriggerSelector_values', 'TransferTriggerMode_names',
    'TransferTriggerMode_values', 'TransferTriggerSource_names',
    'TransferTriggerSource_values', 'TransferTriggerActivation_names',
    'TransferTriggerActivation_values', 'TransferStatusSelector_names',
    'TransferStatusSelector_values', 'TransferComponentSelector_names',
    'TransferComponentSelector_values', 'Scan3dDistanceUnit_names',
    'Scan3dDistanceUnit_values', 'Scan3dCoordinateSystem_names',
    'Scan3dCoordinateSystem_values', 'Scan3dOutputMode_names',
    'Scan3dOutputMode_values', 'Scan3dCoordinateSystemReference_names',
    'Scan3dCoordinateSystemReference_values', 'Scan3dCoordinateSelector_names',
    'Scan3dCoordinateSelector_values',
    'Scan3dCoordinateTransformSelector_names',
    'Scan3dCoordinateTransformSelector_values',
    'Scan3dCoordinateReferenceSelector_names',
    'Scan3dCoordinateReferenceSelector_values', 'ChunkImageComponent_names',
    'ChunkImageComponent_values', 'ChunkCounterSelector_names',
    'ChunkCounterSelector_values', 'ChunkTimerSelector_names',
    'ChunkTimerSelector_values', 'ChunkEncoderSelector_names',
    'ChunkEncoderSelector_values', 'ChunkEncoderStatus_names',
    'ChunkEncoderStatus_values', 'ChunkExposureTimeSelector_names',
    'ChunkExposureTimeSelector_values', 'ChunkSourceID_names',
    'ChunkSourceID_values', 'ChunkRegionID_names', 'ChunkRegionID_values',
    'ChunkTransferStreamID_names', 'ChunkTransferStreamID_values',
    'ChunkScan3dDistanceUnit_names', 'ChunkScan3dDistanceUnit_values',
    'ChunkScan3dOutputMode_names', 'ChunkScan3dOutputMode_values',
    'ChunkScan3dCoordinateSystem_names', 'ChunkScan3dCoordinateSystem_values',
    'ChunkScan3dCoordinateSystemReference_names',
    'ChunkScan3dCoordinateSystemReference_values',
    'ChunkScan3dCoordinateSelector_names',
    'ChunkScan3dCoordinateSelector_values',
    'ChunkScan3dCoordinateTransformSelector_names',
    'ChunkScan3dCoordinateTransformSelector_values',
    'ChunkScan3dCoordinateReferenceSelector_names',
    'ChunkScan3dCoordinateReferenceSelector_values', 'DeviceTapGeometry_names',
    'DeviceTapGeometry_values', 'GevPhysicalLinkConfiguration_names',
    'GevPhysicalLinkConfiguration_values',
    'GevCurrentPhysicalLinkConfiguration_names',
    'GevCurrentPhysicalLinkConfiguration_values',
    'GevIPConfigurationStatus_names', 'GevIPConfigurationStatus_values',
    'GevGVCPExtendedStatusCodesSelector_names',
    'GevGVCPExtendedStatusCodesSelector_values', 'GevGVSPExtendedIDMode_names',
    'GevGVSPExtendedIDMode_values', 'ClConfiguration_names',
    'ClConfiguration_values', 'ClTimeSlotsCount_names',
    'ClTimeSlotsCount_values', 'CxpLinkConfigurationStatus_names',
    'CxpLinkConfigurationStatus_values', 'CxpLinkConfigurationPreferred_names',
    'CxpLinkConfigurationPreferred_values', 'CxpLinkConfiguration_names',
    'CxpLinkConfiguration_values', 'CxpConnectionTestMode_names',
    'CxpConnectionTestMode_values', 'CxpPoCxpStatus_names',
    'CxpPoCxpStatus_values'
)


def _to_dict(e: Enum, skip_prefix=('NUM', '_')) -> dict:
    return {
        item.name: item.value
        for item in e
        if not any(item.name.startswith(p) for p in skip_prefix)
    }


def _remove_prefix(prefix: str, e: Enum, skip_prefix=('NUM', '_')) -> dict:
    n = len(prefix)
    return {
        item.name[n:]: item.value
        for item in e
        if not any(item.name.startswith(p) for p in skip_prefix)
    }


def _split_name(
        n_splits: int, e: Enum, skip_prefix=('NUM', '_'), lower=False) -> dict:
    items = {
        item.name.split('_', n_splits)[n_splits]: item.value
        for item in e
        if not any(item.name.startswith(p) for p in skip_prefix)
    }
    if lower:
        items = {k.lower(): v for k, v in items.items()}
    return items


def _lower_names(e: Enum) -> dict:
    return {item.name.lower(): item.value for item in e}


def _invert_dict(d: dict) -> dict:
    return {v: k for k, v in d.items()}


error_code_names = _split_name(2, Error, lower=True)
error_code_values = _invert_dict(error_code_names)

event_names = _split_name(2, EventType, lower=True)
event_values = _invert_dict(event_names)

pix_fmt_namespace_names = _split_name(3, PixelFormatNamespaceID, lower=True)
pix_fmt_namespace_values = _invert_dict(pix_fmt_namespace_names)

color_processing_algo_names = _lower_names(ColorProcessingAlgorithm)
color_processing_algo_values = _invert_dict(color_processing_algo_names)

img_file_fmt_names = _lower_names(ImageFileFormat)
img_file_fmt_values = _invert_dict(img_file_fmt_names)

img_status_names = _split_name(1, ImageStatus, lower=True)
img_status_values = _invert_dict(img_status_names)

# compression_names = _lower_names(CompressionMethod)
# compression_values = _invert_dict(compression_names)

stats_channel_names = _lower_names(StatisticsChannel)
stats_channel_values = _invert_dict(stats_channel_names)

log_level_names = _split_name(2, SpinnakerLogLevel, lower=True)
"""
Logging events below each level will not trigger callbacks.

Spinnaker uses five levels of logging:
- Error - failures that are non-recoverable without user intervention.
- Warning - failures that are recoverable without user intervention.
- Notice - information about events such as camera arrival and removal, initialization and
           deinitialization, starting and stopping image acquisition, and feature modification.
- Info - information about recurring events that are generated regularly such as information on
               individual images.
- Debug - information that can be used to troubleshoot the system.
"""
log_level_values = _invert_dict(log_level_names)

payload_type_names = _split_name(2, PayloadTypeInfoIDs, lower=True)
payload_type_values = _invert_dict(payload_type_names)

cmd_status_names = _split_name(3, ActionCommandStatus, lower=True)
cmd_status_values = _invert_dict(cmd_status_names)

pix_fmt_int_names = _split_name(1, PixelFormatIntType, lower=True)
pix_fmt_int_values = _invert_dict(pix_fmt_int_names)

buffer_owner_names = _split_name(2, BufferOwnership, lower=True)
buffer_owner_values = _invert_dict(buffer_owner_names)

img_correction_temp_names = _lower_names(CCMColorTemperature)
img_correction_temp_values = _invert_dict(img_correction_temp_names)

img_correction_type_names = _lower_names(CCMType)
img_correction_type_values = _invert_dict(img_correction_type_names)

img_correction_sensor_names = _lower_names(CCMSensor)
img_correction_sensor_values = _invert_dict(img_correction_sensor_names)

img_correction_space_names = _lower_names(CCMColorSpace)
img_correction_space_values = _invert_dict(img_correction_space_names)

img_correction_app_names = _split_name(2, CCMApplication, lower=True)
img_correction_app_values = _invert_dict(img_correction_app_names)

# ----------------------------------------------------------------

int_sign_names = _lower_names(_ESign)
int_sign_values = _invert_dict(int_sign_names)

access_mode_names = _to_dict(_EAccessMode)
access_mode_values = _invert_dict(access_mode_names)

Visibility_names = _to_dict(_EVisibility)
Visibility_values = _invert_dict(Visibility_names)

CachingMode_names = _to_dict(_ECachingMode)
CachingMode_values = _invert_dict(CachingMode_names)

Representation_names = _to_dict(_ERepresentation)
Representation_values = _invert_dict(Representation_names)

Endianess_names = _to_dict(_EEndianess)
Endianess_values = _invert_dict(Endianess_names)

NameSpace_names = _to_dict(_ENameSpace)
NameSpace_values = _invert_dict(NameSpace_names)

StandardNameSpace_names = _to_dict(_EStandardNameSpace)
StandardNameSpace_values = _invert_dict(StandardNameSpace_names)

YesNo_names = _to_dict(_EYesNo)
YesNo_values = _invert_dict(YesNo_names)

Slope_names = _to_dict(_ESlope)
Slope_values = _invert_dict(Slope_names)

XMLValidation_names = _remove_prefix('xv', _EXMLValidation)
XMLValidation_values = _invert_dict(XMLValidation_names)

DisplayNotation_names = _remove_prefix('fn', _EDisplayNotation)
DisplayNotation_values = _invert_dict(DisplayNotation_names)

InterfaceType_names = _remove_prefix('intfI', _EInterfaceType)
InterfaceType_values = _invert_dict(InterfaceType_names)

LinkType_names = _remove_prefix('ct', _ELinkType)
LinkType_values = _invert_dict(LinkType_names)

IncMode_names = _to_dict(_EIncMode)
IncMode_values = _invert_dict(IncMode_names)

InputDirection_names = _remove_prefix('id', _EInputDirection)
InputDirection_values = _invert_dict(InputDirection_names)

GenApiSchemaVersion_names = _to_dict(_EGenApiSchemaVersion)
GenApiSchemaVersion_values = _invert_dict(GenApiSchemaVersion_names)

# ----------------------------------------------------------------

LUTSelector_names = _split_name(1, LUTSelectorEnums)
LUTSelector_values = _invert_dict(LUTSelector_names)

ExposureMode_names = _split_name(1, ExposureModeEnums)
ExposureMode_values = _invert_dict(ExposureMode_names)

AcquisitionMode_names = _split_name(1, AcquisitionModeEnums)
AcquisitionMode_values = _invert_dict(AcquisitionMode_names)

TriggerSource_names = _split_name(1, TriggerSourceEnums)
TriggerSource_values = _invert_dict(TriggerSource_names)

TriggerActivation_names = _split_name(1, TriggerActivationEnums)
TriggerActivation_values = _invert_dict(TriggerActivation_names)

SensorShutterMode_names = _split_name(1, SensorShutterModeEnums)
SensorShutterMode_values = _invert_dict(SensorShutterMode_names)

TriggerMode_names = _split_name(1, TriggerModeEnums)
TriggerMode_values = _invert_dict(TriggerMode_names)

TriggerOverlap_names = _split_name(1, TriggerOverlapEnums)
TriggerOverlap_values = _invert_dict(TriggerOverlap_names)

TriggerSelector_names = _split_name(1, TriggerSelectorEnums)
TriggerSelector_values = _invert_dict(TriggerSelector_names)

ExposureAuto_names = _split_name(1, ExposureAutoEnums)
ExposureAuto_values = _invert_dict(ExposureAuto_names)

EventSelector_names = _split_name(1, EventSelectorEnums)
EventSelector_values = _invert_dict(EventSelector_names)

EventNotification_names = _split_name(1, EventNotificationEnums)
EventNotification_values = _invert_dict(EventNotification_names)

LogicBlockSelector_names = _split_name(1, LogicBlockSelectorEnums)
LogicBlockSelector_values = _invert_dict(LogicBlockSelector_names)

LogicBlockLUTInputActivation_names = _split_name(1, LogicBlockLUTInputActivationEnums)
LogicBlockLUTInputActivation_values = _invert_dict(LogicBlockLUTInputActivation_names)

LogicBlockLUTInputSelector_names = _split_name(1, LogicBlockLUTInputSelectorEnums)
LogicBlockLUTInputSelector_values = _invert_dict(LogicBlockLUTInputSelector_names)

LogicBlockLUTInputSource_names = _split_name(1, LogicBlockLUTInputSourceEnums)
LogicBlockLUTInputSource_values = _invert_dict(LogicBlockLUTInputSource_names)

LogicBlockLUTSelector_names = _split_name(1, LogicBlockLUTSelectorEnums)
LogicBlockLUTSelector_values = _invert_dict(LogicBlockLUTSelector_names)

ColorTransformationSelector_names = _split_name(1, ColorTransformationSelectorEnums)
ColorTransformationSelector_values = _invert_dict(ColorTransformationSelector_names)

RgbTransformLightSource_names = _split_name(1, RgbTransformLightSourceEnums)
RgbTransformLightSource_values = _invert_dict(RgbTransformLightSource_names)

ColorTransformationValueSelector_names = _split_name(1, ColorTransformationValueSelectorEnums)
ColorTransformationValueSelector_values = _invert_dict(ColorTransformationValueSelector_names)

DeviceRegistersEndianness_names = _split_name(1, DeviceRegistersEndiannessEnums)
DeviceRegistersEndianness_values = _invert_dict(DeviceRegistersEndianness_names)

DeviceScanType_names = _split_name(1, DeviceScanTypeEnums)
DeviceScanType_values = _invert_dict(DeviceScanType_names)

DeviceCharacterSet_names = _split_name(1, DeviceCharacterSetEnums)
DeviceCharacterSet_values = _invert_dict(DeviceCharacterSet_names)

DeviceTLType_names = _split_name(1, DeviceTLTypeEnums)
DeviceTLType_values = _invert_dict(DeviceTLType_names)

DevicePowerSupplySelector_names = _split_name(1, DevicePowerSupplySelectorEnums)
DevicePowerSupplySelector_values = _invert_dict(DevicePowerSupplySelector_names)

DeviceTemperatureSelector_names = _split_name(1, DeviceTemperatureSelectorEnums)
DeviceTemperatureSelector_values = _invert_dict(DeviceTemperatureSelector_names)

DeviceIndicatorMode_names = _split_name(1, DeviceIndicatorModeEnums)
DeviceIndicatorMode_values = _invert_dict(DeviceIndicatorMode_names)

AutoExposureControlPriority_names = _split_name(1, AutoExposureControlPriorityEnums)
AutoExposureControlPriority_values = _invert_dict(AutoExposureControlPriority_names)

AutoExposureMeteringMode_names = _split_name(1, AutoExposureMeteringModeEnums)
AutoExposureMeteringMode_values = _invert_dict(AutoExposureMeteringMode_names)

BalanceWhiteAutoProfile_names = _split_name(1, BalanceWhiteAutoProfileEnums)
BalanceWhiteAutoProfile_values = _invert_dict(BalanceWhiteAutoProfile_names)

AutoAlgorithmSelector_names = _split_name(1, AutoAlgorithmSelectorEnums)
AutoAlgorithmSelector_values = _invert_dict(AutoAlgorithmSelector_names)

AutoExposureTargetGreyValueAuto_names = _split_name(1, AutoExposureTargetGreyValueAutoEnums)
AutoExposureTargetGreyValueAuto_values = _invert_dict(AutoExposureTargetGreyValueAuto_names)

AutoExposureLightingMode_names = _split_name(1, AutoExposureLightingModeEnums)
AutoExposureLightingMode_values = _invert_dict(AutoExposureLightingMode_names)

GevIEEE1588Status_names = _split_name(1, GevIEEE1588StatusEnums)
GevIEEE1588Status_values = _invert_dict(GevIEEE1588Status_names)

GevIEEE1588Mode_names = _split_name(1, GevIEEE1588ModeEnums)
GevIEEE1588Mode_values = _invert_dict(GevIEEE1588Mode_names)

GevIEEE1588ClockAccuracy_names = _split_name(1, GevIEEE1588ClockAccuracyEnums)
GevIEEE1588ClockAccuracy_values = _invert_dict(GevIEEE1588ClockAccuracy_names)

GevCCP_names = _split_name(1, GevCCPEnums)
GevCCP_values = _invert_dict(GevCCP_names)

GevSupportedOptionSelector_names = _split_name(1, GevSupportedOptionSelectorEnums)
GevSupportedOptionSelector_values = _invert_dict(GevSupportedOptionSelector_names)

BlackLevelSelector_names = _split_name(1, BlackLevelSelectorEnums)
BlackLevelSelector_values = _invert_dict(BlackLevelSelector_names)

BalanceWhiteAuto_names = _split_name(1, BalanceWhiteAutoEnums)
BalanceWhiteAuto_values = _invert_dict(BalanceWhiteAuto_names)

GainAuto_names = _split_name(1, GainAutoEnums)
GainAuto_values = _invert_dict(GainAuto_names)

BalanceRatioSelector_names = _split_name(1, BalanceRatioSelectorEnums)
BalanceRatioSelector_values = _invert_dict(BalanceRatioSelector_names)

GainSelector_names = _split_name(1, GainSelectorEnums)
GainSelector_values = _invert_dict(GainSelector_names)

DefectCorrectionMode_names = _split_name(1, DefectCorrectionModeEnums)
DefectCorrectionMode_values = _invert_dict(DefectCorrectionMode_names)

UserSetSelector_names = _split_name(1, UserSetSelectorEnums)
UserSetSelector_values = _invert_dict(UserSetSelector_names)

UserSetDefault_names = _split_name(1, UserSetDefaultEnums)
UserSetDefault_values = _invert_dict(UserSetDefault_names)

SerialPortBaudRate_names = _split_name(1, SerialPortBaudRateEnums)
SerialPortBaudRate_values = _invert_dict(SerialPortBaudRate_names)

SerialPortParity_names = _split_name(1, SerialPortParityEnums)
SerialPortParity_values = _invert_dict(SerialPortParity_names)

SerialPortSelector_names = _split_name(1, SerialPortSelectorEnums)
SerialPortSelector_values = _invert_dict(SerialPortSelector_names)

SerialPortStopBits_names = _split_name(1, SerialPortStopBitsEnums)
SerialPortStopBits_values = _invert_dict(SerialPortStopBits_names)

SerialPortSource_names = _split_name(1, SerialPortSourceEnums)
SerialPortSource_values = _invert_dict(SerialPortSource_names)

SequencerMode_names = _split_name(1, SequencerModeEnums)
SequencerMode_values = _invert_dict(SequencerMode_names)

SequencerConfigurationValid_names = _split_name(1, SequencerConfigurationValidEnums)
SequencerConfigurationValid_values = _invert_dict(SequencerConfigurationValid_names)

SequencerSetValid_names = _split_name(1, SequencerSetValidEnums)
SequencerSetValid_values = _invert_dict(SequencerSetValid_names)

SequencerTriggerActivation_names = _split_name(1, SequencerTriggerActivationEnums)
SequencerTriggerActivation_values = _invert_dict(SequencerTriggerActivation_names)

SequencerConfigurationMode_names = _split_name(1, SequencerConfigurationModeEnums)
SequencerConfigurationMode_values = _invert_dict(SequencerConfigurationMode_names)

SequencerTriggerSource_names = _split_name(1, SequencerTriggerSourceEnums)
SequencerTriggerSource_values = _invert_dict(SequencerTriggerSource_names)

TransferQueueMode_names = _split_name(1, TransferQueueModeEnums)
TransferQueueMode_values = _invert_dict(TransferQueueMode_names)

TransferOperationMode_names = _split_name(1, TransferOperationModeEnums)
TransferOperationMode_values = _invert_dict(TransferOperationMode_names)

TransferControlMode_names = _split_name(1, TransferControlModeEnums)
TransferControlMode_values = _invert_dict(TransferControlMode_names)

ChunkGainSelector_names = _split_name(1, ChunkGainSelectorEnums)
ChunkGainSelector_values = _invert_dict(ChunkGainSelector_names)

ChunkSelector_names = _split_name(1, ChunkSelectorEnums)
ChunkSelector_values = _invert_dict(ChunkSelector_names)

ChunkBlackLevelSelector_names = _split_name(1, ChunkBlackLevelSelectorEnums)
ChunkBlackLevelSelector_values = _invert_dict(ChunkBlackLevelSelector_names)

ChunkPixelFormat_names = _split_name(1, ChunkPixelFormatEnums)
ChunkPixelFormat_values = _invert_dict(ChunkPixelFormat_names)

FileOperationStatus_names = _split_name(1, FileOperationStatusEnums)
FileOperationStatus_values = _invert_dict(FileOperationStatus_names)

FileOpenMode_names = _split_name(1, FileOpenModeEnums)
FileOpenMode_values = _invert_dict(FileOpenMode_names)

FileOperationSelector_names = _split_name(1, FileOperationSelectorEnums)
FileOperationSelector_values = _invert_dict(FileOperationSelector_names)

FileSelector_names = _split_name(1, FileSelectorEnums)
FileSelector_values = _invert_dict(FileSelector_names)

BinningSelector_names = _split_name(1, BinningSelectorEnums)
BinningSelector_values = _invert_dict(BinningSelector_names)

TestPatternGeneratorSelector_names = _split_name(1, TestPatternGeneratorSelectorEnums)
TestPatternGeneratorSelector_values = _invert_dict(TestPatternGeneratorSelector_names)

CompressionSaturationPriority_names = _split_name(1, CompressionSaturationPriorityEnums)
CompressionSaturationPriority_values = _invert_dict(CompressionSaturationPriority_names)

TestPattern_names = _split_name(1, TestPatternEnums)
TestPattern_values = _invert_dict(TestPattern_names)

PixelColorFilter_names = _split_name(1, PixelColorFilterEnums)
PixelColorFilter_values = _invert_dict(PixelColorFilter_names)

AdcBitDepth_names = _split_name(1, AdcBitDepthEnums)
AdcBitDepth_values = _invert_dict(AdcBitDepth_names)

DecimationHorizontalMode_names = _split_name(1, DecimationHorizontalModeEnums)
DecimationHorizontalMode_values = _invert_dict(DecimationHorizontalMode_names)

BinningVerticalMode_names = _split_name(1, BinningVerticalModeEnums)
BinningVerticalMode_values = _invert_dict(BinningVerticalMode_names)

PixelSize_names = _split_name(1, PixelSizeEnums)
PixelSize_values = _invert_dict(PixelSize_names)

DecimationSelector_names = _split_name(1, DecimationSelectorEnums)
DecimationSelector_values = _invert_dict(DecimationSelector_names)

ImageCompressionMode_names = _split_name(1, ImageCompressionModeEnums)
ImageCompressionMode_values = _invert_dict(ImageCompressionMode_names)

BinningHorizontalMode_names = _split_name(1, BinningHorizontalModeEnums)
BinningHorizontalMode_values = _invert_dict(BinningHorizontalMode_names)

PixelFormat_names = _split_name(1, PixelFormatEnums)
PixelFormat_values = _invert_dict(PixelFormat_names)

DecimationVerticalMode_names = _split_name(1, DecimationVerticalModeEnums)
DecimationVerticalMode_values = _invert_dict(DecimationVerticalMode_names)

LineMode_names = _split_name(1, LineModeEnums)
LineMode_values = _invert_dict(LineMode_names)

LineSource_names = _split_name(1, LineSourceEnums)
LineSource_values = _invert_dict(LineSource_names)

LineInputFilterSelector_names = _split_name(1, LineInputFilterSelectorEnums)
LineInputFilterSelector_values = _invert_dict(LineInputFilterSelector_names)

UserOutputSelector_names = _split_name(1, UserOutputSelectorEnums)
UserOutputSelector_values = _invert_dict(UserOutputSelector_names)

LineFormat_names = _split_name(1, LineFormatEnums)
LineFormat_values = _invert_dict(LineFormat_names)

LineSelector_names = _split_name(1, LineSelectorEnums)
LineSelector_values = _invert_dict(LineSelector_names)

ExposureActiveMode_names = _split_name(1, ExposureActiveModeEnums)
ExposureActiveMode_values = _invert_dict(ExposureActiveMode_names)

CounterTriggerActivation_names = _split_name(1, CounterTriggerActivationEnums)
CounterTriggerActivation_values = _invert_dict(CounterTriggerActivation_names)

CounterSelector_names = _split_name(1, CounterSelectorEnums)
CounterSelector_values = _invert_dict(CounterSelector_names)

CounterStatus_names = _split_name(1, CounterStatusEnums)
CounterStatus_values = _invert_dict(CounterStatus_names)

CounterTriggerSource_names = _split_name(1, CounterTriggerSourceEnums)
CounterTriggerSource_values = _invert_dict(CounterTriggerSource_names)

CounterResetSource_names = _split_name(1, CounterResetSourceEnums)
CounterResetSource_values = _invert_dict(CounterResetSource_names)

CounterEventSource_names = _split_name(1, CounterEventSourceEnums)
CounterEventSource_values = _invert_dict(CounterEventSource_names)

CounterEventActivation_names = _split_name(1, CounterEventActivationEnums)
CounterEventActivation_values = _invert_dict(CounterEventActivation_names)

CounterResetActivation_names = _split_name(1, CounterResetActivationEnums)
CounterResetActivation_values = _invert_dict(CounterResetActivation_names)

DeviceType_names = _split_name(1, DeviceTypeEnums)
DeviceType_values = _invert_dict(DeviceType_names)

DeviceConnectionStatus_names = _split_name(1, DeviceConnectionStatusEnums)
DeviceConnectionStatus_values = _invert_dict(DeviceConnectionStatus_names)

DeviceLinkThroughputLimitMode_names = _split_name(1, DeviceLinkThroughputLimitModeEnums)
DeviceLinkThroughputLimitMode_values = _invert_dict(DeviceLinkThroughputLimitMode_names)

DeviceLinkHeartbeatMode_names = _split_name(1, DeviceLinkHeartbeatModeEnums)
DeviceLinkHeartbeatMode_values = _invert_dict(DeviceLinkHeartbeatMode_names)

DeviceStreamChannelType_names = _split_name(1, DeviceStreamChannelTypeEnums)
DeviceStreamChannelType_values = _invert_dict(DeviceStreamChannelType_names)

DeviceStreamChannelEndianness_names = _split_name(1, DeviceStreamChannelEndiannessEnums)
DeviceStreamChannelEndianness_values = _invert_dict(DeviceStreamChannelEndianness_names)

DeviceClockSelector_names = _split_name(1, DeviceClockSelectorEnums)
DeviceClockSelector_values = _invert_dict(DeviceClockSelector_names)

DeviceSerialPortSelector_names = _split_name(1, DeviceSerialPortSelectorEnums)
DeviceSerialPortSelector_values = _invert_dict(DeviceSerialPortSelector_names)

DeviceSerialPortBaudRate_names = _split_name(1, DeviceSerialPortBaudRateEnums)
DeviceSerialPortBaudRate_values = _invert_dict(DeviceSerialPortBaudRate_names)

SensorTaps_names = _split_name(1, SensorTapsEnums)
SensorTaps_values = _invert_dict(SensorTaps_names)

SensorDigitizationTaps_names = _split_name(1, SensorDigitizationTapsEnums)
SensorDigitizationTaps_values = _invert_dict(SensorDigitizationTaps_names)

RegionSelector_names = _split_name(1, RegionSelectorEnums)
RegionSelector_values = _invert_dict(RegionSelector_names)

RegionMode_names = _split_name(1, RegionModeEnums)
RegionMode_values = _invert_dict(RegionMode_names)

RegionDestination_names = _split_name(1, RegionDestinationEnums)
RegionDestination_values = _invert_dict(RegionDestination_names)

ImageComponentSelector_names = _split_name(1, ImageComponentSelectorEnums)
ImageComponentSelector_values = _invert_dict(ImageComponentSelector_names)

PixelFormatInfoSelector_names = _split_name(1, PixelFormatInfoSelectorEnums)
PixelFormatInfoSelector_values = _invert_dict(PixelFormatInfoSelector_names)

Deinterlacing_names = _split_name(1, DeinterlacingEnums)
Deinterlacing_values = _invert_dict(Deinterlacing_names)

ImageCompressionRateOption_names = _split_name(1, ImageCompressionRateOptionEnums)
ImageCompressionRateOption_values = _invert_dict(ImageCompressionRateOption_names)

ImageCompressionJPEGFormatOption_names = _split_name(1, ImageCompressionJPEGFormatOptionEnums)
ImageCompressionJPEGFormatOption_values = _invert_dict(ImageCompressionJPEGFormatOption_names)

AcquisitionStatusSelector_names = _split_name(1, AcquisitionStatusSelectorEnums)
AcquisitionStatusSelector_values = _invert_dict(AcquisitionStatusSelector_names)

ExposureTimeMode_names = _split_name(1, ExposureTimeModeEnums)
ExposureTimeMode_values = _invert_dict(ExposureTimeMode_names)

ExposureTimeSelector_names = _split_name(1, ExposureTimeSelectorEnums)
ExposureTimeSelector_values = _invert_dict(ExposureTimeSelector_names)

GainAutoBalance_names = _split_name(1, GainAutoBalanceEnums)
GainAutoBalance_values = _invert_dict(GainAutoBalance_names)

BlackLevelAuto_names = _split_name(1, BlackLevelAutoEnums)
BlackLevelAuto_values = _invert_dict(BlackLevelAuto_names)

BlackLevelAutoBalance_names = _split_name(1, BlackLevelAutoBalanceEnums)
BlackLevelAutoBalance_values = _invert_dict(BlackLevelAutoBalance_names)

WhiteClipSelector_names = _split_name(1, WhiteClipSelectorEnums)
WhiteClipSelector_values = _invert_dict(WhiteClipSelector_names)

TimerSelector_names = _split_name(1, TimerSelectorEnums)
TimerSelector_values = _invert_dict(TimerSelector_names)

TimerStatus_names = _split_name(1, TimerStatusEnums)
TimerStatus_values = _invert_dict(TimerStatus_names)

TimerTriggerSource_names = _split_name(1, TimerTriggerSourceEnums)
TimerTriggerSource_values = _invert_dict(TimerTriggerSource_names)

TimerTriggerActivation_names = _split_name(1, TimerTriggerActivationEnums)
TimerTriggerActivation_values = _invert_dict(TimerTriggerActivation_names)

EncoderSelector_names = _split_name(1, EncoderSelectorEnums)
EncoderSelector_values = _invert_dict(EncoderSelector_names)

EncoderSourceA_names = _split_name(1, EncoderSourceAEnums)
EncoderSourceA_values = _invert_dict(EncoderSourceA_names)

EncoderSourceB_names = _split_name(1, EncoderSourceBEnums)
EncoderSourceB_values = _invert_dict(EncoderSourceB_names)

EncoderMode_names = _split_name(1, EncoderModeEnums)
EncoderMode_values = _invert_dict(EncoderMode_names)

EncoderOutputMode_names = _split_name(1, EncoderOutputModeEnums)
EncoderOutputMode_values = _invert_dict(EncoderOutputMode_names)

EncoderStatus_names = _split_name(1, EncoderStatusEnums)
EncoderStatus_values = _invert_dict(EncoderStatus_names)

EncoderResetSource_names = _split_name(1, EncoderResetSourceEnums)
EncoderResetSource_values = _invert_dict(EncoderResetSource_names)

EncoderResetActivation_names = _split_name(1, EncoderResetActivationEnums)
EncoderResetActivation_values = _invert_dict(EncoderResetActivation_names)

SoftwareSignalSelector_names = _split_name(1, SoftwareSignalSelectorEnums)
SoftwareSignalSelector_values = _invert_dict(SoftwareSignalSelector_names)

ActionUnconditionalMode_names = _split_name(1, ActionUnconditionalModeEnums)
ActionUnconditionalMode_values = _invert_dict(ActionUnconditionalMode_names)

SourceSelector_names = _split_name(1, SourceSelectorEnums)
SourceSelector_values = _invert_dict(SourceSelector_names)

TransferSelector_names = _split_name(1, TransferSelectorEnums)
TransferSelector_values = _invert_dict(TransferSelector_names)

TransferTriggerSelector_names = _split_name(1, TransferTriggerSelectorEnums)
TransferTriggerSelector_values = _invert_dict(TransferTriggerSelector_names)

TransferTriggerMode_names = _split_name(1, TransferTriggerModeEnums)
TransferTriggerMode_values = _invert_dict(TransferTriggerMode_names)

TransferTriggerSource_names = _split_name(1, TransferTriggerSourceEnums)
TransferTriggerSource_values = _invert_dict(TransferTriggerSource_names)

TransferTriggerActivation_names = _split_name(1, TransferTriggerActivationEnums)
TransferTriggerActivation_values = _invert_dict(TransferTriggerActivation_names)

TransferStatusSelector_names = _split_name(1, TransferStatusSelectorEnums)
TransferStatusSelector_values = _invert_dict(TransferStatusSelector_names)

TransferComponentSelector_names = _split_name(1, TransferComponentSelectorEnums)
TransferComponentSelector_values = _invert_dict(TransferComponentSelector_names)

Scan3dDistanceUnit_names = _split_name(1, Scan3dDistanceUnitEnums)
Scan3dDistanceUnit_values = _invert_dict(Scan3dDistanceUnit_names)

Scan3dCoordinateSystem_names = _split_name(1, Scan3dCoordinateSystemEnums)
Scan3dCoordinateSystem_values = _invert_dict(Scan3dCoordinateSystem_names)

Scan3dOutputMode_names = _split_name(1, Scan3dOutputModeEnums)
Scan3dOutputMode_values = _invert_dict(Scan3dOutputMode_names)

Scan3dCoordinateSystemReference_names = _split_name(1, Scan3dCoordinateSystemReferenceEnums)
Scan3dCoordinateSystemReference_values = _invert_dict(Scan3dCoordinateSystemReference_names)

Scan3dCoordinateSelector_names = _split_name(1, Scan3dCoordinateSelectorEnums)
Scan3dCoordinateSelector_values = _invert_dict(Scan3dCoordinateSelector_names)

Scan3dCoordinateTransformSelector_names = _split_name(1, Scan3dCoordinateTransformSelectorEnums)
Scan3dCoordinateTransformSelector_values = _invert_dict(Scan3dCoordinateTransformSelector_names)

Scan3dCoordinateReferenceSelector_names = _split_name(1, Scan3dCoordinateReferenceSelectorEnums)
Scan3dCoordinateReferenceSelector_values = _invert_dict(Scan3dCoordinateReferenceSelector_names)

ChunkImageComponent_names = _split_name(1, ChunkImageComponentEnums)
ChunkImageComponent_values = _invert_dict(ChunkImageComponent_names)

ChunkCounterSelector_names = _split_name(1, ChunkCounterSelectorEnums)
ChunkCounterSelector_values = _invert_dict(ChunkCounterSelector_names)

ChunkTimerSelector_names = _split_name(1, ChunkTimerSelectorEnums)
ChunkTimerSelector_values = _invert_dict(ChunkTimerSelector_names)

ChunkEncoderSelector_names = _split_name(1, ChunkEncoderSelectorEnums)
ChunkEncoderSelector_values = _invert_dict(ChunkEncoderSelector_names)

ChunkEncoderStatus_names = _split_name(1, ChunkEncoderStatusEnums)
ChunkEncoderStatus_values = _invert_dict(ChunkEncoderStatus_names)

ChunkExposureTimeSelector_names = _split_name(1, ChunkExposureTimeSelectorEnums)
ChunkExposureTimeSelector_values = _invert_dict(ChunkExposureTimeSelector_names)

ChunkSourceID_names = _split_name(1, ChunkSourceIDEnums)
ChunkSourceID_values = _invert_dict(ChunkSourceID_names)

ChunkRegionID_names = _split_name(1, ChunkRegionIDEnums)
ChunkRegionID_values = _invert_dict(ChunkRegionID_names)

ChunkTransferStreamID_names = _split_name(1, ChunkTransferStreamIDEnums)
ChunkTransferStreamID_values = _invert_dict(ChunkTransferStreamID_names)

ChunkScan3dDistanceUnit_names = _split_name(1, ChunkScan3dDistanceUnitEnums)
ChunkScan3dDistanceUnit_values = _invert_dict(ChunkScan3dDistanceUnit_names)

ChunkScan3dOutputMode_names = _split_name(1, ChunkScan3dOutputModeEnums)
ChunkScan3dOutputMode_values = _invert_dict(ChunkScan3dOutputMode_names)

ChunkScan3dCoordinateSystem_names = _split_name(1, ChunkScan3dCoordinateSystemEnums)
ChunkScan3dCoordinateSystem_values = _invert_dict(ChunkScan3dCoordinateSystem_names)

ChunkScan3dCoordinateSystemReference_names = _split_name(1, ChunkScan3dCoordinateSystemReferenceEnums)
ChunkScan3dCoordinateSystemReference_values = _invert_dict(ChunkScan3dCoordinateSystemReference_names)

ChunkScan3dCoordinateSelector_names = _split_name(1, ChunkScan3dCoordinateSelectorEnums)
ChunkScan3dCoordinateSelector_values = _invert_dict(ChunkScan3dCoordinateSelector_names)

ChunkScan3dCoordinateTransformSelector_names = _split_name(1, ChunkScan3dCoordinateTransformSelectorEnums)
ChunkScan3dCoordinateTransformSelector_values = _invert_dict(ChunkScan3dCoordinateTransformSelector_names)

ChunkScan3dCoordinateReferenceSelector_names = _split_name(1, ChunkScan3dCoordinateReferenceSelectorEnums)
ChunkScan3dCoordinateReferenceSelector_values = _invert_dict(ChunkScan3dCoordinateReferenceSelector_names)

DeviceTapGeometry_names = _split_name(1, DeviceTapGeometryEnums)
DeviceTapGeometry_values = _invert_dict(DeviceTapGeometry_names)

GevPhysicalLinkConfiguration_names = _split_name(1, GevPhysicalLinkConfigurationEnums)
GevPhysicalLinkConfiguration_values = _invert_dict(GevPhysicalLinkConfiguration_names)

GevCurrentPhysicalLinkConfiguration_names = _split_name(1, GevCurrentPhysicalLinkConfigurationEnums)
GevCurrentPhysicalLinkConfiguration_values = _invert_dict(GevCurrentPhysicalLinkConfiguration_names)

GevIPConfigurationStatus_names = _split_name(1, GevIPConfigurationStatusEnums)
GevIPConfigurationStatus_values = _invert_dict(GevIPConfigurationStatus_names)

GevGVCPExtendedStatusCodesSelector_names = _split_name(1, GevGVCPExtendedStatusCodesSelectorEnums)
GevGVCPExtendedStatusCodesSelector_values = _invert_dict(GevGVCPExtendedStatusCodesSelector_names)

GevGVSPExtendedIDMode_names = _split_name(1, GevGVSPExtendedIDModeEnums)
GevGVSPExtendedIDMode_values = _invert_dict(GevGVSPExtendedIDMode_names)

ClConfiguration_names = _split_name(1, ClConfigurationEnums)
ClConfiguration_values = _invert_dict(ClConfiguration_names)

ClTimeSlotsCount_names = _split_name(1, ClTimeSlotsCountEnums)
ClTimeSlotsCount_values = _invert_dict(ClTimeSlotsCount_names)

CxpLinkConfigurationStatus_names = _split_name(1, CxpLinkConfigurationStatusEnums)
CxpLinkConfigurationStatus_values = _invert_dict(CxpLinkConfigurationStatus_names)

CxpLinkConfigurationPreferred_names = _split_name(1, CxpLinkConfigurationPreferredEnums)
CxpLinkConfigurationPreferred_values = _invert_dict(CxpLinkConfigurationPreferred_names)

CxpLinkConfiguration_names = _split_name(1, CxpLinkConfigurationEnums)
CxpLinkConfiguration_values = _invert_dict(CxpLinkConfiguration_names)

CxpConnectionTestMode_names = _split_name(1, CxpConnectionTestModeEnums)
CxpConnectionTestMode_values = _invert_dict(CxpConnectionTestMode_names)

CxpPoCxpStatus_names = _split_name(1, CxpPoCxpStatusEnums)
CxpPoCxpStatus_values = _invert_dict(CxpPoCxpStatus_names)
