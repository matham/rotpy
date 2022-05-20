cdef extern from "SpinnakerGenApiC.h" nogil:

    spinError spinNodeMapGetNode(spinNodeMapHandle hNodeMap, const char* pName, spinNodeHandle* phNode)

    spinError spinNodeMapGetNumNodes(spinNodeMapHandle hNodeMap, size_t* pValue)

    spinError spinNodeMapGetNodeByIndex(spinNodeMapHandle hNodeMap, size_t index, spinNodeHandle* phNode)

    spinError spinNodeMapReleaseNode(spinNodeMapHandle hNodeMap, spinNodeHandle hNode)

    spinError spinNodeMapPoll(spinNodeMapHandle hNodeMap, int64_t timestamp)

    spinError spinNodeIsImplemented(spinNodeHandle hNode, bool8_t* pbResult)

    spinError spinNodeIsReadable(spinNodeHandle hNode, bool8_t* pbResult)

    spinError spinNodeIsWritable(spinNodeHandle hNode, bool8_t* pbResult)

    spinError spinNodeIsAvailable(spinNodeHandle hNode, bool8_t* pbResult)

    spinError spinNodeIsEqual(spinNodeHandle hNodeFirst, spinNodeHandle hNodeSecond, bool8_t* pbResult)

    spinError spinNodeGetAccessMode(spinNodeHandle hNode, spinAccessMode* pAccessMode)

    spinError spinNodeGetName(spinNodeHandle hNode, char* pBuf, size_t* pBufLen)

    spinError spinNodeGetNameSpace(spinNodeHandle hNode, spinNameSpace* pNamespace)

    spinError spinNodeGetVisibility(spinNodeHandle hNode, spinVisibility* pVisibility)

    spinError spinNodeInvalidateNode(spinNodeHandle hNode)

    spinError spinNodeGetCachingMode(spinNodeHandle hNode, spinCachingMode* pCachingMode)

    spinError spinNodeGetToolTip(spinNodeHandle hNode, char* pBuf, size_t* pBufLen)

    spinError spinNodeGetDescription(spinNodeHandle hNode, char* pBuf, size_t* pBufLen)

    spinError spinNodeGetDisplayName(spinNodeHandle hNode, char* pBuf, size_t* pBufLen)

    spinError spinNodeGetType(spinNodeHandle hNode, spinNodeType* pType)

    spinError spinNodeGetPollingTime(spinNodeHandle hNode, int64_t* pPollingTime)

    spinError spinNodeRegisterCallback(spinNodeHandle hNode, spinNodeCallbackFunction pCbFunction, spinNodeCallbackHandle* phCb)

    spinError spinNodeDeregisterCallback(spinNodeHandle hNode, spinNodeCallbackHandle hCb)

    spinError spinNodeGetImposedAccessMode(spinNodeHandle hNode, spinAccessMode imposedAccessMode)

    spinError spinNodeGetImposedVisibility(spinNodeHandle hNode, spinVisibility imposedVisibility)

    spinError spinNodeToString(spinNodeHandle hNode, char* pBuf, size_t* pBufLen)

    spinError spinNodeToStringEx(spinNodeHandle hNode, bool8_t bVerify, char* pBuf, size_t* pBufLen)

    spinError spinNodeFromString(spinNodeHandle hNode, const char* pBuf)

    spinError spinNodeFromStringEx(spinNodeHandle hNode, bool8_t bVerify, const char* pBuf)

    spinError spinStringSetValue(spinNodeHandle hNode, const char* pBuf)

    spinError spinStringSetValueEx(spinNodeHandle hNode, bool8_t bVerify, const char* pBuf)

    spinError spinStringGetValue(spinNodeHandle hNode, char* pBuf, size_t* pBufLen)

    spinError spinStringGetValueEx(spinNodeHandle hNode, bool8_t bVerify, char* pBuf, size_t* pBufLen)

    spinError spinStringGetMaxLength(spinNodeHandle hNode, int64_t* pValue)

    spinError spinIntegerSetValue(spinNodeHandle hNode, int64_t value)

    spinError spinIntegerSetValueEx(spinNodeHandle hNode, bool8_t bVerify, int64_t value)

    spinError spinIntegerGetValue(spinNodeHandle hNode, int64_t* pValue)

    spinError spinIntegerGetValueEx(spinNodeHandle hNode, bool8_t bVerify, int64_t* pValue)

    spinError spinIntegerGetMin(spinNodeHandle hNode, int64_t* pValue)

    spinError spinIntegerGetMax(spinNodeHandle hNode, int64_t* pValue)

    spinError spinIntegerGetInc(spinNodeHandle hNode, int64_t* pValue)

    spinError spinIntegerGetRepresentation(spinNodeHandle hNode, spinRepresentation* pValue)

    spinError spinFloatSetValue(spinNodeHandle hNode, double value)

    spinError spinFloatSetValueEx(spinNodeHandle hNode, bool8_t bVerify, double value)

    spinError spinFloatGetValue(spinNodeHandle hNode, double* pValue)

    spinError spinFloatGetValueEx(spinNodeHandle hNode, bool8_t bVerify, double* pValue)

    spinError spinFloatGetMin(spinNodeHandle hNode, double* pValue)

    spinError spinFloatGetMax(spinNodeHandle hNode, double* pValue)

    spinError spinFloatGetRepresentation(spinNodeHandle hNode, spinRepresentation* pValue)

    spinError spinFloatGetUnit(spinNodeHandle hNode, char* pBuf, size_t* pBufLen)

    spinError spinEnumerationGetNumEntries(spinNodeHandle hEnumNode, size_t* pValue)

    spinError spinEnumerationGetEntryByIndex(spinNodeHandle hEnumNode, size_t index, spinNodeHandle* phEntry)

    spinError spinEnumerationGetEntryByName(spinNodeHandle hEnumNode, const char* pName, spinNodeHandle* phEntry)

    spinError spinEnumerationGetCurrentEntry(spinNodeHandle hEnumNode, spinNodeHandle* phEntry)

    spinError spinEnumerationReleaseNode(spinNodeHandle hEnumNode, spinNodeHandle hEntry)

    spinError spinEnumerationSetIntValue(spinNodeHandle hEnumNode, int64_t value)

    spinError spinEnumerationSetEnumValue(spinNodeHandle hEnumNode, size_t value)

    spinError spinEnumerationEntryGetIntValue(spinNodeHandle hNode, int64_t* pValue)

    spinError spinEnumerationEntryGetEnumValue(spinNodeHandle hNode, size_t* pValue)

    spinError spinEnumerationEntryGetSymbolic(spinNodeHandle hNode, char* pBuf, size_t* pBufLen)

    spinError spinBooleanSetValue(spinNodeHandle hNode, bool8_t value)

    spinError spinBooleanGetValue(spinNodeHandle hNode, bool8_t* pbValue)

    spinError spinCommandExecute(spinNodeHandle hNode)

    spinError spinCommandIsDone(spinNodeHandle hNode, bool8_t* pbValue)

    spinError spinCategoryGetNumFeatures(spinNodeHandle hCategoryNode, size_t* pValue)

    spinError spinCategoryGetFeatureByIndex(spinNodeHandle hCategoryNode, size_t index, spinNodeHandle* phFeature)

    spinError spinCategoryReleaseNode(spinNodeHandle hCategoryNode, spinNodeHandle hFeature)

    spinError spinRegisterGet(spinNodeHandle hNode, uint8_t* pBuf, int64_t length)

    spinError spinRegisterGetEx(spinNodeHandle hNode, bool8_t bVerify, bool8_t bIgnoreCache, uint8_t* pBuf, int64_t length)

    spinError spinRegisterGetAddress(spinNodeHandle hNode, int64_t* pAddress)

    spinError spinRegisterGetLength(spinNodeHandle hNode, int64_t* pLength)

    spinError spinRegisterSet(spinNodeHandle hNode, const uint8_t* pBuf, int64_t length)

    spinError spinRegisterSetEx(spinNodeHandle hNode, bool8_t bVerify, const uint8_t* pBuf, int64_t length)

    spinError spinRegisterSetReference(spinNodeHandle hNode, spinNodeHandle hRef)
