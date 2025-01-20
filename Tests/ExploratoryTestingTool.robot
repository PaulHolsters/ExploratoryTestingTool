*** Settings ***
Library     SeleniumLibrary
Resource    ../Resources/Pages/Bugreport.robot
Resource    ../Resources/Pages/Charter.robot
Resource    ../Resources/Pages/CharterDetail.robot
Resource    ../Resources/Pages/Home.robot
Resource    ../Resources/Pages/Login.robot
Resource    ../Resources/Pages/Session.robot

Test Setup          Login     ${BROWSER}
Test Teardown       close browser

# robot -d .\Results\ -t "Create a test charter" tests/ExploratoryTestingTool.robot
*** Variables ***
${BROWSER} =    edge

*** Keywords ***
Login
    [Arguments]    ${BROWSER}
    open browser   http://127.0.0.1:8000/    ${BROWSER}
    Home.AppHeader.click "Log in"
    Login.LoginForm.Enter email address
    LoginForm.Enter password
    LoginForm.Select "Remember me" checkbox
    LoginForm.Click on "Log in" button
*** Test Cases ***
# logging in feature
Login with valid credentials succeeds
    [Tags]    login
    Charter.Verify if page has loaded

Login with invalid email address fails while showing a fail message
    [Setup]
    [Tags]    login
    open browser   http://127.0.0.1:8000/    ${BROWSER}
    Home.AppHeader.click "Log in"
    Login.LoginForm.Enter email address     ph.29@hotmail.com
    Login.LoginForm.Enter password
    Login.LoginForm.Click on "Log in" button
    Login.Page is open
    Login.LoginForm.Form shows message      The provided credentials are incorrect.

Login with invalid password fails while showing a fail message
    [Setup]
    [Tags]    login
    open browser   http://127.0.0.1:8000/    ${BROWSER}
    Home.AppHeader.click "Log in"
    Login.LoginForm.Enter email address
    Login.LoginForm.Enter password          Some incorrect password;
    Login.LoginForm.Click on "Log in" button
    Login.Page is open
    Login.LoginForm.Form shows message      The provided credentials are incorrect.

Login with invalid email address and invalid password fails while showing a fail message
    [Setup]
    [Tags]    login
    open browser   http://127.0.0.1:8000/    ${BROWSER}
    Home.AppHeader.click "Log in"
    Login.LoginForm.Enter email address     ph.29@hotmail.com
    Login.LoginForm.Enter password          Some incorrect password;
    Login.LoginForm.Click on "Log in" button
    Login.Page is open
    Login.LoginForm.Form shows message      The provided credentials are incorrect.

Selecting the "Remember me" checkbox when logging in makes sure your pages never expire
    [Tags]    login
    sleep     30s
    Charter.AppHeader.click app logo
    Home.AppHeader.click "My tests"

Create a test charter
    [Tags]      charter
    Charter.NewCharterForm.Enter charter text                               This is a new charter!
    Charter.NewCharterForm.Click on the "Create" button
    CharterDetail.AppHeader.click "Back" button
    Charter.CharterList.Verify if test charter is in the charter list       This is a new charter!

Edit a test charter
    [Tags]      charter
    Charter.CharterList.Select a charter from the charter list              This is a new charter
    CharterDetail.CharterForm.Change charter text                           Changed Charter
    CharterDetail.CharterForm.Click on the "Edit" button
    reload page
    CharterDetail.CharterForm.Verify charter text is equal to               Changed Charter

Edit the notes of a test charter
    [Tags]      charter
    Charter.CharterList.Select a charter from the charter list              This is a new charter
    CharterDetail.CharterForm.Change charter notes text                     Changed Note Charter Text
    CharterDetail.CharterForm.Click on the "Edit" button
    reload page
    CharterDetail.CharterForm.Verify charter note text is equal to          Changed Note Charter Text

Open a bugreport when there is only one bugreport
    [Tags]      charter detail
    Charter.CharterList.Select a charter from the charter list              just a charter
    CharterDetail.BugreportList.Open bugreport                              some test bug report
    Bugreport.BugreportForm.Verify if bug report has title                  some test bug report

# test session feature
Create a test session
    [Tags]      session
    Charter.CharterList.Select a charter from the charter list              just a charter
    CharterDetail.CharterForm.Click on the "New session" button
    Session.SessionForm.Verify if session has a title

Add findings to a test session when a recording with a few notes and a bugreport is already made

Change the findings of a test session when a recording with a few notes and a bugreport is already made

Edit the session title

Edit the name of a recording when only one recording is present

Download a recording and open it        # how?

View a recording    # go to the correct tab check for the video element to have the src attribute filled in and play the video (with javascript?)

Delete a recording when only one recording is present

Delete a few notes of a test session within a bunch of notes making sure one of the deleted notes is a note taken during recording and one is not

Create two bugreports
# todo dees is nog nen interessante om te doen

# bugreport feature
Change the title of a bugreport

Delete a bugreport from within the bugreport page

Add a few steps to an existing bugreport when no steps are present

Change the order of steps, including the first and last step

Delete the first and last step and a step in between multiple steps

# back button feature
Going back from the sessions page to the charters page

Going back from the bugreports page to the sessions page

Going back from the bugreports page to the charters page

# logging out feature
Logging out from the sessions page

# logo button feature
Open the charters page via the "My tests" link














