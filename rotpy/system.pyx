
__all__ = ('SpinError', 'SpinSystem')

DEF MAX_BUFF_LEN = 256
ctypedef spinError (*buf_func)(char*, size_t*) nogil


cdef inline str read_buffer(buf_func f):
    cdef char msg[MAX_BUFF_LEN]
    cdef size_t n = MAX_BUFF_LEN
    with nogil:
        check_ret(f(msg, &n))
    return msg[:max(n - 1, 0)]


cdef class SpinError:
    """Provides the API for spinnaker error functions.
    """

    cpdef spinError get_last_error(self):
        """Retrieves the error code of the last error.
        """
        cdef spinError err
        with nogil:
            check_ret(spinErrorGetLast(&err))
        return err

    cpdef str get_last_message(self):
        """Retrieves the error message of the last error.
        """
        return read_buffer(&spinErrorGetLastMessage)

    cpdef str get_last_build_date(self):
        """Retrieves the build date of the last error.
        """
        return read_buffer(&spinErrorGetLastBuildDate)

    cpdef str get_last_build_time(self):
        """Retrieves the build time of the last error.
        """
        return read_buffer(&spinErrorGetLastBuildTime)

    cpdef str get_last_filename(self):
        """Retrieves the filename of the last error.
        """
        return read_buffer(&spinErrorGetLastFileName)

    cpdef str get_last_full_message(self):
        """Retrieves the full error message of the last error.
        """
        return read_buffer(&spinErrorGetLastFullMessage)

    cpdef str get_last_function(self):
        """Retrieves the function name of the last error.
        """
        return read_buffer(&spinErrorGetLastFunctionName)

    cpdef int64_t get_last_line_num(self):
        """Retrieves the error message of the last error.
        """
        cdef int64_t line
        with nogil:
            check_ret(spinErrorGetLastLineNumber(&line))
        return line

    cpdef dict get_error_data(self):
        """Returns a dict with the error info of all the other functions:

        .. code-block:: python

            >>> SpinError().get_error_data()
            {'code': 0,
             'message': '',
             'date': '',
             'time': '',
             'filename': '',
             'full_message': '',
             'function': '',
             'line_num': 0,
             }

        """
        return {
            'code': self.get_last_error(),
            'message': self.get_last_message(),
            'date': self.get_last_build_date(),
            'time': self.get_last_build_time(),
            'filename': self.get_last_filename(),
            'full_message': self.get_last_full_message(),
            'function': self.get_last_function(),
            'line_num': self.get_last_line_num(),
        }


cdef class SpinSystem:
    """Provides access to information, objects, and functionality of the system
    object. This includes the system object, interface and camera lists, and
    interface and logging events.
    """

    def __cinit__(self):
        self._system_set = 0

    def __int__(self):
        with nogil:
            check_ret(spinSystemGetInstance(&self._system))
        self._system_set = 1

    def __dealloc__(self):
        if self._system_set:
            self._system_set = 0
            with nogil:
                check_ret(spinSystemReleaseInstance(self._system))
