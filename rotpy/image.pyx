from .names import PixelFormat_names, PixelFormat_values, payload_type_names, \
    payload_type_values

__all__ = ('Image',)


cdef class Image:

    def __cinit__(self):
        self._needs_destroy = 0
        self._needs_release = 0

    def __dealloc__(self):
        self.release()

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
