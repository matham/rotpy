#ifndef ROTPY_SPINNAKER_ENUM_WRAPPER_H
#define ROTPY_SPINNAKER_ENUM_WRAPPER_H


#include "Spinnaker.h"
#include "SpinGenApi/IEnumerationT.h"
#include "SpinGenApi/IEnumEntry.h"


interface RotPyEnumWrapper
{
    public:
        RotPyEnumWrapper(){};
        virtual ~RotPyEnumWrapper(){};

        virtual void SetEnumReference(int Index, Spinnaker::GenICam::gcstring Name) = 0;
        virtual void SetNumEnums(int NumEnums) = 0;
        virtual void SetValue(int Value, bool Verify) = 0;
        virtual int GetValue(bool Verify, bool IgnoreCache) = 0;
        virtual Spinnaker::GenApi::IEnumEntry* GetEntry(int Value) = 0;
};


template <typename SpinnakerEnumT>
class RotPyEnumWrapperT: virtual public RotPyEnumWrapper
{
    public:
        RotPyEnumWrapperT(Spinnaker::GenApi::IEnumerationT<SpinnakerEnumT>* handle){
            m_handle = handle;
        }
        ~RotPyEnumWrapperT(){};

        void SetEnumReference(int Index, Spinnaker::GenICam::gcstring Name){
            m_handle->SetEnumReference(Index, Name);
        }
        void SetNumEnums(int NumEnums){
            m_handle->SetNumEnums(NumEnums);
        }
        void SetValue(int Value, bool Verify){
            m_handle->SetValue((SpinnakerEnumT)Value, Verify);
        }
        int GetValue(bool Verify, bool IgnoreCache){
            return (int)m_handle->GetValue(Verify, IgnoreCache);
        }
        Spinnaker::GenApi::IEnumEntry* GetEntry(int Value){
            return m_handle->GetEntry((SpinnakerEnumT)Value);
        }

    private:
        Spinnaker::GenApi::IEnumerationT<SpinnakerEnumT>* m_handle;
};

#endif // ROTPY_SPINNAKER_ENUM_WRAPPER_H
