*** Settings ***
Resource    ../PO/AppHeader.robot
Resource    ../PO/LoginForm.robot

*** Keywords ***

LoginForm.Click on "Log in" button
    LoginForm.Click on "Log in" button

LoginForm.Enter email address
    [Arguments]         ${email}=paul.holsters@hotmail.com
    LoginForm.Enter email address   ${email}

LoginForm.Enter password
    [Arguments]         ${password}=password2
    LoginForm.Enter password     ${password}

LoginForm.Select "Remember me" checkbox
    LoginForm.Select "Remember me" checkbox

LoginForm.Form shows message
    [Arguments]    ${message}
    LoginForm.Form shows message    ${message}

Page is open
    location should be    ${BASE_URL}/login