#!/bin/bash

set -e
set -x

if [ `uname` = "Darwin" ]; then
    FLAGS="-std=c++14"
else
    FLAGS="-std=c++11"
fi

if [ -z "$PREFIX" ]; then
  PREFIX="$CONDA_PREFIX"
fi
echo "Installing helics to ${PREFIX}"

mkdir -p helics/build && cd helics/build
cmake $CONDA_CMAKE_ARGS -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS=$FLAGS -DCMAKE_INSTALL_PREFIX=$PREFIX ../
make -j $CPU_COUNT
make install

cd $REPO_DIR/pyhelics
$PYTHON setup.py install

cp -v ${PREFIX}/* ${SP_DIR}/helics/install
