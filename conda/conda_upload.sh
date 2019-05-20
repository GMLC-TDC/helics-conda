
set -e

PKG_NAME=helics

if [[ "$TRAVIS_OS_NAME" == "windows" ]]; then
    OS="win-$PYTHON_ARCH"
else
    OS=$TRAVIS_OS_NAME-$PYTHON_ARCH
fi

mkdir ~/conda-bld
export CONDA_BLD_PATH=~/conda-bld
export VERSION="2.0.0"
echo "Started building ..."
conda build $PKG_NAME --no-test
echo "Finished building. Uploading ..."
anaconda -t $ANACONDA_TOKEN upload $CONDA_BLD_PATH/$OS/$PKG_NAME-*.tar.bz2 --force
echo "Finished uploading."

