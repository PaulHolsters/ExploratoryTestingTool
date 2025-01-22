*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Enter email address
    [Arguments]         ${email}=paul.holsters@hotmail.com
    input text          email       ${email}

Enter password
    [Arguments]         ${password}=password2
    input text          password    ${password}

Select "Remember me" checkbox
    select checkbox     remember

Click on "Log in" button
    click button        Log in

Form shows message
    [Arguments]    ${message}
    page should contain    ${message}