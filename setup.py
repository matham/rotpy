from setuptools import setup, Extension, find_packages
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
    items = list(map(str, root.glob('Spinnaker_v*.dll')))
    items.extend(map(str, root.glob('GCBase_MD_*.dll')))
    items.extend(map(str, root.glob('GenApi_MD_*.dll')))

    return [('share/rotpy/spinnaker/bin', items)]


include_dirs = []
library_dirs = []

if sys.platform in ('win32', 'cygwin'):
    libraries = ['Spinnaker_v140', ]
else:
    libraries = ['Spinnaker']
    include_dirs.append('/opt/spinnaker/include')
    library_dirs.append('/opt/spinnaker/lib')

include = environ.get('ROTPY_INCLUDE')
if include:
    include_dirs.extend(include.split(pathsep))

lib = environ.get('ROTPY_LIB')
if lib:
    library_dirs.extend(lib.split(pathsep))


mods = [
    '_cam_defs._cam_defs1', '_cam_defs._cam_defs2', '_cam_defs._cam_defs3',
    '_cam_defs._cam_defs4', '_cam_defs._cam_defs5',
    '_interface', 'system', 'names.camera', 'names.geni', 'names.spin',
    'names.tl', 'camera', 'image', 'node', 'camera_nodes', 'system_nodes',
]
mod_suffix = '.pyx'
include_dirs.append(join(abspath(dirname(__file__)), 'rotpy', 'includes'))

ext_modules = [Extension(
    'rotpy.' + src_file,
    sources=[join('rotpy', src_file.replace('.', '/') + mod_suffix)],
    libraries=libraries, include_dirs=include_dirs, library_dirs=library_dirs,
    language="c++")
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
    description='Cython bindings for the Spinnaker camera control API.',
    url='https://matham.github.io/rotpy/',
    long_description=long_description,
    classifiers=[
        'License :: OSI Approved :: MIT License',
        'Topic :: Multimedia :: Graphics :: Capture :: Digital Camera',
        'Topic :: Multimedia :: Graphics :: Capture',
        'Programming Language :: Python :: 3.7',
        'Programming Language :: Python :: 3.8',
        'Programming Language :: Python :: 3.9',
        'Programming Language :: Python :: 3.10',
        'Operating System :: Microsoft :: Windows',
        'Operating System :: POSIX :: Linux',
        'Intended Audience :: Developers'],
    packages=find_packages(),
    package_data={
        'rotpy': [
            '*.pxd', '*.pyx', 'includes/*.pxi', 'names/*.pyx', 'includes/*.h',
            '_cam_defs/*.pyx', '_cam_defs/*.pxd'
        ]},
    data_files=get_wheel_data(),
    cmdclass=cmdclass, ext_modules=ext_modules)
