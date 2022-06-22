RotPy
=====

RotPy provides python bindings for the Spinnaker SDK
to enable Pythonic control of Teledyne/FLIR/Point Grey USB and GigE cameras.

See `the website <https://matham.github.io/rotpy/index.html>`_ for the complete **documentation**.

.. image:: https://github.com/matham/rotpy/workflows/Python%20application/badge.svg
    :target: https://github.com/matham/rotpy/actions
    :alt: Github CI status

Installation
============

You can install RotPy using pre-compiled wheels on Windows, Linux, or Mac or by installing
the Spinnaker SDK and then installing RotPy from source.

Either way, you'll likely need to install the **Spinnaker drivers** so that the cameras
are recognized. Please download it from `their website <https://www.flir.com/products/spinnaker-sdk/>`_
and follow the instructions to install the drivers if the cameras are not found.

Pre-compiled wheels
-------------------

To install from the pre-compiled wheels (assuming it's available on your platform), simply do::

    python -m pip install rotpy


.. note::

    For Windows, if rotpy errors out saying dll not found, you probably need
    to install the
    `Microsoft Visual C++ Redistributable <https://docs.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist>`_
    (`64-bit <https://aka.ms/vs/17/release/vc_redist.x64.exe>`_,
    `32-bit <https://aka.ms/vs/17/release/vc_redist.x86.exe>`_).

.. warning::

    RotPy is licensed under MIT. However, the pre-compiled wheels contain some of the
    Spinnaker SDK runtime libraries which have their own license. Please see the
    license file packaged along with the binaries in the wheel.

From source
-----------

To install RotPy from source, you need to:

#. Install the
   `Spinnaker SDK <https://www.flir.com/products/spinnaker-sdk/>`_ development
   libraries.
#. Install a C++ compiler that supports C++11. E.g. on Windows Visual Studio etc.
   On Mac you may have to export the following environment variables::

       export CXX="/usr/bin/clang"
       export CXXFLAGS="-std=c++11"
       export CPPFLAGS="-std=c++11"

#. Set the environment variables so Python can locate the Spinnaker SDK.

   #. You need to set ``ROTPY_INCLUDE`` to the include directory, e.g. on Windows it may be something like
      ``set ROTPY_INCLUDE="C:\Program Files\FLIR\Spinnaker\include"``. On Linux and Mac it should typically
      be automatically found.
   #. You need to set ``ROTPY_LIB`` to the paths that contain the libraries and binaries. E.g. on Windows it may
      be ``set ROTPY_LIB="C:\Program Files\FLIR\Spinnaker\bin64\vs2015;C:\Program Files\FLIR\Spinnaker\lib64\vs2015"``.
      On Linux and Mac, again, it should typically be automatically found.
#. Then install RotPy with::

       python -m pip install rotpy --no-binary rotpy

#. At runtime, you'll need to ensure the Spinnaker runtime binaries are on the
   system ``PATH`` using e.g.
   `os.add_dll_directory <https://docs.python.org/3/library/os.html#os.add_dll_directory>`_.

   You may also have to set the environmental variable (depending on the OS bitness)
   ``GENICAM_GENTL32_PATH``/``GENICAM_GENTL64_PATH``
   to the directory containing the ``FLIR_GenTL*.cti`` file as well as any or all variables
   ``FLIR_GENTL32_CTI_VS140``/``FLIR_GENTL64_CTI_VS140``/``FLIR_GENTL32_CTI``/``FLIR_GENTL64_CTI``
   to the **full path** to the ``FLIR_GenTL*.cti`` file.

   Additionally, the ``FLIR_GenTL*.cti`` file containing directory may also need to be added
   to the system ``PATH``. Spinnaker will raise an error if the cti file cannot be loaded.

Examples
========

Getting an image from a GigE camera
-----------------------------------

.. code-block:: python

    >>> from rotpy.system import SpinSystem
    >>> from rotpy.camera import CameraList
    >>> # get a system ref and a list of all attached cameras
    >>> system = SpinSystem()
    >>> cameras = CameraList.create_from_system(system, update_cams=True, update_interfaces=True)
    >>> cameras.get_size()
        1
    >>> # get the camera attached from the list
    >>> camera = cameras.create_camera_by_index(0)
    >>> camera.get_unique_id()
        '77T45WD4A84C_86TA1684_GGGGGG14_64CW3987'
    >>> # init the camera and get one image
    >>> camera.init_cam()
    >>> # get its serial number
    >>> camera.camera_nodes.DeviceSerialNumber.get_node_value()
    '36548975'
    >>> camera.begin_acquisition()
    >>> image_cam = camera.get_next_image(timeout=5)
    >>> # we copy the image so that we can release its camera buffer
    >>> image = image_cam.deep_copy_image(image_cam)
    >>> image_cam.release()
    >>> camera.end_acquisition()
    >>> # save the image
    >>> image.save_png('image.png')
    >>> # get image metadata
    >>> image.get_bits_per_pixel()
        8
    >>> image.get_height()
        512
    >>> image.get_width()
        612
    >>> image.get_frame_id()
        1
    >>> image.get_frame_timestamp()
        67557050882
    >>> image.get_pix_fmt()
        'Mono8'
    >>> image.get_image_data_size()
        313344
    >>> data = image.get_image_data()
    >>> type(data)
        bytearray
    >>> len(data)
        313344
    >>> 512 * 612
        313344
    >>> camera.deinit_cam()

System and camera properties
----------------------------

The system and camera properties can be read and set using :py:mod:`~rotpy.node`
objects. These nodes, each represent a camera or system property, and they
can be integer nodes, float nodes, boolean nodes, string nodes, command
nodes etc.

These nodes derive from Spinnaker's `GenICam <https://en.wikipedia.org/wiki/GenICam>`_
implementation for their cameras. RotPy provides access to a generic node access API
as well as to some pre-listed nodes available on many cameras.

The generic API is accessed through the :py:class:`~rotpy.node.NodeMap` using
e.g. :py:meth:`~rotpy.system.SpinSystem.get_tl_node_map`,
:py:meth:`~rotpy.system.InterfaceDevice.get_tl_node_map`,
:py:meth:`~rotpy.camera.Camera.get_node_map`, :py:meth:`~rotpy.camera.Camera.get_tl_dev_node_map`, or
:py:meth:`~rotpy.camera.Camera.get_tl_stream_node_map`.

The pre-listed nodes can be accessed through e.g. :py:attr:`~rotpy.system.SpinSystem.system_nodes`,
:py:attr:`~rotpy.system.InterfaceDevice.interface_nodes`,
:py:attr:`~rotpy.camera.Camera.camera_nodes`, :py:attr:`~rotpy.camera.Camera.tl_dev_nodes`, or
:py:attr:`~rotpy.camera.Camera.tl_stream_nodes`. These link to the following respective
objects: :py:class:`~rotpy.system_nodes.SystemNodes`, :py:class:`~rotpy.system_nodes.InterfaceNodes`,
:py:class:`~rotpy.camera_nodes.CameraNodes`, :py:class:`~rotpy.camera_nodes.TLDevNodes`, and
:py:class:`~rotpy.camera_nodes.TLStreamNodes`.

E.g. to access some of the system nodes using :py:attr:`~rotpy.system.SpinSystem.system_nodes`:

.. code-block:: python

    >>> from rotpy.system import SpinSystem
    >>> system = SpinSystem()
    >>> # get a list of all boolean nodes
    >>> system.system_nodes.bool_nodes
    ['EnumerateGEVInterfaces', 'EnumerateUSBInterfaces', 'EnumerateGen2Cameras']
    >>> # let's inspect the USB node
    >>> system.system_nodes.EnumerateUSBInterfaces
    <rotpy.node.SpinBoolNode at 0x26822c20d68>
    >>> # first make sure this node is actually available for this system
    >>> system.system_nodes.EnumerateUSBInterfaces.is_available()
    True
    >>> system.system_nodes.EnumerateUSBInterfaces.get_node_value()
    True
    >>> system.system_nodes.EnumerateUSBInterfaces.get_description()
    'Enables or disables enumeration of USB Interfaces.'
    >>> system.system_nodes.EnumerateUSBInterfaces.get_name()
    'EnumerateUSBInterfaces'
    >>> system.system_nodes.EnumerateUSBInterfaces.get_node_value_as_str()
    '1'
    >>> system.system_nodes.EnumerateUSBInterfaces.get_short_description()
    'Enables or disables enumeration of USB Interfaces.'

We can similarly use the node map to get the same node if it's available:

.. code-block:: python

    >>> from rotpy.system import SpinSystem
    >>> system = SpinSystem()
    >>> node_map = system.get_tl_node_map()
    >>> node = node_map.get_node_by_name('EnumerateUSBInterfaces')
    >>> node is not None and node.is_available()
    True
    >>> node.get_node_value()
    True
    >>> node.get_description()
    'Enables or disables enumeration of USB Interfaces.'

Similarly, for the camera, we can use the pre-listed nodes:

.. code-block:: python

    >>> # make sure to init the camera, otherwise many nodes won't be available
    >>> camera.init_cam()
    >>> # check that the auto-exposure setting is available
    >>> camera.camera_nodes.ExposureAuto.is_available()
    True
    >>> camera.camera_nodes.ExposureAuto.get_description()
    'Sets the automatic exposure mode when Exposure Mode is Timed.'
    >>> # the auto-exposure is a enum node with children items
    >>> camera.camera_nodes.ExposureAuto.get_node_value()
    <rotpy.node.SpinEnumItemNode at 0x26822c2bc18>
    >>> camera.camera_nodes.ExposureAuto.get_node_value().get_enum_name()
    'Continuous'
    >>> # but we can just get the symbolic string name directly
    >>> camera.camera_nodes.ExposureAuto.get_node_value_as_str()
    'Continuous'
    >>> # to see what options are available for this enum node, look in the names module
    >>> from rotpy.names.camera import ExposureAuto_names
    >>> ExposureAuto_names
    {'Off': 0, 'Once': 1, 'Continuous': 2}
    >>> # or for pre-listed enum nodes, we can get it as an attribute
    >>> camera.camera_nodes.ExposureAuto.enum_names
    {'Off': 0, 'Once': 1, 'Continuous': 2}
    >>> # try setting it to an incorrect value
    >>> camera.camera_nodes.ExposureAuto.set_node_value_from_str('off', verify=True)
    Traceback (most recent call last):
      File "<ipython-input-48-d16a67f0044c>", line 1, in <module>
        camera.camera_nodes.ExposureAuto.set_node_value_from_str('off', verify=True)
      File "rotpy\node.pyx", line 650, in rotpy.node.SpinValueNode.set_node_value_from_str
        cpdef set_node_value_from_str(self, str value, cbool verify=True):
      File "rotpy\node.pyx", line 664, in rotpy.node.SpinValueNode.set_node_value_from_str
        self._value_handle.FromString(s, verify)
    RuntimeError: Spinnaker: GenICam::InvalidArgumentException= Feature 'ExposureAuto' : cannot convert value 'off', the value is invalid. : InvalidArgumentException thrown in node 'ExposureAuto' while calling 'ExposureAuto.FromString()' (file 'Enumeration.cpp', line 132) [-2001]
    >>> # now set it correctly
    >>> camera.camera_nodes.ExposureAuto.set_node_value_from_str('Off', verify=True)
    >>> camera.camera_nodes.ExposureAuto.get_node_value_as_str()
    'Off'

Similarly, we can use the node map to set the exposure back to ``"Continuous"``:

.. code-block:: python

    >>> node_map = camera.get_node_map()
    >>> node = node_map.get_node_by_name('ExposureAuto')
    >>> node is not None and node.is_available()
    True
    >>> node.get_node_value_as_str()
    'Off'
    >>> node.set_node_value_from_str('Continuous', verify=True)
    >>> node.get_node_value_as_str()
    'Continuous'
    >>> # now de-init the camera and the node won't be available
    >>> camera.deinit_cam()
    >>> node.is_available()
    False
    >>> camera.camera_nodes.ExposureAuto.is_available()
    False

Attaching event handlers
------------------------

Camera detection events
^^^^^^^^^^^^^^^^^^^^^^^

We can register callbacks to be called when the system detects a camera arrival or
removal on any interface, or on specific interfaces. E.g. to be notified on any interface:

.. code-block:: python

    >>> from rotpy.system import SpinSystem
    >>> system = SpinSystem()
    >>> # register a callback for both arrival and removal
    >>> def arrival(handler, system, serial):
    ...     print('Arrived:', serial)
    >>> def removal(handler, system, serial):
    ...     print('Removed:', serial)
    >>> # register and then plug and unplug a camera twice
    >>> handler = system.attach_interface_event_handler(arrival, removal, update=True)
    Arrived: 36548975
    Removed: 36548975
    Arrived: 36548975
    Removed: 36548975
    >>> system.detach_interface_event_handler(handler)

Logging handler
^^^^^^^^^^^^^^^

We can also register logging event handlers to get any logging events on the system or devices:

.. code-block:: python

    >>> from rotpy.system import SpinSystem
    >>> from rotpy.camera import CameraList
    >>> # create system and set logging level to debug
    >>> system = SpinSystem()
    >>> system.set_logging_level('debug')
    >>> # create a callback that prints the message
    >>> def log_handler(handler, system, item):
    ...     print('Log:', item['category'], item['priority'], item['message'])
    >>> # attach the callback and do something that causes logs
    >>> handler = system.attach_log_event_handler(log_handler)
    >>> cameras = CameraList.create_from_system(system, update_cams=True, update_interfaces=True)
    Log: SpinnakerCallback DEBUG Spinnaker: GetCameras()
    Log: GenTLCallback DEBUG Entering InterfaceGev::InterfaceGev()
    Log: GenTLCallback DEBUG Leaving InterfaceGev::InterfaceGev()
    Log: GenTLCallback DEBUG GenTL Trace: system.cpp, line 125, GenTL::EnumerateGigEInterfaces
    Log: GenTLCallback DEBUG Entering HAL_UsbGetInterfaces()
    Log: GenTLCallback DEBUG Enumerating host Controller PCI\VEN_8086&DEV_A12F&SUBSYS_06E41028&REV_31\3&11458735&0&A0
    Log: GenTLCallback DEBUG Host Controller's child instance ID: USB\VID_8087&PID_0029\5&587A6F87&0&4
    Log: GenTLCallback DEBUG Entering InterfaceUsb::InterfaceUsb()
    Log: GenTLCallback DEBUG Leaving InterfaceUsb::InterfaceUsb()
    Log: GenTLCallback DEBUG GenTL Trace: system.cpp, line 162, GenTL::EnumerateUsbInterfaces
    Log: GenTLCallback DEBUG GenTL Trace: system.cpp, line 191, GenTL::InitializeInterfaces
    Log: GenTLCallback DEBUG GenTL Trace: system.cpp, line 225, GenTL::System::RefreshInterfaces
    Log: GenTLCallback DEBUG GenTL Trace: system.cpp, line 535, GenTL::System::UpdateInterfaceList
    >>> # now detach the handler
    >>> system.detach_log_event_handler(handler)

Camera image handler
^^^^^^^^^^^^^^^^^^^^

We can also register a callback that is called on every new image that is received from the
device, as opposed to polling for new images:

.. code-block:: python

    >>> from rotpy.camera import CameraList
    >>> from rotpy.system import SpinSystem
    >>> # create system and get a camera
    >>> system = SpinSystem()
    >>> cameras = CameraList.create_from_system(system, update_cams=True, update_interfaces=True)
    >>> camera = cameras.create_camera_by_index(0)
    >>> camera.init_cam()
    >>> # create an image handler that prints the frame ID and time
    >>> def image_callback(handler, camera, image):
    ...     print('Image:', image.get_frame_id(), image.get_frame_timestamp())
    >>> # attach callback and start getting frames
    >>> handler = camera.attach_image_event_handler(image_callback)
    >>> camera.begin_acquisition()
    Image: 1 388361262364
    Image: 2 388366605529
     ...
    Image: 135 389077033335
    >>> # stop frames and printing
    >>> camera.end_acquisition()
    >>> camera.detach_image_event_handler(handler)
    >>> camera.deinit_cam()

Camera events
^^^^^^^^^^^^^

We can also register a callback that is called on camera events. E.g.:

.. code-block:: python

    >>> from rotpy.camera import CameraList
    >>> from rotpy.system import SpinSystem
    >>> # create system and get a camera
    >>> system = SpinSystem()
    >>> cameras = CameraList.create_from_system(system, update_cams=True, update_interfaces=True)
    >>> camera = cameras.create_camera_by_index(0)
    >>> camera.init_cam()
    >>> # define the callback and attach it
    >>> def event_callback(handler, camera, event):
    ...     print('Event:', event, handler.get_event_data(event), handler.get_event_metadata())
    >>> handler = camera.attach_device_event_handler(event_callback)
    >>> # now use the EventSelector enum to get the enum items which
    >>> correspond to the event names that are available.
    >>> nodes = camera.camera_nodes.EventSelector.get_entries()
    >>> # not all are actually available, so only activate the ones available
    >>> nodes = [node for node in nodes if node.is_available()]
    >>> for node in nodes:
    ...     print(node.get_enum_name())
    ...     camera.camera_nodes.EventSelector.set_node_value_from_str(node.get_enum_name())
    ...     camera.camera_nodes.EventNotification.set_node_value_from_str('On')
    ExposureEnd
    >>> # this printed just ExposureEnd, indicating only this event was available
    >>> # start acquisition so that the events occur
    >>> camera.begin_acquisition()
    Event: EventExposureEnd {'frame_id': 62629213124996} ('device', 'EventExposureEnd', 40003)
    Event: EventExposureEnd {'frame_id': 62633508092293} ('device', 'EventExposureEnd', 40003)
    ...
    Event: EventExposureEnd {'frame_id': 62676457765304} ('device', 'EventExposureEnd', 40003)
    >>> camera.end_acquisition()
    >>> camera.detach_device_event_handler(handler)
    >>> camera.deinit_cam()
