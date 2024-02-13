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

    :: Wheck for Web Data
    IF NOT EXIST "Web Data" (
        echo Critical Error: data.json not found in the same directory.
        pause
        exit /b 1
    )


    :: Check for data.json file
    IF NOT EXIST data.json (
        echo Critical Error: data.json not found in the same directory.
        pause
        exit /b 1
    )

    :: Run npm install locally
    echo Installing dependencies...
    call npm install sqlite3
    call npm install
    

    :: Run importautofill.js if it exists in the same directory
    if exist importautofill.js (
        echo ImportAutofill: Running importautofill.js...
        node importautofill.js
    ) else (
        echo Critical Error: importautofill.js not found in the same directory.
    )
 
    :: Pause to keep the window open
    pause
    exit /b 0

) else (
    echo Critical Error: Node.js is not installed. Please install it using install-node.bat and then run this script again.
    pause
    exit /b 1
)
