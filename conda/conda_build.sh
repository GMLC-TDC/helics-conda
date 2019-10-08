
set -e

PKG_NAME=helics

if [[ "$TRAVIS_OS_NAME" == "windows" ]]; then
    OS="win-$PYTHON_ARCH"
else
    OS=$TRAVIS_OS_NAME-$PYTHON_ARCH
fi

mkdir -p ~/conda-bld
export CONDA_BLD_PATH=~/conda-bld
echo "Started building ..."
conda build $PKG_NAME --python=$PYTHON_VERSION

PACKAGE_DIR=$(conda build $PKG_NAME --output)
ls `dirname $PACKAGE_DIR`
ls $CONDA_BLD_PATH
PACKAGE_PATH=$PACKAGE_DIR
echo $PACKAGE_PATH

