*** Settings ***
Library    SeleniumLibrary
Library     Process
Library     OperatingSystem

Resource    Pages/Charter.robot
Resource    Pages/CharterDetail.robot
Resource    Pages/Session.robot
Resource    Pages/Bugreport.robot


*** Variables ***
${BASE_URL} =   http://127.0.0.1:8000
&{URLS}     home=${BASE_URL}    charter=${BASE_URL}/tests   login=${BASE_URL}/login

# https://www.exploratory-testing-tool.com/
# http://127.0.0.1:8000/
*** Keywords ***
Open ${pagename} page
    ${loc} =    get location
    RUN KEYWORD IF   '${loc}' != '${URLS}[${pagename}]'    go to    ${URLS}[${pagename}]

Download a recording and open it
    [Arguments]    ${CORRUPTED_FILE}=${empty}
    open a session that has an existing recording in its "recordings" list
    ${filename} =   Session.RecordingList.Get recording name of nth recording   0
    ${filename} =     strip string    ${filename}
    Session.RecordingList.Click on the "Download" button of the nth recording    0
    ${fn} =     catenate    D:\\Users\\PC Gebruiker\\Downloads\\${filename}
    log to console    corrupted fuile ${CORRUPTED_FILE}
    IF    '${CORRUPTED_FILE}' != '${EMPTY}'
        ${fn} =    set variable    D:\\Users\\PC Gebruiker\\Downloads\\${CORRUPTED_FILE}
    END
    Wait Until Keyword Succeeds    1min    10sec    File Should Exist    ${fn}
    ${PS_FILE} =    set variable     ${EXECDIR}${/}Scripts${/}RunBatchAsAdmin.ps1
    ${LOG_FILE} =   set variable   D:\playback_status.log
    ${result}=  Run Process    powershell.exe    -Command    Start-Process powershell.exe -ArgumentList '-ExecutionPolicy Bypass -File "${PS_FILE}" -downloadedFilePath "${fn}"' -Verb RunAs -Wait
    ${status}=  Wait Until Keyword Succeeds  1 min  2 sec  Get File  ${LOG_FILE}
    remove file    ${LOG_FILE}
    RETURN      ${status}

Open a bugreport that has no bug reproduction steps in it
    Open charter page
    ${CHARTER_INDEX} =      set variable    0
    ${CHARTER_COUNT} =      Charter.CharterList.Get number of charters in the "Charters" list
    ${BUGREPORT_NOT_FOUND} =      set variable    ${true}
    IF  ${CHARTER_COUNT} == 0   fail    No charters exist to select a bugreport from
    WHILE   ${BUGREPORT_NOT_FOUND}     limit=${CHARTER_COUNT}    on_limit=pass
        Charter.CharterList.Select "nth" charter from the charter list    ${CHARTER_INDEX}
        ${BUGREPORT_INDEX} =      set variable    0
        ${BUGREPORT_COUNT} =      CharterDetail.BugreportList.Get number of bugreports in the "Bugreports" list
        IF  ${BUGREPORT_COUNT} > 0
            WHILE    ${BUGREPORT_NOT_FOUND}     limit=${BUGREPORT_COUNT}    on_limit=pass
                    CharterDetail.BugreportList.Open "nth" bugreport    ${BUGREPORT_INDEX}
                    ${NO_STEPS_EXIST} =  Bugreport.ReproStepList.There are no bug reproduction steps present yet
                    IF      ${NO_STEPS_EXIST}
                        ${BUGREPORT_NOT_FOUND} =      set variable    ${false}
                    ELSE
                        Bugreport.AppHeader.click "Back" button
                    END
                    ${BUGREPORT_INDEX} =  evaluate    ${BUGREPORT_INDEX} + 1
            END
        END
        IF    ${BUGREPORT_NOT_FOUND}
            CharterDetail.AppHeader.click "Back" button
        END
        ${CHARTER_INDEX} =  evaluate    ${CHARTER_INDEX} + 1
    END
    run keyword if    ${CHARTER_INDEX} == ${CHARTER_COUNT}      fail    There aren't any existing bugreports to choose from

Open a bugreport that has at least ${REQUIRED_NUMBER_OF_STEPS} reproduction steps in it
    Open charter page
    ${CHARTER_INDEX} =      set variable    0
    ${CHARTER_COUNT} =      Charter.CharterList.Get number of charters in the "Charters" list
    ${BUGREPORT_NOT_FOUND} =      set variable    ${true}
    IF  ${CHARTER_COUNT} == 0   fail    No charters exist to select a bugreport from
    WHILE   ${BUGREPORT_NOT_FOUND}     limit=${CHARTER_COUNT}    on_limit=pass
        Charter.CharterList.Select "nth" charter from the charter list    ${CHARTER_INDEX}
        ${BUGREPORT_INDEX} =      set variable    0
        ${BUGREPORT_COUNT} =      CharterDetail.BugreportList.Get number of bugreports in the "Bugreports" list
        IF  ${BUGREPORT_COUNT} > 0
            WHILE    ${BUGREPORT_NOT_FOUND}     limit=${BUGREPORT_COUNT}    on_limit=pass
                CharterDetail.BugreportList.Open "nth" bugreport    ${BUGREPORT_INDEX}
                ${NUMBER_OF_STEPS_FOUND} =  Bugreport.ReproStepList.Get number of bug reproduction steps
                IF      ${NUMBER_OF_STEPS_FOUND} >= ${REQUIRED_NUMBER_OF_STEPS}
                    ${BUGREPORT_NOT_FOUND} =      set variable    ${false}
                ELSE
                    Bugreport.AppHeader.click "Back" button
                END
                ${BUGREPORT_INDEX} =  evaluate    ${BUGREPORT_INDEX} + 1
            END
        END
        IF    ${BUGREPORT_NOT_FOUND}
            CharterDetail.AppHeader.click "Back" button
        END
        ${CHARTER_INDEX} =  evaluate    ${CHARTER_INDEX} + 1
    END
    run keyword if    ${CHARTER_INDEX} == ${CHARTER_COUNT}      fail    There aren't any existing bugreports to choose from

Open a bugreport
    Open charter page
    ${CHARTER_INDEX} =      set variable    0
    ${CHARTER_COUNT} =      Charter.CharterList.Get number of charters in the "Charters" list
    ${BUGREPORT_NOT_FOUND} =      set variable    ${true}
    IF  ${CHARTER_COUNT} == 0   fail    No charters exist to select a bugreport from
    WHILE   ${BUGREPORT_NOT_FOUND}     limit=${CHARTER_COUNT}    on_limit=pass
        Charter.CharterList.Select "nth" charter from the charter list    ${CHARTER_INDEX}
        TRY
            CharterDetail.BugreportList.Open "nth" bugreport    0
            ${BUGREPORT_NOT_FOUND} =      set variable    ${false}
        EXCEPT
            CharterDetail.AppHeader.click "Back" button
            ${CHARTER_INDEX} =  evaluate    ${CHARTER_INDEX} + 1
        END
    END
    run keyword if    ${CHARTER_INDEX} == ${CHARTER_COUNT}      fail    There aren't any existing bugreports to choose from

Open a session that has an existing recording in its "Recordings" list
    Open charter page
    ${found} =      set variable    ${false}
    ${number_of_charters} =     Charter.CharterList.Get number of charters in the "Charters" list
    FOR    ${index}     IN RANGE  ${number_of_charters}
        Charter.CharterList.Select "nth" charter from the charter list    ${index}
        ${number_of_sessions} =     CharterDetail.SessionList.Get number of sessions in the "Sessions" list
        FOR    ${index2}    IN RANGE  ${number_of_sessions}
            CharterDetail.SessionList.Select "nth" session from the session list    ${index2}
            ${exists} =     Session.RecordingList.There is at least one recording in the list
            IF    ${exists}
                  ${found} =    set variable    ${true}
                  exit for loop
            END
            Session.AppHeader.click "Back" button
        END
        exit for loop if    ${found}
        CharterDetail.AppHeader.click "Back" button
    END
    run keyword if   ${found} == ${false}     fail     No session with an existing recording was found

Open a session that has at least two notes,where one of the notes was taken during a recording and the other one was not
    Open charter page
    ${found} =      set variable    ${false}
    ${number_of_charters} =     Charter.CharterList.Get number of charters in the "Charters" list
    FOR    ${index}     IN RANGE  ${number_of_charters}
        Charter.CharterList.Select "nth" charter from the charter list    ${index}
        ${number_of_sessions} =     CharterDetail.SessionList.Get number of sessions in the "Sessions" list
        FOR    ${index2}    IN RANGE  ${number_of_sessions}
            CharterDetail.SessionList.Select "nth" session from the session list    ${index2}
            ${note_outside_exists} =     Session.NoteList.There is at least one note that was taken outside of a recording
            ${note_during_exists} =     Session.NoteList.There is at least one note that was taken while recording
            IF    ${note_outside_exists} and ${note_during_exists}
                  ${found} =    set variable    ${true}
                  exit for loop
            END
            Session.AppHeader.click "Back" button
        END
        exit for loop if    ${found}
        CharterDetail.AppHeader.click "Back" button
    END
    run keyword if   ${found} == ${false}     fail     No session with the appropriate notes was found

Delete all sessions of nth charter
    [Arguments]    ${CHARTER_INDEX}
    Open charter page
    Charter.CharterList.Select "nth" charter from the charter list    ${CHARTER_INDEX}
    ${SESSION_COUNT} =  CharterDetail.SessionList.Get number of sessions in the "Sessions" list
    IF    ${SESSION_COUNT}>0
        WHILE   ${true}     limit=${SESSION_COUNT}    on_limit=pass
            CharterDetail.SessionList.Select "nth" session from the session list    0
            Session.SessionForm.Click "Delete" button
        END
    END

open a session that has at least one bugreport
    Open charter page
    ${found} =      set variable    ${false}
    ${number_of_charters} =     Charter.CharterList.Get number of charters in the "Charters" list
    FOR    ${index}     IN RANGE  ${number_of_charters}
        Charter.CharterList.Select "nth" charter from the charter list    ${index}
        ${number_of_sessions} =     CharterDetail.SessionList.Get number of sessions in the "Sessions" list
        FOR    ${index2}    IN RANGE  ${number_of_sessions}
            CharterDetail.SessionList.Select "nth" session from the session list    ${index2}
            ${COUNT} =  Session.BugreportList.Get number of bugreports in the "Bugreports" list
            IF    ${COUNT} > 0
                ${found} =    set variable    ${true}
                exit for loop
            END
            Session.AppHeader.click "Back" button
        END
        exit for loop if    ${found}
        CharterDetail.AppHeader.click "Back" button
    END
    run keyword if   ${found} == ${false}     fail     No session with an existing bugreport was found

open a session
    Open charter page
    ${CHARTER_INDEX} =      set variable    0
    ${CHARTER_COUNT} =      Charter.CharterList.Get number of charters in the "Charters" list
    ${SESSION_NOT_FOUND} =      set variable    ${true}
    IF  ${CHARTER_COUNT} == 0   fail    No charters exist to select a session from
    WHILE   ${SESSION_NOT_FOUND}     limit=${CHARTER_COUNT}    on_limit=pass
        Charter.CharterList.Select "nth" charter from the charter list    ${CHARTER_INDEX}
        TRY
            CharterDetail.SessionList.Select "nth" session from the session list    0
            ${SESSION_NOT_FOUND} =      set variable    ${false}
        EXCEPT
            CharterDetail.AppHeader.click "Back" button
            ${CHARTER_INDEX} =  evaluate    ${CHARTER_INDEX} + 1
        END
    END
    run keyword if    ${CHARTER_INDEX} == ${CHARTER_COUNT}      fail    There aren't any existing sessions to choose from