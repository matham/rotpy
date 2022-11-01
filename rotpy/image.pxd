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
    cpdef get_image_data_memoryview(self)
    cpdef copy_image_data(self, unsigned char[:] buffer)
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
    cpdef save_file(self, str filename, str file_format=*)
    cpdef save_png(self, str filename, cbool interlaced=*, unsigned int compression=*)
    cpdef save_ppm(self, str filename, cbool binary=*)
    cpdef save_pgm(self, str filename, cbool binary=*)
    cpdef save_tiff(self, str filename, str compression=*)
    cpdef save_jpeg(self, str filename, cbool progressive=*, unsigned int quality=*)
    cpdef save_jpeg2(self, str filename, unsigned int quality=*)
    cpdef save_bmp(self, str filename, cbool indexed_color_8bit=*)
    cpdef get_chunk_data(self)


cdef class ImageChunkData:

    cdef Image _image

    cdef void set_image(self, Image image)

    cpdef get_black_level(self)
    cpdef get_frame_id(self)
    cpdef get_exposure_time(self)
    cpdef get_compression_mode(self)
    cpdef get_compression_ratio(self)
    cpdef get_timestamp(self)
    cpdef get_exposure_end_line_status_all(self)
    cpdef get_width(self)
    cpdef get_image(self)
    cpdef get_height(self)
    cpdef get_gain(self)
    cpdef get_sequencer_set_active(self)
    cpdef get_crc(self)
    cpdef get_offset_x(self)
    cpdef get_offset_y(self)
    cpdef get_serial_data_length(self)
    cpdef get_part_selector(self)
    cpdef get_pixel_dynamic_range_min(self)
    cpdef get_pixel_dynamic_range_max(self)
    cpdef get_timestamp_latch_value(self)
    cpdef get_line_status_all(self)
    cpdef get_counter_value(self)
    cpdef get_timer_value(self)
    cpdef get_scan_line_selector(self)
    cpdef get_encoder_value(self)
    cpdef get_line_pitch(self)
    cpdef get_transfer_block_id(self)
    cpdef get_transfer_queue_current_block_count(self)
    cpdef get_stream_channel_id(self)
    cpdef get_scan3d_coordinate_scale(self)
    cpdef get_scan3d_coordinate_offset(self)
    cpdef get_scan3d_invalid_data_value(self)
    cpdef get_scan3d_axis_min(self)
    cpdef get_scan3d_axis_max(self)
    cpdef get_scan3d_transform_value(self)
    cpdef get_scan3d_coordinate_reference_value(self)
    cpdef get_inference_frame_id(self)
    cpdef get_inference_result(self)
    cpdef get_inference_confidence(self)
    cpdef get_data(self)
    cpdef get_expert_data(self)
    cpdef get_inference_data(self)


cdef class ChunkDataInference:

    cdef ImageChunkData chunk
    cdef InferenceBoundingBoxResult box_result

    cdef set_chunk(self, ImageChunkData chunk)
    cpdef get_version(self)
    cpdef get_box_size(self)
    cpdef get_num_boxes(self)
    cpdef get_box(self, uint16_t index)
    cpdef get_boxes(self)
