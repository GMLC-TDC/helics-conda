mkdir "%SRC_DIR%"\build
pushd "%SRC_DIR%"\build

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

cmake -DCMAKE_BUILD_TYPE=Release -DHELICS_BUILD_TESTS=OFF -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ..
cmake --build . --config Release --target install

xcopy %LIBRARY_PREFIX%\python\* %SP_DIR%

popd
