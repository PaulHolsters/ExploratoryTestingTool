*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Open bugreport
    [Arguments]    ${title}
    click element  xpath://p[contains(text(), "${title}")]

Open "nth" bugreport
    [Arguments]    ${bugreport}
    ${converted} =  convert to integer    ${bugreport}
    ${sum} =        evaluate    ${converted} + 1
    click element  xpath://h3[contains(text(), "Bugreports")]/following-sibling::ul/li[${sum}]/a