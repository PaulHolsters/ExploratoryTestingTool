*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${RECORDINGS_LIST} =    xpath:(//h3[text()='Recordings']/following-sibling::ul)[1]

*** Keywords ***
There is at least one recording in the list
    ${count} =      get element count    ${RECORDINGS_LIST}/li
    ${exists} =      evaluate    ${count}>0
    RETURN  ${exists}

Click on the "pencil" icon of the nth recording
    [Arguments]     ${index}
    ${index} =      evaluate    ${index} + 1
    click element    xpath:(//span[text()='Edit recording'])[${index}]/parent::button

Click on the "trash" icon of the nth recording
    [Arguments]     ${index}
    ${index} =      evaluate    ${index} + 1
    click element    xpath:(//span[text()='Delete recording'])[${index}]/parent::button

Verify no recording exists with timestamp
     [Arguments]     ${timestamp}
     ${recs} =      get element count    xpath:(//h3[text()='Recordings']/following-sibling::ul)[1]/li
     FOR    ${index}    IN RANGE     1       ${recs}
        ${ts} =     get text    xpath:((//h3[text()='Recordings']/following-sibling::ul)[1]/li[${index}]//p)[1]
        ${equal} =  should not be equal as strings    ${ts}     ${timestamp}
        IF  ${equal}    =     False
            fail
        END

Verify the nth recording in the list has name
    [Arguments]     ${index}    ${name}
    ${index} =      evaluate    ${index} + 1
    element text should be      xpath:((//h3[text()='Recordings']/following-sibling::ul)[1]/li[${index}]//p)[2]   ${name}

Get timestamp of nth recording
    [Arguments]     ${index}
    ${index} =      evaluate    ${index} + 1
    ${timestamp} =  get text    xpath:((//h3[text()='Recordings']/following-sibling::ul)[1]/li[${index}]//p)[1]
    log to console    ${timestamp}
    RETURN              ${timestamp}

