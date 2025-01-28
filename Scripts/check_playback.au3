#include <Misc.au3>  ; dit is er standaard in denk ik
#RequireAdmin
Opt("WinTitleMatchMode", 2) ; Match partial window titles

; Define the log file path
Local $logFile = "D:\playback_status.log"

; DIT FAALT
;WinWaitActive("Windows Media Player")

; Open the log file in write mode (1 = write mode, will create the file if it doesn't exist)
Local $hFile = FileOpen($logFile, 1)
If $hFile = -1 Then
    MsgBox(0, "Error", "Unable to open log file.")
    Exit
EndIf

; Add a debugging message to indicate the script is running
FileWrite($hFile, "Script started" & @CRLF)

; Wait for a few seconds to allow playback to start
Sleep(4000)

; Declare the status variable
;$text = WinGetText("Windows Media Player")

;WinWaitActive("[CLASS:#32770]")

; Check if the control exists
;$hControl = ControlGetHandle("", "", "[ID:201]")
;$text = ControlGetText("", "", "[ID:201]")
;FileWrite($hFile, "Text in window " & $text & @CRLF)

;If $hControl <> "" Then
;    $status = "Playback failed. Check if the file is corrupted."
;Else
;        $status = "Playback successful."
;EndIf

; The text you want to search for
;$searchText = "Er is een probleem opgetreden tijdens het afspelen van het bestand in Windows Mediaspeler."


;If StringInStr($text, $searchText) Then
;    $status = "Playback failed. Check if the file is corrupted."
;Else
;        $status = "Playback successful."
;EndIf

; Define the file path
;$filePath = @ScriptDir & "\WindowHandlesWithTitles.txt"

; Open the file for writing
;$file = FileOpen($filePath, 2) ; 2 = write mode

#cb

#ce

; Define the file path
;$filePath = @ScriptDir & "\WindowHandlesWithTitles.txt"

; Open the file for writing
;$file = FileOpen($filePath, 2) ; 2 = write mode

; List all open windows and their titles
;Local $aList = WinList()

; Define the file path
;$filePath = @ScriptDir & "\WindowHandlesWithTitles.txt"

; Open the file for writing


; List all open windows and their titles
;Local $aList = WinList()

; Loop through the list and write each window's title and handle to the file
#cb

#ce
; Close the file
;FileClose($file)

;MsgBox(0, "Done", "Window handles and titles have been written to " & $filePath)

; List all open windows and their titles
;Local $aList = WinList()
Local $status = "No status assigned yet"
; Loop through the list and display each window's title and handle
#cs
For $i = 1 To $aList[0][0]
    $hControl = WinGetHandle($aList[$i][1], "", "[CLASS:Edit; INSTANCE:1; ID:201]")
    If $hControl <> "" Then
        MsgBox(0, "YEAH", "The specified window does exist!!!!")
        ; Control exists, now get its text
        ; The text you want to search for
        $text = ControlGetText($hControl, "", "[CLASS:Edit; INSTANCE:1; ID:201]")
        $searchText = "Sluiten" & @CRLF & "Help op het &web" & @CRLF & "Er is een probleem opgetreden tijdens het afspelen van het bestand in Windows Mediaspeler."
        ; Check if the text is found
        If StringInStr($text, $searchText) Then
            $status = "Playback failed. Check if the file is corrupted."
        Else
            $status = "Playback successful."
        EndIf
    Else

    EndIf
Next
#ce
If WinExists("Windows Media Player") Then
    $status = "Playback failed. Check if the file is corrupted."
Else
    $status = "Playback successful."
EndIf
; Get the handle of the "Windows Media Player" window

#cb
$hWnd = WinGetHandle("Windows Media Player", _
"Sluiten" & _
"Help op het &web" & _
"Er is een probleem opgetreden tijdens het afspelen van het bestand in Windows Mediaspeler.")

If $hWnd <> "" Then
    $status = "Playback failed. Check if the file is corrupted."
Else
    $status = "Playback successful."
EndIf
#ce

; Add a debugging message to indicate the status has been set
;FileWrite($hFile, "Status set: " & $status & @CRLF)

; Add a final debugging message to indicate the script is finishing
FileWrite($hFile, "Script finished" & @CRLF)

; Close the log file
FileClose($hFile)

; Exit the script
Exit
