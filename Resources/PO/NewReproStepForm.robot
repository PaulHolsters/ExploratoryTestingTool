*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Enter step text
    [Arguments]    ${text}
    input text     step      ${text}

Click on the "Create" button
    click button    Create