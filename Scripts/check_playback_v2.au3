#include <Misc.au3>
#RequireAdmin

Local $logFile = "D:\playback_status.log"

Local $hFile = FileOpen($logFile, 1)

FileWrite($hFile, "Script started" & @CRLF)

Local $status = "No status assigned yet"
Sleep(1000)
Local $aList = WinList("Windows Media Player", "Er is een probleem opgetreden tijdens het afspelen van het bestand in Windows Mediaspeler.")

Local $numberOfWindows = $aList[0][0]

FileWrite($hFile, "Number of windows: " & $numberOfWindows & @CRLF)

Sleep(1000) ; na lang ermee spelen blijkt dat het toch compleet onbetrouwbaar is maw onderstaaand window bestaat blijkbaar niet

If WinExists("Windows Media Player", "Er is een probleem opgetreden tijdens het afspelen van het bestand in Windows Mediaspeler.") Then
    $status = "Playback failed. Check if the file is corrupted."
Else
    $status = "Playback successful."
EndIf

FileWrite($hFile, "Status set: " & $status & @CRLF)

FileClose($hFile)
Exit

