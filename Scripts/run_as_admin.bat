@echo off
set downloadedFilePath=%1
powershell -Command "Get-Process | Where-Object { $_.Name -like '*Video.UI*' } | Stop-Process -Force"
"D:\PSTools\PsExec.exe" -s -i -h -d -accepteula -u Administrator -p "mygreatpassword123;" "C:\Program Files\Windows Media Player\wmplayer.exe" %downloadedFilePath% > "D:\log_file.txt" 2>&1
"D:\PSTools\PsExec.exe" -s -i -h -d -accepteula -u Administrator -p "mygreatpassword123;" "C:\Program Files (x86)\AutoIt3\AutoIt3.exe" "C:\Users\PC Gebruiker\PycharmProjects\TestAutomation\Robotframework\ExploratoryTestingTool\Scripts\check_playback_v2.au3"
timeout /t 3
powershell -Command "Get-Process | Where-Object { $_.Name -like '*wmplayer*' -or $_.Name -like '*WMP*' } | Stop-Process -Force"






