@echo off
rem 编译 SKTHwCollector 硬件信息收集工具（.NET Framework 4.x）
rem 无外部依赖，仅需 System.Management.dll
setlocal

set "CSC="
if exist "C:\Program Files\Microsoft Visual Studio\18\Community\MSBuild\Current\Bin\Roslyn\csc.exe" (
  set "CSC=C:\Program Files\Microsoft Visual Studio\18\Community\MSBuild\Current\Bin\Roslyn\csc.exe"
) else if exist "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\csc.exe" (
  set "CSC=C:\Windows\Microsoft.NET\Framework64\v4.0.30319\csc.exe"
)

if "%CSC%"=="" (
  echo [ERROR] csc.exe not found
  exit /b 1
)

"%CSC%" /nologo /target:exe /out:SKTHwCollector.exe ^
  /r:"C:\Windows\Microsoft.NET\Framework64\v4.0.30319\mscorlib.dll" ^
  /r:"C:\Windows\Microsoft.NET\Framework64\v4.0.30319\System.Management.dll" ^
  /r:"C:\Windows\Microsoft.NET\Framework64\v4.0.30319\System.dll" ^
  /r:"C:\Windows\Microsoft.NET\Framework64\v4.0.30319\System.Net.dll" ^
  /r:"C:\Windows\Microsoft.NET\Framework64\v4.0.30319\System.Windows.Forms.dll" ^
  Program.cs

if %errorlevel%==0 (
  echo.
  echo Build OK: SKTHwCollector.exe
  echo Usage: SKTHwCollector.exe [--out hwinfo.txt] [--clip]
) else (
  echo Build FAILED
)
endlocal
