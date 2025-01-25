*** Settings ***
Library    SeleniumLibrary
Resource    ../PO/AppHeader.robot

*** Keywords ***
AppHeader.click "Log in"
    AppHeader.click "Log in"

AppHeader.click "Log out"
    AppHeader.click "Log out"

AppHeader.click "My tests"
    AppHeader.click "My tests"

AppHeader.click app logo
    AppHeader.click app logo

Verify if page has loaded
    location should be    ${BASE_URL}/
    page should contain link    Register me