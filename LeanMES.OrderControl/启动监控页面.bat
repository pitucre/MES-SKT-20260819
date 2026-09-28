@echo off
setlocal EnableDelayedExpansion

chcp 65001 >nul 2>&1
title Machine Status Monitor

echo.
echo ========================================
echo   Injection Machine Status Monitor
echo ========================================
echo.

set EXE_PATH=%~dp0bin\Debug\net48\LeanMES.OrderControl.exe
set MONITOR_PATH=%~dp0Monitor\index.html

echo [1] Running status checker...
echo.

if exist "%EXE_PATH%" (
    "%EXE_PATH%" --check-status
    echo.
    echo [2] Opening monitor page...
    start "" "%MONITOR_PATH%"
) else (
    echo Error: exe not found!
    echo Path: %EXE_PATH%
    echo.
    pause
)
