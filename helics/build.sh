#!/bin/bash

if [ `uname` == Darwin ]; then
    if [ "$PY_VER" == "2.7" ]; then
        HELICS_PY_WHL_FILE=https://pypi.org/packages/cp27/h/helics/helics-${PKG_VERSION}-cp27-cp27m-macosx_10_9_intel.whl
    elif [ "$PY_VER" == "3.5" ]; then
        HELICS_PY_WHL_FILE=https://pypi.org/packages/cp35/h/helics/helics-${PKG_VERSION}-cp35-cp35m-macosx_10_9_intel.whl
    elif [ "$PY_VER" == "3.6" ]; then
        HELICS_PY_WHL_FILE=https://pypi.org/packages/cp36/h/helics/helics-${PKG_VERSION}-cp36-cp36m-macosx_10_9_intel.whl
    elif [ "$PY_VER" == "3.7" ]; then
        HELICS_PY_WHL_FILE=https://pypi.org/packages/cp37/h/helics/helics-${PKG_VERSION}-cp37-cp37m-macosx_10_9_intel.whl
    fi
    HELICS_APPS_WHL_FILE=https://files.pythonhosted.org/packages/ca/d5/f8a405222f4f4254e424b99959dcb2775923d96debaea611dd101fa701e3/helics_apps-2.4.1-py2.py3-none-macosx_10_9_intel.whl
fi

if [ `uname` == Linux ]; then
    if [ "$PY_VER" == "2.7" ]; then
        HELICS_PY_WHL_FILE=https://pypi.org/packages/cp27/h/helics/helics-${PKG_VERSION}-cp27-cp27mu-manylinux2010_x86_64.whl
    elif [ "$PY_VER" == "3.5" ]; then
        HELICS_PY_WHL_FILE=https://pypi.org/packages/cp35/h/helics/helics-${PKG_VERSION}-cp35-cp35m-manylinux2010_x86_64.whl
    elif [ "$PY_VER" == "3.6" ]; then
        HELICS_PY_WHL_FILE=https://pypi.org/packages/cp36/h/helics/helics-${PKG_VERSION}-cp36-cp36m-manylinux2010_x86_64.whl
    elif [ "$PY_VER" == "3.7" ]; then
        HELICS_PY_WHL_FILE=https://pypi.org/packages/cp37/h/helics/helics-${PKG_VERSION}-cp37-cp37m-manylinux2010_x86_64.whl
    fi
    HELICS_APPS_WHL_FILE=https://files.pythonhosted.org/packages/11/a1/a59d2fffb34c762fd4e96496a9eb38c27edf6d5158fff804e0f9fa8bc757/helics_apps-2.4.1-py2.py3-none-manylinux2010_x86_64.whl
fi

pip install --no-deps $HELICS_PY_WHL_FILE $HELICS_APPS_WHL_FILE
