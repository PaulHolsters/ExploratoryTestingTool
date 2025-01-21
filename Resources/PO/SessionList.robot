*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Select "nth" session from the session list
    [Arguments]         ${session}
    click element       dom:document.querySelectorAll('main ul')[1].querySelectorAll('a')[${session}]