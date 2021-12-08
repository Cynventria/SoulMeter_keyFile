@ECHO OFF

ECHO Updateing SWPkey, updating from github.com/Cynventria, latest version is:
ECHO.
curl -s -o Version.txt https://raw.githubusercontent.com/Cynventria/SoulMeter_keyFile/main/Version.txt
TYPE Version.txt
DEL Version.txt
ECHO.
ECHO Close this window to cancel update
PAUSE


IF EXIST BACKUP_SWPkey.bin (
  DEL BACKUP_SWPkey.bin
)

IF EXIST SWPkey.bin (
  RENAME SWPkey.bin BACKUP_SWPkey.bin
)

ECHO.
curl -o SWPkey.bin https://raw.githubusercontent.com/Cynventria/SoulMeter_keyFile/main/SWPkey.bin

ECHO.
ECHO SWPkey updated to latest
ECHO Please open SoulMeter(1.2.8a+) and check if the file being loaded successfully
ECHO If not, wait for update or try download it manually 
ECHO.

PAUSE


