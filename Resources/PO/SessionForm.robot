*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Keywords ***
Verify if session has a title
    ${value} =    get value    dom:document.getElementsByName('title')[1]
    should not be empty    ${value}