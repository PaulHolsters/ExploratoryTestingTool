*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${NOTES_LIST_XPATH} =   //h3[text()='Notes']/following-sibling::ul[1]

*** Keywords ***
There is at least one note that was taken outside of a recording
    ${note_count} =     get element count    xpath:${NOTES_LIST_XPATH}/li
    FOR    ${INDEX}     IN RANGE    ${note_count}
        ${listitem_index} =     evaluate    ${INDEX} + 1
        ${count} =  get element count    xpath:${NOTES_LIST_XPATH}/li[${listitem_index}]//button[contains(text(),'View')]
        ${has_view_button} =    evaluate    ${count}>0
        IF   ${has_view_button} == ${false}
             RETURN   ${true}
        END
    END
    RETURN    ${false}

There is at least one note that was taken while recording
    ${note_count} =     get element count    xpath:${NOTES_LIST_XPATH}/li
    FOR    ${INDEX}     IN RANGE    ${note_count}
        ${listitem_index} =     evaluate    ${INDEX} + 1
        ${count} =  get element count    xpath:${NOTES_LIST_XPATH}/li[${listitem_index}]//button[contains(text(),'View')]
        ${has_view_button} =    evaluate    ${count}>0
        IF   ${has_view_button}
            RETURN  ${true}
        END
    END
    RETURN    ${false}