*** Settings ***
Resource    ../PO/AppHeader.robot
Resource    ../PO/CharterForm.robot
Resource    ../PO/BugreportList.robot
Resource    ../PO/SessionList.robot

*** Variables ***

*** Keywords ***
AppHeader.click "Log out"
AppHeader.click app logo

AppHeader.click "Back" button
    AppHeader.click "Back" button

CharterForm.Change charter notes text
    [Arguments]    ${text}
    CharterForm.Change charter notes text     ${text}

CharterForm.Change charter text
    [Arguments]    ${text}
    CharterForm.Change charter text     ${text}

CharterForm.Click on the "Edit" button
    CharterForm.Click on the "Edit" button

CharterForm.Verify charter text is equal to
    [Arguments]    ${text}
    CharterForm.Verify charter text is equal to     ${text}

CharterForm.Verify charter note text is equal to
    [Arguments]    ${text}
    CharterForm.Verify charter note text is equal to    ${text}

Create new session

BugreportList.Open bugreport
    [Arguments]    ${title}
    BugreportList.Open bugreport    ${title}

CharterForm.Click on the "New session" button
    CharterForm.Click on the "New session" button

SessionList.Select "nth" session from the session list
    [Arguments]         ${session}
    SessionList.Select "nth" session from the session list  ${session}

BugreportList.Open "nth" bugreport
    [Arguments]    ${bugreport}
    BugreportList.Open "nth" bugreport      ${bugreport}