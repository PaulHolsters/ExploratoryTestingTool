*** Settings ***
Resource    ../PO/AppHeader.robot
Resource    ../PO/CharterList.robot
Resource    ../PO/NewCharterForm.robot

*** Variables ***

*** Keywords ***
AppHeader.click app logo
    AppHeader.click app logo

AppHeader.click "Log out"
    AppHeader.click "Log out"

CharterList.Verify if test charter is in the charter list
    [Arguments]    ${charter}
    CharterList.Verify if test charter is in the charter list   ${charter}

CharterList.Select a charter from the charter list
    [Arguments]    ${charter}
    CharterList.Select a charter from the charter list   ${charter}

CharterList.Select "nth" charter from the charter list
    [Arguments]     ${charter}
    CharterList.Select "nth" charter from the charter list  ${charter}

NewCharterForm.Click on the "Create" button
    NewCharterForm.Click on the "Create" button

NewCharterForm.Enter charter text
    [Arguments]    ${text}
    NewCharterForm.Enter charter text   ${text}

Verify if page has loaded
    wait until page contains    New test


