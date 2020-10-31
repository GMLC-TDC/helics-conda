#!/bin/bash -xv

set -o xtrace
set -o verbose

echo "******************* BUILD ENV VARS!!!!!!!!!!!!!!!!!!!!!!!! *******************"
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

if [ `uname` = "Darwin" ]; then
    FLAGS="-std=c++14"
else
    FLAGS="-std=c++11"
fi

if [ -z "$PREFIX" ]; then
  PREFIX="$CONDA_PREFIX"
fi
echo "Installing helics to ${PREFIX}"

mkdir -p $SRC_DIR/helics/build && cd $SRC_DIR/helics/build
git submodule update
cmake $CONDA_CMAKE_ARGS -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS=$FLAGS -DCMAKE_INSTALL_PREFIX=$PREFIX ../
make -j $CPU_COUNT
make install

if [[ $PY3K -eq 1 || $PY3K == True || $PY3K == "True" ]]; then
    echo "Python 3"
else
    echo "Python 2"
fi

export PYTHON_BIN_PATH=${PYTHON}
export PYTHON_LIB_PATH=${SP_DIR}
export USE_DEFAULT_PYTHON_LIB_PATH=1

cd $SRC_DIR/pyhelics

python setup.py install --single-version-externally-managed --record=record.txt

mkdir -p "$SP_DIR/helics"

echo $SP_DIR
echo $BUILD_PREFIX/lib/python3.8/site-packages/

ls $SP_DIR
ls $BUILD_PREFIX/lib/python3.8/site-packages/
