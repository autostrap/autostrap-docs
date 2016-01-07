# Building

This repository contains high-level documentation on operating and extending
the Autostrap cloud bootstrapping system. All documentation is in markdown
format and can be rendered to HTML by issuing a

``make``

in the top-level directory (the result will end up in site/). This requires the
following dependencies to work (puppet-sys11docs will take care of these):

* markdown-include (python egg, install through pip)
* mkdocs (python egg, install through pip)
* python-markdown-comments (https://github.com/ryneeverett/python-markdown-comments.git')

You will find detailed information on the extra markdown features available in
EDITING.md and information on creating your own build environment in ENVIRONMENT.md.
