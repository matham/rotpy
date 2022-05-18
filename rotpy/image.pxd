from ._interface cimport *


cdef class Image:

    cdef spinImage _image
    cdef int _needs_destroy
    cdef int _needs_release

    @staticmethod
    cdef Image create_empty_c()
    @staticmethod
    cdef Image create_image_c(
            int width, int height, int x_offset, int y_offset, str pix_fmt,
            data=*, str data_type=*, size_t data_len=*
    )
    @staticmethod
    cdef Image create_image_ref_c(Image image)
    @staticmethod
    cdef Image deep_copy_image_c(Image image)
    cpdef release(self)
