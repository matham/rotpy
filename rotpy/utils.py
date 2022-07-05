"""Utilities
=============

Module for extracting cython headers from the Spinnaker headers.
For example::

    header = r'E:\\FLIR\\Spinnaker\\include\\spinc\\FSpinnakerC'
    content = parse_header('{}.h'.format(header))
    dump_cython(content, '{}.h'.format(header), '{}.pxi'.format(header))

Or to get the class nodes::

    content = parse_class_vars(f)
    dump_genapi_var_type_prop_cython(content, f'{name}.px')
"""

from typing import List
from textwrap import TextWrapper
from re import compile, match, sub, split, finditer
import traceback
import re
from collections import namedtuple, defaultdict

__all__ = (
    'VariableSpec', 'FunctionSpec', 'StructSpec', 'EnumSpec', 'EnumMemberSpec',
    'TypeDef', 'GenAPIVarSpec', 'strip_comments', 'parse_prototype',
    'parse_struct', 'parse_enum', 'parse_header', 'format_typedef',
    'format_enum', 'format_variable', 'format_function', 'format_struct',
    'dump_cython', 'parse_class_vars', 'dump_genapi_prop_cython',
    'dump_genapi_import_prop_cython', 'dump_genapi_var_type_prop_cython')

tab = '    '
sp_pat = compile(' +')
func_pat = compile(r'SPINNAKERC_API +(\w+) *\((.*?)\);')
func_pat_short = compile('(SPINNAKERC_API.+?\\(.+?\\);)', re.DOTALL)
arg_split_pat = compile(' *, *')
variable_pat = compile(
    '^([\\w]+(?: +[\\w]+)?(?: *\\*+ *)?(?: +[\\w]+)?)((?: *\\*+ *)| +)([\\w]+)'
    '(?: *\\[([ \\w]*)\\] *)?;?$'
)
struct_pat = compile(
    '(?:typedef)? *(struct|enum) +([\\w]+)[ \\n]*\\{([\\w ,=\\n;\\-\\*\\[\\]]+)\\}'
    '[ \\n]*([\\w ,]*) *;', re.DOTALL
)
typedef_pat = compile('typedef +(.+?);')


VariableSpec = namedtuple('VariableSpec', ['type', 'pointer', 'name', 'count'])
'''Represents a variable declaration in e.g. the definition of a function
or its return value.
'''

FunctionSpec = namedtuple('FunctionSpec',
                          ['dec', 'type', 'pointer', 'name', 'args'])
'''Represents a c function prototype.
'''

StructSpec = namedtuple('StructSpec', ['tp_name', 'names', 'members'])
'''Represents a c struct definition.
'''

EnumSpec = namedtuple('EnumSpec', ['tp_name', 'names', 'values'])
'''Represents a c enum definition.
'''

EnumMemberSpec = namedtuple('EnumMemberSpec', ['name', 'value'])
'''Represents a c enum member.
'''

TypeDef = namedtuple('TypeDef', ['body'])
'''Represents a c typedef.
'''


class_genapi_var_pat = compile(
    r'/\*\*.+?'
    r'Description:(.+?)'
    r'Visibility:[ \t]*([a-zA-Z0-9]+)?[ \t]*'
    r'.+?'
    r'GenApi::([\w<>]+) *& *(\w+) *;+',
    flags=re.DOTALL)
template_genapi_type = compile(r'(\w+)<(\w+)>')


GenAPIVarSpec = namedtuple(
    'GenAPIVarSpec',
    ['visibility', 'type_name', 'type_template', 'name', 'description']
)
"""Represnts a Node that is a class variable in the header.
"""


def strip_comments(code):
    '''Returns the headers with comments removed.
    '''
    single_comment = compile('//.*')  # single line comment
    multi_comment = compile(r'/\*(\*?).*?\*/', re.DOTALL)  # multiline comment
    code = sub(single_comment, '', code)
    code = sub(multi_comment, '', code)
    return '\n'.join([c for c in code.splitlines() if c.strip()])


def parse_prototype(prototype):
    '''Returns a :attr:`FunctionSpec` instance from the input.
    '''
    val = ' '.join(prototype.splitlines())
    f = match(func_pat, val)  # match the whole function
    if f is None:
        raise Exception('Cannot parse function prototype "{}"'.format(val))
    name, arg = [v.strip() for v in f.groups()]

    args = []
    if arg.strip():  # split each arg into type, zero or more *, and name
        for item in split(arg_split_pat, arg):
            m = match(variable_pat, item.strip())
            if m is None:
                raise Exception(
                    f'Cannot parse arg "{item.strip()}" of function prototype '
                    f'"{val}" with args "{arg.strip}"')

            tp, star, nm, count = [v.strip() if v else '' for v in m.groups()]
            args.append(VariableSpec(tp, star, nm, count))

    return FunctionSpec('', 'spinError', '', name, args)


def parse_struct(type_name, body, name):
    '''Returns a :attr:`StructSpec` instance from the input.
    '''
    type_name, name = type_name.strip(), name.strip()
    lines = [l.strip() for l in body.splitlines() if l.strip()]
    members = []

    for line in lines:
        m = match(variable_pat, line)
        if m is None:
            raise Exception('Cannot parse "{}" for "{}"'.format(line, name))

        tp, star, nm, count = [v.strip() if v else '' for v in m.groups()]
        members.append(VariableSpec(tp, star, nm, count))
    return StructSpec(type_name, [n.strip() for n in name.split(',')], members)


def parse_enum(type_name, body: str, name):
    '''Returns a :attr:`EnumSpec` instance from the input.
    '''
    type_name, name = type_name.strip(), name.strip()
    body = body.replace('=\n', '= ')
    lines = [l.strip(' ,') for l in body.splitlines() if l.strip(', ')]
    members = []

    for line in lines:
        vals = [v.strip() for v in line.split('=')]
        if len(vals) == 1:
            members.append(EnumMemberSpec(vals[0], ''))
        else:
            members.append(EnumMemberSpec(*vals))

    return EnumSpec(type_name, [n.strip() for n in name.split(',')], members)


def parse_header(filename):
    '''Returns a list of :attr:`VariableSpec`, :attr:`FunctionSpec`,
    :attr:`StructSpec`, :attr:`EnumSpec`, :attr:`EnumMemberSpec`, and
    :attr:`TypeDef` instances representing the c header file.
    '''
    with open(filename, 'r') as fh:
        content = '\n'.join(fh.read().splitlines())

    content = sub('\t', ' ', content)
    content = strip_comments(content)

    # first get the functions
    content = split(func_pat_short, content)

    for i, s in enumerate(content):
        if i % 2 and content[i].strip():  # matched a prototype
            try:
                content[i] = parse_prototype(content[i])
            except Exception as e:
                traceback.print_exc()

    # now process structs
    res = []
    for i, item in enumerate(content):
        if not isinstance(item, str):  # if it's already a func etc. skip it
            res.append(item)
            continue

        items = split(struct_pat, item)
        j = 0
        while j < len(items):
            if not j % 5:
                res.append(items[j])
                j += 1
            else:
                if items[j].strip() == 'enum':
                    res.append(parse_enum(*items[j + 1: j + 4]))
                else:
                    res.append(parse_struct(*items[j + 1: j + 4]))
                j += 4

    # now do remaining simple typedefs
    content = res
    res = []
    for i, item in enumerate(content):
        if not isinstance(item, str):  # if it's already processed skip it
            res.append(item)
            continue

        items = split(typedef_pat, item)
        for j, item in enumerate(items):
            res.append(TypeDef(item.strip()) if j % 2 else item)

    content = [c for c in res if not isinstance(c, str) or c.strip()]
    return content


def format_typedef(typedef):
    '''Generates a cython typedef from a :attr:`TypeDef` instance.
    '''
    return ['ctypedef {}'.format(typedef.body)]


def format_enum(enum_def):
    '''Returns a cython enum from a :attr:`EnumSpec` instance.
    '''
    text = []
    text.append('cdef enum {}:'.format(enum_def.tp_name))
    for member in enum_def.values:
        if member.value:
            text.append('{}{} = {}'.format(tab, *member))
        else:
            text.append('{}{}'.format(tab, member.name))

    for name in enum_def.names:
        if name and name != enum_def.tp_name:
            text.append('ctypedef {} {}'.format(enum_def.tp_name, name))

    return text


def format_variable(variable):
    '''Returns a cython variable from a :attr:`VariableSpec` instance.
    '''
    if variable.count:
        return '{}{} {}[{}]'.format(*variable)
    return '{} {}{}'.format(*variable[:-1])


def format_function(function):
    '''Returns a cython function from a :attr:`FunctionSpec` instance.
    '''
    args = [format_variable(arg) for arg in function.args]
    return ['{}{} {}({})'.format(
        function.type, function.pointer, function.name, ', '.join(args))]


def format_struct(struct_def):
    '''Returns a cython struct from a :attr:`StructSpec` instance.
    '''
    text = []
    text.append('cdef struct {}:'.format(struct_def.tp_name))
    text.extend(
        ['{}{}'.format(tab, format_variable(var))
         for var in struct_def.members]
    )

    for name in struct_def.names:
        if name and name != struct_def.tp_name:
            text.append('ctypedef {} {}'.format(struct_def.tp_name, name))

    return text


def dump_cython(content, name, ofile):
    '''Generates a cython pxi file from the output of :func:`parse_header`.
    '''
    with open(ofile, 'w') as fh:
        fh.write('cdef extern from "{}":\n'.format(name))
        for item in content:
            if isinstance(item, FunctionSpec):
                code = format_function(item)
            elif isinstance(item, StructSpec):
                code = format_struct(item)
            elif isinstance(item, EnumSpec):
                code = format_enum(item)
            elif isinstance(item, TypeDef):
                code = format_typedef(item)
            else:
                fh.write('>>>>>>>>\n{}\n<<<<<<<<'.format(item))
                code = []

            fh.write('{}\n\n'.format('\n'.join(['{}{}'.format(tab, c)
                                                for c in code])))


def parse_class_vars(filename):
    """Parses the variable nodes from a header.
    """
    with open(filename, 'r') as fh:
        content = fh.read()

    items = []
    for m in finditer(class_genapi_var_pat, content):
        desc, vis, tp, name = m.groups()
        desc = [l.strip(' \n*') for l in desc.splitlines()]
        desc = ' '.join([l for l in desc if l])

        tp_m = match(template_genapi_type, tp)
        if tp_m is None:
            tp_name = tp
            tp_template = None
        else:
            tp_name, tp_template = tp_m.groups()

        items.append(GenAPIVarSpec(vis, tp_name, tp_template, name, desc))

    return items


def dump_genapi_prop_cython(
        items: List[GenAPIVarSpec], ofile, prop_storage_name='_nodes',
        cam_name='_camera', handle_name='_camera', prop_prefix='',
        name_mod='.camera', enum_suffix='Enum'):
    """Dumps all the nodes as ``@property`` methods of a cython class.
    """
    node_cls_map = {
        'IInteger': 'SpinIntNode',
        'IBoolean': 'SpinBoolNode',
        'ICommand': 'SpinCommandNode',
        'IFloat': 'SpinFloatNode',
        'IString': 'SpinStrNode',
        'IRegister': 'SpinRegisterNode',
        'ICategory': 'SpinTreeNode',
        'IEnumerationT': 'SpinEnumDefNode',
        'IPort': 'SpinPortNode',
    }

    wrapper = TextWrapper(width=68, tabsize=4)
    with open(ofile, 'w') as fh:
        for item in items:

            description = '\n        '.join(wrapper.wrap(item.description))
            visibility = 'default' or item.visibility

            enum_dict = ''
            t_name = item.type_template
            doc_name = ''
            if t_name is not None:
                if t_name.endswith('Enums'):
                    t_name = t_name[:-5]
                if t_name.endswith('Enum'):
                    t_name = t_name[:-4]
                doc_name = f'''
        :Enum entries: :attr:`~rotpy.names{name_mod}.{t_name}_names`.'''

                enum_dict = f"""
            node_inst.enum_names = rotpy.names{name_mod}.{t_name}_names
            node_inst.enum_values = rotpy.names{name_mod}.{t_name}_values"""

            prop = f'''
    @property
    def {item.name}(self):
        """{description}

        :Property type: :class:`~rotpy.node.{node_cls_map[item.type_name]}`.\
{doc_name}
        :Visibility: ``{visibility}``.
        """
        cdef {node_cls_map[item.type_name]} node_inst
        node = self.{prop_storage_name}.get("{item.name}")
        if node is None:
            node_inst = {node_cls_map[item.type_name]}()
            node_inst.set_handle(self, dynamic_cast[IBasePointer](
                &self.{cam_name}.{handle_name}.get(){prop_prefix}.{item.name}))
            node_inst.set_wrapper(
                dynamic_cast[RotPyEnumWrapperPointer](
                    new RotPyEnumWrapperT[{t_name}{enum_suffix}](
                        &self.{cam_name}.{handle_name}.get()\
{prop_prefix}.{item.name})))\
{enum_dict}
            node = self.{prop_storage_name}["{item.name}"] = node_inst
        return node
'''

            fh.write(prop)


def dump_genapi_import_prop_cython(items: List[GenAPIVarSpec], ofile):
    """Dumps all the C++ class nodes in the format to be included in a pxi
    file representing the header import.
    """
    with open(ofile, 'w') as fh:
        for item in items:
            tp = item.type_name
            if item.type_template is not None:
                tp = f'{item.type_name}[{item.type_template}]'
            fh.write(f'        {tp} &{item.name}\n')


def dump_genapi_var_type_prop_cython(items: List[GenAPIVarSpec], ofile):
    """Dumps all the names of the nodes of a cython class and groups them
    into the type of node, e.g. string, float, enum etc.
    """
    node_name_map = {
        'IBoolean': 'bool',
        'IInteger': 'int',
        'IFloat': 'float',
        'IString': 'str',
        'IEnumerationT': 'enum',
        'ICommand': 'command',
        'IRegister': 'register',
    }

    props = {value: [] for value in node_name_map.values()}
    for item in items:
        props[node_name_map[item.type_name]].append(item.name)

    with open(ofile, 'w') as fh:
        for prop, values in props.items():
            fh.write(f'cdef public list {prop}_nodes\n')
        for prop, values in props.items():
            fh.write(f'self.{prop}_nodes = {repr(values)}\n')


if __name__ == '__main__':
    from os.path import join
    include = r'e:\FLIR\Spinnaker\include'

    for name in ('TransportLayerInterface', ):
        f = join(include, '{}.h'.format(name))
        content = parse_class_vars(f)
        # content = parse_header(f)

        # dump_genapi_import_prop_cython(content, f'{name}.px')
        # dump_genapi_prop_cython(
        #     content, f'{name}.px', prop_prefix='.TLInterface', name_mod='.tl',
        #     cam_name='_interface', handle_name='_interface')
        dump_genapi_var_type_prop_cython(content, f'{name}.px')
        # dump_cython(content, '{}.h'.format(name), '{}.pxi'.format(name))

        print('{} done!'.format(name))
