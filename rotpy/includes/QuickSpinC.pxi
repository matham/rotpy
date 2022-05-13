cdef extern from "QuickSpinC.h" nogil:

    spinError quickSpinInit(spinCamera hCamera, quickSpin* pQuickSpin)

    spinError quickSpinInitEx(spinCamera hCamera, quickSpin* pQuickSpin, quickSpinTLDevice* pQuickSpinTLDevice, quickSpinTLStream* pQuickSpinTLStream)

    spinError quickSpinTLDeviceInit(spinCamera hCamera, quickSpinTLDevice* pQuickSpinTLDevice)

    spinError quickSpinTLStreamInit(spinCamera hCamera, quickSpinTLStream* pQuickSpinTLStream)

    spinError quickSpinTLInterfaceInit(spinInterface hInterface, quickSpinTLInterface* pQuickSpinTLInterface)

    spinError quickSpinTLSystemInit(spinSystem hSystem, quickSpinTLSystem* pQuickSpinTLSystem)

