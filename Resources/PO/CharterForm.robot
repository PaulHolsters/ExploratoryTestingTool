*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Change charter text
    [Arguments]    ${Text}
    input text      charter     ${Text}

Change charter notes text
    [Arguments]    ${Text}
    input text      notes     ${Text}

Click on the "Edit" button
    click button    Edit

Verify charter text is equal to
    [Arguments]         ${Text}
    ${actualValue} =    get text    charter
    should be equal as strings     ${Text}      ${actualValue}

Verify charter note text is equal to
    [Arguments]         ${Text}
    ${actualValue} =    get text    notes
    should be equal as strings     ${Text}      ${actualValue}

Click on the "New session" button
    click button    New session
