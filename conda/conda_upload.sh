
set -e

PKG_NAME=helics

if [[ "$TRAVIS_OS_NAME" == "windows" ]]; then
    OS="win-$PYTHON_ARCH"
else
    OS=$TRAVIS_OS_NAME-$PYTHON_ARCH
fi

echo "Finished building. Uploading ..."
anaconda -t $ANACONDA_TOKEN upload $CONDA_BLD_PATH/$OS/$PKG_NAME-*.tar.bz2 --force
echo "Finished uploading."

