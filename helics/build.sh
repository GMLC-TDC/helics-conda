#!/bin/bash -xv

set -o xtrace
set -o verbose

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
