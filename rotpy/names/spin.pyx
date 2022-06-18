"""Spinnaker enums
=================

Provides access to all the basic Spinnaker enums.
"""
import rotpy._interface
from ..names import _split_name, _lower_names, _invert_dict

__all__ = (
    'error_code_names', 'error_code_values', 'event_names', 'event_values',
    'pix_fmt_namespace_names', 'pix_fmt_namespace_values',
    'color_processing_algo_names', 'color_processing_algo_values',
    'img_file_fmt_names', 'img_file_fmt_values', 'img_status_names',
    'img_status_values', 'compression_names', 'compression_values',
    'stats_channel_names', 'stats_channel_values', 'log_level_names',
    'log_level_values', 'payload_type_names', 'payload_type_values',
    'cmd_status_names', 'cmd_status_values', 'pix_fmt_int_names',
    'pix_fmt_int_values', 'buffer_owner_names', 'buffer_owner_values',
    'img_correction_temp_names', 'img_correction_temp_values',
    'img_correction_type_names', 'img_correction_type_values',
    'img_correction_sensor_names', 'img_correction_sensor_values',
    'img_correction_space_names', 'img_correction_space_values',
    'img_correction_app_names', 'img_correction_app_values',
)


error_code_names = _split_name(2, rotpy._interface.Error, lower=True)
error_code_values = _invert_dict(error_code_names)

event_names = _split_name(2, rotpy._interface.EventType, lower=True)
event_values = _invert_dict(event_names)

pix_fmt_namespace_names = _split_name(
    3, rotpy._interface.PixelFormatNamespaceID, lower=True)
pix_fmt_namespace_values = _invert_dict(pix_fmt_namespace_names)

color_processing_algo_names = _lower_names(
    rotpy._interface.ColorProcessingAlgorithm)
color_processing_algo_values = _invert_dict(color_processing_algo_names)

img_file_fmt_names = _lower_names(rotpy._interface.ImageFileFormat)
img_file_fmt_values = _invert_dict(img_file_fmt_names)

img_status_names = _split_name(1, rotpy._interface.ImageStatus, lower=True)
img_status_values = _invert_dict(img_status_names)

compression_names = _lower_names(rotpy._interface.CompressionMethod)
compression_values = _invert_dict(compression_names)

stats_channel_names = _lower_names(rotpy._interface.StatisticsChannel)
stats_channel_values = _invert_dict(stats_channel_names)

log_level_names = _split_name(2, rotpy._interface.SpinnakerLogLevel, lower=True)
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

payload_type_names = _split_name(
    2, rotpy._interface.PayloadTypeInfoIDs, lower=True)
payload_type_values = _invert_dict(payload_type_names)

cmd_status_names = _split_name(
    3, rotpy._interface.ActionCommandStatus, lower=True)
cmd_status_values = _invert_dict(cmd_status_names)

pix_fmt_int_names = _split_name(
    1, rotpy._interface.PixelFormatIntType, lower=True)
pix_fmt_int_values = _invert_dict(pix_fmt_int_names)

buffer_owner_names = _split_name(
    2, rotpy._interface.BufferOwnership, lower=True)
buffer_owner_values = _invert_dict(buffer_owner_names)

img_correction_temp_names = _lower_names(rotpy._interface.CCMColorTemperature)
img_correction_temp_values = _invert_dict(img_correction_temp_names)

img_correction_type_names = _lower_names(rotpy._interface.CCMType)
img_correction_type_values = _invert_dict(img_correction_type_names)

img_correction_sensor_names = _lower_names(rotpy._interface.CCMSensor)
img_correction_sensor_values = _invert_dict(img_correction_sensor_names)

img_correction_space_names = _lower_names(rotpy._interface.CCMColorSpace)
img_correction_space_values = _invert_dict(img_correction_space_names)

img_correction_app_names = _split_name(
    2, rotpy._interface.CCMApplication, lower=True)
img_correction_app_values = _invert_dict(img_correction_app_names)
