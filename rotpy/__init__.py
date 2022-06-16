"""RotPy Library
====================

Project that provides python bindings for the Spinnaker SDK that provides
access to GigE and USB camera control.
"""
__version__ = '0.1.0.dev0'

import sys
import site
import os
from os.path import join

__all__ = ('dep_bins', )

dep_bins = []
'''A list of paths to the binaries used by the library. It can be used during
packaging for including required binaries.

It is read only.
'''

_bitness = '64' if sys.maxsize > 2 ** 32 else '32'

for d in [sys.prefix, site.USER_BASE]:
    p = join(d, 'share', 'rotpy', 'spinnaker', 'bin')
    if os.path.isdir(p):
        os.environ["PATH"] = p + os.pathsep + os.environ["PATH"]
        if hasattr(os, 'add_dll_directory'):
            os.add_dll_directory(p)
        dep_bins.append(p)

    p = join(d, 'share', 'rotpy', 'spinnaker', 'cti')
    if os.path.isdir(p):
        for _name in (
                f'GENICAM_GENTL{_bitness}_PATH', f'FLIR_GENTL{_bitness}_CTI',
                f'FLIR_GENTL{_bitness}_CTI_VS140'):
            if _name in os.environ:
                os.environ[_name] = p + os.pathsep + os.environ[_name]
            else:
                os.environ[_name] = p

        os.environ["PATH"] = p + os.pathsep + os.environ["PATH"]
        if hasattr(os, 'add_dll_directory'):
            os.add_dll_directory(p)
        dep_bins.append(p)
