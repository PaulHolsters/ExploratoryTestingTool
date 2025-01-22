*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Change name of recording into
    [Arguments]    ${Text}
    input text      name     ${Text}

Click on the "Edit" button
    click element    xpath://form[starts-with(@id, 'edit-recording-modalRec-')]/following-sibling::*//button[contains(text(),"Edit")]
