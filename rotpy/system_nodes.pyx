"""System nodes
===============

Lists all the pre-listed nodes of the :class:`~rotpy.system.SpinSystem` and
:class:`~rotpy.system.InterfaceDevice`.

"""
from .node cimport SpinIntNode, SpinFloatNode, SpinBoolNode, SpinStrNode, \
    SpinCommandNode, SpinRegisterNode, SpinEnumDefNode, SpinBaseNode

from .node import SpinIntNode, SpinFloatNode, SpinBoolNode, SpinStrNode, \
    SpinCommandNode, SpinRegisterNode, SpinEnumDefNode
import rotpy.names.camera
import rotpy.names.tl
import rotpy.names.spin
import rotpy.names.geni

__all__ = ('SystemNodes', 'InterfaceNodes')


cdef class SystemNodes:
    """Lists all the pre-listed nodes of the :class:`~rotpy.system.SpinSystem`.

    .. warning::

        Do **not** create a :class:`SystemNodes` manually, rather get it
        from :attr:`~rotpy.system.SpinSystem.system_nodes` that is automatically
        created when the system is instantiated.

    .. warning::

        Once the associated system is freed, the nodes are not valid anymore.

    .. note::

        Even though the nodes are pre-listed, it is simply a convenience and
        the same nodes can be gotten by name through
        :class:`~rotpy.node.NodeMap`. Additionally, you must check that the
        node is actually available, readable etc, even if it's pre-listed.
    """

    def __cinit__(self, system):
        self._system = system
        self._nodes = {}

        self.bool_nodes = ['EnumerateGEVInterfaces', 'EnumerateUSBInterfaces',
                           'EnumerateGen2Cameras']
        self.int_nodes = ['GenTLVersionMajor', 'GenTLVersionMinor',
                          'GenTLSFNCVersionMajor', 'GenTLSFNCVersionMinor',
                          'GenTLSFNCVersionSubMinor', 'GevVersionMajor',
                          'GevVersionMinor', 'InterfaceSelector',
                          'GevInterfaceMACAddress',
                          'GevInterfaceDefaultIPAddress',
                          'GevInterfaceDefaultSubnetMask',
                          'GevInterfaceDefaultGateway']
        self.float_nodes = []
        self.str_nodes = ['TLID', 'TLVendorName', 'TLModelName', 'TLVersion',
                          'TLFileName', 'TLDisplayName', 'TLPath',
                          'InterfaceID', 'InterfaceDisplayName']
        self.enum_nodes = ['TLType']
        self.command_nodes = ['InterfaceUpdateList']
        self.register_nodes = []

    def __init__(self, system):
        pass

    cdef clear_system(self):
        cdef SpinBaseNode node
        for node in self._nodes.values():
            node.clear_handle()
        self._nodes = {}
        self._system = None

    @property
    def TLID(self) -> SpinStrNode:
        """Unique identifier of the GenTL Producer like a GUID.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("TLID")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._system._system.get().TLSystem.TLID))
            node = self._nodes["TLID"] = node_inst
        return node

    @property
    def TLVendorName(self) -> SpinStrNode:
        """Name of the GenTL Producer vendor.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("TLVendorName")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._system._system.get().TLSystem.TLVendorName))
            node = self._nodes["TLVendorName"] = node_inst
        return node

    @property
    def TLModelName(self) -> SpinStrNode:
        """Name of the GenTL Producer to distinguish different kinds of GenTL
        Producer implementations from one vendor.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("TLModelName")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._system._system.get().TLSystem.TLModelName))
            node = self._nodes["TLModelName"] = node_inst
        return node

    @property
    def TLVersion(self) -> SpinStrNode:
        """Vendor specific version string.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("TLVersion")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._system._system.get().TLSystem.TLVersion))
            node = self._nodes["TLVersion"] = node_inst
        return node

    @property
    def TLFileName(self) -> SpinStrNode:
        """Filename including extension of the GenTL Producer.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("TLFileName")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._system._system.get().TLSystem.TLFileName))
            node = self._nodes["TLFileName"] = node_inst
        return node

    @property
    def TLDisplayName(self) -> SpinStrNode:
        """User readable name of the GenTL Producer.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("TLDisplayName")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._system._system.get().TLSystem.TLDisplayName))
            node = self._nodes["TLDisplayName"] = node_inst
        return node

    @property
    def TLPath(self) -> SpinStrNode:
        """Full path to the GenTL Producer including filename and extension.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("TLPath")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._system._system.get().TLSystem.TLPath))
            node = self._nodes["TLPath"] = node_inst
        return node

    @property
    def TLType(self) -> SpinEnumDefNode:
        """Transport layer type of the GenTL Producer implementation.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.tl.TLType_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("TLType")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._system._system.get().TLSystem.TLType))
            node_inst.set_wrapper(
                dynamic_cast[RotPyEnumWrapperPointer](
                    new RotPyEnumWrapperT[TLTypeEnum](
                        &self._system._system.get().TLSystem.TLType)))
            node_inst.enum_names = rotpy.names.tl.TLType_names
            node_inst.enum_values = rotpy.names.tl.TLType_values
            node = self._nodes["TLType"] = node_inst
        return node

    @property
    def GenTLVersionMajor(self) -> SpinIntNode:
        """Major version number of the GenTL specification the GenTL Producer
        implementation complies with.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GenTLVersionMajor")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._system._system.get().TLSystem.GenTLVersionMajor))
            node = self._nodes["GenTLVersionMajor"] = node_inst
        return node

    @property
    def GenTLVersionMinor(self) -> SpinIntNode:
        """Minor version number of the GenTL specification the GenTL Producer
        implementation complies with.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GenTLVersionMinor")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._system._system.get().TLSystem.GenTLVersionMinor))
            node = self._nodes["GenTLVersionMinor"] = node_inst
        return node

    @property
    def GenTLSFNCVersionMajor(self) -> SpinIntNode:
        """Major version number of the GenTL Standard Features Naming
        Convention that was used to create the GenTL Producer`s XML.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GenTLSFNCVersionMajor")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._system._system.get().TLSystem.GenTLSFNCVersionMajor))
            node = self._nodes["GenTLSFNCVersionMajor"] = node_inst
        return node

    @property
    def GenTLSFNCVersionMinor(self) -> SpinIntNode:
        """Minor version number of the GenTL Standard Features Naming
        Convention that was used to create the GenTL Producer`s XML.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GenTLSFNCVersionMinor")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._system._system.get().TLSystem.GenTLSFNCVersionMinor))
            node = self._nodes["GenTLSFNCVersionMinor"] = node_inst
        return node

    @property
    def GenTLSFNCVersionSubMinor(self) -> SpinIntNode:
        """Sub minor version number of the GenTL Standard Features Naming
        Convention that was used to create the GenTL Producer`s XML.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GenTLSFNCVersionSubMinor")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._system._system.get().TLSystem.GenTLSFNCVersionSubMinor))
            node = self._nodes["GenTLSFNCVersionSubMinor"] = node_inst
        return node

    @property
    def GevVersionMajor(self) -> SpinIntNode:
        """Major version number of the GigE Vision specification the GenTL
        Producer implementation complies to.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevVersionMajor")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._system._system.get().TLSystem.GevVersionMajor))
            node = self._nodes["GevVersionMajor"] = node_inst
        return node

    @property
    def GevVersionMinor(self) -> SpinIntNode:
        """Minor version number of the GigE Vision specification the GenTL
        Producer implementation complies to.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevVersionMinor")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._system._system.get().TLSystem.GevVersionMinor))
            node = self._nodes["GevVersionMinor"] = node_inst
        return node

    @property
    def InterfaceUpdateList(self) -> SpinCommandNode:
        """Updates the internal list of the interfaces. This feature is
        readable even if the execution cannot be performed immediately. The
        command then returns and the status can be polled. This function
        interacts with the TLUpdateInterfaceList function of the GenTL
        producer. It is up to the GenTL consumer to handle access in case
        both methods are used.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("InterfaceUpdateList")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._system._system.get().TLSystem.InterfaceUpdateList))
            node = self._nodes["InterfaceUpdateList"] = node_inst
        return node

    @property
    def InterfaceSelector(self) -> SpinIntNode:
        """Selector for the different GenTL Producer interfaces. This interface
        list only changes on execution of "InterfaceUpdateList". The
        selector is 0-based in order to match the index of the C interface.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("InterfaceSelector")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._system._system.get().TLSystem.InterfaceSelector))
            node = self._nodes["InterfaceSelector"] = node_inst
        return node

    @property
    def InterfaceID(self) -> SpinStrNode:
        """GenTL Producer wide unique identifier of the selected interface.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("InterfaceID")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._system._system.get().TLSystem.InterfaceID))
            node = self._nodes["InterfaceID"] = node_inst
        return node

    @property
    def InterfaceDisplayName(self) -> SpinStrNode:
        """A user-friendly name of the selected Interface.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("InterfaceDisplayName")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._system._system.get().TLSystem.InterfaceDisplayName))
            node = self._nodes["InterfaceDisplayName"] = node_inst
        return node

    @property
    def GevInterfaceMACAddress(self) -> SpinIntNode:
        """48-bit MAC address of the selected interface. Note that for a GenTL
        Producer implementation supporting GigE Vision this feature is
        mandatory.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevInterfaceMACAddress")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._system._system.get().TLSystem.GevInterfaceMACAddress))
            node = self._nodes["GevInterfaceMACAddress"] = node_inst
        return node

    @property
    def GevInterfaceDefaultIPAddress(self) -> SpinIntNode:
        """IP address of the first subnet of the selected interface. Note that
        for a GenTL Producer implementation supporting GigE Vision this
        feature is mandatory.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevInterfaceDefaultIPAddress")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._system._system.get().TLSystem.GevInterfaceDefaultIPAddress))
            node = self._nodes["GevInterfaceDefaultIPAddress"] = node_inst
        return node

    @property
    def GevInterfaceDefaultSubnetMask(self) -> SpinIntNode:
        """Subnet mask of the first subnet of the selected interface. Note that
        for a GenTL Producer implementation supporting GigE Vision this
        feature is mandatory.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevInterfaceDefaultSubnetMask")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._system._system.get().TLSystem.GevInterfaceDefaultSubnetMask))
            node = self._nodes["GevInterfaceDefaultSubnetMask"] = node_inst
        return node

    @property
    def GevInterfaceDefaultGateway(self) -> SpinIntNode:
        """Gateway of the selected interface.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevInterfaceDefaultGateway")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._system._system.get().TLSystem.GevInterfaceDefaultGateway))
            node = self._nodes["GevInterfaceDefaultGateway"] = node_inst
        return node

    @property
    def EnumerateGEVInterfaces(self) -> SpinBoolNode:
        """Enables or disables enumeration of GEV Interfaces.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("EnumerateGEVInterfaces")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._system._system.get().TLSystem.EnumerateGEVInterfaces))
            node = self._nodes["EnumerateGEVInterfaces"] = node_inst
        return node

    @property
    def EnumerateUSBInterfaces(self) -> SpinBoolNode:
        """Enables or disables enumeration of USB Interfaces.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("EnumerateUSBInterfaces")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._system._system.get().TLSystem.EnumerateUSBInterfaces))
            node = self._nodes["EnumerateUSBInterfaces"] = node_inst
        return node

    @property
    def EnumerateGen2Cameras(self) -> SpinBoolNode:
        """Enables or disables the enumeration of USB3 and GigE based
        Generation 2 cameras. This includes the CM3, FL3, GS3, and BFLY
        families.

        :Property type: :class:`~rotpy.node.SpinBoolNode`.
        :Visibility: ``default``.
        """
        cdef SpinBoolNode node_inst
        node = self._nodes.get("EnumerateGen2Cameras")
        if node is None:
            node_inst = SpinBoolNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._system._system.get().TLSystem.EnumerateGen2Cameras))
            node = self._nodes["EnumerateGen2Cameras"] = node_inst
        return node


cdef class InterfaceNodes:
    """Lists all the pre-listed nodes of the
    :class:`~rotpy.system.InterfaceDevice`.

    .. warning::

        Do **not** create a :class:`InterfaceNodes` manually, rather get it
        from :attr:`~rotpy.system.InterfaceDevice.interface_nodes` that is
        automatically created when the interface is instantiated.

    .. warning::

        Once the associated interface is freed, the nodes are not valid anymore.

    .. note::

        Even though the nodes are pre-listed, it is simply a convenience and
        the same nodes can be gotten by name through
        :class:`~rotpy.node.NodeMap`. Additionally, you must check that the
        node is actually available, readable etc, even if it's pre-listed.
    """

    def __cinit__(self, interface):
        self._interface = interface
        self._nodes = {}

        self.bool_nodes = []
        self.int_nodes = ['GevInterfaceGatewaySelector', 'GevInterfaceGateway',
                          'GevInterfaceMACAddress',
                          'GevInterfaceSubnetSelector',
                          'GevInterfaceSubnetIPAddress',
                          'GevInterfaceSubnetMask',
                          'GevInterfaceTransmitLinkSpeed',
                          'GevInterfaceReceiveLinkSpeed', 'GevInterfaceMTU',
                          'GevActionDeviceKey', 'GevActionGroupKey',
                          'GevActionGroupMask', 'GevActionTime', 'DeviceCount',
                          'DeviceSelector', 'GevDeviceIPAddress',
                          'GevDeviceSubnetMask', 'GevDeviceGateway',
                          'GevDeviceMACAddress', 'IncompatibleDeviceCount',
                          'IncompatibleDeviceSelector',
                          'IncompatibleGevDeviceIPAddress',
                          'IncompatibleGevDeviceSubnetMask',
                          'IncompatibleGevDeviceMACAddress',
                          'GevDeviceForceIPAddress', 'GevDeviceForceSubnetMask',
                          'GevDeviceForceGateway']
        self.float_nodes = []
        self.str_nodes = ['InterfaceID', 'InterfaceDisplayName', 'DeviceUnlock',
                          'DeviceID', 'DeviceVendorName', 'DeviceModelName',
                          'DeviceSerialNumber', 'IncompatibleDeviceID',
                          'IncompatibleDeviceVendorName',
                          'IncompatibleDeviceModelName', 'HostAdapterName',
                          'HostAdapterVendor', 'HostAdapterDriverVersion']
        self.enum_nodes = ['InterfaceType', 'POEStatus', 'FilterDriverStatus',
                           'DeviceAccessStatus']
        self.command_nodes = ['ActionCommand', 'DeviceUpdateList',
                              'GevDeviceForceIP', 'GevDeviceAutoForceIP']
        self.register_nodes = []

    def __init__(self, interface):
        pass

    cdef clear_interface(self):
        cdef SpinBaseNode node
        for node in self._nodes.values():
            node.clear_handle()
        self._nodes = {}
        self._interface = None

    @property
    def InterfaceID(self) -> SpinStrNode:
        """Transport layer Producer wide unique identifier of the selected
        interface.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("InterfaceID")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.InterfaceID))
            node = self._nodes["InterfaceID"] = node_inst
        return node

    @property
    def InterfaceDisplayName(self) -> SpinStrNode:
        """User readable name of the selected interface.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("InterfaceDisplayName")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.InterfaceDisplayName))
            node = self._nodes["InterfaceDisplayName"] = node_inst
        return node

    @property
    def InterfaceType(self) -> SpinEnumDefNode:
        """Transport layer type of the interface.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.tl.InterfaceType_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("InterfaceType")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.InterfaceType))
            node_inst.set_wrapper(
                dynamic_cast[RotPyEnumWrapperPointer](
                    new RotPyEnumWrapperT[InterfaceTypeEnum](
                        &self._interface._interface.get().TLInterface.InterfaceType)))
            node_inst.enum_names = rotpy.names.tl.InterfaceType_names
            node_inst.enum_values = rotpy.names.tl.InterfaceType_values
            node = self._nodes["InterfaceType"] = node_inst
        return node

    @property
    def GevInterfaceGatewaySelector(self) -> SpinIntNode:
        """Selector for the different gateway entries for this interface.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevInterfaceGatewaySelector")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.GevInterfaceGatewaySelector))
            node = self._nodes["GevInterfaceGatewaySelector"] = node_inst
        return node

    @property
    def GevInterfaceGateway(self) -> SpinIntNode:
        """IP address of the selected gateway entry of this interface.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevInterfaceGateway")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.GevInterfaceGateway))
            node = self._nodes["GevInterfaceGateway"] = node_inst
        return node

    @property
    def GevInterfaceMACAddress(self) -> SpinIntNode:
        """48-bit MAC address of this interface.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevInterfaceMACAddress")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.GevInterfaceMACAddress))
            node = self._nodes["GevInterfaceMACAddress"] = node_inst
        return node

    @property
    def GevInterfaceSubnetSelector(self) -> SpinIntNode:
        """Selector for the subnet of this interface.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevInterfaceSubnetSelector")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.GevInterfaceSubnetSelector))
            node = self._nodes["GevInterfaceSubnetSelector"] = node_inst
        return node

    @property
    def GevInterfaceSubnetIPAddress(self) -> SpinIntNode:
        """IP address of the selected subnet of this interface.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevInterfaceSubnetIPAddress")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.GevInterfaceSubnetIPAddress))
            node = self._nodes["GevInterfaceSubnetIPAddress"] = node_inst
        return node

    @property
    def GevInterfaceSubnetMask(self) -> SpinIntNode:
        """Subnet mask of the selected subnet of this interface.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevInterfaceSubnetMask")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.GevInterfaceSubnetMask))
            node = self._nodes["GevInterfaceSubnetMask"] = node_inst
        return node

    @property
    def GevInterfaceTransmitLinkSpeed(self) -> SpinIntNode:
        """Transmit link speed of this interface in bits per second.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevInterfaceTransmitLinkSpeed")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.GevInterfaceTransmitLinkSpeed))
            node = self._nodes["GevInterfaceTransmitLinkSpeed"] = node_inst
        return node

    @property
    def GevInterfaceReceiveLinkSpeed(self) -> SpinIntNode:
        """Receive link speed of this interface in bits per second.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevInterfaceReceiveLinkSpeed")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.GevInterfaceReceiveLinkSpeed))
            node = self._nodes["GevInterfaceReceiveLinkSpeed"] = node_inst
        return node

    @property
    def GevInterfaceMTU(self) -> SpinIntNode:
        """Maximum transmission unit of this interface.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevInterfaceMTU")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.GevInterfaceMTU))
            node = self._nodes["GevInterfaceMTU"] = node_inst
        return node

    @property
    def POEStatus(self) -> SpinEnumDefNode:
        """Reports and controls the interface's power over Ethernet status.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.tl.POEStatus_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("POEStatus")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.POEStatus))
            node_inst.set_wrapper(
                dynamic_cast[RotPyEnumWrapperPointer](
                    new RotPyEnumWrapperT[POEStatusEnum](
                        &self._interface._interface.get().TLInterface.POEStatus)))
            node_inst.enum_names = rotpy.names.tl.POEStatus_names
            node_inst.enum_values = rotpy.names.tl.POEStatus_values
            node = self._nodes["POEStatus"] = node_inst
        return node

    @property
    def FilterDriverStatus(self) -> SpinEnumDefNode:
        """Reports whether FLIR Light Weight Filter Driver is enabled,
        disabled, or not installed.

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.tl.FilterDriverStatus_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("FilterDriverStatus")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.FilterDriverStatus))
            node_inst.set_wrapper(
                dynamic_cast[RotPyEnumWrapperPointer](
                    new RotPyEnumWrapperT[FilterDriverStatusEnum](
                        &self._interface._interface.get().TLInterface.FilterDriverStatus)))
            node_inst.enum_names = rotpy.names.tl.FilterDriverStatus_names
            node_inst.enum_values = rotpy.names.tl.FilterDriverStatus_values
            node = self._nodes["FilterDriverStatus"] = node_inst
        return node

    @property
    def GevActionDeviceKey(self) -> SpinIntNode:
        """Key to authorize the action for the device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevActionDeviceKey")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.GevActionDeviceKey))
            node = self._nodes["GevActionDeviceKey"] = node_inst
        return node

    @property
    def GevActionGroupKey(self) -> SpinIntNode:
        """Provides the key that the device will use to validate the action on
        reception of the action protocol message.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevActionGroupKey")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.GevActionGroupKey))
            node = self._nodes["GevActionGroupKey"] = node_inst
        return node

    @property
    def GevActionGroupMask(self) -> SpinIntNode:
        """Provides the mask that the device will use to validate the action on
        reception of the action protocol message.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevActionGroupMask")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.GevActionGroupMask))
            node = self._nodes["GevActionGroupMask"] = node_inst
        return node

    @property
    def GevActionTime(self) -> SpinIntNode:
        """Provides the time in nanoseconds when the action is to be executed.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevActionTime")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.GevActionTime))
            node = self._nodes["GevActionTime"] = node_inst
        return node

    @property
    def ActionCommand(self) -> SpinCommandNode:
        """Issues an Action Command to attached GEV devices on interface.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("ActionCommand")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.ActionCommand))
            node = self._nodes["ActionCommand"] = node_inst
        return node

    @property
    def DeviceUnlock(self) -> SpinStrNode:
        """Unlocks devices for internal use.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("DeviceUnlock")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.DeviceUnlock))
            node = self._nodes["DeviceUnlock"] = node_inst
        return node

    @property
    def DeviceUpdateList(self) -> SpinCommandNode:
        """Updates the internal device list.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("DeviceUpdateList")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.DeviceUpdateList))
            node = self._nodes["DeviceUpdateList"] = node_inst
        return node

    @property
    def DeviceCount(self) -> SpinIntNode:
        """Number of compatible devices detected on current interface.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.DeviceCount))
            node = self._nodes["DeviceCount"] = node_inst
        return node

    @property
    def DeviceSelector(self) -> SpinIntNode:
        """Selector for the different devices on this interface. This value
        only changes on execution of "DeviceUpdateList". The selector is
        0-based in order to match the index of the C interface.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("DeviceSelector")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.DeviceSelector))
            node = self._nodes["DeviceSelector"] = node_inst
        return node

    @property
    def DeviceID(self) -> SpinStrNode:
        """Interface wide unique identifier of the selected device. This value
        only changes on execution of "DeviceUpdateList".

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("DeviceID")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.DeviceID))
            node = self._nodes["DeviceID"] = node_inst
        return node

    @property
    def DeviceVendorName(self) -> SpinStrNode:
        """Name of the device vendor. This value only changes on execution of
        "DeviceUpdateList".

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("DeviceVendorName")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.DeviceVendorName))
            node = self._nodes["DeviceVendorName"] = node_inst
        return node

    @property
    def DeviceModelName(self) -> SpinStrNode:
        """Name of the device model. This value only changes on execution of
        "DeviceUpdateList".

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("DeviceModelName")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.DeviceModelName))
            node = self._nodes["DeviceModelName"] = node_inst
        return node

    @property
    def DeviceSerialNumber(self) -> SpinStrNode:
        """Serial number of the selected remote device.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("DeviceSerialNumber")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.DeviceSerialNumber))
            node = self._nodes["DeviceSerialNumber"] = node_inst
        return node

    @property
    def DeviceAccessStatus(self) -> SpinEnumDefNode:
        """Gives the device's access status at the moment of the last execution
        of "DeviceUpdateList". This value only changes on execution of
        "DeviceUpdateList".

        :Property type: :class:`~rotpy.node.SpinEnumDefNode`.
        :Enum entries: :attr:`~rotpy.names.tl.DeviceAccessStatus_names`.
        :Visibility: ``default``.
        """
        cdef SpinEnumDefNode node_inst
        node = self._nodes.get("DeviceAccessStatus")
        if node is None:
            node_inst = SpinEnumDefNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.DeviceAccessStatus))
            node_inst.set_wrapper(
                dynamic_cast[RotPyEnumWrapperPointer](
                    new RotPyEnumWrapperT[DeviceAccessStatusEnum](
                        &self._interface._interface.get().TLInterface.DeviceAccessStatus)))
            node_inst.enum_names = rotpy.names.tl.DeviceAccessStatus_names
            node_inst.enum_values = rotpy.names.tl.DeviceAccessStatus_values
            node = self._nodes["DeviceAccessStatus"] = node_inst
        return node

    @property
    def GevDeviceIPAddress(self) -> SpinIntNode:
        """Current IP address of the GVCP interface of the selected remote
        device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevDeviceIPAddress")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.GevDeviceIPAddress))
            node = self._nodes["GevDeviceIPAddress"] = node_inst
        return node

    @property
    def GevDeviceSubnetMask(self) -> SpinIntNode:
        """Current subnet mask of the GVCP interface of the selected remote
        device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevDeviceSubnetMask")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.GevDeviceSubnetMask))
            node = self._nodes["GevDeviceSubnetMask"] = node_inst
        return node

    @property
    def GevDeviceGateway(self) -> SpinIntNode:
        """Current gateway IP address of the GVCP interface of the selected
        remote device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevDeviceGateway")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.GevDeviceGateway))
            node = self._nodes["GevDeviceGateway"] = node_inst
        return node

    @property
    def GevDeviceMACAddress(self) -> SpinIntNode:
        """48-bit MAC address of the GVCP interface of the selected remote
        device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevDeviceMACAddress")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.GevDeviceMACAddress))
            node = self._nodes["GevDeviceMACAddress"] = node_inst
        return node

    @property
    def IncompatibleDeviceCount(self) -> SpinIntNode:
        """Number of incompatible devices detected on current interface.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("IncompatibleDeviceCount")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.IncompatibleDeviceCount))
            node = self._nodes["IncompatibleDeviceCount"] = node_inst
        return node

    @property
    def IncompatibleDeviceSelector(self) -> SpinIntNode:
        """Selector for the devices that are not compatible with Spinnaker on
        this interface. This value only changes on execution of
        "DeviceUpdateList". The selector is 0-based in order to match the
        index of the C interface.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("IncompatibleDeviceSelector")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.IncompatibleDeviceSelector))
            node = self._nodes["IncompatibleDeviceSelector"] = node_inst
        return node

    @property
    def IncompatibleDeviceID(self) -> SpinStrNode:
        """Interface wide unique identifier of the selected incompatible
        device. This value only changes on execution of "DeviceUpdateList".

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("IncompatibleDeviceID")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.IncompatibleDeviceID))
            node = self._nodes["IncompatibleDeviceID"] = node_inst
        return node

    @property
    def IncompatibleDeviceVendorName(self) -> SpinStrNode:
        """Name of the incompatible device vendor. This value only changes on
        execution of "DeviceUpdateList".

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("IncompatibleDeviceVendorName")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.IncompatibleDeviceVendorName))
            node = self._nodes["IncompatibleDeviceVendorName"] = node_inst
        return node

    @property
    def IncompatibleDeviceModelName(self) -> SpinStrNode:
        """Name of the incompatible device model. This value only changes on
        execution of "DeviceUpdateList".

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("IncompatibleDeviceModelName")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.IncompatibleDeviceModelName))
            node = self._nodes["IncompatibleDeviceModelName"] = node_inst
        return node

    @property
    def IncompatibleGevDeviceIPAddress(self) -> SpinIntNode:
        """Current IP address of the GVCP interface of the selected remote
        incompatible device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("IncompatibleGevDeviceIPAddress")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.IncompatibleGevDeviceIPAddress))
            node = self._nodes["IncompatibleGevDeviceIPAddress"] = node_inst
        return node

    @property
    def IncompatibleGevDeviceSubnetMask(self) -> SpinIntNode:
        """Current subnet mask of the GVCP interface of the selected remote
        incompatible device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("IncompatibleGevDeviceSubnetMask")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.IncompatibleGevDeviceSubnetMask))
            node = self._nodes["IncompatibleGevDeviceSubnetMask"] = node_inst
        return node

    @property
    def IncompatibleGevDeviceMACAddress(self) -> SpinIntNode:
        """48-bit MAC address of the GVCP interface of the selected remote
        incompatible device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("IncompatibleGevDeviceMACAddress")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.IncompatibleGevDeviceMACAddress))
            node = self._nodes["IncompatibleGevDeviceMACAddress"] = node_inst
        return node

    @property
    def GevDeviceForceIP(self) -> SpinCommandNode:
        """Apply the force IP settings (GevDeviceForceIPAddress,
        GevDeviceForceSubnetMask and GevDeviceForceGateway) in the selected
        remote device using ForceIP command.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("GevDeviceForceIP")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.GevDeviceForceIP))
            node = self._nodes["GevDeviceForceIP"] = node_inst
        return node

    @property
    def GevDeviceForceIPAddress(self) -> SpinIntNode:
        """Static IP address to set for the GVCP interface of the selected
        remote device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevDeviceForceIPAddress")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.GevDeviceForceIPAddress))
            node = self._nodes["GevDeviceForceIPAddress"] = node_inst
        return node

    @property
    def GevDeviceForceSubnetMask(self) -> SpinIntNode:
        """Static subnet mask to set for GVCP interface of the selected remote
        device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevDeviceForceSubnetMask")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.GevDeviceForceSubnetMask))
            node = self._nodes["GevDeviceForceSubnetMask"] = node_inst
        return node

    @property
    def GevDeviceForceGateway(self) -> SpinIntNode:
        """Static gateway IP address to set for the GVCP interface of the
        selected remote device.

        :Property type: :class:`~rotpy.node.SpinIntNode`.
        :Visibility: ``default``.
        """
        cdef SpinIntNode node_inst
        node = self._nodes.get("GevDeviceForceGateway")
        if node is None:
            node_inst = SpinIntNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.GevDeviceForceGateway))
            node = self._nodes["GevDeviceForceGateway"] = node_inst
        return node

    @property
    def GevDeviceAutoForceIP(self) -> SpinCommandNode:
        """Automatically forces the selected remote device to an IP Address on
        the same subnet as the GVCP interface.

        :Property type: :class:`~rotpy.node.SpinCommandNode`.
        :Visibility: ``default``.
        """
        cdef SpinCommandNode node_inst
        node = self._nodes.get("GevDeviceAutoForceIP")
        if node is None:
            node_inst = SpinCommandNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.GevDeviceAutoForceIP))
            node = self._nodes["GevDeviceAutoForceIP"] = node_inst
        return node

    @property
    def HostAdapterName(self) -> SpinStrNode:
        """User readable name of the interface's host adapter.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("HostAdapterName")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.HostAdapterName))
            node = self._nodes["HostAdapterName"] = node_inst
        return node

    @property
    def HostAdapterVendor(self) -> SpinStrNode:
        """User readable name of the host adapter's vendor.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("HostAdapterVendor")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.HostAdapterVendor))
            node = self._nodes["HostAdapterVendor"] = node_inst
        return node

    @property
    def HostAdapterDriverVersion(self) -> SpinStrNode:
        """Driver version of the interface's host adapter.

        :Property type: :class:`~rotpy.node.SpinStrNode`.
        :Visibility: ``default``.
        """
        cdef SpinStrNode node_inst
        node = self._nodes.get("HostAdapterDriverVersion")
        if node is None:
            node_inst = SpinStrNode()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self._interface._interface.get().TLInterface.HostAdapterDriverVersion))
            node = self._nodes["HostAdapterDriverVersion"] = node_inst
        return node
