
set -e

PKG_NAME=helics

if [[ "$TRAVIS_OS_NAME" == "windows" ]]; then
    OS="win-$PYTHON_ARCH"
else
    OS=$TRAVIS_OS_NAME-$PYTHON_ARCH
fi

mkdir ~/conda-bld
export CONDA_BLD_PATH=~/conda-bld
echo "Started building ..."
conda build $PKG_NAME --no-test
