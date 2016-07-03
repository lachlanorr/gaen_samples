:: Run this first on a clean system to prepare gaen_samples build.

@ECHO OFF
SETLOCAL

:: Change to root dir
CD /d %~dp0

:: Make sure we're in a clean state
call .\clean.bat
if %errorlevel% neq 0 exit /b %errorlevel%

:: Clone gaen if it doesn't exist. This will need to happen for
:: anyone who has cloned the project specific repository and is running
:: bootstrap.bat for the first time.
IF NOT EXIST .\gaen (
  git clone -b master https://github.com/lachlanorr/gaen.git gaen
  if %errorlevel% neq 0 exit /b %errorlevel%
)

:: Write root directory to main GAEN_SAMPLES_ROOT env var
FOR /f "tokens=1" %%B in ('CHDIR') do set GAEN_SAMPLES_ROOT=%%B

if "%1"=="" (
    SET PLAT=win64
)
if "%1"=="win64" (
    SET PLAT=win64
)
if "%1"=="win32" (
    SET PLAT=win32
)
if "%PLAT%"=="" (
    echo Invalid platform type "%1", must be win32 or win64
    exit /b 1
)

set BUILD_DIR=%GAEN_SAMPLES_ROOT%\build\%PLAT%

if not exist "%BUILD_DIR%" (
   mkdir "%BUILD_DIR%"
   if %errorlevel% neq 0 exit /b %errorlevel%
)

:: Create our project specific system_api_meta.cpp
python "%~dp0\gaen\python\codegen_api.py"
if %errorlevel% neq 0 exit /b %errorlevel%

:: Issue cmake command
cd %BUILD_DIR%
if "%PLAT%"=="win64" (
    cmake -G "Visual Studio 14 Win64" %GAEN_SAMPLES_ROOT%
    if %errorlevel% neq 0 exit /b %errorlevel%
)
if "%PLAT%"=="win32" (
    cmake -G "Visual Studio 14" %GAEN_SAMPLES_ROOT%
    if %errorlevel% neq 0 exit /b %errorlevel%
)

echo.
echo Bootstrapping complete.
echo Visual Studio solution: %BUILD_DIR%\gaen_samples.sln
echo.

