mkdir "%SRC_DIR%"\build
pushd "%SRC_DIR%"\build

set PY_VER_NO_DOT=%PY_VER:.=%

where python > tempFile
set /p HELICS_PYTHON_PREFIX= < tempFile
del tempFile

python -c "import os, sys; print(os.path.dirname(sys.argv[1]))" %HELICS_PYTHON_PREFIX% > tempFile
set /p HELICS_PYTHON_PREFIX= < tempFile
del tempFile

echo "Python location:"
echo %HELICS_PYTHON_PREFIX%

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
