*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Click "Create bugreport" button
    click button    xpath://button[contains(text(),'Create bugreport')]

Click "Create recording" button
    click button    xpath://button[contains(text(),'Create recording')]