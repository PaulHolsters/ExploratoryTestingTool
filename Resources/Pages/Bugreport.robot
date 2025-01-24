*** Settings ***
Resource    ../PO/AppHeader.robot
Resource    ../PO/BugreportForm.robot
Resource    ../PO/ReproStepList.robot
Resource    ../PO/NewReproStepForm.robot

*** Keywords ***
BugreportForm.Verify if bug report has title
    [Arguments]     ${value}
    BugreportForm.Verify if bug report has title    ${value}

BugreportForm.Enter users in "Users" textfield
    [Arguments]     ${value}
    BugreportForm.Enter users in "Users" textfield  ${value}

BugreportForm.Enter environment in "Environment" textfield
    [Arguments]     ${value}
    BugreportForm.Enter environment in "Environment" textfield  ${value}

BugreportForm.Enter title in "Title" textfield erasing previous content
    [Arguments]     ${value}
    BugreportForm.Enter title in "Title" textfield erasing previous content  ${value}

BugreportForm.Click the "Edit" button
    BugreportForm.Click the "Edit" button

BugreportForm.Click the "Delete" button
    BugreportForm.Click the "Delete" button

BugreportForm.Get bugreport title
    ${title} =  BugreportForm.Get bugreport title
    RETURN    ${title}

AppHeader.click "Back" button
    AppHeader.click "Back" button

ReproStepList.There are no bug reproduction steps present yet
    ${count} =    ReproStepList.There are no bug reproduction steps present yet
    RETURN      ${count} == 0

Click the "Add step" button
    click button    xpath://button[contains(text(),'Add step')]

NewReproStepForm.Enter step text
    [Arguments]     ${value}
    NewReproStepForm.Enter step text    ${value}

NewReproStepForm.Click on the "Create" button
    NewReproStepForm.Click on the "Create" button

ReproStepList.Verify the list has ${count} number of steps
    ReproStepList.Verify the list has ${count} number of steps