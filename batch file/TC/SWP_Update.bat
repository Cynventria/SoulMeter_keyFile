@ECHO OFF
chcp 65001
CLS

ECHO SWPkey更新工具，更新資料來源github.com/Cynventria，目前最新版本為:
ECHO.
curl -s -o Version.txt https://raw.githubusercontent.com/Cynventria/SoulMeter_keyFile/main/Version.txt
TYPE Version.txt
DEL Version.txt
ECHO.
ECHO 若要取消更新，請關閉此視窗
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
ECHO SWPkey已更新至最新 
ECHO 請開啟SoulMeter(1.2.8a+)並檢查SWPkey是否被正確載入 
ECHO 若仍無法使用或未被載入，請嘗試手動更新  
ECHO.

PAUSE


