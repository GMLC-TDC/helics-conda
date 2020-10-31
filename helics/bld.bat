echo "******************* Installing PyHELICS ***************"

cd $SRC_DIR/pyhelics

mkdir -p "$SP_DIR/helics/install"
cp -r helics/* $SP_DIR/helics/

echo "******************* Installing HELICS ***************"

mkdir -p $SRC_DIR/helics/build
cd $SRC_DIR/helics/build
git submodule update
cmake -DCMAKE_INSTALL_PREFIX="$SP_DIR/helics/install" --build . --target install --config Release
