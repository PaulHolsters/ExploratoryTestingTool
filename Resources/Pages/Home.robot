*** Settings ***
Library    SeleniumLibrary
Resource    ../PO/AppHeader.robot

*** Keywords ***
AppHeader.click "Log in"
    AppHeader.click "Log in"        # dit werkt perfect

AppHeader.click "Log out"
    AppHeader.click "Log out"

AppHeader.click "My tests"
    AppHeader.click "My tests"

AppHeader.click app logo
    AppHeader.click app logo