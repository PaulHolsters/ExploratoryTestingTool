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
    # deze check is ingebouwd omdat je bij de complexe acties
    # per abuis mogelijks op een andere pagina kan zijn waarbij deze
    # locators ook werken (omdat ze zo algemeen zijn)
    location should be    ${BASE_URL}tests
    CharterList.Verify if test charter is in the charter list   ${charter}

CharterList.Select a charter from the charter list
    [Arguments]    ${charter}
    # deze check is ingebouwd omdat je bij de complexe acties
    # per abuis mogelijks op een andere pagina kan zijn waarbij deze
    # locators ook werken
    location should be    ${BASE_URL}tests
    CharterList.Select a charter from the charter list   ${charter}

CharterList.Select "nth" charter from the charter list
    [Arguments]     ${charter}
    # deze check is ingebouwd omdat je bij de complexe acties
    # per abuis mogelijks op een andere pagina kan zijn waarbij deze
    # locators ook werken
    location should be    ${BASE_URL}tests
    CharterList.Select "nth" charter from the charter list  ${charter}

NewCharterForm.Click on the "Create" button
    NewCharterForm.Click on the "Create" button

NewCharterForm.Enter charter text
    [Arguments]    ${text}
    NewCharterForm.Enter charter text   ${text}

Verify if page has loaded
    location should be    ${BASE_URL}tests
    wait until page contains    New test

CharterList.Get number of charters in the "Charters" list
    # deze check is ingebouwd omdat je bij de complexe acties
    # per abuis mogelijks op een andere pagina kan zijn waarbij deze
    # locators ook werken
    location should be    ${BASE_URL}tests
    ${count} =  CharterList.Get number of charters in the "Charters" list
    RETURN      ${count}

