*** Settings ***
Library    SeleniumLibrary
Library    ../../Libraries/Common.py
Library     String
Library     Process
Library     OperatingSystem


*** Variables ***
${RECORDINGS_LIST} =    (//h3[text()='Recordings']/following-sibling::ul)[1]

*** Keywords ***
There is at least one recording in the list
    ${count} =      get element count    ${RECORDINGS_LIST}/li
    ${exists} =      evaluate    ${count}>0
    RETURN  ${exists}

Click on the "pencil" icon of the nth recording
    [Arguments]     ${index}
    ${index} =      evaluate    ${index} + 1
    click element    xpath:(//span[text()='Edit recording'])[${index}]/parent::button

Click on the "Download" button of the nth recording
    [Arguments]     ${index}
    ${index} =      evaluate    ${index} + 1
    click element    xpath:(//button[contains(text(),'Download')])[${index}]

Click on the "View" button of the nth recording
    [Arguments]     ${index}
    ${index} =      evaluate    ${index} + 1
    click element    xpath:(//button[contains(text(),'View')])[${index}]

Click on the "Download" button of recording with timestamp
    [Arguments]     ${timestamp}
    click element    xpath:${RECORDINGS_LIST}/li//p[1][contains(text(),'${timestamp}')]/ancestor::li//button[contains(text(),'Download')]

Get recording name of recording with timestamp
        [Arguments]     ${timestamp}
        ${name} =       get text    xpath:(${RECORDINGS_LIST}/li//p[1][contains(text(),'${timestamp}')]/ancestor::li//p)[2]
        RETURN  ${name}

Verify download of recording with timestamp
    [Arguments]     ${timestamp}
    Click on the "Download" button of recording with timestamp    ${timestamp}
    ${filename} =   Get recording name of recording with timestamp    ${timestamp}
    ${filename} =   strip string    ${filename}
    ${fn} =     catenate    D:\\Users\\PC Gebruiker\\Downloads\\${filename}
    Wait Until Keyword Succeeds    1min    10sec    File Should Exist    ${fn}
    ${PS_FILE} =    set variable     ${EXECDIR}${/}Scripts${/}RunBatchAsAdmin.ps1
    ${LOG_FILE} =   set variable   D:\playback_status.log
    ${result}=  Run Process    powershell.exe    -Command    Start-Process powershell.exe -ArgumentList '-ExecutionPolicy Bypass -File "${PS_FILE}" -downloadedFilePath "${fn}"' -Verb RunAs -Wait
    ${status}=  Wait Until Keyword Succeeds  1 min  2 sec  Get File  ${LOG_FILE}
    remove file    ${LOG_FILE}
    should contain    ${status}    Playback successful


Wait for recording to be created
    [Arguments]     ${last_index}
    wait until element is visible    xpath:${RECORDINGS_LIST}/li[${last_index}]

Get list of recordings
        @{RECORDINGS} =     get webelements    xpath:${RECORDINGS_LIST}/li
        @{TEXT_OF_RECORDINGS} =     get text nodes      ${RECORDINGS}
        ${TEXT_OF_RECORDINGS} =     get str parts    ${TEXT_OF_RECORDINGS}
        RETURN      ${TEXT_OF_RECORDINGS}

Get recording name of nth recording
    [Arguments]     ${index}
    ${index} =      evaluate    ${index} + 1
    ${name} =       get text     xpath:((//h3[text()='Recordings']/following-sibling::ul)[1]/li[${index}]//p)[2]
    RETURN          ${name}

Click on the "trash" icon of the nth recording
    [Arguments]     ${index}
    ${index} =      evaluate    ${index} + 1
    click element    xpath:(//span[text()='Delete recording'])[${index}]/parent::button


Verify no recording exists with timestamp
     [Arguments]     ${timestamp}
     ${recs} =      get element count    xpath:(//h3[text()='Recordings']/following-sibling::ul)[1]/li
     FOR    ${index}    IN RANGE     1       ${recs}
        ${ts} =     get text    xpath:((//h3[text()='Recordings']/following-sibling::ul)[1]/li[${index}]//p)[1]
        should not be equal as strings  ${ts}    ${timestamp}
     END

Verify the nth recording in the list has name
    [Arguments]     ${index}    ${name}
    ${index} =      evaluate    ${index} + 1
    element text should be      xpath:((//h3[text()='Recordings']/following-sibling::ul)[1]/li[${index}]//p)[2]   ${name}

Get timestamp of nth recording
    [Arguments]     ${index}
    ${index} =      evaluate    ${index} + 1
    ${timestamp} =  get text    xpath:((//h3[text()='Recordings']/following-sibling::ul)[1]/li[${index}]//p)[1]
    log to console    ${timestamp}
    RETURN              ${timestamp}

