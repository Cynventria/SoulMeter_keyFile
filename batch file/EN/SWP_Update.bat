@echo off
title SWPkey Updater
setlocal EnableDelayedExpansion 

@REM Getting current online version
set onlineVersion=UnknownOnline

for /F %%i in ('curl -s https://raw.githubusercontent.com/Cynventria/SoulMeter_keyFile/main/Version.txt') do set onlineVersion=%%i

echo Online Version is:%onlineVersion%
echo;

@REM Finding current installed version
set installedVersion=UnknownInstalled
 
echo Reading Version.txt to find current installed version...

@REM :::: 1-Searching in Version.txt if available
if exist Version.txt (
    set /p installedVersion=<Version.txt 
    echo Installed Version is:!installedVersion!
) else (
    echo Can't find Version.txt file
    echo Attempting to extract installed version from SWPkey.bin...
    echo;
@REM :::: 2-Read SWPkey.bin and find its version
    @REM :: If there is major change in SWPkey.bin this line might not find the correct version
    for /F "tokens=2 delims=S" %%i in ('more +4 SWPkey.bin') do ( set installedVersion=%%i )
    IF not !installedVersion!==UnknownInstalled ( 
        set installedVersion=S!installedVersion!
        echo Installed Version is:!installedVersion!
        )
    :::: Save the extracted version in a text file for later updates
    echo !installedVersion!>Version.txt 
)



@REM Comparing installed vs online versions
set smthUnknown=false
if %installedVersion%==%onlineVersion% (
    echo Current version is the latest
    ) else (
        if %onlineVersion%==UnknownOnline (
            echo Couldn't determine the online version
            set smthUnknown=true
            )
        if %installedVersion%==UnknownInstalled (
            echo Couldn't determine the installed version
            set smthUnknown=true
            )
        if !smthUnknown!==false ( echo You don't have latest version)
    )

echo;
choice /c:yn /n /m "Do you want to download the latest online version? [Y]es/[N]o"

if %errorlevel%==1 goto:download_key
if %errorlevel%==2 goto:dont_download_key

pause
goto :eof

:download_key
echo Updateing SWPkey from github.com/Cynventria...
echo;
if exist BACKUP_SWPkey.bin (
  del BACKUP_SWPkey.bin
)
if exist SWPkey.bin (
  rename SWPkey.bin BACKUP_SWPkey.bin
)
echo %onlineVersion%>Version.txt
curl -o SWPkey.bin https://raw.githubusercontent.com/Cynventria/SoulMeter_keyFile/main/SWPkey.bin
echo;
echo SWPkey updated to latest version successfully
echo;
echo Please open SoulMeter(1.2.8a+) and check if the file being loaded successfully
echo If not, wait for update or try download it manually 
echo;
pause
goto :eof


:dont_download_key
echo;
echo User refused to download latest SWPkey.bin
echo script finished successfully...
echo;
pause
goto :eof