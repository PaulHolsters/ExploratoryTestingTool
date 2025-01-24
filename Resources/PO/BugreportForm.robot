*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
${BUGREPORT_TITLE_TEXTFIELD} =    title
${BUGREPORT_ENVIRONMENT_TEXTFIELD} =    environment
${BUGREPORT_USERS_TEXTFIELD} =    users

*** Keywords ***
Verify if bug report has title
    [Arguments]     ${value}
    ${title} =    get value       ${BUGREPORT_TITLE_TEXTFIELD}
    should be equal as strings    ${title}    ${value}

Enter title in "Title" textfield erasing previous content
    [Arguments]    ${title}
    input text     ${BUGREPORT_TITLE_TEXTFIELD}     ${title}

Get bugreport title
    ${title} =      get text    ${BUGREPORT_TITLE_TEXTFIELD}
    RETURN  ${title}

Enter environment in "Environment" textfield
    [Arguments]    ${environment}
    input text     ${BUGREPORT_ENVIRONMENT_TEXTFIELD}      ${environment}

Enter users in "Users" textfield
    [Arguments]    ${users}
    input text     ${BUGREPORT_USERS_TEXTFIELD}   ${users}

Click the "Edit" button
    click button    xpath://button[contains(text(),'Edit')]

Click the "Delete" button
    click button    xpath://button[contains(text(),'Delete')]