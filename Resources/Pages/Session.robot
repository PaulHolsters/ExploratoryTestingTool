*** Settings ***
Resource    ../PO/AppHeader.robot
Resource    ../PO/SessionForm.robot

*** Keywords ***
SessionForm.Verify if session has a title
    SessionForm.Verify if session has a title

SessionForm.Verify if "Findings" textarea has text
    [Arguments]    ${text}
    SessionForm.Verify if "findings" textarea has text  ${text}

SessionForm.Change "Findings" textarea to
    [Arguments]     ${findings}
    SessionForm.Change "Findings" textarea to    ${findings}

SessionForm.Click "edit" button
    SessionForm.Click "edit" button

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