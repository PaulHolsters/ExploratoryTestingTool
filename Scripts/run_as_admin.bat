@echo off
set downloadedFilePath=%1
echo The downloaded file path is: %downloadedFilePath%
:: Kill any lingering media player processes
::"D:\Users\PC Gebruiker\Downloads\session_1_1.webm"
powershell -Command "Get-Process | Where-Object { $_.Name -like '*Video.UI*' } | Stop-Process -Force"
echo Starting Program as Administrator...

:: Start Windows Media Player with the .webm file

"D:\PSTools\PsExec.exe" -s -i -h -d -accepteula -u Administrator -p "" "C:\Program Files\Windows Media Player\wmplayer.exe" %downloadedFilePath% > "D:\log_file.txt" 2>&1
echo Running AutoIt script...
:: Wait for 10 seconds to ensure the application is fully started
:: Kill Windows Media Player process

echo Running AutoIt script...
::powershell -Command "Get-Process | Where-Object { $_.Name -like '*wmplayer*' -or $_.Name -like '*WMP*' } | Stop-Process -Force"

"D:\PSTools\PsExec.exe" -s -i -h -d -accepteula -u Administrator -p " "C:\Program Files (x86)\AutoIt3\AutoIt3.exe" "C:\Users\PC Gebruiker\PycharmProjects\TestAutomation\Robotframework\ExploratoryTestingTool\Scripts\check_playback_v2.au3"
echo AutoIt script executed.
timeout /t 3
powershell -Command "Get-Process | Where-Object { $_.Name -like '*wmplayer*' -or $_.Name -like '*WMP*' } | Stop-Process -Force"

::powershell -Command "Get-Process | Where-Object { $_.Name -eq 'Video.UI' } | Stop-Process -Force"

echo Finished Execution.






