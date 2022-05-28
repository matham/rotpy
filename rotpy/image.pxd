from ._interface cimport *


cdef class Image:

    cdef ImagePtr _image
    cdef int _needs_destroy
    cdef int _needs_release
    cdef object _image_data_ref

    @staticmethod
    cdef Image create_from_camera(ImagePtr spin_img)
    @staticmethod
    cdef Image create_empty_c()
    @staticmethod
    cdef Image create_image_c(
            int width, int height, int x_offset, int y_offset, str pix_fmt,
            data=*, str data_type=*, size_t data_len=*
    )
    @staticmethod
    cdef Image deep_copy_image_c(Image image)
    cpdef deep_copy_from(self, Image source)
    cpdef release(self)
    cpdef str get_color_processing_algo(self)
    cpdef Image convert_fmt(self, str pix_fmt, str algorithm=*, Image dest=*)
    cpdef reset_image(
            self, int width, int height, int x_offset, int y_offset,
            str pix_fmt, data=*, str data_type=*, size_t data_len=*
    )
    cpdef get_valid_payload_size(self)
    cpdef get_buffer_size(self)
    cpdef get_image_data_size(self)
    cpdef get_image_data(self)
    cpdef get_data_max(self)
    cpdef get_data_min(self)
    cpdef get_image_id(self)
    cpdef get_width(self)
    cpdef get_height(self)
    cpdef get_offset_x(self)
    cpdef get_offset_y(self)
    cpdef get_padding_x(self)
    cpdef get_padding_y(self)
    cpdef get_stride(self)
    cpdef get_bits_per_pixel(self)
    cpdef get_num_channels(self)
    cpdef get_frame_id(self)
    cpdef get_frame_timestamp(self)
    cpdef get_payload_type(self)
    cpdef get_tl_payload_type(self)
    cpdef get_pix_fmt(self)
    cpdef get_pix_fmt_int_type(self)
    cpdef get_pix_fmt_sfnc(self)
    cpdef get_tl_pix_fmt(self)
    cpdef get_tl_pix_fmt_namespace(self)
    cpdef get_layout_id(self)
    cpdef get_completed(self)
    cpdef has_crc(self)
    cpdef get_crc(self)
    cpdef get_in_use(self)
    cpdef get_is_compressed(self)
    cpdef get_status(self)
    @staticmethod
    cdef str get_status_description_c(str status)
