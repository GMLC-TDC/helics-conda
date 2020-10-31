mkdir "%SRC_DIR%"\helics
mkdir "%SRC_DIR%"\helics\build
pushd "%SRC_DIR%"\helics\build

set PY_VER_NO_DOT=%PY_VER:.=%

echo "Setting build options"

if "%PYTHON_ARCH%" == "32" (
    set CONDA_FORCE_32BIT=1
    set HELICS_PLATFORM=-AWin32
    echo "Building 32 bit"
) ELSE (
    set HELICS_PLATFORM=-Ax64
    echo "Building 64 bit"
)

echo %HELICS_PLATFORM%

mkdir "%SP_DIR%"\helics
mkdir "%SP_DIR%"\helics\install

cmake -G "%CMAKE_GENERATOR%" -DCMAKE_BUILD_TYPE=Release -DHELICS_BUILD_TESTS=OFF -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% -DCMAKE_INSTALL_PREFIX=%SP_DIR%\helics\install ..
cmake --build . --config Release --target install

if errorlevel 1 exit /b 1

popd

pushd "%SRC_DIR%"\pyhelics\

xcopy helics\* %SP_DIR%\helics\

popd

exit 0
