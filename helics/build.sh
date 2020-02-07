#!/bin/bash

pip install pip --upgrade

python-config --extension-suffix

# install using pip from the whl file
pip install helics -vv
