*** Settings ***
Resource    Pages/Charter.robot
Resource    Pages/CharterDetail.robot
Resource    Pages/Session.robot

*** Keywords ***
Open a session that has an existing recording in its "Recordings" list
    ${found} =      set variable    False
    ${number_of_charters} =     Charter.CharterList.Get number of charters in the "Charters" list
    FOR    ${index}     IN RANGE  ${number_of_charters}

        # ${charter} =    evaluate    ${index} - 1
        log to console    ${index} charter INDEX with ${number_of_charters} of charters
        Charter.CharterList.Select "nth" charter from the charter list    ${index}
        ${number_of_sessions} =     CharterDetail.SessionList.Get number of sessions in the "Sessions" list
        FOR    ${index2}    IN RANGE  ${number_of_sessions}
            # ${session} =    evaluate    ${index2} - 1
            log to console    ${index2} session INDEX with ${number_of_sessions} of sessions
            CharterDetail.SessionList.Select "nth" session from the session list    ${index2}
            ${exists} =     Session.RecordingList.There is at least one recording in the list
            IF    ${exists}
                  ${found} =    set variable    True
                  exit for loop
            END
            Session.AppHeader.click "Back" button
        END
        exit for loop if    ${found} == True
        CharterDetail.AppHeader.click "Back" button
    END
    run keyword if   ${found} == False     fail