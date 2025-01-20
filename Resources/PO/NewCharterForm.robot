*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Enter charter text
    [Arguments]    ${text}
    input text     charter      ${text}

Click on the "Create" button
    click button    Create