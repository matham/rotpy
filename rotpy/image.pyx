cdef extern from "string.h" nogil:
    void *memcpy(void *, const void *, size_t)

from .names import PixelFormat_names, PixelFormat_values, payload_type_names, \
    payload_type_values, color_processing_algo_names, \
    color_processing_algo_values, pix_fmt_namespace_names, \
    pix_fmt_namespace_values

DEF MAX_BUFF_LEN = 256

__all__ = ('Image',)


cdef class Image:

    data_float_properties = set(
        'BlackLevel', 'ExposureTime', 'CompressionRatio', 'Gain', 'TimerValue',
        'Scan3dCoordinateScale', 'Scan3dCoordinateOffset',
        'Scan3dInvalidDataValue', 'Scan3dAxisMin', 'Scan3dAxisMax',
        'Scan3dTransformValue', 'Scan3dCoordinateReferenceValue',
        'InferenceConfidence')
    """Floating point number properties that can be gotten with
    :meth:`get_data_property`.
    """

    data_int_properties = set(
        'FrameID', 'CompressionMode', 'Timestamp', 'ExposureEndLineStatusAll',
        'Width', 'Image', 'Height', 'SequencerSetActive', 'CRC', 'OffsetX',
        'OffsetY', 'SerialDataLength', 'PartSelector', 'PixelDynamicRangeMin',
        'PixelDynamicRangeMax', 'TimestampLatchValue', 'LineStatusAll',
        'CounterValue', 'ScanLineSelector', 'EncoderValue', 'LinePitch',
        'TransferBlockID', 'TransferQueueCurrentBlockCount', 'StreamChannelID',
        'InferenceFrameId', 'InferenceResult')
    """Integer number properties that can be gotten with
    :meth:`get_data_property`.
    """

    def __cinit__(self):
        self._needs_destroy = 0
        self._needs_release = 0
        self._image_data_ref = None

    def __dealloc__(self):
        self.release()

    @staticmethod
    cdef Image create_from_camera(spinImage spin_img):
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
            check_ret(spinImageCreateEmpty(&img._image))
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
            :attr:`~rotpy.names.PixelFormat_names`.
        :param data: An optional bytes buffer or array containing the data to
            initialize the image with. If None, data is not set.
        :param data_type: The payload type of the data as named in
            :attr:`~rotpy.names.payload_type_names`. See also
            :meth:`get_payload_type`.
        :param data_len: The size of the ``data`` if provided. This is only used
            if the ``data_type`` is also given.
        :return: :class:`Image`.
        """
        return Image.create_image_c(
            width, height, x_offset, y_offset, pix_fmt, data, data_type,
            data_len)

    @staticmethod
    cdef Image create_image_c(
            int width, int height, int x_offset, int y_offset, str pix_fmt,
            data=None, str data_type='', size_t data_len=0
    ):
        cdef spinPixelFormatEnums int_fmt = PixelFormat_names[pix_fmt]
        cdef spinPayloadTypeInfoIDs payload = PAYLOAD_TYPE_UNKNOWN
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
                check_ret(spinImageCreateEx2(
                    &img._image, width, height, x_offset, y_offset, int_fmt,
                    buffer, payload, data_len
                ))
        else:
            with nogil:
                check_ret(spinImageCreateEx(
                    &img._image, width, height, x_offset, y_offset, int_fmt,
                    buffer))
        img._needs_destroy = 1

        return img

    @staticmethod
    def create_image_ref(Image image) -> Image:
        """Creates and returns an image referencing the data from another image
        without copying all its data.
        """
        return Image.create_image_ref_c(image)

    @staticmethod
    cdef Image create_image_ref_c(Image image):
        cdef Image dest = Image()
        dest._image_data_ref = image._image_data_ref
        with nogil:
            check_ret(spinImageCreate(image._image, &dest._image))
            dest._needs_destroy = 1

        return dest

    @staticmethod
    def deep_copy_image(Image image) -> Image:
        """Creates and returns an image by copying all the data from the other
        image.
        """
        return Image.deep_copy_image_c(image)

    @staticmethod
    cdef Image deep_copy_image_c(Image image):
        cdef Image dest = Image()
        dest._image_data_ref = image._image_data_ref
        with nogil:
            check_ret(spinImageCreateEmpty(&dest._image))
            check_ret(spinImageDeepCopy(image._image, dest._image))
            dest._needs_destroy = 1

        return dest

    cpdef release(self):
        """Release the image and its data.

        If the image has been returned from the camera buffer, our hold over it
        is released and the camera can reuse it. If we created the image, it's
        destroyed.

        :meth:`release` must be called to release the image if it was returned
        by the camera. Otherwise, the camera can not use it. For manually
        created images, this is not necessary as it happens automatically. But,
        calling it sooner releases the memory sooner.

        .. warning::

            Once called, all image operations are invalid and image methods
            should not be called.
        """
        if self._needs_destroy:
            self._needs_destroy = 0
            with nogil:
                check_ret(spinImageDestroy(self._image))

        if self._needs_release:
            self._needs_release = 0
            with nogil:
                check_ret(spinImageRelease(self._image))
        self._image_data_ref = None

    @staticmethod
    def set_default_color_processing_algo(str name):
        """Sets the default color processing algorithm of all images (if not
        otherwise set).

        :param name: The name of the color processing algorithm used by default
            as listed in :attr:`~rotpy.names.color_processing_algo_names`.
        """
        cdef spinColorProcessingAlgorithm algorithm = \
            color_processing_algo_names[name]
        with nogil:
            check_ret(spinImageSetDefaultColorProcessing(algorithm))

    @staticmethod
    def get_default_color_processing_algo() -> str:
        """Gets the default color processing algorithm of all images (if not
        otherwise set).

        :return: The name of the color processing algorithm used by default
            as listed in :attr:`~rotpy.names.color_processing_algo_names`.
        """
        cdef spinColorProcessingAlgorithm algorithm
        with nogil:
            check_ret(spinImageGetDefaultColorProcessing(&algorithm))
        return color_processing_algo_values[algorithm]

    cpdef str get_color_processing_algo(self):
        """Gets the color processing algorithm of this image.

        :return: The name of the color processing algorithm used
            as listed in :attr:`~rotpy.names.color_processing_algo_names`.
        """
        cdef spinColorProcessingAlgorithm algorithm
        with nogil:
            check_ret(spinImageGetColorProcessing(self._image, &algorithm))
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
            check_ret(spinImageSetNumDecompressionThreads(num))

    @staticmethod
    def get_compression_threads() -> int:
        """Gets the default number of threads used for image decompression
        during :meth:`convert`.
        """
        cdef unsigned int num
        with nogil:
            check_ret(spinImageGetNumDecompressionThreads(&num))
        return num

    cpdef Image convert_fmt(self, str pix_fmt, str algorithm=''):
        """Converts the image to a new pixel format and optionally using
        a specific algorithm and returns a new image.

        :param pix_fmt: The pixel format name string from
            :attr:`~rotpy.names.PixelFormat_names`.
        :param algorithm: An optional algorithm name string from
            :attr:`~rotpy.names.color_processing_algo_names`. If empty it's not
            set.
        :return: A new :class:`Image`.
        """
        cdef Image dest = Image.create_empty_c()
        cdef spinPixelFormatEnums fmt = PixelFormat_names[pix_fmt]
        cdef spinColorProcessingAlgorithm algo

        if algorithm:
            algo = color_processing_algo_names[algorithm]
            with nogil:
                check_ret(spinImageConvertEx(
                    self._image, fmt, algo, dest._image))
        else:
            with nogil:
                check_ret(spinImageConvert(self._image, fmt, dest._image))

        return dest

    cpdef reset_image(
            self, int width, int height, int x_offset, int y_offset,
            str pix_fmt, data=None
    ):
        """Resets the image to some preset properties.

        :param width: The image width.
        :param height: The image height.
        :param x_offset: The x-offset of the start of the image.
        :param y_offset: The y-offset of the start of the image.
        :param pix_fmt: The pixel format name string from
            :attr:`~rotpy.names.PixelFormat_names`.
        :param data: An optional bytes buffer or array containing the data to
            initialize the image with. If None, data is not set.
        """
        cdef spinPixelFormatEnums int_fmt = PixelFormat_names[pix_fmt]
        cdef unsigned char * buffer = NULL

        if data is not None:
            buffer = data
            with nogil:
                check_ret(spinImageResetEx(
                    &self._image, width, height, x_offset, y_offset, int_fmt,
                    buffer))
            self._image_data_ref = data
        else:
            with nogil:
                check_ret(spinImageReset(
                    &self._image, width, height, x_offset, y_offset, int_fmt))
            self._image_data_ref = None

    cpdef get_image_data_size(self):
        """Gets the size of the image's buffer data.
        """
        cdef size_t n
        with nogil:
            check_ret(spinImageGetBufferSize(self._image, &n))
        return n

    cpdef get_image_data(self):
        """Gets the image's buffer data as a bytearray.

        TODO: Understand the format of the data.
        """
        cdef size_t n
        cdef void* buf
        cdef unsigned char* dest

        with nogil:
            check_ret(spinImageGetBufferSize(self._image, &n))
            check_ret(spinImageGetData(self._image, &buf))

        data = bytearray(b'\0') * n
        dest = data
        memcpy(dest, buf, n)

        return data

    cpdef get_image_id(self):
        """Gets the ID of the image.
        """
        cdef uint64_t n
        with nogil:
            check_ret(spinImageGetID(self._image, &n))
        return n

    cpdef get_width(self):
        """Gets the image's width.
        """
        cdef size_t n
        with nogil:
            check_ret(spinImageGetWidth(self._image, &n))
        return n

    cpdef get_height(self):
        """Gets the image's height.
        """
        cdef size_t n
        with nogil:
            check_ret(spinImageGetHeight(self._image, &n))
        return n

    cpdef get_offset_x(self):
        """Gets the image's x-offset.
        """
        cdef size_t n
        with nogil:
            check_ret(spinImageGetOffsetX(self._image, &n))
        return n

    cpdef get_offset_y(self):
        """Gets the image's y-offset.
        """
        cdef size_t n
        with nogil:
            check_ret(spinImageGetOffsetY(self._image, &n))
        return n

    cpdef get_padding_x(self):
        """Gets the image's x-padding.
        """
        cdef size_t n
        with nogil:
            check_ret(spinImageGetPaddingX(self._image, &n))
        return n

    cpdef get_padding_y(self):
        """Gets the image's y-padding.
        """
        cdef size_t n
        with nogil:
            check_ret(spinImageGetPaddingY(self._image, &n))
        return n

    cpdef get_frame_id(self):
        """Gets the image's acquisition frame ID.
        """
        cdef uint64_t n
        with nogil:
            check_ret(spinImageGetFrameID(self._image, &n))
        return n

    cpdef get_frame_timestamp(self):
        """Gets the image's acquisition timestamp.
        """
        cdef uint64_t n
        with nogil:
            check_ret(spinImageGetTimeStamp(self._image, &n))
        return n

    cpdef str get_payload_type(self):
        """Gets the image's payload type.

        This returns the payload type name string from
        :attr:`~rotpy.names.payload_type_names`.
        """
        cdef size_t n
        with nogil:
            check_ret(spinImageGetPayloadType(self._image, &n))
        return payload_type_values[n]

    cpdef str get_tl_payload_type(self):
        """Gets the image's underlying transport layer payload type.

        This returns the payload type name string from
        :attr:`~rotpy.names.payload_type_names`.
        """
        cdef spinPayloadTypeInfoIDs n
        with nogil:
            check_ret(spinImageGetTLPayloadType(self._image, &n))
        return payload_type_values[n]

    cpdef str get_pix_fmt(self):
        """Gets the image's pixel format.

        This returns the pixel format name string from
        :attr:`~rotpy.names.PixelFormat_names`.
        """
        cdef spinPixelFormatEnums n
        with nogil:
            check_ret(spinImageGetPixelFormat(self._image, &n))
        return PixelFormat_values[n]

    cpdef str get_pix_fmt2(self):
        """Gets the image's pixel format as a string from the image settings.

        It's not clear how this is different from :meth:`get_pix_fmt`, so
        :meth:`get_pix_fmt` should be preferred.

        TODO: understand why this function exists.
        """
        cdef char msg[MAX_BUFF_LEN]
        cdef size_t n = MAX_BUFF_LEN
        with nogil:
            check_ret(spinImageGetPixelFormatName(self._image, msg, &n))
        return msg[:max(n - 1, 0)].decode()

    cpdef str get_tl_pix_fmt(self):
        """Gets the image's underlying transport layer pixel format.

        This returns the pixel format name string from
        :attr:`~rotpy.names.PixelFormat_names`.
        """
        cdef uint64_t n
        with nogil:
            check_ret(spinImageGetTLPixelFormat(self._image, &n))
        return PixelFormat_values[n]

    cpdef str get_tl_pix_fmt_namespace(self):
        """Gets the image's underlying transport layer pixel format namespace.

        This returns the pixel format name string from
        :attr:`~rotpy.names.pix_fmt_namespace_values`.
        """
        cdef spinPixelFormatNamespaceID n
        with nogil:
            check_ret(spinImageGetTLPixelFormatNamespace(self._image, &n))
        return pix_fmt_namespace_values[n]

    cpdef get_valid_data_size(self):
        """Gets the valid data (payload) size of this image.
        """
        cdef size_t n
        with nogil:
            check_ret(spinImageGetValidPayloadSize(self._image, &n))
        return n

    cpdef has_crc(self):
        """Checks whether the image has CRC information available.
        """
        cdef bool8_t n
        with nogil:
            check_ret(spinImageHasCRC(self._image, &n))
        return bool(n)

    cpdef get_crc(self):
        """Returns whether the CRC of the image is correct.
        """
        cdef bool8_t n
        with nogil:
            check_ret(spinImageCheckCRC(self._image, &n))
        return bool(n)

    cpdef get_bits_per_pixel(self):
        """Gets the number of bits per pixel of this image.
        """
        cdef size_t n
        with nogil:
            check_ret(spinImageGetBitsPerPixel(self._image, &n))
        return n

    cpdef get_size(self):
        """Gets the size of this image.
        """
        cdef size_t n
        with nogil:
            check_ret(spinImageGetSize(self._image, &n))
        return n

    cpdef get_stride(self):
        """Gets the stride of this image.
        """
        cdef size_t n
        with nogil:
            check_ret(spinImageGetStride(self._image, &n))
        return n

    cpdef get_data_property(self, str name):
        """Gets a named data property of the image.

        The property names are listed in :attr:`data_float_properties` and
        :attr:`data_int_properties`. If ``name`` is in neither set, an error is
        raised.

        :param name: The name of the property.
        :return: Either a int or float, depending on the property.
        """
        cdef int is_float
        cdef double d_val
        cdef int64_t i_val
        cdef bytes name_b = name.encode()
        cdef const char* name_c = name_b

        if name in self.data_int_properties:
            is_float = 0
        elif name in self.data_float_properties:
            is_float = 1
        else:
            raise ValueError(f'"{name}" is not a recognized data property')

        if is_float:
            with nogil:
                check_ret(spinImageChunkDataGetFloatValue(self._image, name_c, &d_val))
            return d_val
        else:
            with nogil:
                check_ret(spinImageChunkDataGetIntValue(self._image, name_c, &i_val))
            return i_val

    cpdef get_data_int_property(self, str name):
        """Gets a integer named data property of the image.

        The property names are listed in :attr:`data_int_properties`, but we
        don't verify that ``name`` is a valid property, unlike
        :meth:`get_data_property`.

        :param name: The name of the property.
        :return: An integer.
        """
        cdef int64_t val
        cdef bytes name_b = name.encode()
        cdef const char * name_c = name_b
        with nogil:
            check_ret(
                spinImageChunkDataGetIntValue(self._image, name_c, &val))
        return val

    cpdef get_data_float_property(self, str name):
        """Gets a float named data property of the image.

        The property names are listed in :attr:`data_float_properties`, but we
        don't verify that ``name`` is a valid property, unlike
        :meth:`get_data_property`.

        :param name: The name of the property.
        :return: A floating point number.
        """
        cdef double val
        cdef bytes name_b = name.encode()
        cdef const char * name_c = name_b
        with nogil:
            check_ret(
                spinImageChunkDataGetFloatValue(self._image, name_c, &val))
        return val

    cpdef get_layout(self):
        """Gets the data layout of this image.

        TODO: Understand what this means.
        """
        cdef uint64_t n
        with nogil:
            check_ret(spinImageGetChunkLayoutID(self._image, &n))
        return n
