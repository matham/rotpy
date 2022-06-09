cdef extern from "string.h" nogil:
    void *memcpy(void *, const void *, size_t)

from .names.spin import payload_type_names, \
    payload_type_values, color_processing_algo_names, \
    color_processing_algo_values, \
    pix_fmt_namespace_values, pix_fmt_int_values,\
    img_status_values, img_status_names
from .names.camera import PixelFormat_values, PixelFormat_names

DEF MAX_BUFF_LEN = 256

__all__ = ('Image',)


cdef class Image:

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
        """Creates and returns an empty image.
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

        TODO: Consider returning memoryview of the pointer.
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
