#!/bin/bash

set -e
set -x


if [ `uname` = "Darwin" ]; then
	FLAGS="-std=c++14"
else
	FLAGS="-std=c++11"
fi

if [[ $PY3K -eq 1 || $PY3K == True || $PY3K == "True" ]]; then
  BUILD_PYTHON="-DBUILD_PYTHON_INTERFACE=ON"
else
  BUILD_PYTHON="-DBUILD_PYTHON2_INTERFACE=ON"
fi

mkdir -p build && cd build
cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_HELICS_TESTS=OFF -DCMAKE_CXX_FLAGS=$FLAGS ${BUILD_PYTHON} -DCMAKE_INSTALL_PREFIX=$PREFIX -DPYTHON_INCLUDE_DIR=$(python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") -DPYTHON_LIBRARY=$(python -c "import distutils.sysconfig as sysconfig; print(sysconfig.get_config_var('LIBDIR'))") ../
make
make install

cp -v ${PREFIX}/python/_helics.so ${SP_DIR}/
cp -v ${PREFIX}/python/helics.py ${SP_DIR}/
