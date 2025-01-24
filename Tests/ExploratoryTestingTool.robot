*** Settings ***
Library     SeleniumLibrary
Resource    ../Resources/Pages/Bugreport.robot
Resource    ../Resources/Pages/Charter.robot
Resource    ../Resources/Pages/CharterDetail.robot
Resource    ../Resources/Pages/Home.robot
Resource    ../Resources/Pages/Login.robot
Resource    ../Resources/Pages/Session.robot

Resource    ../Resources/ExploratoryTestingTool.app.robot

Test Setup          Login     ${BROWSER}
Test Teardown       close browser

# robot -d .\Results\ -t "Create a test charter" tests/ExploratoryTestingTool.robot
*** Variables ***
${BROWSER} =    edge
# https://www.exploratory-testing-tool.com/
# http://127.0.0.1:8000/
*** Keywords ***
Login
    [Arguments]    ${BROWSER}
    open browser      ${BASE_URL}    ${BROWSER}
    Home.AppHeader.click "Log in"
    Login.LoginForm.Enter email address
    LoginForm.Enter password
    LoginForm.Select "Remember me" checkbox
    LoginForm.Click on "Log in" button

*** Test Cases ***
# logging in feature
Login with valid credentials succeeds
    [Tags]    auth
    Charter.Verify if page has loaded

Login with invalid email address fails while showing a fail message
    [Setup]
    [Tags]    auth
    open browser   ${BASE_URL}    ${BROWSER}
    Home.AppHeader.click "Log in"
    Login.LoginForm.Enter email address     ph.29@hotmail.com
    Login.LoginForm.Enter password
    Login.LoginForm.Click on "Log in" button
    Login.Page is open
    Login.LoginForm.Form shows message      The provided credentials are incorrect.

Login with invalid password fails while showing a fail message
    [Setup]
    [Tags]    auth
    open browser   ${BASE_URL}    ${BROWSER}
    Home.AppHeader.click "Log in"
    Login.LoginForm.Enter email address
    Login.LoginForm.Enter password          Some incorrect password;
    Login.LoginForm.Click on "Log in" button
    Login.Page is open
    Login.LoginForm.Form shows message      The provided credentials are incorrect.

Login with invalid email address and invalid password fails while showing a fail message
    [Setup]
    [Tags]    auth
    open browser   ${BASE_URL}    ${BROWSER}
    Home.AppHeader.click "Log in"
    Login.LoginForm.Enter email address     ph.29@hotmail.com
    Login.LoginForm.Enter password          Some incorrect password;
    Login.LoginForm.Click on "Log in" button
    Login.Page is open
    Login.LoginForm.Form shows message      The provided credentials are incorrect.

Selecting the "Remember me" checkbox when logging in makes sure your pages never expire
    [Tags]    auth
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
    Charter.CharterList.Select "nth" charter from the charter list          1
    CharterDetail.CharterForm.Change charter text                           Changed Charter
    CharterDetail.CharterForm.Click on the "Edit" button
    reload page
    CharterDetail.CharterForm.Verify charter text is equal to               Changed Charter

Edit the notes of a test charter
    [Tags]      charter
    Charter.CharterList.Select "nth" charter from the charter list          4
    CharterDetail.CharterForm.Change charter notes text                     Changed Note Charter Text
    CharterDetail.CharterForm.Click on the "Edit" button
    reload page
    CharterDetail.CharterForm.Verify charter note text is equal to          Changed Note Charter Text

Open a bugreport when there is only one bugreport
    [Tags]      charter detail
    Charter.CharterList.Select "nth" charter from the charter list          0
    CharterDetail.BugreportList.Open "nth" bugreport                        0
    # Bugreport.BugreportForm.Verify if bug report has a title

Create a test session
    [Tags]      session
    Charter.CharterList.Select "nth" charter from the charter list          0
    CharterDetail.CharterForm.Click on the "New session" button
    Session.SessionForm.Verify if session has a title

Add findings to a test session when a recording with a few notes and a bugreport is already made
    [Tags]      session
    Charter.CharterList.Select "nth" charter from the charter list          0
    CharterDetail.SessionList.Select "nth" session from the session list    0
    Session.SessionForm.Add findings to the "Findings" textarea             My fresh findings
    Session.SessionForm.Click "edit" button
    reload page
    Session.SessionForm.Verify if "Findings" textarea contains text         My fresh findings

Change the findings of a test session when a recording with a few notes and a bugreport is already made
    [Tags]      session
    Charter.CharterList.Select "nth" charter from the charter list          0
    CharterDetail.SessionList.Select "nth" session from the session list    0
    Session.SessionForm.Change "Findings" textarea to                       My fresh findings
    Session.SessionForm.Click "edit" button
    reload page
    Session.SessionForm.Verify if "findings" textarea has text              My fresh findings

Edit the session title
    [Tags]      session
    Charter.CharterList.Select "nth" charter from the charter list          0
    CharterDetail.SessionList.Select "nth" session from the session list    0
    Session.SessionForm.Replace text in "Title" textfield with              My new title doo
    Session.SessionForm.Click "edit" button
    reload page
    Session.SessionForm.Verify if "Title" textfield has text                My new title doo

Edit the name of a recording
    [Tags]      session
    Open a session that has an existing recording in its "Recordings" list
    Session.RecordingList.Click on the "pencil" icon of the nth recording   0
    Session.RecordingForm.Change name of recording into                     my_new_name.webm
    Session.RecordingForm.Click on the "Edit" button
    Session.RecordingList.Verify the nth recording in the list has name    0    my_new_name.webm

Delete a recording
    [Tags]      session
    Open a session that has an existing recording in its "Recordings" list
    ${timestamp} =   Session.Recordinglist.Get timestamp of nth recording           0
    Session.RecordingList.Click on the "trash" icon of the nth recording            0
    Session.RecordingList.Verify no recording exists with timestamp                 ${timestamp}

Delete a few notes of a test session within a bunch of notes making sure one of the deleted notes is a note taken during recording and one is not
    [Tags]      session
# todo het probleem is altijd: zulk een sessie zou moeten klaarstaan vóór aanvang van de test => DB implementatie!
    Open a session that has at least two notes,where one of the notes was taken during a recording and the other one was not
    Session.NoteList.Delete all notes
    Session.NoteList.Verify list is empty

Create two bugreports
    [Tags]      bugreport
    Open a session
    Session.SessionButtons.Click "Create bugreport" button
    Session.NewBugreportForm.Enter title in "Title" textfield    Title bugreport 3
    Session.NewBugreportForm.Enter environment in "Environment" textfield    Environment bugreport 3
    Session.NewBugreportForm.Enter users in "Users" textfield    Users bugreport 3
    Session.NewBugreportForm.Click the "Create" button
    Session.SessionButtons.Click "Create bugreport" button
    Session.NewBugreportForm.Enter title in "Title" textfield    Title bugreport 4
    Session.NewBugreportForm.Enter environment in "Environment" textfield    Environment bugreport 4
    Session.NewBugreportForm.Enter users in "Users" textfield    Users bugreport 4
    Session.NewBugreportForm.Click the "Create" button
    Session.BugreportList.Verify the list contains a bugreport with title    Title bugreport 3
    Session.BugreportList.Verify the list contains a bugreport with title    Title bugreport 4

Change the title of a bugreport
    [Tags]      bugreport
    Open a bugreport
    Bugreport.BugreportForm.Enter title in "Title" textfield erasing previous content      My new fresh tit
    Bugreport.BugreportForm.Click the "Edit" button
    reload page
    Bugreport.BugreportForm.Verify if bug report has title    My new fresh tit

Open a bugreport
    [Tags]      actions
    Open a bugreport
    sleep    300s

Delete a bugreport
    [Tags]      bugreport
    Open a bugreport
    ${title} =      Bugreport.BugreportForm.Get bugreport title
    Bugreport.BugreportForm.Click the "Delete" button
    CharterDetail.BugreportList.Verify the list does not contain a bugreport with title    ${title}

Add a few steps to an existing bugreport when no steps are present
    [Tags]      bugreport
    Open a bugreport that has no bug reproduction steps in it
    FOR    ${INDEX}    IN RANGE   1   24
        Bugreport.Click the "Add step" button
        Bugreport.NewReproStepForm.Enter step text    My fresh new steppy ${INDEX}
        Bugreport.NewReproStepForm.Click on the "Create" button
    END
    Bugreport.ReproStepList.Verify the list has 21 number of steps

Change the order of steps
    [Tags]      bugreport
    Open a bugreport that has at least 10 reproduction steps in it
    @{BEFORE} =     Bugreport.ReproStepList.Get all steps
    Bugreport.ReproStepList.Click the down arrow of step        1
    Bugreport.ReproStepList.Verify step 2 equals                ${BEFORE}[0]
    Bugreport.ReproStepList.Click the up arrow arrow of step    9
    Bugreport.ReproStepList.Verify step 8 equals                ${BEFORE}[8]
    Bugreport.ReproStepList.Click the up arrow arrow of step    8
    Bugreport.ReproStepList.Verify step 7 equals                ${BEFORE}[8]
    Bugreport.ReproStepList.Click the up arrow arrow of step    7
    Bugreport.ReproStepList.Verify step 6 equals                ${BEFORE}[8]
    Bugreport.ReproStepList.Click the down arrow of step        2
    Bugreport.ReproStepList.Verify step 3 equals                ${BEFORE}[0]
    Bugreport.ReproStepList.Click the down arrow of step        3
    Bugreport.ReproStepList.Verify step 4 equals                ${BEFORE}[0]
    Bugreport.ReproStepList.Verify step 1 equals                ${BEFORE}[1]
    Bugreport.ReproStepList.Verify step 2 equals                ${BEFORE}[2]
    Bugreport.ReproStepList.Verify step 3 equals                ${BEFORE}[3]
    Bugreport.ReproStepList.Verify step 5 equals                ${BEFORE}[4]
    Bugreport.ReproStepList.Verify step 7 equals                ${BEFORE}[5]
    Bugreport.ReproStepList.Verify step 8 equals                ${BEFORE}[6]
    Bugreport.ReproStepList.Verify step 9 equals                ${BEFORE}[7]
    Bugreport.ReproStepList.Verify step 10 equals               ${BEFORE}[9]
    ${COUNT} =  get count   ${BEFORE}
    IF  ${COUNT} > 10
        @{SLICE} =  get slice from list   10
        ${COUNT} =  get count    ${SLICE}
        FOR    ${INDEX}     IN RANGE    ${COUNT}
            ${STEPNUMBER} =    evaluate    ${INDEX} + 1
            Bugreport.Verify step ${STEPNUMBER} equals                ${BEFORE}[${INDEX}]
        END
    END

Delete the first and last step and a step in between multiple steps
    [Tags]      bugreport
# todo

# back button feature
Going back from the sessions page to the charters page
    [Tags]      navigation
# todo

Going back from the bugreports page to the sessions page
    [Tags]      navigation
# todo

Going back from the bugreports page to the charters page
    [Tags]      navigation
# todo

Logging out from the sessions page
    [Tags]      auth
# todo

# logo button feature
Open the charters page via the "My tests" link from within the home page
    [Tags]      navigation
# todo

Download a recording and open it
    [Tags]      session

View a recording    # go to the correct tab check for the video element to have the src attribute filled in and play the video (with javascript?)
    [Tags]      session











