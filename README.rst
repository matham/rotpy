Provides python bindings for the Spinnaker SDK
to enable Pythonic control of Teledyne/FLIR/Point Grey USB and GigE cameras.

For more information: https://matham.github.io/rotpy/index.html

To install: https://matham.github.io/rotpy/installation.html

.. image:: https://github.com/matham/rotpy/workflows/Python%20application/badge.svg
    :target: https://github.com/matham/rotpy/actions
    :alt: Github CI status


Examples
========

Getting an image from a GigE camera
-----------------------------------

.. code-block:: python

    >>> from rotpy.system import SpinSystem
    >>> # get a system ref and a list of all attached cameras
    >>> system = SpinSystem()
    >>> cameras = system.create_camera_list(update_cams=True, update_interfaces=True)
    >>> cameras.get_size()
        1
    >>> # get the camera attached from the list
    >>> camera = cameras.create_camera_by_index(0)
    >>> camera.get_unique_id()
        '77T45WD4A84C_86TA1684_GGGGGG14_64CW3987'
    >>> # init the camera and get one image
    >>> camera.init_cam()
    >>> camera.begin_acquisition()
    >>> image_cam = camera.get_next_image(timeout=5)
    >>> # we copy the image so that we can release its camera buffer
    >>> image = image_cam.deep_copy_image(image_cam)
    >>> image_cam.release()
    >>> camera.end_acquisition()
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

Attaching event handlers
------------------------

Logging handler
^^^^^^^^^^^^^^^

.. code-block:: python

    >>> from rotpy.system import SpinSystem, LoggingEventHandler
    >>> # create system and set logging level to debug
    >>> system = SpinSystem()
    >>> system.set_logging_level('debug')
    >>> # create a handler that prints the message
    >>> def log_handler(item):
    ...     print('Log:', item['category'], item['priority'], item['message'])
    >>> handler = LoggingEventHandler(log_handler)
    >>> # attach the handler and do something that causes logs
    >>> system.attach_log_event_handler(handler)
    >>> cameras = system.create_camera_list(update_cams=True, update_interfaces=True)
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

.. code-block:: python

    >>> from rotpy.camera import ImageEventHandler
    >>> from rotpy.system import SpinSystem
    >>> # create system and get a camera
    >>> system = SpinSystem()
    >>> cameras = system.create_camera_list(update_cams=True, update_interfaces=True)
    >>> camera = cameras.create_camera_by_index(0)
    >>> camera.init_cam()
    >>> # create an image handler that prints the frame ID and time
    >>> def image_callback(image):
    ...     print('Image:', image.get_frame_id(), image.get_frame_timestamp())
    >>> handler = ImageEventHandler(image_callback)
    >>> # attach handler and start getting frames
    >>> camera.attach_image_event_handler(handler)
    >>> camera.begin_acquisition()
    Image: 1 388361262364
    Image: 2 388366605529
     ...
    Image: 135 389077033335
    >>> # stop frames and printing
    >>> camera.end_acquisition()
    >>> camera.detach_image_event_handler(handler)
    >>> camera.deinit_cam()
