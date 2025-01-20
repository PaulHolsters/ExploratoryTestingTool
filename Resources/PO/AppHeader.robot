*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${App_LOGO} =         xpath://h1[contains(text(),"Exploratory testing tool")]
${"My tests"_LINK} =  My tests
${"Back"_BUTTON} =    BACK
${"Log out"_LINK} =   Log out
${"Log in"_LINK} =    Log in

*** Keywords ***
click app logo
    click element    ${App_LOGO}

click "My tests"
    click link    ${"My tests"_LINK}

click "Log in"
    click link    ${"Log in"_LINK}

click "Log out"
    click link    ${"Log out"_LINK}

click "Back" button
    ${element}=      get "back" button      ${"Back"_BUTTON}
    click element    ${element}

get "back" button
    [Arguments]     ${locator}
    ${el}=     execute javascript      let links = window.document.getElementsByTagName('a');
    ...                                let textContent = [];
    ...                                let ok = false;
    ...                                for(let i=0;i<links.length;i++){
    ...                                    if(links[i].textContent.includes('${locator}')){
    ...                                      el = links[i];
    ...                                      break;
    ...                                    }
    ...                                }
    ...                                return el;
    RETURN    ${el}

