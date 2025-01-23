*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${SESSION_LIST} =   xpath://h3[text()='Sessions']/following-sibling::ul[1]

*** Keywords ***
Select "nth" session from the session list
    [Arguments]         ${session}
    click element       dom:document.querySelectorAll('main ul')[1].querySelectorAll('a')[${session}]

Get number of sessions in the "Sessions" list
    ${count} =  get element count   ${SESSION_LIST}//li
    RETURN      ${count}

