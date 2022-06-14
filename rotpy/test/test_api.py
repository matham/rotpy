

def test_example_node():
    from rotpy.system import SpinSystem

    system = SpinSystem()
    nodes = system.system_nodes
    node = nodes.TLVendorName

    assert node.get_name() == 'TLVendorName'
    assert node.get_name(True) == 'Std::TLVendorName'
    assert node.get_alias_node() is None
    assert node.get_node_value() == 'FLIR Systems, Inc.'


def test_enum():
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
