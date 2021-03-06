# Configuration file for the Sphinx documentation builder.
#
# This file only contains a selection of the most common options. For a full
# list see the documentation:
# http://www.sphinx-doc.org/en/master/config

# -- Path setup --------------------------------------------------------------

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
#
import os
import rotpy
import sphinx_rtd_theme


# -- Project information -----------------------------------------------------

project = 'RotPy'
copyright = '2022, Matthew Einhorn'
author = 'Matthew Einhorn'


# -- General configuration ---------------------------------------------------

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = [
    'sphinx_copybutton',
    'sphinx.ext.autodoc',
    'sphinx.ext.todo',
    'sphinx.ext.coverage',
    'sphinx.ext.intersphinx',
    "sphinx_rtd_theme",
    'sphinx.ext.viewcode',
    'autodocsumm',
]

intersphinx_mapping = {"python": ("https://docs.python.org/3", None)}

version = rotpy.__version__
release = rotpy.__version__

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = []


# -- Options for HTML output -------------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
#
html_theme = 'sphinx_rtd_theme'

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = ["_static"]

html_theme_options = {
    'collapse_navigation': False,
}

html_context = {
    'display_github': True,
    'github_user': 'matham',
    'github_repo': 'rotpy',
    'github_version': 'main',
    "conf_py_path": "/doc/source/"
}

add_module_names = False

autodoc_member_order = 'bysource'

autodoc_default_options = {
    'autosummary': True, 'autosummary-nosignatures': True
}


def setup(app):
    from sphinx.ext.autodoc import DataDocumenter, ModuleDocumenter

    class EnumDataDocumentor(DataDocumenter):

        objtype = 'cython_enum_dict'
        directivetype = DataDocumenter.objtype

        @classmethod
        def can_document_member(cls, member, membername, isattr, parent):
            return isinstance(parent, ModuleDocumenter) and \
                   (membername.endswith('_names') or membername.endswith(
                       '_values')) \
                   and isinstance(member, dict)

        def get_doc(self):
            comment = self.get_module_comment(self.objpath[-1])
            if comment:
                return [comment]
            else:
                return [['']]

    app.add_autodocumenter(EnumDataDocumentor)
