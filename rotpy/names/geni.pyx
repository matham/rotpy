"""GenAPI enums
===============

Provides access to all the GenAPI-related enums.
"""
from rotpy._interface import _ESign, _EAccessMode, _EVisibility, _ECachingMode,\
    _ERepresentation, \
    _EEndianess, _ENameSpace, _EStandardNameSpace, _EYesNo, _ESlope, \
    _EXMLValidation, _EDisplayNotation, _EInterfaceType, _ELinkType, \
    _EIncMode, _EInputDirection, _EGenApiSchemaVersion
from ..names import _to_dict, _remove_prefix, _lower_names, _invert_dict

__all__ = (
    'Sign_names',
    'Sign_values', 'AccessMode_names', 'AccessMode_values',
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
)


Sign_names = _lower_names(_ESign)
Sign_values = _invert_dict(Sign_names)

AccessMode_names = _to_dict(_EAccessMode)
AccessMode_values = _invert_dict(AccessMode_names)

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
