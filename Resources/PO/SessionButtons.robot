*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Click "Create bugreport" button
    click button    xpath://button[contains(text(),'Create bugreport')]