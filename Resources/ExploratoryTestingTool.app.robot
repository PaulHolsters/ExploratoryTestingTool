*** Settings ***
Resource    Pages/Charter.robot
Resource    Pages/CharterDetail.robot
Resource    Pages/Session.robot

*** Keywords ***
Open a session that has an existing recording in its "Recordings" list
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