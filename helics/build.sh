#!/bin/bash -xv

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

set -o xtrace
set -o verbose

if [[ $PY3K -eq 1 || $PY3K == True || $PY3K == "True" ]]; then
    echo "Python 3"
else
    echo "Python 2"
fi

cd $SRC_DIR/pyhelics

python setup.py install --single-version-externally-managed --record=record.txt

ls ${PREFIX}
ls ${PREFIX}/bin
ls ${PREFIX}/lib
ls ${PREFIX}/install

ls ${SP_DIR}
ls ${SP_DIR}/helics

mkdir -p ${SP_DIR}/helics/install
cp -r ${PREFIX}/* ${SP_DIR}/helics/install/
