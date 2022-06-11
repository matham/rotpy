#ifndef ROTPY_EVENT_HANDLER_H
#define ROTPY_EVENT_HANDLER_H


#include "Spinnaker.h"
#include "SpinGenApi/SpinnakerGenApi.h"
#include "DeviceEventHandler.h"
#include "LoggingEventHandler.h"
#include "LoggingEventDataPtr.h"
#include "ImageEventHandler.h"
#include "ImagePtr.h"
#include "InterfaceEventHandler.h"
#include "SystemEventHandler.h"


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


class RotpyLoggingEventHandler : public Spinnaker::LoggingEventHandler
{
  public:
    RotpyLoggingEventHandler(){};
    ~RotpyLoggingEventHandler(){};

    void OnLogEvent(Spinnaker::LoggingEventDataPtr eventPtr)
    {
        m_callback_f(m_callback_data, eventPtr);
    }

    void SetCallback(
        void* callback_data, void (*callback_f)(void*, const Spinnaker::LoggingEventDataPtr))
    {
        m_callback_data = callback_data;
        m_callback_f = callback_f;
    }

  private:
    void* m_callback_data;
    void (*m_callback_f)(void*, const Spinnaker::LoggingEventDataPtr);
};


class RotpyImageEventHandler : public Spinnaker::ImageEventHandler
{
  public:
    RotpyImageEventHandler(){};
    ~RotpyImageEventHandler(){};

    void OnImageEvent(Spinnaker::ImagePtr image)
    {
        m_callback_f(m_callback_data, image);
    }

    void SetCallback(
        void* callback_data, void (*callback_f)(void*, const Spinnaker::ImagePtr))
    {
        m_callback_data = callback_data;
        m_callback_f = callback_f;
    }

  private:
    void* m_callback_data;
    void (*m_callback_f)(void*, const Spinnaker::ImagePtr);
};


class RotpyInterfaceEventHandler : public Spinnaker::InterfaceEventHandler
{
  public:
    RotpyInterfaceEventHandler(){};
    ~RotpyInterfaceEventHandler(){};

    void OnDeviceArrival(uint64_t serialNumber)
    {
        m_callback_f_arrival(m_callback_data, serialNumber);
    }

    void OnDeviceRemoval(uint64_t serialNumber)
    {
        m_callback_f_removal(m_callback_data, serialNumber);
    }

    void SetCallback(
        void* callback_data, void (*callback_f_arrival)(void*, uint64_t),
        void (*callback_f_removal)(void*, uint64_t))
    {
        m_callback_data = callback_data;
        m_callback_f_arrival = callback_f_arrival;
        m_callback_f_removal = callback_f_removal;
    }

  private:
    void* m_callback_data;
    void (*m_callback_f_arrival)(void*, uint64_t);
    void (*m_callback_f_removal)(void*, uint64_t);
};


class RotpySystemEventHandler : public Spinnaker::SystemEventHandler
{
  public:
    RotpySystemEventHandler(){};
    ~RotpySystemEventHandler(){};

    void OnInterfaceArrival(std::string interfaceID)
    {
        m_callback_f_arrival(m_callback_data, interfaceID);
    }

    void OnInterfaceRemoval(std::string interfaceID)
    {
        m_callback_f_removal(m_callback_data, interfaceID);
    }

    void SetCallback(
        void* callback_data, void (*callback_f_arrival)(void*, std::string),
        void (*callback_f_removal)(void*, std::string))
    {
        m_callback_data = callback_data;
        m_callback_f_arrival = callback_f_arrival;
        m_callback_f_removal = callback_f_removal;
    }

  private:
    void* m_callback_data;
    void (*m_callback_f_arrival)(void*, std::string);
    void (*m_callback_f_removal)(void*, std::string);
};

#endif // ROTPY_EVENT_HANDLER_H
