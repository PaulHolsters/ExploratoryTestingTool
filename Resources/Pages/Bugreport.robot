*** Settings ***
Resource    ../PO/AppHeader.robot
Resource    ../PO/BugreportForm.robot

*** Keywords ***
BugreportForm.Verify if bug report has title
    [Arguments]     ${value}
    BugreportForm.Verify if bug report has title    ${value}