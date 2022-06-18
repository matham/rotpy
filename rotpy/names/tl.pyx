"""Transport layer enums
========================

Provides access to all the transport-layer-related enums.
"""
import rotpy._interface
from ..names import _split_name, _invert_dict

__all__ = (
    'StreamType_names', 'StreamType_values',
    'StreamMode_names', 'StreamMode_values', 'StreamBufferCountMode_names',
    'StreamBufferCountMode_values', 'StreamBufferHandlingMode_names',
    'StreamBufferHandlingMode_values', 'DeviceType_names', 'DeviceType_values',
    'DeviceAccessStatus_names', 'DeviceAccessStatus_values', 'GevCCP_tl_names',
    'GevCCP_tl_values', 'GUIXMLLocation_names', 'GUIXMLLocation_values',
    'GenICamXMLLocation_names', 'GenICamXMLLocation_values',
    'DeviceEndianessMechanism_names', 'DeviceEndianessMechanism_values',
    'DeviceCurrentSpeed_names', 'DeviceCurrentSpeed_values',
    'InterfaceType_names', 'InterfaceType_values', 'POEStatus_names',
    'POEStatus_values', 'FilterDriverStatus_names', 'FilterDriverStatus_values',
    'TLType_names', 'TLType_values',
)


StreamType_names = _split_name(1, rotpy._interface.StreamTypeEnum)
StreamType_values = _invert_dict(StreamType_names)

StreamMode_names = _split_name(1, rotpy._interface.StreamModeEnum)
StreamMode_values = _invert_dict(StreamMode_names)

StreamBufferCountMode_names = _split_name(
    1, rotpy._interface.StreamBufferCountModeEnum)
StreamBufferCountMode_values = _invert_dict(StreamBufferCountMode_names)

StreamBufferHandlingMode_names = _split_name(
    1, rotpy._interface.StreamBufferHandlingModeEnum)
StreamBufferHandlingMode_values = _invert_dict(StreamBufferHandlingMode_names)

DeviceType_names = _split_name(1, rotpy._interface.DeviceTypeEnum)
DeviceType_values = _invert_dict(DeviceType_names)

DeviceAccessStatus_names = _split_name(
    1, rotpy._interface.DeviceAccessStatusEnum)
DeviceAccessStatus_values = _invert_dict(DeviceAccessStatus_names)

GevCCP_tl_names = _split_name(3, rotpy._interface.GevCCPEnum)
GevCCP_tl_values = _invert_dict(GevCCP_tl_names)

GUIXMLLocation_names = _split_name(1, rotpy._interface.GUIXMLLocationEnum)
GUIXMLLocation_values = _invert_dict(GUIXMLLocation_names)

GenICamXMLLocation_names = _split_name(
    1, rotpy._interface.GenICamXMLLocationEnum)
GenICamXMLLocation_values = _invert_dict(GenICamXMLLocation_names)

DeviceEndianessMechanism_names = _split_name(
    1, rotpy._interface.DeviceEndianessMechanismEnum)
DeviceEndianessMechanism_values = _invert_dict(DeviceEndianessMechanism_names)

DeviceCurrentSpeed_names = _split_name(
    1, rotpy._interface.DeviceCurrentSpeedEnum)
DeviceCurrentSpeed_values = _invert_dict(DeviceCurrentSpeed_names)

InterfaceType_names = _split_name(1, rotpy._interface.InterfaceTypeEnum)
InterfaceType_values = _invert_dict(InterfaceType_names)

POEStatus_names = _split_name(1, rotpy._interface.POEStatusEnum)
POEStatus_values = _invert_dict(POEStatus_names)

FilterDriverStatus_names = _split_name(
    1, rotpy._interface.FilterDriverStatusEnum)
FilterDriverStatus_values = _invert_dict(FilterDriverStatus_names)

TLType_names = _split_name(1, rotpy._interface.TLTypeEnum)
TLType_values = _invert_dict(TLType_names)
