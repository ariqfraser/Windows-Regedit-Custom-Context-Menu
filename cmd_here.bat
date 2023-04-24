@echo off

:: Check if script is running as administrator
net session >nul 2>&1
if %errorlevel% == 0 (
 echo STARTING
) else (
  echo ERROR: This script needs to be ran as administrator.
  echo Press any key to close.
  pause >nul
  exit /b
)

:: Create key for context menu
set "keyPath=HKEY_CLASSES_ROOT\Directory\Background\shell\cmd_here"
echo INFO: Adding context menu item...
reg add "%keyPath%" /ve /t REG_SZ /d "Open CMD here"

:: Adding cmd functionality
echo INFO: Adding context menu functionality
reg add "%keyPath%\command" /ve /t REG_SZ /d "cmd.exe /k cd "%V"" 

:: Adding icon
echo INFO: Adding icon...
set "icon="
for /f "delims=" %%a in ('where cmd') do set "icon=%%a"
reg add "%keyPath%" /v "Icon" /t REG_SZ /d "%icon%" 

pause >nul

