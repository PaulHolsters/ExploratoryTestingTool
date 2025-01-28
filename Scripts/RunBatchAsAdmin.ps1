param (
    [string]$downloadedFilePath
)

# Path to the original batch file
$originalBatchFile = "C:\Users\PC Gebruiker\PycharmProjects\TestAutomation\Robotframework\ExploratoryTestingTool\Scripts\run_as_admin.bat"
$logFile = "C:\Users\PC Gebruiker\PycharmProjects\TestAutomation\Robotframework\ExploratoryTestingTool\Scripts\BatchFileOutput.log"

# Path to the temporary batch file
$tempBatchFile = "C:\Users\PC Gebruiker\PycharmProjects\TestAutomation\Robotframework\ExploratoryTestingTool\Scripts\temp_run_as_admin.bat"

# Create the temporary batch file
$batchContent = "@echo off
`"$originalBatchFile`" `"$downloadedFilePath`""
Set-Content -Path $tempBatchFile -Value $batchContent

# Run the temporary batch file with elevated privileges
try {
    Write-Output "Executing temporary batch file: $tempBatchFile"

    Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$tempBatchFile`"" -Verb RunAs -Wait

        # Start-Process -FilePath "cmd.exe" -ArgumentList @("/c", "`"$batchFile`"", "`"$downloadedFilePath`"") -Verb RunAs -Wait
    Write-Output "Batch file executed successfully."

    # Display the output
    if (Test-Path $logFile) {
        Get-Content $logFile
    } else {
        Write-Output "Log file not found."
    }
} catch {
    Write-Output "Error: $_"
}

#