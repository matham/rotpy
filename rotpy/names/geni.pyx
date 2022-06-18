"""GenAPI enums
===============

Provides access to all the GenAPI-related enums.
"""
import rotpy._interface
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


Sign_names = _lower_names(rotpy._interface._ESign)
Sign_values = _invert_dict(Sign_names)

AccessMode_names = _to_dict(rotpy._interface._EAccessMode)
AccessMode_values = _invert_dict(AccessMode_names)

Visibility_names = _to_dict(rotpy._interface._EVisibility)
Visibility_values = _invert_dict(Visibility_names)

CachingMode_names = _to_dict(rotpy._interface._ECachingMode)
CachingMode_values = _invert_dict(CachingMode_names)

Representation_names = _to_dict(rotpy._interface._ERepresentation)
Representation_values = _invert_dict(Representation_names)

Endianess_names = _to_dict(rotpy._interface._EEndianess)
Endianess_values = _invert_dict(Endianess_names)

NameSpace_names = _to_dict(rotpy._interface._ENameSpace)
NameSpace_values = _invert_dict(NameSpace_names)

StandardNameSpace_names = _to_dict(rotpy._interface._EStandardNameSpace)
StandardNameSpace_values = _invert_dict(StandardNameSpace_names)

YesNo_names = _to_dict(rotpy._interface._EYesNo)
YesNo_values = _invert_dict(YesNo_names)

Slope_names = _to_dict(rotpy._interface._ESlope)
Slope_values = _invert_dict(Slope_names)

XMLValidation_names = _remove_prefix('xv', rotpy._interface._EXMLValidation)
XMLValidation_values = _invert_dict(XMLValidation_names)

DisplayNotation_names = _remove_prefix('fn', rotpy._interface._EDisplayNotation)
DisplayNotation_values = _invert_dict(DisplayNotation_names)

InterfaceType_names = _remove_prefix('intfI', rotpy._interface._EInterfaceType)
InterfaceType_values = _invert_dict(InterfaceType_names)

LinkType_names = _remove_prefix('ct', rotpy._interface._ELinkType)
LinkType_values = _invert_dict(LinkType_names)

IncMode_names = _to_dict(rotpy._interface._EIncMode)
IncMode_values = _invert_dict(IncMode_names)

InputDirection_names = _remove_prefix('id', rotpy._interface._EInputDirection)
InputDirection_values = _invert_dict(InputDirection_names)

GenApiSchemaVersion_names = _to_dict(rotpy._interface._EGenApiSchemaVersion)
GenApiSchemaVersion_values = _invert_dict(GenApiSchemaVersion_names)
