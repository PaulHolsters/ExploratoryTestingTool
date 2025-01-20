*** Settings ***
Resource    ../PO/AppHeader.robot
Resource    ../PO/SessionForm.robot

*** Keywords ***
SessionForm.Verify if session has a title
    SessionForm.Verify if session has a title