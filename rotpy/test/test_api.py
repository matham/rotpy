import pytest


@pytest.fixture
def spin_system():
    from rotpy.system import SpinSystem

    system = SpinSystem()
    yield system


def test_example_node(spin_system):
    nodes = spin_system.system_nodes
    node = nodes.TLVendorName

    assert node.get_name() == 'TLVendorName'
    assert node.get_name(True) == 'Std::TLVendorName'
    assert node.get_alias_node() is None
    assert node.get_node_value() == 'FLIR Systems, Inc.'


def test_enum_mod():
    from rotpy.names.spin import compression_names
    d = {
        'none': 1,
        'packbits': 2,
        'deflate': 3,
        'adobe_deflate': 4,
        'ccittfax3': 5,
        'ccittfax4': 6,
        'lzw': 7,
        'jpeg_enc': 8
     }
    assert compression_names == d


def test_enum_node_pre_listed(spin_system):
    from rotpy.names.tl import TLType_names, TLType_values
    node = spin_system.system_nodes.TLType
    assert node.enum_names == TLType_names
    assert node.enum_values == TLType_values


def test_pre_listed_node_read(spin_system):
    version = spin_system.get_library_version()
    str_version = '.'.join(map(str, version))

    assert spin_system.system_nodes.TLVersion.is_available()
    assert spin_system.system_nodes.TLVersion.get_node_value() == str_version


def test_node_map_node_read(spin_system):
    version = spin_system.get_library_version()
    str_version = '.'.join(map(str, version))

    node_map = spin_system.get_tl_node_map()
    node = node_map.get_node_by_name('TLVersion')
    assert node.is_available()
    assert node.get_node_value() == str_version


def test_pre_listed_node_write_fail(spin_system):
    from rotpy.system import SpinnakerAPIException

    assert spin_system.system_nodes.TLVersion.is_available()
    with pytest.raises(SpinnakerAPIException):
        spin_system.system_nodes.TLVersion.set_node_value('test')


def test_node_map_node_write_fail(spin_system):
    from rotpy.system import SpinnakerAPIException

    node_map = spin_system.get_tl_node_map()
    node = node_map.get_node_by_name('TLVersion')
    assert node.is_available()
    with pytest.raises(SpinnakerAPIException):
        node.set_node_value('test')


def test_pre_listed_node_write(spin_system):
    assert spin_system.system_nodes.EnumerateGen2Cameras.is_available()
    start_val = spin_system.system_nodes.EnumerateGen2Cameras.get_node_value()

    spin_system.system_nodes.EnumerateGen2Cameras.set_node_value(not start_val)
    spin_system.system_nodes.EnumerateGen2Cameras.set_node_value(
        not start_val, verify=True)
    spin_system.system_nodes.EnumerateGen2Cameras.set_node_value(start_val)
    spin_system.system_nodes.EnumerateGen2Cameras.set_node_value_from_str(
        '0', verify=True)
    spin_system.system_nodes.EnumerateGen2Cameras.set_node_value_from_str(
        '1', verify=True)
    spin_system.system_nodes.EnumerateGen2Cameras.set_node_value(
        start_val, verify=True)


def test_node_map_node_write(spin_system):
    node_map = spin_system.get_tl_node_map()
    node = node_map.get_node_by_name('EnumerateGen2Cameras')
    assert node.is_available()
    start_val = node.get_node_value()

    node.set_node_value(not start_val)
    node.set_node_value(not start_val, verify=True)
    node.set_node_value(start_val)
    node.set_node_value_from_str('0', verify=True)
    node.set_node_value_from_str('1', verify=True)
    node.set_node_value(start_val, verify=True)


def test_interfaces(spin_system):
    interfaces = spin_system.create_interface_list(update_interfaces=True)
    interfaces.get_size()


def test_camera_list(spin_system):
    from rotpy.camera import CameraList
    cameras = CameraList.create_from_system(spin_system, True, True)
    cameras.get_size()


def test_logging_callback(spin_system):
    spin_system.set_logging_level('debug')

    items = []

    def log_handler(handler, system, item):
        items.append((handler, system, item))

    handler = spin_system.attach_log_event_handler(log_handler)
    spin_system.update_camera_list(update_interfaces=True)
    spin_system.detach_log_event_handler(handler)

    with pytest.raises(ValueError):
        spin_system.detach_log_event_handler(handler)

    assert items
    for h, s, item in items:
        assert h is handler
        assert s is spin_system
        assert isinstance(item['message'], str)
        assert item['category']
        assert item['priority']
