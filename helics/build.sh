#!/bin/bash

which pip
which python
pip --version
python --version
pip install pip --upgrade

python-config --extension-suffix

# install using pip from the whl file
pip install helics -vv
