@echo off
rem 编译 SKTLicGen 工具（.NET Framework 4.x）
rem 依赖 System.Web.Engine.dll 和 System.Management.dll
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

"%CSC%" /nologo /target:exe /out:SKTLicGen.exe ^
  /r:"C:\Windows\Microsoft.NET\Framework64\v4.0.30319\mscorlib.dll" ^
  /r:"C:\Windows\Microsoft.NET\Framework64\v4.0.30319\System.Management.dll" ^
  /r:"E:\source\MES\SKT\20260819\Code\Web\bin\System.Web.Engine.dll" ^
  Program.cs

if %errorlevel%==0 (
  echo.
  echo Build OK: SKTLicGen.exe
  echo Usage: SKTLicGen.exe [--out path] [--customer name] [--system name] [--version v] [--line n] [--user n] [--expire date] [--service date] [--cpu c] [--mac m] [--disk d] [--dll path]
  echo Example: SKTLicGen.exe --out "E:\source\MES\SKT\20260819\Code\Web\SKTLicense.cer"
) else (
  echo Build FAILED
)
endlocal