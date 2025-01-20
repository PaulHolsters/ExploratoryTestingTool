*** Settings ***
Library    SeleniumLibrary
Library    String

*** Keywords ***
Verify if bug report has title
    [Arguments]     ${value}
    ${title} =    get value       title
    should be equal as strings    ${title}    ${value}