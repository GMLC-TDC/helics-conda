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
    elif [ "$PY_VER" == "3.8" ]; then
        HELICS_PY_WHL_FILE=https://pypi.org/packages/cp38/h/helics/helics-${PKG_VERSION}-cp38-cp38-macosx_10_9_intel.whl
    fi
    HELICS_APPS_WHL_FILE=https://pypi.org/packages/py2.py3/h/helics_apps/helics_apps-${PKG_VERSION}-py2.py3-none-macosx_10_9_intel.whl
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
    elif [ "$PY_VER" == "3.8" ]; then
        HELICS_PY_WHL_FILE=https://pypi.org/packages/cp38/h/helics/helics-${PKG_VERSION}-cp38-cp38-manylinux2010_x86_64.whl
    fi
    HELICS_APPS_WHL_FILE=https://pypi.org/packages/py2.py3/h/helics_apps/helics_apps-${PKG_VERSION}-py2.py3-none-manylinux2010_x86_64.whl
fi

pip install --no-cache-dir --disable-pip-version-check --no-deps $HELICS_PY_WHL_FILE $HELICS_APPS_WHL_FILE
