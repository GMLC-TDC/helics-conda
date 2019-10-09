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

where python > tempFile
set /p HELICS_PYTHON_EXECUTABLE= < tempFile
del tempFile

python -c "import distutils.sysconfig as sysconfig; print(sysconfig.PREFIX)" > tempFile
set /p HELICS_PYTHON_ROOT_DIR= < tempFile
del tempFile

echo %HELICS_PYTHON_INCLUDE_DIR%
echo %HELICS_PYTHON_LIBRARY%
echo %HELICS_PYTHON_EXECUTABLE%
echo %HELICS_PYTHON_ROOT_DIR%


if "%PYTHON_VERSION%" == "2.7" (
    set BUILD_PYTHON=-DBUILD_PYTHON2_INTERFACE=ON
) ELSE (
    set BUILD_PYTHON=-DBUILD_PYTHON_INTERFACE=ON
)

echo "Building 64 bit"

echo %BUILD_PYTHON%

cmake -DZMQ_LOCAL_BUILD=ON -DENABLE_SWIG=ON -DCMAKE_BUILD_TYPE=Release -A x64 -DBUILD_HELICS_TESTS=OFF -DBUILD_HELICS_BOOST_TESTS=OFF -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% %BUILD_PYTHON% ..
cmake --build . --config Release --target install

xcopy %LIBRARY_PREFIX%\python\* %SP_DIR%

popd
