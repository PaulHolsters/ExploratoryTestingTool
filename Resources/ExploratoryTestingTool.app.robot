*** Settings ***
Library    SeleniumLibrary
Resource    Pages/Charter.robot
Resource    Pages/CharterDetail.robot
Resource    Pages/Session.robot

*** Variables ***
${BASE_URL} =   http://127.0.0.1:8000
&{URLS}     home=${BASE_URL}    charter=${BASE_URL}/tests   login=${BASE_URL}/login
# https://www.exploratory-testing-tool.com/
# http://127.0.0.1:8000/
*** Keywords ***
Open ${pagename} page
    ${loc} =    get location
    RUN KEYWORD IF   '${loc}' != '${URLS}[${pagename}]'    go to    ${URLS}[${pagename}]

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

#open a session
#    ${found} =      set variable    ${false}
#    ${number_of_charters} =     Charter.CharterList.Get number of charters in the "Charters" list
#    FOR    ${index}     IN RANGE  ${number_of_charters}
#        Charter.CharterList.Select "nth" charter from the charter list    ${index}
#        ${number_of_sessions} =     CharterDetail.SessionList.Get number of sessions in the "Sessions" list
#        IF    ${number_of_sessions} > 0
#            CharterDetail.SessionList.Select "nth" session from the session list    0
#            ${found} =  set variable    ${true}
#            exit for loop
#        END
#    END
#    run keyword if   ${found} == ${false}     fail     No session found