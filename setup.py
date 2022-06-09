from setuptools import setup, Extension
import sys
from os.path import join, exists, dirname, abspath, isdir, pathsep
from os import environ, listdir
from rotpy import __version__
from Cython.Distutils import build_ext
import pathlib

cmdclass = {'build_ext': build_ext}


def get_wheel_data():
    deps = environ.get('ROTPY_WHEEL_DEPS')
    if not deps or not isdir(deps):
        return []

    root = pathlib.Path(deps)
    items = list(map(str, root.glob('FlyCap*_v140.dll')))
    items = [
        val for val in items
        if val[-10] != 'd' or val[:-10] + 'd' + val[-10:] in items
    ]
    items.extend(map(str, root.glob('msvcp140.dll')))
    items.extend(map(str, root.glob('libiomp5md.dll')))

    return [('share/rotpy/flycapture2/bin', items)]


include_dirs = []
library_dirs = []

if sys.platform in ('win32', 'cygwin'):
    libraries = ['Spinnaker_v140', ]
else:
    libraries = ['flycapturegui-c', 'flycapture-c']
    include_dirs.append('/usr/include/flycapture')
    include_dirs.append('/usr/include/flycapture/C')

include = environ.get('ROTPY_INCLUDE', r'E:\FLIR\Spinnaker\include')
if include:
    include_dirs.extend(include.split(pathsep))

lib = environ.get('ROTPY_LIB', r'E:\FLIR\Spinnaker\lib64\vs2015')
if lib:
    library_dirs.extend(lib.split(pathsep))


mods = [
    '_interface', 'system', 'names', 'camera', 'image', 'node', 'camera_nodes'
]
mod_suffix = '.pyx'
include_dirs.append(join(abspath(dirname(__file__)), 'rotpy', 'includes'))

ext_modules = [Extension(
    'rotpy.' + src_file,
    sources=[join('rotpy', src_file + mod_suffix)], libraries=libraries,
    include_dirs=include_dirs, library_dirs=library_dirs, language="c++")
    for src_file in mods]

for e in ext_modules:
    e.cython_directives = {
        "embedsignature": True, 'c_string_encoding': 'utf-8',
        'language_level': 3}

with open('README.rst') as fh:
    long_description = fh.read()

setup(
    name='rotpy',
    version=__version__,
    author='Matthew Einhorn',
    license='MIT',
    description='Cython bindings for Point Gray Fly Capture 2.',
    url='https://matham.github.io/rotpy/',
    long_description=long_description,
    classifiers=[
        'License :: OSI Approved :: MIT License',
        'Topic :: Multimedia :: Graphics :: Capture :: Digital Camera',
        'Topic :: Multimedia :: Graphics :: Capture',
        'Programming Language :: Python :: 3.5',
        'Programming Language :: Python :: 3.6',
        'Programming Language :: Python :: 3.7',
        'Operating System :: Microsoft :: Windows',
        'Operating System :: POSIX :: Linux',
        'Intended Audience :: Developers'],
    packages=['rotpy'],
    data_files=get_wheel_data(),
    cmdclass=cmdclass, ext_modules=ext_modules)
