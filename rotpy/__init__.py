"""RotPy Library
====================

Project that provides python bindings for the Spinnaker SDK and provides
access to their GigE and USB cameras.
"""
__version__ = '0.1.1.dev0'

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
        if os.path.exists(os.path.join(p, 'FLIR_GenTL.cti')):
            os.environ[f'FLIR_GENTL{_bitness}_CTI'] = os.path.join(
                p, 'FLIR_GenTL.cti')
        if os.path.exists(os.path.join(p, 'FLIR_GenTL_v140.cti')):
            os.environ[f'FLIR_GENTL{_bitness}_CTI_VS140'] = os.path.join(
                p, 'FLIR_GenTL_v140.cti')

        _name = f'GENICAM_GENTL{_bitness}_PATH'
        if _name in os.environ:
            os.environ[_name] = p + os.pathsep + os.environ[_name]
        else:
            os.environ[_name] = p

        os.environ["PATH"] = p + os.pathsep + os.environ["PATH"]
        if hasattr(os, 'add_dll_directory'):
            os.add_dll_directory(p)
        dep_bins.append(p)
