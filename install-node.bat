@echo off
setlocal

:: Check if Node.js is already installed
for /f "delims=" %%v in ('node -v 2^>nul') do set "NODE_VERSION=%%v"
if defined NODE_VERSION (
    echo Node.js is already installed: %NODE_VERSION%
) else (
    :: Install Node.js
    echo Installing Node.js...
    winget install OpenJS.NodeJS || (
        echo Failed to install Node.js.
        exit /b 1
    )
    echo Node.js installed successfully.
)

:: Keep the command prompt window open
pause

endlocal