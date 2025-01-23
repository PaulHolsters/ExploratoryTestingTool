*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
${BUGREPORT_TITLE_TEXTFIELD} =    css:form#create-bugreport input#title
${BUGREPORT_ENVIRONMENT_TEXTFIELD} =    css:form#create-bugreport input#environment
${BUGREPORT_USERS_TEXTFIELD} =    css:form#create-bugreport input#users

*** Keywords ***
Verify if bug report has title
    [Arguments]     ${value}
    ${title} =    get value       title
    should be equal as strings    ${title}    ${value}

Enter title in "Title" textfield
    [Arguments]    ${title}
    input text     ${BUGREPORT_TITLE_TEXTFIELD}     ${title}

Enter environment in "Environment" textfield
    [Arguments]    ${environment}
    input text     ${BUGREPORT_ENVIRONMENT_TEXTFIELD}      ${environment}

Enter users in "Users" textfield
    [Arguments]    ${users}
    input text     ${BUGREPORT_USERS_TEXTFIELD}   ${users}

Click the "Create" button
    click button    xpath://div[@id='modal']//button[contains(text(),'Create')]