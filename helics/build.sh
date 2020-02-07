#!/bin/bash

which pip
which python
pip --version
python --version
python-config --extension-suffix

# install using pip from the whl file
pip install https://files.pythonhosted.org/packages/00/a1/e965807ba1241af2b7d81c4404ca15805c0d94188508ba9c5dda78b2d74e/helics-2.4.0-cp37-cp37m-manylinux2010_x86_64.whl -vv
