*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String

*** Variables ***
${SESSION_TITLE_TEXTFIELD} =    xpath://input[@id="title"]/ancestor::form//h2[text()="Test session"]/following-sibling::*//input[@id="title"]

*** Keywords ***
Verify if session has a title
    ${value} =    get value    dom:document.getElementsByName('title')[1]
    should not be empty    ${value}

Verify if "Findings" textarea has text
    [Arguments]    ${text}
    textarea value should be    id:findings   ${text}

Verify if "Findings" textarea contains text
    [Arguments]    ${text}
    textarea should contain    id:findings  ${text}

Add findings to the "Findings" textarea
    [Arguments]     ${findings}
    ${value} =    get value    id:findings
    ${value} =    catenate  ${value}    ${findings}
    input text    id:findings    ${value}

Click "edit" button
    click button    Edit

Change "Findings" textarea to
    [Arguments]     ${findings}
    input text      id:findings    ${findings}

Replace text in "Title" textfield with
    [Arguments]     ${text}
    input text      ${SESSION_TITLE_TEXTFIELD}      ${text}

Verify if "Title" textfield has text
    [Arguments]     ${text}
    textfield value should be   ${SESSION_TITLE_TEXTFIELD}   ${text}