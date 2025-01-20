*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Open bugreport
    [Arguments]    ${title}
    click element  xpath://p[contains(text(), "${title}")]