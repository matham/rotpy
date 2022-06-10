#ifndef ROTPY_EVENT_HANDLER_H
#define ROTPY_EVENT_HANDLER_H


#include "Spinnaker.h"
#include "SpinGenApi/SpinnakerGenApi.h"
#include "Interface/IDeviceEventHandler.h"


class RotpyDeviceEventHandler : public Spinnaker::DeviceEventHandler
{
  public:
    RotpyDeviceEventHandler(){};
    ~RotpyDeviceEventHandler(){};

    void OnDeviceEvent(Spinnaker::GenICam::gcstring eventName)
    {
        if (m_eventName.empty() || eventName == m_eventName)
        {
            m_callback_f(m_callback_data, &eventName);
        }
    }

    void SetCallback(
        void* callback_data, void (*callback_f)(void*, const Spinnaker::GenICam::gcstring*),
        Spinnaker::GenICam::gcstring &eventName)
    {
        m_callback_data = callback_data;
        m_callback_f = callback_f;
        m_eventName = eventName;
    }

  private:
    void* m_callback_data;
    void (*m_callback_f)(void*, const Spinnaker::GenICam::gcstring*);
    Spinnaker::GenICam::gcstring m_eventName;
};

#endif // ROTPY_EVENT_HANDLER_H
