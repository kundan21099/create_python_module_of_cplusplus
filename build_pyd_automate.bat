REM Batch script to build a Python extension module (.pyd) using g++
REM Activate your python env before running this script to ensure correct paths

REM Get Python include path dynamically
FOR /F "usebackq tokens=*" %%i IN (`python -c "import sysconfig; print(sysconfig.get_paths()['include'])"`) DO SET PYTHON_INCLUDE=%%i

REM Get pybind11 include path dynamically
FOR /F "usebackq tokens=*" %%i IN (`python -c "import pybind11; print(pybind11.get_include())"`) DO SET PYBIND11_INCLUDE=%%i

echo PYTHON_INCLUDE=%PYTHON_INCLUDE%
echo PYBIND11_INCLUDE=%PYBIND11_INCLUDE%

REM ------------------------------------------------------------
REM Get Python link flag dynamically (e.g., python310)
FOR /F "usebackq tokens=*" %%i IN (`python -c "import sysconfig; print('python' + sysconfig.get_config_var('VERSION').replace('.', ''))"`) DO SET PYTHON_LIB_NAME=%%i

echo PYTHON_LIB_NAME=%PYTHON_LIB_NAME%
REM ------------------------------------------------------------

:: manually add directory paths
SET PROJECT_INCLUDE=<include your project include path here>
SET BUILD_DIR=<include your build directory path here>
SET SRC_DIR=<include your source directory path here>
SET PYBIND11_SRC=<include your pybind11 source directory path here>
SET OUTPUT_PYD=<include your output pyd directory path here>

:: Set file names
SET CPLUSPLUS_CLASS=<include your C++ class file name here>
SET PYBIND11_CPP=<include your pybind11 cpp file name here>
SET CPLUSPLUS_OBJ=<include your C++ object file name here>
SET PYBIND11_OBJ=<include your pybind11 object file name here>
SET PYD_FILE_NAME=<include your output pyd file name here>


g++ -O2 -Wall -std=c++17 -fPIC -I"%PYTHON_INCLUDE%" -I"%PROJECT_INCLUDE%" -I"%PYBIND11_INCLUDE%" -c "%SRC_DIR%\%CPLUSPLUS_CLASS%" -o "%BUILD_DIR%\%CPLUSPLUS_OBJ%"

IF ERRORLEVEL 1 (
    echo Error compiling %CPLUSPLUS_CLASS%
    exit /b 1
)

g++ -O2 -Wall -std=c++17 -fPIC -I"%PYTHON_INCLUDE%" -I"%PROJECT_INCLUDE%" -I"%PYBIND11_INCLUDE%" -c "%PYBIND11_SRC%\%PYBIND11_CPP%" -o "%BUILD_DIR%\%PYBIND11_OBJ%"

IF ERRORLEVEL 1 (
    echo Error compiling %PYBIND11_CPP%
    exit /b 1
)

g++ -shared "%BUILD_DIR%\%CPLUSPLUS_OBJ%" "%BUILD_DIR%\%PYBIND11_OBJ%" -o "%OUTPUT_PYD%\%PYD_FILE_NAME%" -L"%PYTHON_LIB%" -l%PYTHON_LIB_NAME%

IF ERRORLEVEL 1 (
    echo Error linking %PYD_FILE_NAME%
    exit /b 1
)
echo Build successful!
pause