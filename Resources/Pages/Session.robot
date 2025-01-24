*** Settings ***
Resource    ../PO/AppHeader.robot
Resource    ../PO/SessionForm.robot
Resource    ../PO/RecordingList.robot
Resource    ../PO/RecordingForm.robot
Resource    ../PO/NoteList.robot
Resource    ../PO/BugreportList.robot
Resource    ../PO/NewBugreportForm.robot
Resource    ../PO/SessionButtons.robot

*** Keywords ***
SessionForm.Verify if session has a title
    SessionForm.Verify if session has a title

SessionForm.Verify if "Findings" textarea has text
    [Arguments]    ${text}
    SessionForm.Verify if "findings" textarea has text  ${text}

SessionForm.Change "Findings" textarea to
    [Arguments]     ${findings}
    SessionForm.Change "Findings" textarea to    ${findings}

SessionForm.Click "Edit" button
    SessionForm.Click "Edit" button

SessionForm.Click "Delete" button
    SessionForm.Click "Delete" button

SessionForm.Verify if "Findings" textarea contains text
    [Arguments]    ${text}
    SessionForm.Verify if "findings" textarea contains text  ${text}

SessionForm.Add findings to the "Findings" textarea
    [Arguments]     ${findings}
    SessionForm.Add findings to the "Findings" textarea     ${findings}

SessionForm.Replace text in "Title" textfield with
    [Arguments]     ${text}
    SessionForm.Replace text in "Title" textfield with    ${text}

SessionForm.Verify if "Title" textfield has text
    [Arguments]     ${text}
    SessionForm.Verify if "Title" textfield has text    ${text}

RecordingList.There is at least one recording in the list
    ${exists} =  RecordingList.There is at least one recording in the list
    RETURN  ${exists}

RecordingList.Click on the "pencil" icon of the nth recording
    [Arguments]     ${index}
    RecordingList.Click on the "pencil" icon of the nth recording    ${index}

RecordingList.Click on the "trash" icon of the nth recording
    [Arguments]     ${index}
    RecordingList.Click on the "trash" icon of the nth recording     ${index}

RecordingList.Get timestamp of nth recording
    [Arguments]     ${index}
    ${timestamp} =  RecordingList.Get timestamp of nth recording   ${index}
    RETURN    ${timestamp}

RecordingList.Verify no recording exists with timestamp
     [Arguments]     ${timestamp}
     RecordingList.Verify no recording exists with timestamp        ${timestamp}

RecordingList.Verify the nth recording in the list has name
    [Arguments]     ${index}    ${name}
    RecordingList.Verify the nth recording in the list has name     ${index}    ${name}

RecordingForm.Change name of recording into
    [Arguments]     ${text}
    RecordingForm.Change name of recording into     ${text}

RecordingForm.Click on the "Edit" button
    RecordingForm.Click on the "Edit" button

AppHeader.click "Back" button
    AppHeader.click "Back" button

NoteList.There is at least one note that was taken outside of a recording
    ${exists} =     NoteList.There is at least one note that was taken outside of a recording
    RETURN  ${exists}

NoteList.There is at least one note that was taken while recording
    ${exists} =     NoteList.There is at least one note that was taken while recording
    RETURN  ${exists}

NoteList.Delete all notes
    NoteList.Delete all notes

NoteList.Verify list is empty
    NoteList.Verify list is empty

NewBugreportForm.Click the "Create" button
    NewBugreportForm.Click the "Create" button

NewBugreportForm.Enter environment in "Environment" textfield
    [Arguments]     ${val}
    NewBugreportForm.Enter environment in "Environment" textfield      ${val}

NewBugreportForm.Enter title in "Title" textfield
    [Arguments]     ${val}
    NewBugreportForm.Enter title in "Title" textfield  ${val}

NewBugreportForm.Enter users in "Users" textfield
    [Arguments]     ${val}
    NewBugreportForm.Enter users in "Users" textfield       ${val}

BugreportList.Verify the list contains a bugreport with title
    [Arguments]    ${title}
    BugreportList.Verify the list contains a bugreport with title  ${title}

SessionButtons.Click "Create bugreport" button
    SessionButtons.Click "Create bugreport" button