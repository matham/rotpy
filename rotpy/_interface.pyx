"""C++ interface
================

Cython module that includes all the C++ header files and defined names.

"""


cdef int raise_spin_exc() except*:
    from rotpy.system import SpinnakerAPIException

    cdef cstr what
    cdef cstr full_msg
    cdef cstr msg
    cdef cstr file_name
    cdef cstr func_name
    cdef cstr build_date
    cdef cstr build_time
    cdef int line_num
    cdef int err
    cdef cbool is_spinnaker = False

    get_spinnaker_exception(
        what, full_msg, msg, file_name, func_name, build_date, build_time,
        &line_num, &err, &is_spinnaker
    )

    if not is_spinnaker:
        if what.size():
            raise RuntimeError(what.c_str().decode())
        raise RuntimeError

    raise SpinnakerAPIException(
        what.c_str().decode() if what.size() else '',
        spin_what=what.c_str().decode() if what.size() else '',
        spin_full_msg=full_msg.c_str().decode() if full_msg.size() else '',
        spin_msg=msg.c_str().decode() if msg.size() else '',
        spin_file_name=file_name.c_str().decode() if file_name.size() else '',
        spin_func_name=func_name.c_str().decode() if func_name.size() else '',
        spin_build_date=build_date.c_str().decode() if build_date.size() else '',
        spin_build_time=build_time.c_str().decode() if build_time.size() else '',
        spin_line_num=line_num, spin_error_code=err
    )
