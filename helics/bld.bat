mkdir "%SRC_DIR%"\build
pushd "%SRC_DIR%"\build

git clean -fxd

set PY_VER_NO_DOT=%PY_VER:.=%

python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())" > tempFile
set /p HELICS_PYTHON_INCLUDE_DIR= < tempFile
del tempFile

python -c "import distutils.sysconfig as sysconfig; print(sysconfig.get_config_var('LIBDIR'))" > tempFile
set /p HELICS_PYTHON_LIBRARY= < tempFile
del tempFile

python-config --prefix > tempFile
set /p HELICS_PYTHON_PREFIX= < tempFile
del tempFile

echo %HELICS_PYTHON_PREFIX%
echo %HELICS_PYTHON_INCLUDE_DIR%
echo %HELICS_PYTHON_LIBRARY%
echo %HELICS_PYTHON_EXECUTABLE%
echo %HELICS_PYTHON_ROOT_DIR%


if "%PYTHON_VERSION%" == "2.7" (
    set BUILD_PYTHON=-DBUILD_PYTHON2_INTERFACE=ON
    set HELICS_PYTHON_LIBRARIES=%HELICS_PYTHON_PREFIX%\Libs
    set HELICS_PYTHON_EXECUTABLE=%HELICS_PYTHON_PREFIX%\python.exe
    set HELICS_PYTHON_INCLUDE_DIRS=%HELICS_PYTHON_PREFIX%\include
) ELSE (
    set BUILD_PYTHON=-DBUILD_PYTHON_INTERFACE=ON
    set HELICS_PYTHON_EXECUTABLE=%HELICS_PYTHON_PREFIX%\python.exe
    set HELICS_PYTHON_INCLUDE_DIRS=%HELICS_PYTHON_PREFIX%\include
    set HELICS_PYTHON_LIBRARIES=%HELICS_PYTHON_PREFIX%\Libs
)

echo "Building 64 bit"

set BUILD_PYTHON=%BUILD_PYTHON% -DPYTHON_EXECUTABLE=%HELICS_PYTHON_EXECUTABLE% -DPYTHON_INCLUDE_DIRS=%HELICS_PYTHON_INCLUDE_DIRS% -DPYTHON_LIBRARIES=%HELICS_PYTHON_LIBRARIES%

echo %BUILD_PYTHON%

cmake -DZMQ_LOCAL_BUILD=ON -DENABLE_SWIG=ON -DCMAKE_BUILD_TYPE=Release -A x64 -DBUILD_HELICS_TESTS=OFF -DBUILD_HELICS_BOOST_TESTS=OFF -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% %BUILD_PYTHON% ..
cmake --build . --config Release --target install

xcopy %LIBRARY_PREFIX%\python\* %SP_DIR%

popd
