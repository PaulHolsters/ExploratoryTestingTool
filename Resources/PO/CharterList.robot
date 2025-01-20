*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Verify if test charter is in the charter list
    [Arguments]             ${Charter}
    page should contain     ${Charter}

Select a charter from the charter list
    [Arguments]         ${Charter}
    click element       xpath://p[contains(text(), "${Charter}")]