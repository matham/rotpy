from ._interface cimport *


cdef class Image:

    cdef spinImage _image
    cdef int _needs_destroy
    cdef int _needs_release
    cdef object _image_data_ref

    @staticmethod
    cdef Image create_from_camera(spinImage spin_img)
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
    cpdef str get_color_processing_algo(self)
    cpdef Image convert_fmt(self, str pix_fmt, str algorithm=*)
    cpdef reset_image(
            self, int width, int height, int x_offset, int y_offset,
            str pix_fmt, data=*
    )
    cpdef get_image_data_size(self)
    cpdef get_image_data(self)
    cpdef get_image_id(self)
    cpdef get_width(self)
    cpdef get_height(self)
    cpdef get_offset_x(self)
    cpdef get_offset_y(self)
    cpdef get_padding_x(self)
    cpdef get_padding_y(self)
    cpdef get_frame_id(self)
    cpdef get_frame_timestamp(self)
    cpdef str get_payload_type(self)
    cpdef str get_tl_payload_type(self)
    cpdef str get_pix_fmt(self)
    cpdef str get_tl_pix_fmt(self)
    cpdef str get_tl_pix_fmt_namespace(self)
    cpdef get_valid_data_size(self)
    cpdef has_crc(self)
    cpdef get_crc(self)
    cpdef get_bits_per_pixel(self)
    cpdef get_size(self)
    cpdef get_stride(self)
    cpdef get_data_property(self, str name)
    cpdef get_data_int_property(self, str name)
    cpdef get_data_float_property(self, str name)
