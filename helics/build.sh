#!/bin/bash -xv

set -o xtrace
set -o verbose

echo "******************* BUILD ENV VARS! *******************"
export CONDA_PREFIX=$PREFIX
export LIBDIR=$PREFIX/lib
export INCLUDEDIR=$PREFIX/include
export LD_LIBRARY_PATH="$LIBDIR:$LD_LIBRARY_PATH"

echo "SITE_PACKAGES: $SP_DIR"
echo "PREFIX: $PREFIX"
echo "BUILD_PREFIX: $BUILD_PREFIX"
echo "CONDA_PREFIX: $CONDA_PREFIX"
echo "SRC_DIR: $SRC_DIR"
echo "PYTHON VERSION: $PY_VER"

echo "******************* Installing PyHELICS ***************"

export PYTHON_BIN_PATH=${PYTHON}
export PYTHON_LIB_PATH=${SP_DIR}
export USE_DEFAULT_PYTHON_LIB_PATH=1

cd $SRC_DIR/pyhelics

mkdir -p "$SP_DIR/helics/install"

if [ "$PY_VER" == "2.7" ]; then

    strip-hints helics/capi.py > _tmp.py
    rm helics/capi.py
    mv _tmp.py helics/capi.py

fi

cp -r helics/* $SP_DIR/helics/

echo "******************* Installing HELICS ***************"

if [ `uname` = "Darwin" ]; then
    FLAGS="-std=c++14"
else
    FLAGS="-std=c++11"
fi

if [ -z "$PREFIX" ]; then
  PREFIX="$CONDA_PREFIX"
fi

mkdir -p $SRC_DIR/helics/build && cd $SRC_DIR/helics/build
git submodule update
cmake $CONDA_CMAKE_ARGS -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS=$FLAGS -DCMAKE_INSTALL_PREFIX="$SP_DIR/helics/install" ../
make -j $CPU_COUNT
make install
