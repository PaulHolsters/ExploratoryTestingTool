*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Verify if test charter is in the charter list
    [Arguments]             ${Charter}
    page should contain     ${Charter}

Select a charter from the charter list
    [Arguments]         ${Charter}
    click element       xpath://p[contains(text(), "${Charter}")]

Select "nth" charter from the charter list
    [Arguments]     ${charter}
    click element       dom:document.querySelectorAll('main ul a')[${charter}]

Get number of charters in the "Charters" list
    ${elements}=    get element count    css:ul a
    RETURN    ${elements}