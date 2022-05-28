#
#
# cdef int check_ret(spinError ret) nogil except 1:
#     if ret == SPINNAKER_ERR_SUCCESS:
#         return 0
#
#     cdef char msg[256]
#     cdef size_t msg_len = sizeof(msg)
#     cdef spinError ret2
#     ret2 = spinErrorGetLastMessage(msg, &msg_len)
#
#     with gil:
#         name = b'unknown'
#         if ret2 == SPINNAKER_ERR_SUCCESS:
#             name = msg[:max(msg_len - 1, 0)]
#         raise Exception(f'Spinnaker error: "{name.decode()}", code: {ret}')
