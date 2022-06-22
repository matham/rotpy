#ifndef ROTPY_SPINNAKER_EXCEPTION_H
#define ROTPY_SPINNAKER_EXCEPTION_H


#include "Spinnaker.h"
#include "Exception.h"


void get_spinnaker_exception(
    std::string &what, std::string &full_msg, std::string &msg,
    std::string &file_name, std::string &func_name, std::string &build_date,
    std::string &build_time, int *line_num, int *err, bool *is_spinnaker)
{
    try {
        throw;
    } catch(const Spinnaker::Exception& exn) {
        what.assign(exn.what());
        full_msg.assign(exn.GetFullErrorMessage());
        msg.assign(exn.GetErrorMessage());
        file_name.assign(exn.GetFileName());
        func_name.assign(exn.GetFunctionName());
        build_date.assign(exn.GetBuildDate());
        build_time.assign(exn.GetBuildTime());
        *line_num = exn.GetLineNumber();
        *err = exn.GetError();
        *is_spinnaker = true;
    } catch (const std::exception& exn) {
        *is_spinnaker = false;
        what.assign(exn.what());
    } catch(...) {
        *is_spinnaker = false;
    }
}

#endif // ROTPY_SPINNAKER_EXCEPTION_H
