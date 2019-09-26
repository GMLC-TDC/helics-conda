
if %PY3K% equ 1 (
  set BUILD_PYTHON="-DBUILD_PYTHON_INTERFACE=ON"
  set PYTHON_VERSION="%PY_VER%m"
) else (
  set BUILD_PYTHON="-DBUILD_PYTHON2_INTERFACE=ON"
  set PYTHON_VERSION="%PY_VER%"
  set VS90COMNTOOLS=%VS100COMNTOOLS%
)

mkdir "%SRC_DIR%"\build
pushd "%SRC_DIR%"\build

git clean -fxd

set PY_VER_NO_DOT=%PY_VER:.=%

if %PYTHON_ARCH% equ 64 (
  echo "Building 64 bit"
  cmake -DZMQ_LOCAL_BUILD=ON -DCMAKE_BUILD_TYPE=Release -A x64 -DCOMPILER_CAN_DO_CPP_11=ON -DCXX_FLAGS="-std=c++11" -DBUILD_HELICS_TESTS=OFF -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" %BUILD_PYTHON%" ..
) else (
  echo "Building 32 bit"
  cmake -DZMQ_LOCAL_BUILD=ON -DCMAKE_BUILD_TYPE=Release -DCOMPILER_CAN_DO_CPP_11=ON -DCXX_FLAGS="-std=c++11" -DBUILD_HELICS_TESTS=OFF -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" %BUILD_PYTHON%" ..
)
cmake --build . --config Release --target install

xcopy %LIBRARY_PREFIX%\python\* %SP_DIR%

popd
