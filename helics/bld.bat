IF "%PY_VER%"=="2.7" (
    %PYTHON% -m pip install --no-deps https://pypi.org/packages/cp27/h/helics/helics-%PKG_VERSION%-cp27-cp27m-win_amd64.whl
)

IF "%PY_VER%"=="3.5" (
    %PYTHON% -m pip install --no-deps https://pypi.org/packages/cp35/h/helics/helics-%PKG_VERSION%-cp35-cp35m-win_amd64.whl
)

IF "%PY_VER%"=="3.6" (
    %PYTHON% -m pip install --no-deps https://pypi.org/packages/cp36/h/helics/helics-%PKG_VERSION%-cp36-cp36m-win_amd64.whl
)

IF "%PY_VER%"=="3.7" (
    %PYTHON% -m pip install --no-deps https://pypi.org/packages/cp37/h/helics/helics-%PKG_VERSION%-cp37-cp37m-win_amd64.whl
)

IF "%ARCH%"=="32" (
    %PYTHON% -m pip install --no-deps https://files.pythonhosted.org/packages/18/0d/bb3fe292beb8f602dc0ac6f2ca62ad9d0ec067c7d1006690ef4fbbafc93d/helics_apps-2.4.1-py2.py3-none-win32.whl
) ELSE (
    %PYTHON% -m pip install --no-deps https://files.pythonhosted.org/packages/fa/5c/8db7fecc8fbd0b0aa1418e727f1dcd22dedd495228902a60be6fd9e122ab/helics_apps-2.4.1-py2.py3-none-win_amd64.whl
)
IF "%ARCH%"=="64" (
    %PYTHON% -m pip install --no-deps https://files.pythonhosted.org/packages/fa/5c/8db7fecc8fbd0b0aa1418e727f1dcd22dedd495228902a60be6fd9e122ab/helics_apps-2.4.1-py2.py3-none-win_amd64.whl
) ELSE (
    %PYTHON% -m pip install --no-deps https://files.pythonhosted.org/packages/18/0d/bb3fe292beb8f602dc0ac6f2ca62ad9d0ec067c7d1006690ef4fbbafc93d/helics_apps-2.4.1-py2.py3-none-win32.whl
)

if errorlevel 1 exit 1
