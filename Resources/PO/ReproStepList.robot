*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
There are no bug reproduction steps present yet
    ${count} =  get element count    css:main li
    RETURN    ${count} == 0

Verify the list has ${count} number of steps
      ${count_actual} =  get element count    css:main li
      should be equal as integers    ${count_actual}    ${count}