@echo off

:: Set the working directory to the script's directory
cd /d "%~dp0"

:: Simple text art for "Autofill Manager 1.0"
echo ============================================
echo           Chrome (Edge, Brave, Opera etc..) Autofill Importer 1.0
echo        Author: github.com/TempusOwl
echo ============================================

:: Check if the script is run as administrator
NET SESSION >nul 2>nul
if %errorlevel% neq 0 (
    echo This script requires administrator privileges. Please right-click and select "Run as administrator".
    pause
    exit /b 1
)

:: Check if Node.js is already installed
node -v >nul 2>nul
if %errorlevel% equ 0 (
    echo Node.js is already installed.

    :: Check for data.json file
    if exist data.json (
        echo data.json found.
    ) else (
        echo data.json not found in the same directory.
    )

    :: Run npm install locally
    echo Installing dependencies...
    call npm install

    :: Run importautofill.js if it exists in the same directory
    if exist importautofill.js (
        echo Running importautofill.js...
        node importautofill.js
    ) else (
        echo importautofill.js not found in the same directory.
    )

    pause
    exit /b 0
) else (
    echo Node.js is not installed. Please install it using install-node.bat and then run this script again.
    pause
    exit /b 1
)

: Set the desired Node.js version
SET "NODE_VERSION=v21.6.1"

echo Installing Node.js %NODE_VERSION%...

:: Download the Node.js installer
curl -o node_setup.msi https://nodejs.org/dist/%NODE_VERSION%/node-%NODE_VERSION%-x64.msi

:: Install Node.js
start /wait "" msiexec /i node_setup.msi

:: Check Node.js and npm versions
node -v
npm -v

:: Wait for a few seconds to ensure the installer has completed
timeout /t 5 /nobreak > nul

:: Clean up temporary files
del node_setup.msi

echo Node.js installation complete.

:: Check for data.json file
if exist data.json (
    echo data.json found.
) else (
    echo data.json not found in the same directory.
)

:: Run npm install locally
echo Installing dependencies...
call npm install

:: Run importautofill.js if it exists in the same directory
if exist importautofill.js (
    echo Running importautofill.js...
    node importautofill.js
) else (
    echo importautofill.js not found in the same directory.
)

:: Pause to keep the window open
pause
exit /b 0
