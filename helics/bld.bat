mkdir "%SRC_DIR%"\helics\build
pushd "%SRC_DIR%"\helics\build

set PY_VER_NO_DOT=%PY_VER:.=%

echo "Setting build options"

mkdir "%SP_DIR%"\helics
mkdir "%SP_DIR%"\helics\install

:: Visual Studio 2009 doesn't set the version variable
if "%VisualStudioVersion%" == "" (
  set VisualStudioVersion=9
)

cmake -G"NMake Makefiles" -DCMAKE_BUILD_TYPE=Release -DHELICS_BUILD_TESTS=OFF -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% -DCMAKE_INSTALL_PREFIX=%SP_DIR%\helics\install ..
cmake --build . --config Release --target install

if errorlevel 1 exit /b 1

popd

pushd "%SRC_DIR%"\pyhelics\

xcopy helics\* %SP_DIR%\helics\

popd

exit 0
