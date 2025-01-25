*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    ../../Libraries/Common.py

*** Keywords ***
There are no bug reproduction steps present yet
    ${count} =  get element count    css:main li
    RETURN    ${count} == 0

Get number of bug reproduction steps
    ${count} =  get element count    css:main li
    RETURN    ${count}

Verify the list has ${count} number of steps
      ${count_actual} =  get element count    css:main li
      should be equal as integers    ${count_actual}    ${count}

Click the down arrow of step
    [Arguments]    ${stepnumber}
    click button    xpath://main//li[${stepnumber}]//span[contains(text(),'Down one step')]/parent::button

Click the up arrow arrow of step
    [Arguments]    ${stepnumber}
    click button    xpath://main//li[${stepnumber}]//span[contains(text(),'Up one step')]/parent::button

Verify step ${stepnumber} equals
    [Arguments]    ${text}
    ${text_found} =   get text    xpath:(//main//li[${stepnumber}]//p)[2]
    should be equal as strings    ${text}   ${text_found}

Get all steps
    @{elements} =   get webelements    xpath://main//li//p
    @{step_descriptions} =      filter on odd indices    ${elements}
    ${step_descriptions} =      get text nodes    ${step_descriptions}
    RETURN    ${step_descriptions}

Delete step
    [Arguments]    ${stepnumber}
    click button    xpath://main//li[${stepnumber}]//span[contains(text(),'Delete test step')]/parent::button