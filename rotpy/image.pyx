"""Image
========

Image and image data/metadata returned by cameras.

"""
cdef extern from "string.h" nogil:
    void *memcpy(void *, const void *, size_t)

from cython cimport view as cyview

from .names.spin import payload_type_names, \
    payload_type_values, color_processing_algo_names, \
    color_processing_algo_values, \
    pix_fmt_namespace_values, pix_fmt_int_values,\
    img_status_values, img_status_names, img_file_fmt_names, compression_names
from .names.camera import PixelFormat_values, PixelFormat_names

__all__ = ('Image', 'ImageChunkData', 'ChunkDataInference')


cdef class Image:
    """An image and its data and metadata.

    .. warning::

        Do **not** create a :class:`Image` manually, rather get an image
        from e.g. :meth:`create_empty`, :meth:`create_image`,
        :meth:`deep_copy_image`, or from a camera with e.g.
        :meth:`~rotpy.camera.Camera.get_next_image`.
    """

    def __cinit__(self):
        self._needs_destroy = 0
        self._needs_release = 0
        self._image_data_ref = None

    def __dealloc__(self):
        self.release()

    @staticmethod
    cdef Image create_from_camera(ImagePtr spin_img):
        cdef Image img = Image()
        img._image = spin_img
        img._needs_release = 1
        return img

    @staticmethod
    def create_empty() -> Image:
        """Creates and returns an empty image with no data or data buffers.
        """
        return Image.create_empty_c()

    @staticmethod
    cdef Image create_empty_c():
        cdef Image img = Image()
        with nogil:
            img._image = CImage.Create0()
            img._needs_destroy = 1

        return img

    @staticmethod
    def create_image(
            int width, int height, int x_offset, int y_offset, str pix_fmt,
            data=None, str data_type='', size_t data_len=0
    ) -> Image:
        """Creates and returns an image with some pre-set properties.

        :param width: The image width.
        :param height: The image height.
        :param x_offset: The x-offset of the start of the image.
        :param y_offset: The y-offset of the start of the image.
        :param pix_fmt: The pixel format name string from
            :attr:`~rotpy.names.camera.PixelFormat_names`.
        :param data: An optional bytes buffer or array containing the data to
            initialize the image with. If None, data is not set.
        :param data_type: The payload type of the data as named in
            :attr:`~rotpy.names.spin.payload_type_names` (such as compressed). See
            also :meth:`get_payload_type`.
        :param data_len: The size of the ``data`` if provided. This is only used
            if the ``data_type`` is also given.
        :return: :class:`Image`.

        .. note::

            Note that images with chunk payload types are saved with only the
            image data preserved. Remember to specify the non-chunk equivalent
            payload type when creating images with these chunk payload types.
            For example, images need to be created with PAYLOAD_TYPE_IMAGE
            payload type if the original image had PAYLOAD_TYPE_EXTENDED_CHUNK
            payload type.
        """
        return Image.create_image_c(
            width, height, x_offset, y_offset, pix_fmt, data, data_type,
            data_len)

    @staticmethod
    cdef Image create_image_c(
            int width, int height, int x_offset, int y_offset, str pix_fmt,
            data=None, str data_type='', size_t data_len=0
    ):
        cdef PixelFormatEnums int_fmt = PixelFormat_names[pix_fmt]
        cdef PayloadTypeInfoIDs payload = PAYLOAD_TYPE_UNKNOWN
        cdef unsigned char* buffer = NULL
        cdef Image img = Image()

        if data is not None:
            img._image_data_ref = data
            buffer = data
            if data_type:
                payload = payload_type_names[data_type]
                if not data_len:
                    data_len = len(data)
        else:
            data_len = 0

        if data_type:
            with nogil:
                img._image = CImage.Create8(
                    width, height, x_offset, y_offset, int_fmt,
                    buffer, payload, data_len
                )
        else:
            with nogil:
                img._image = CImage.Create6(
                    width, height, x_offset, y_offset, int_fmt,
                    buffer)
        img._needs_destroy = 1

        return img

    @staticmethod
    def deep_copy_image(Image image) -> Image:
        """Creates and returns an image by copying all the data from the other
        image so they don't share buffers.
        """
        return Image.deep_copy_image_c(image)

    @staticmethod
    cdef Image deep_copy_image_c(Image image):
        cdef Image dest = Image()
        with nogil:
            dest._image = CImage.Create1(image._image)
            dest._needs_destroy = 1

        return dest

    cpdef deep_copy_from(self, Image source):
        """Copies the given image into this image.

        After this operation, this and the source image contents and member
        variables will be the same. However, the images will not share a buffer.
        The source image's buffer will not be :meth:`release` so you must
        still release it if it's a camera acquired image.
        """
        with nogil:
            self._image.get().DeepCopy(source._image)

    cpdef release(self):
        """Release the image and its data for images gotten with
        :meth:`~rotpy.camera.Camera.get_next_image`.

        If the image has been returned from the camera buffer, our hold over it
        is released and the camera can reuse the buffer. If we created the
        image manually it doesn't do anything.

        :meth:`release` must be called to release the image if it was returned
        by the camera. Otherwise, the camera can not re-use the buffer. For
        manually created images, this is not necessary as it happens
        automatically when the image is deleted.

        .. warning::

            Once called, all image operations are invalid and image methods
            should not be called.
        """
        if self._needs_destroy:
            self._needs_destroy = 0

        if self._needs_release:
            self._needs_release = 0
            with nogil:
                self._image.get().Release()
            self._image_data_ref = None

    @staticmethod
    def set_default_color_processing_algo(str name):
        """Sets the default color processing algorithm of all images (if not
        otherwise set).

        :param name: The name of the color processing algorithm used by default
            as listed in :attr:`~rotpy.names.spin.color_processing_algo_names`.
        """
        cdef ColorProcessingAlgorithm algorithm = color_processing_algo_names[name]
        with nogil:
            CImage.SetDefaultColorProcessing(algorithm)

    @staticmethod
    def get_default_color_processing_algo() -> str:
        """Gets the default color processing algorithm of all images (if not
        otherwise set).

        :return: The name of the color processing algorithm used by default
            as listed in :attr:`~rotpy.names.spin.color_processing_algo_names`.
        """
        cdef ColorProcessingAlgorithm algorithm
        with nogil:
            algorithm = CImage.GetDefaultColorProcessing()
        return color_processing_algo_values[algorithm]

    cpdef str get_color_processing_algo(self):
        """Gets the color processing algorithm of this image.

        :return: The name of the color processing algorithm used
            as listed in :attr:`~rotpy.names.spin.color_processing_algo_names`.
        """
        cdef ColorProcessingAlgorithm algorithm
        with nogil:
            algorithm = self._image.get().GetColorProcessing()
        return color_processing_algo_values[algorithm]

    @staticmethod
    def set_compression_threads(unsigned int num):
        """Sets the default number of threads used for image decompression
        during :meth:`convert`.

        The number of threads used is defaulted to be equal to one less than the
        number of concurrent threads supported by the system.

        :param num: Number of parallel image decompression threads set to run.
        """
        with nogil:
            CImage.SetNumDecompressionThreads(num)

    @staticmethod
    def get_compression_threads() -> int:
        """Gets the default number of threads used for image decompression
        during :meth:`convert`.
        """
        cdef unsigned int num
        with nogil:
            num = CImage.GetNumDecompressionThreads()
        return num

    cpdef Image convert_fmt(
            self, str pix_fmt, str algorithm='', Image dest=None):
        """Converts the image to a new pixel format and optionally using
        a specific algorithm and returns a new image.

        :param pix_fmt: The pixel format name string from
            :attr:`~rotpy.names.camera.PixelFormat_names`.
        :param algorithm: An optional algorithm name string from
            :attr:`~rotpy.names.spin.color_processing_algo_names`. If empty it's not
            set.
        :param dest: Optional destination image where the converted output
            result will be stored. The destination image buffer size must be
            sufficient to store the converted image data.
        :return: A new :class:`Image` if ``dest`` was not provided, otherwise
            ``dest``.

        .. note::

            Compressed images are decompressed before any further color
            processing or conversion during this call. Decompression is
            multi-threaded and defaults to utilizing one less than the number of
            concurrent threads supported by the system. It uses the number
            set in :meth:`set_compression_threads`, if set.
        """
        cdef PixelFormatEnums fmt = PixelFormat_names[pix_fmt]
        cdef ColorProcessingAlgorithm algo = DEFAULT
        if algorithm:
            algo = color_processing_algo_names[algorithm]

        if dest is None:
            dest = Image()
            with nogil:
                dest._image = self._image.get().Convert(fmt, algo)
            dest._needs_destroy = 1
        else:
            self._image.get().Convert(dest._image, fmt, algo)

        return dest

    cpdef reset_image(
            self, int width, int height, int x_offset, int y_offset,
            str pix_fmt, data=None, str data_type='', size_t data_len=0
    ):
        """Sets new dimensions of the image object and allocates memory if
        needed.

        :param width: The image width.
        :param height: The image height.
        :param x_offset: The x-offset of the start of the image.
        :param y_offset: The y-offset of the start of the image.
        :param pix_fmt: The pixel format name string from
            :attr:`~rotpy.names.camera.PixelFormat_names`.
        :param data: An optional bytes buffer or array containing the data to
            initialize the image with. If None, memory is automatically
            allocated.
        :param data_type: The optional payload type of the data as named in
            :attr:`~rotpy.names.spin.payload_type_names` (such as compressed). See
            also :meth:`get_payload_type`. See also :meth:`create_image`.
        :param data_len: The size of the ``data`` if provided. This is only used
            if the ``data_type`` is also given.
        """
        cdef PixelFormatEnums int_fmt = PixelFormat_names[pix_fmt]
        cdef PayloadTypeInfoIDs payload = PAYLOAD_TYPE_UNKNOWN
        cdef unsigned char * buffer = NULL

        if self._needs_release:
            self._needs_release = 0
            with nogil:
                self._image.get().Release()
            self._image_data_ref = None

        if data is None:
            with nogil:
                self._image.get().ResetImage(
                    width, height, x_offset, y_offset, int_fmt)
        else:
            buffer = data

            if data_type:
                payload = payload_type_names[data_type]
                if not data_len:
                    data_len = len(data)

                with nogil:
                    self._image.get().ResetImage(
                        width, height, x_offset, y_offset, int_fmt, buffer,
                        payload, data_len
                    )
            else:
                with nogil:
                    self._image.get().ResetImage(
                        width, height, x_offset, y_offset, int_fmt, buffer)

        self._image_data_ref = data
        self._needs_destroy = 1

    cpdef get_valid_payload_size(self):
        """Gets the size of valid data in the image payload.

        This is the actual amount of data read from the device, including any
        additional private data. A user created image has a payload size of
        zero. The value returned here can be equal to the value returned by
        :meth:`get_image_data_size` if image data is the only payload.
        Note that :meth:`get_buffer_size` returns the total size of bytes
        allocated for the image and could be equal to or greater than the size
        returned by this function.
        """
        cdef size_t n
        with nogil:
            n = self._image.get().GetValidPayloadSize()
        return n

    cpdef get_buffer_size(self):
        """Gets the size of the buffer associated with the image in bytes.

        For user created images, this function returns the size of the user
        provided data if the data size was provided when creating or setting
        the image. If the data size was not provided, the buffer size is
        calculated based on the image dimensions and pixel format.

        The buffer size may be large than the actual image size as returned
        by :meth:`get_image_data_size` or :meth:`get_valid_payload_size`.
        """
        cdef size_t n
        with nogil:
            n = self._image.get().GetBufferSize()
        return n

    cpdef get_image_data_size(self):
        """Gets the size of the image and just the image - not including any
        additional payloads with the image.

        For chunk images, only the size of chunk image portion is reported here.
        The entire chunk data payload including the image and full payload can
        be gotten by :meth:`get_valid_payload_size`. For compressed images, this
        value may be different than the image size once decompressed.
        """
        cdef size_t n
        with nogil:
            n = self._image.get().GetImageSize()
        return n

    cpdef get_image_data(self):
        """Gets and copies the image data and returns it as a bytearray.

        This does not include any additional payload data included with the
        image. For compressed images, the full image may be larger once
        decompressed.

        See also :meth:`copy_image_data` and :meth:`get_image_data_memoryview`.

        For example:

        .. code-block:: python

            >>> image = Image.create_image(640, 480, 0, 0, 'Mono16')
            >>> data = image.get_image_data()
            >>> type(data)
            <class 'bytearray'>
            >>> len(view)
            614400

        TODO: Understand the format of the data.
        """
        cdef size_t n
        cdef void* buf
        cdef unsigned char* dest

        with nogil:
            n = self._image.get().GetImageSize()
            buf = self._image.get().GetData()

        data = bytearray(b'\0') * n
        dest = data
        memcpy(dest, buf, n)

        return data

    cpdef get_image_data_memoryview(self):
        """Gets the image data as a memory view of the underlying data without copying.
        This is much more efficient than :meth:`get_image_data`, but more dangerous.

        This does not include any additional payload data included with the
        image. For compressed images, the full image may be larger once
        decompressed.

        .. warning::

            You MUST ensure that this :class:`Image` instance does not go out of memory
            and the image and buffers are not released as long as
            the returned memory view of the array is in use. Otherwise, when
            the original data will become invalid, usage of the memory view will crash python.

        For example:

        .. code-block:: python

            >>> image = Image.create_image(640, 480, 0, 0, 'Mono16')
            >>> view = image.get_image_data_memoryview()
            >>> view
            <rotpy.image.array object at 0x0000021CE7420B20>
            >>> # memview is the only attribute of cython arrays
            >>> view.memview
            <MemoryView of 'array' object>
            >>> view.memview.size
            614400
        """
        cdef size_t n
        cdef void* buf
        cdef cyview.array cyarr

        with nogil:
            n = self._image.get().GetImageSize()
            buf = self._image.get().GetData()

        cyarr = cyview.array(
            shape=(n, ), itemsize=sizeof(char), format="B", mode="c",
            allocate_buffer=False)
        cyarr.data = <char *>buf

        return cyarr

    cpdef copy_image_data(self, unsigned char[:] buffer):
        """Copies the image data into an existing buffer, such as a numpy array
        or a bytearray that can be re-used.

        The buffer must be at least as large as the image data and must be
        able to be used as a memory view of a unsigned bytes array.

        This does not include any additional payload data included with the
        image. For compressed images, the full image may be larger once
        decompressed.

        For example:

        .. code-block:: python

            >>> image = Image.create_image(640, 480, 0, 0, 'Mono16')
            >>> buffer = bytearray(b'\0') * full_image.get_image_data_size()
            >>> image.copy_image_data(buffer)
            >>> buffer = np.empty(full_image.get_image_data_size(), dtype=np.uint8)
            >>> image.copy_image_data(buffer)
        """
        cdef size_t n
        cdef void* buf

        if buffer is None:
            raise ValueError('Buffer cannot be None')

        with nogil:
            n = self._image.get().GetImageSize()
            buf = self._image.get().GetData()

        if buffer.shape[0] < n:
            raise ValueError(
                f'Buffer size {len(buffer)} is smaller than required buffer size {n}')

        memcpy(&buffer[0], buf, n)

    cpdef get_data_max(self):
        """Get the value which no image data will exceed.
        """
        cdef float n
        with nogil:
            n = self._image.get().GetDataAbsoluteMax()
        return n

    cpdef get_data_min(self):
        """Get the value which no image data will be less than.
        """
        cdef float n
        with nogil:
            n = self._image.get().GetDataAbsoluteMin()
        return n

    cpdef get_image_id(self):
        """Gets a unique ID for this image.

        Each image in a steam will have a unique ID to help identify it.
        """
        cdef uint64_t n
        with nogil:
            n = self._image.get().GetID()
        return n

    cpdef get_width(self):
        """Gets the width of the image in pixels.
        """
        cdef size_t n
        with nogil:
            n = self._image.get().GetWidth()
        return n

    cpdef get_height(self):
        """Gets the height of the image in pixels.
        """
        cdef size_t n
        with nogil:
            n = self._image.get().GetHeight()
        return n

    cpdef get_offset_x(self):
        """Gets the ROI x offset in pixels for this image.
        """
        cdef size_t n
        with nogil:
            n = self._image.get().GetXOffset()
        return n

    cpdef get_offset_y(self):
        """Gets the ROI y offset in pixels for this image.
        """
        cdef size_t n
        with nogil:
            n = self._image.get().GetYOffset()
        return n

    cpdef get_padding_x(self):
        """Gets the x padding in bytes for this image.

        This is the number of bytes at the end of each line to facilitate
        alignment in buffers.
        """
        cdef size_t n
        with nogil:
            n = self._image.get().GetXPadding()
        return n

    cpdef get_padding_y(self):
        """Gets the y padding in bytes for this image.
        This is the number of bytes at the end of each image to facilitate
        alignment in buffers.
        """
        cdef size_t n
        with nogil:
            n = self._image.get().GetYPadding()
        return n

    cpdef get_stride(self):
        """Gets the stride of the image in bytes.

        The stride of an image is how many bytes are in each row.
        """
        cdef size_t n
        with nogil:
            n = self._image.get().GetStride()
        return n

    cpdef get_bits_per_pixel(self):
        """Gets the number of bits used per pixel in the image.
        """
        cdef size_t n
        with nogil:
            n = self._image.get().GetBitsPerPixel()
        return n

    cpdef get_num_channels(self):
        """Gets the number of channels (depth) used in the image.

        Returns 0 if the number of channels for the given pixel format is
        unknown.
        """
        cdef size_t n
        with nogil:
            n = self._image.get().GetNumChannels()
        return n

    cpdef get_frame_id(self):
        """Gets the image's acquisition frame ID.
        """
        cdef uint64_t n
        with nogil:
            n = self._image.get().GetFrameID()
        return n

    cpdef get_frame_timestamp(self):
        """Gets the time stamp for the image in nanoseconds.
        """
        cdef uint64_t n
        with nogil:
            n = self._image.get().GetTimeStamp()
        return n

    cpdef get_payload_type(self):
        """Gets the payload type that was transmitted.

        This is a device types specific value that identifies how the image was
        transmitted.

        This returns the payload type name string from
        :attr:`~rotpy.names.spin.payload_type_names`.
        """
        cdef size_t n
        with nogil:
            n = self._image.get().GetPayloadType()
        return payload_type_values[n]

    cpdef get_tl_payload_type(self):
        """Gets the GenTL specific payload type that was transmitted.

        This is a Transport Layer specific value that identifies how the image
        was transmitted.

        This returns the payload type name string from
        :attr:`~rotpy.names.spin.payload_type_names`.
        """
        cdef PayloadTypeInfoIDs n
        with nogil:
            n = self._image.get().GetTLPayloadType()
        return payload_type_values[n]

    cpdef get_pix_fmt(self):
        """Gets the image's pixel format.

        This returns the pixel format name string from
        :attr:`~rotpy.names.camera.PixelFormat_names`.
        """
        cdef PixelFormatEnums n
        with nogil:
            n = self._image.get().GetPixelFormat()
        return PixelFormat_values[n]

    cpdef get_pix_fmt_int_type(self):
        """Gets the image's integer type used in the pixel format of this image.

        This returns the name string from
        :attr:`~rotpy.names.spin.pix_fmt_int_names`.
        """
        cdef PixelFormatIntType n
        with nogil:
            n = self._image.get().GetPixelFormatIntType()
        return pix_fmt_int_values[n]

    cpdef get_pix_fmt_sfnc(self):
        """Returns a string value that represents this image's pixel format.

        The string is a valid SFNC name that maps to the underlying TL specific
        pixel format. This is the most generic way to identify the pixel format
        of the image.
        """
        cdef gcstring s
        with nogil:
            s = self._image.get().GetPixelFormatName()
        return s.c_str().decode()

    cpdef get_tl_pix_fmt(self):
        """Gets the pixel format of the image.

        This is a Transport Layer specific pixel format that identifies how the
        pixels in the image should be interpreted. To understand how to
        interpret this value it is necessary to know what the transport layer
        namespace is. This can be retrieved through
        :meth:`get_tl_pix_fmt_namespace`.
        """
        cdef uint64_t n
        with nogil:
            n = self._image.get().GetTLPixelFormat()
        return n

    cpdef get_tl_pix_fmt_namespace(self):
        """Gets the image's underlying transport layer namespace in which this
        image's TL specific pixel format resides.

        This returns the name string from
        :attr:`~rotpy.names.spin.pix_fmt_namespace_names`.
        """
        cdef PixelFormatNamespaceID n
        with nogil:
            n = self._image.get().GetTLPixelFormatNamespace()
        return pix_fmt_namespace_values[n]

    cpdef get_layout_id(self):
        """Returns the id of the chunk data layout.
        """
        cdef uint64_t n
        with nogil:
            n = self._image.get().GetChunkLayoutId()
        return n

    cpdef get_completed(self):
        """Returns whether this image was incomplete.

        An image is marked as incomplete if the transport layer received less
        data then it requested.
        """
        cdef cbool n
        with nogil:
            n = self._image.get().IsIncomplete()
        return bool(n)

    cpdef has_crc(self):
        """Returns whether the image contains ImageCRC checksum from the chunk
        data.
        """
        cdef cbool n
        with nogil:
            n = self._image.get().HasCRC()
        return bool(n)

    cpdef get_crc(self):
        """Returns whether the computed checksum matches with chunk data's
        ImageCRC.
        """
        cdef cbool n
        with nogil:
            n = self._image.get().CheckCRC()
        return bool(n)

    cpdef get_in_use(self):
        """Returns whether the image is still in use by the stream.
        """
        cdef cbool n
        with nogil:
            n = self._image.get().IsInUse()
        return bool(n)

    cpdef get_is_compressed(self):
        """Returns whether this image is compressed.
        """
        cdef cbool n
        with nogil:
            n = self._image.get().IsCompressed()
        return bool(n)

    cpdef get_status(self):
        """Returns data integrity status of the image when it was returned from
        :meth:`~rotpy.camera.Camera.get_next_image`.

        This returns the name string from :attr:`~rotpy.names.spin.img_status_names`.
        """
        cdef ImageStatus n
        with nogil:
            n = self._image.get().GetImageStatus()
        return img_status_values[n]

    @staticmethod
    def get_status_description(str status):
        """Returns a string describing the meaning of the status string from
        :meth:`get_status`.

        :param status: A status string from
            :attr:`~rotpy.names.spin.img_status_names`.
        """
        return Image.get_status_description_c(status)

    @staticmethod
    cdef str get_status_description_c(str status):
        cdef const char* msg
        cdef ImageStatus n = img_status_names[status]
        with nogil:
            msg = CImage.GetImageStatusDescription(n)
        return msg.decode()

    cpdef save_file(self, str filename, str file_format='from_file_ext'):
        """Saves the image to a file, depending on the format specified.

        :param filename: The filename.
        :param file_format: The file format to save - it's a string from the
            options :attr:`~rotpy.names.spin.img_file_fmt_names`. By default it
            guesses from the extension.
        """
        cdef ImageFileFormat fmt = img_file_fmt_names[file_format]
        cdef bytes filename_b = filename.encode()
        cdef const char * filename_c = filename_b

        with nogil:
            self._image.get().Save(filename_c, fmt)

    cpdef save_png(
            self, str filename, cbool interlaced=False,
            unsigned int compression=6):
        """Saves the image to a png file.

        :param filename: The filename.
        :param interlaced: Whether to save interlaced (default False).
        :param compression: The compression level (default 6) (0-9). 0 is no
            compression, 9 is best compression.
        """
        cdef PNGOption opt
        cdef bytes filename_b = filename.encode()
        cdef const char * filename_c = filename_b

        opt.interlaced = interlaced
        opt.compressionLevel = compression

        with nogil:
            self._image.get().Save(filename_c, opt)

    cpdef save_ppm(self, str filename, cbool binary=True):
        """Saves the image to a ppm file.

        :param filename: The filename.
        :param binary: Whether to save as a binary file (default True).
        """
        cdef PPMOption opt
        cdef bytes filename_b = filename.encode()
        cdef const char * filename_c = filename_b

        opt.binaryFile = binary

        with nogil:
            self._image.get().Save(filename_c, opt)

    cpdef save_pgm(self, str filename, cbool binary=True):
        """Saves the image to a pgm file.

        :param filename: The filename.
        :param binary: Whether to save as a binary file (default True).
        """
        cdef PGMOption opt
        cdef bytes filename_b = filename.encode()
        cdef const char * filename_c = filename_b

        opt.binaryFile = binary

        with nogil:
            self._image.get().Save(filename_c, opt)

    cpdef save_tiff(self, str filename, str compression='lzw'):
        """Saves the image to a tiff file.

        :param filename: The filename.
        :param compression: The compression used to save the image (default
            lzw). It's a string from the options
            :attr:`~rotpy.names.spin.compression_names`.
        """
        cdef TIFFOption opt
        cdef bytes filename_b = filename.encode()
        cdef const char * filename_c = filename_b

        opt.compression = compression_names[compression]

        with nogil:
            self._image.get().Save(filename_c, opt)

    cpdef save_jpeg(
            self, str filename, cbool progressive=False,
            unsigned int quality=75):
        """Saves the image to a JPEG file.

        :param filename: The filename.
        :param progressive: Whether to save as a progressive JPEG (default
            False).
        :param quality: JPEG image quality in range (0-100) (default 75).
            100 - Superb quality, 75 - Good quality, 50 - Normal quality, 10 -
            Poor quality.
        """
        cdef JPEGOption opt
        cdef bytes filename_b = filename.encode()
        cdef const char * filename_c = filename_b

        opt.progressive = progressive
        opt.quality = quality

        with nogil:
            self._image.get().Save(filename_c, opt)

    cpdef save_jpeg2(self, str filename, unsigned int quality=16):
        """Saves the image to a JPEG2000 file.

        :param filename: The filename.
        :param quality: JPEG image quality in range (1-512) (default 16).
        """
        cdef JPG2Option opt
        cdef bytes filename_b = filename.encode()
        cdef const char * filename_c = filename_b

        opt.quality = quality

        with nogil:
            self._image.get().Save(filename_c, opt)

    cpdef save_bmp(self, str filename, cbool indexed_color_8bit=False):
        """Saves the image to a bmp file.

        :param filename: The filename.
        :param indexed_color_8bit: Whether to save as a 8-bit color index bmp
            (default False).
        """
        cdef BMPOption opt
        cdef bytes filename_b = filename.encode()
        cdef const char * filename_c = filename_b

        opt.indexedColor_8bit = indexed_color_8bit

        with nogil:
            self._image.get().Save(filename_c, opt)

    cpdef get_chunk_data(self):
        """Returns a :class:`ImageChunkData` of the image.

        .. warning::

            The :class:`ImageChunkData` is only valid until :meth:`release` is
            called.
        """
        cdef ImageChunkData chunk = ImageChunkData()
        chunk.set_image(self)
        return chunk


"""
API not implemented:

/**
* Gets a pointer to the user passed data associated with the image.
* This function is considered unsafe. The pointer returned could be
* invalidated if the buffer is released. The pointer may also be
* invalidated if the Image object is passed to
* Image::Release().
*
* TODO: no way to set private data for image yet.
*
* @return A pointer to the user passed data pointer.
*/
void* GetPrivateData() const;

/**
* Retrieves a number of pixel statistics for an image including
* a histogram array of the range of pixel values.
*
* @param pStatistics The statistics of an image.
*/
void CalculateStatistics(ImageStatistics& pStatistics);
"""


cdef class ImageChunkData:
    """Represents some metadata about the raw :class:`Image`.

    .. warning::

        Do **not** create a :class:`ImageChunkData` manually, rather get an
        instance from e.g. :meth:`Image.get_chunk_data`.
    """

    def __cinit__(self):
        self._image = None

    cdef void set_image(self, Image image):
        self._image = image

    cpdef get_black_level(self):
        """Returns the black level used to capture the image.

        Visibility: ``default``.
        """
        cdef float64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetBlackLevel()
        return n

    cpdef get_frame_id(self):
        """Returns the image frame ID.

        Visibility: ``default``.
        """
        cdef int64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetFrameID()
        return n

    cpdef get_exposure_time(self):
        """Returns the exposure time used to capture the image.

        Visibility: ``default``.
        """
        cdef float64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetExposureTime()
        return n

    cpdef get_compression_mode(self):
        """Returns the compression mode of the last image payload.

        Visibility: ``default``.
        """
        cdef int64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetCompressionMode()
        return n

    cpdef get_compression_ratio(self):
        """Returns the compression ratio of the last image payload.

        Visibility: ``default``.
        """
        cdef float64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetCompressionRatio()
        return n

    cpdef get_timestamp(self):
        """Returns the Timestamp of the image.

        Visibility: ``default``.
        """
        cdef int64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetTimestamp()
        return n

    cpdef get_exposure_end_line_status_all(self):
        """Returns the status of all the I/O lines at the end of exposure event.

        Visibility: ``default``.
        """
        cdef int64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetExposureEndLineStatusAll()
        return n

    cpdef get_width(self):
        """Returns the width of the image included in the payload.

        Visibility: ``default``.
        """
        cdef int64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetWidth()
        return n

    cpdef get_image(self):
        """Returns the image payload.

        Visibility: ``default``.
        """
        cdef int64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetImage()
        return n

    cpdef get_height(self):
        """Returns the height of the image included in the payload.

        Visibility: ``default``.
        """
        cdef int64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetHeight()
        return n

    cpdef get_gain(self):
        """Returns the gain used to capture the image.

        Visibility: ``default``.
        """
        cdef float64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetGain()
        return n

    cpdef get_sequencer_set_active(self):
        """Returns the index of the active set of the running sequencer included in the payload.

        Visibility: ``default``.
        """
        cdef int64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetSequencerSetActive()
        return n

    cpdef get_crc(self):
        """Returns the CRC of the image payload.

        Visibility: ``default``.
        """
        cdef int64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetCRC()
        return n

    cpdef get_offset_x(self):
        """Returns the Offset X of the image included in the payload.

        Visibility: ``default``.
        """
        cdef int64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetOffsetX()
        return n

    cpdef get_offset_y(self):
        """Returns the Offset Y of the image included in the payload.

        Visibility: ``default``.
        """
        cdef int64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetOffsetY()
        return n

    cpdef get_serial_data_length(self):
        """Returns the length of the received serial data that was included in the payload.

        Visibility: ``default``.
        """
        cdef int64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetSerialDataLength()
        return n

    cpdef get_part_selector(self):
        """Selects the part to access in chunk data in a multipart transmission.

        Visibility: ``Expert``.
        """
        cdef int64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetPartSelector()
        return n

    cpdef get_pixel_dynamic_range_min(self):
        """Returns the minimum value of dynamic range of the image included in the payload.

        Visibility: ``Expert``.
        """
        cdef int64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetPixelDynamicRangeMin()
        return n

    cpdef get_pixel_dynamic_range_max(self):
        """Returns the maximum value of dynamic range of the image included in the payload.

        Visibility: ``Expert``.
        """
        cdef int64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetPixelDynamicRangeMax()
        return n

    cpdef get_timestamp_latch_value(self):
        """Returns the last Timestamp latched with the TimestampLatch command.

        Visibility: ``Expert``.
        """
        cdef int64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetTimestampLatchValue()
        return n

    cpdef get_line_status_all(self):
        """Returns the status of all the I/O lines at the time of the FrameStart internal event.

        Visibility: ``Expert``.
        """
        cdef int64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetLineStatusAll()
        return n

    cpdef get_counter_value(self):
        """Returns the value of the selected Chunk counter at the time of the FrameStart event.

        Visibility: ``Expert``.
        """
        cdef int64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetCounterValue()
        return n

    cpdef get_timer_value(self):
        """Returns the value of the selected Timer at the time of the FrameStart internal event.

        Visibility: ``Expert``.
        """
        cdef float64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetTimerValue()
        return n

    cpdef get_scan_line_selector(self):
        """Index for vector representation of one chunk value per line in an image.

        Visibility: ``Expert``.
        """
        cdef int64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetScanLineSelector()
        return n

    cpdef get_encoder_value(self):
        """Returns the counter's value of the selected Encoder at the time of the FrameStart in area scan mode or the counter's value at the time of the LineStart selected by ChunkScanLineSelector in LineScan mode.

        Visibility: ``Expert``.
        """
        cdef int64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetEncoderValue()
        return n

    cpdef get_line_pitch(self):
        """Returns the LinePitch of the image included in the payload.

        Visibility: ``Expert``.
        """
        cdef int64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetLinePitch()
        return n

    cpdef get_transfer_block_id(self):
        """Returns the unique identifier of the transfer block used to transport the payload.

        Visibility: ``Expert``.
        """
        cdef int64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetTransferBlockID()
        return n

    cpdef get_transfer_queue_current_block_count(self):
        """Returns the current number of blocks in the transfer queue.

        Visibility: ``Expert``.
        """
        cdef int64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetTransferQueueCurrentBlockCount()
        return n

    cpdef get_stream_channel_id(self):
        """Returns identifier of the stream channel used to carry the block.

        Visibility: ``Expert``.
        """
        cdef int64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetStreamChannelID()
        return n

    cpdef get_scan3d_coordinate_scale(self):
        """Returns the Scale for the selected coordinate axis of the image included in the payload.

        Visibility: ``Expert``.
        """
        cdef float64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetScan3dCoordinateScale()
        return n

    cpdef get_scan3d_coordinate_offset(self):
        """Returns the Offset for the selected coordinate axis of the image included in the payload.

        Visibility: ``Expert``.
        """
        cdef float64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetScan3dCoordinateOffset()
        return n

    cpdef get_scan3d_invalid_data_value(self):
        """Returns the Invalid Data Value used for the image included in the payload.

        Visibility: ``Expert``.
        """
        cdef float64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetScan3dInvalidDataValue()
        return n

    cpdef get_scan3d_axis_min(self):
        """Returns the Minimum Axis value for the selected coordinate axis of the image included in the payload.

        Visibility: ``Expert``.
        """
        cdef float64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetScan3dAxisMin()
        return n

    cpdef get_scan3d_axis_max(self):
        """Returns the Maximum Axis value for the selected coordinate axis of the image included in the payload.

        Visibility: ``Expert``.
        """
        cdef float64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetScan3dAxisMax()
        return n

    cpdef get_scan3d_transform_value(self):
        """Returns the transform value.

        Visibility: ``Expert``.
        """
        cdef float64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetScan3dTransformValue()
        return n

    cpdef get_scan3d_coordinate_reference_value(self):
        """Reads the value of a position or pose coordinate for the anchor or transformed coordinate systems relative to the reference point.

        Visibility: ``Expert``.
        """
        cdef float64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetScan3dCoordinateReferenceValue()
        return n

    cpdef get_inference_frame_id(self):
        """Returns the frame ID associated with the most recent inference result.

        Visibility: ``Expert``.
        """
        cdef int64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetInferenceFrameId()
        return n

    cpdef get_inference_result(self):
        """Returns the chunk data inference result.

        Visibility: ``Expert``.
        """
        cdef int64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetInferenceResult()
        return n

    cpdef get_inference_confidence(self):
        """Returns the chunk data inference confidence percentage.

        Visibility: ``Expert``.
        """
        cdef float64_t n
        with nogil:
            n = self._image._image.get().GetChunkData().GetInferenceConfidence()
        return n

    cpdef get_data(self):
        """Returns a dict with all the chunk data labeled with a visibility of
        ``default``.
        """
        cdef ChunkData chunk = self._image._image.get().GetChunkData()
        cdef dict data = {
            "black_level": chunk.GetBlackLevel(),
            "frame_id": chunk.GetFrameID(),
            "exposure_time": chunk.GetExposureTime(),
            "compression_mode": chunk.GetCompressionMode(),
            "compression_ratio": chunk.GetCompressionRatio(),
            "timestamp": chunk.GetTimestamp(),
            "exposure_end_line_status_all": chunk.GetExposureEndLineStatusAll(),
            "width": chunk.GetWidth(),
            "image": chunk.GetImage(),
            "height": chunk.GetHeight(),
            "gain": chunk.GetGain(),
            "sequencer_set_active": chunk.GetSequencerSetActive(),
            "crc": chunk.GetCRC(),
            "offset_x": chunk.GetOffsetX(),
            "offset_y": chunk.GetOffsetY(),
            "serial_data_length": chunk.GetSerialDataLength(),
        }
        return data

    cpdef get_expert_data(self):
        """Returns a dict with all the chunk data labeled with a visibility of
        ``expert``.
        """
        cdef ChunkData chunk = self._image._image.get().GetChunkData()
        cdef dict data = {
            "part_selector": chunk.GetPartSelector(),
            "pixel_dynamic_range_min": chunk.GetPixelDynamicRangeMin(),
            "pixel_dynamic_range_max": chunk.GetPixelDynamicRangeMax(),
            "timestamp_latch_value": chunk.GetTimestampLatchValue(),
            "line_status_all": chunk.GetLineStatusAll(),
            "counter_value": chunk.GetCounterValue(),
            "timer_value": chunk.GetTimerValue(),
            "scan_line_selector": chunk.GetScanLineSelector(),
            "encoder_value": chunk.GetEncoderValue(),
            "line_pitch": chunk.GetLinePitch(),
            "transfer_block_id": chunk.GetTransferBlockID(),
            "transfer_queue_current_block_count": chunk.GetTransferQueueCurrentBlockCount(),
            "stream_channel_id": chunk.GetStreamChannelID(),
            "scan3d_coordinate_scale": chunk.GetScan3dCoordinateScale(),
            "scan3d_coordinate_offset": chunk.GetScan3dCoordinateOffset(),
            "scan3d_invalid_data_value": chunk.GetScan3dInvalidDataValue(),
            "scan3d_axis_min": chunk.GetScan3dAxisMin(),
            "scan3d_axis_max": chunk.GetScan3dAxisMax(),
            "scan3d_transform_value": chunk.GetScan3dTransformValue(),
            "scan3d_coordinate_reference_value": chunk.GetScan3dCoordinateReferenceValue(),
            "inference_frame_id": chunk.GetInferenceFrameId(),
            "inference_result": chunk.GetInferenceResult(),
            "inference_confidence": chunk.GetInferenceConfidence(),
        }
        return data

    cpdef get_inference_data(self):
        """Returns a :class:`ChunkDataInference` that represents the inferred
        labeling of various areas of the image chunk.
        """
        cdef ChunkDataInference inference = ChunkDataInference()
        inference.set_chunk(self)
        return inference


cdef class ChunkDataInference:
    """Represents object location inference data from a :class:`Image`.

    Some cameras support automatically detecting objects using pre-trained
    machine learning algorithms, :class:`ChunkDataInference` represents
    the inferred object detection.

    .. warning::

        Do **not** create a :class:`ChunkDataInference` manually, rather get an
        instance from e.g. :meth:`ImageChunkData.get_inference_data`.
    """

    def __cinit__(self):
        self.chunk = None

    cdef set_chunk(self, ImageChunkData chunk):
        self.chunk = chunk
        with nogil:
            self.box_result = chunk._image._image.get().GetChunkData(
                ).GetInferenceBoundingBoxResult()

    cpdef get_version(self):
        """Returns the bounding box format version number.
        """
        cdef int8_t n
        with nogil:
            n = self.box_result.GetVersion()
        return n

    cpdef get_box_size(self):
        """Returns the number of bytes allocated for one bounding box.
        """
        cdef int8_t n
        with nogil:
            n = self.box_result.GetBoxSize()
        return n

    cpdef get_num_boxes(self):
        """Returns the number of bounding boxes.
        """
        cdef int16_t n
        with nogil:
            n = self.box_result.GetBoxCount()
        return n

    cpdef get_box(self, uint16_t index):
        """Returns the bounding box at the zero-based ``index`` that
        is less than :meth:`get_num_boxes`.

        The total number of boxes is :meth:`get_num_boxes`.

        :param index: The box index to get.
        :return: Returns a 4-tuple of ``(class, confidence, type, value)``,
            where ``class`` is the class ID of the box, ``confidence`` is our
            confidence in it, type is a string indicating the box type and it's
            one of ``"rect"``, ``"rotated_rect"``, or ``"circle"``. ``value``
            is dependant on the type.

            If type is ``"rect"``, ``value`` is a 4-tuple of
            ``(top_left_x, top_left_y, bottom_right_x, bottom_right_y)``.
            If type is ``"rotated_rect"``, ``value`` is a 5-tuple of
            ``(top_left_x, top_left_y, bottom_right_x, bottom_right_y,
            rotation_angle)``.
            If type is ``"circle"``, ``value`` is a 3-tuple of
            ``(center_x, center_y, radius)``.
        """
        cdef InferenceBoundingBox box
        with nogil:
            box = self.box_result.GetBoxAt(index)

        if box.boxType == INFERENCE_BOX_TYPE_RECTANGLE:
            tp = 'rect'
            val = box.rect.topLeftXCoord, box.rect.topLeftYCoord, \
                box.rect.bottomRightXCoord, box.rect.bottomRightYCoord
        elif box.boxType == INFERENCE_BOX_TYPE_ROTATED_RECTANGLE:
            tp = 'rotated_rect'
            val = box.rotatedRect.topLeftXCoord,\
                box.rotatedRect.topLeftYCoord, \
                box.rotatedRect.bottomRightXCoord,\
                box.rotatedRect.bottomRightYCoord, \
                box.rotatedRect.rotationAngle
        else:
            tp = 'circle'
            val = box.circle.centerXCoord, box.circle.centerYCoord, \
                box.circle.radius

        return box.classId, box.confidence, tp, val

    cpdef get_boxes(self):
        """Returns a list of all the inferred boxes.

        It returns a list of tuples, where each tuple is in the format as
        returned by :meth:`get_box`.
        """
        cdef int16_t n = self.box_result.GetBoxCount()
        cdef uint16_t i
        cdef list boxes = []
        for i in range(n):
            boxes.append(self.get_box(i))
        return boxes
