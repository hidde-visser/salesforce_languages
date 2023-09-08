*** Settings ***
Library                         QForce
Library                         QWeb
Library                         String
Library                         DateTime
Variables                       ../resources/languages.yaml


*** Variables ***
${BROWSER}                      chrome

${username}                     hvisser@copado.com.crt
${login_url}                    ${url}
${home_url}                     ${login_url}/lightning/page/home
${applauncher}                  //*[contains(@class, "appLauncher")]


*** Keywords ***
Setup Browser
    Set Library Search Order    QWeb
    Evaluate                    random.seed()
    Open Browser                about:blank                 ${BROWSER}
    SetConfig                   LineBreak                   ${EMPTY}                    #\ue000
    SetConfig                   DefaultTimeout              20s                         #sometimes salesforce is slow
    SetConfig                   CaseInsensitive             True

End suite
    Close All Browsers

Login
    [Documentation]             Login to Salesforce instance
    GoTo                        ${login_url}
    TypeText                    Username                    ${username}
    TypeText                    Password                    ${password}
    ClickText                   Log In
    ${isMFA}=                   IsText                      Verify Your Identity        #Determines MFA is prompted
    Log To Console              ${isMFA}
    IF                          ${isMFA}                    #Conditional Statement for if MFA verification is required to proceed
        ${mfa_code}=            GetOTP                      ${username}                 ${MY_SECRET}                ${password}
        TypeSecret              Code                        ${mfa_code}
        ClickText               Verify
    END

Home
    [Documentation]             Navigate to homepage, login if needed
    GoTo                        ${home_url}
    ${login_status}=            IsText                      To access this page, you have to log in to Salesforce.                              5
    Run Keyword If              ${login_status}             Login
    ${language}=                Determine language
    VerifyText                  ${${language}.app.home}

InsertRandomValue
    [Documentation]             This keyword accepts a character count, suffix, and prefix.
    ...                         It then types a random string into the given field.
    ...                         This is an example of generating dynamic data within a test
    ...                         and how to create a keyword with optional/default arguments.
    [Arguments]                 ${field}                    ${charCount}=5              ${prefix}=                  ${suffix}=
    Set Library Search Order    QWeb
    ${testRandom}=              Generate Random String      ${charCount}
    TypeText                    ${field}                    ${prefix}${testRandom}${suffix}

DeleteData
    [Documentation]             RunBlock to remove all data until it doesn't exist anymore
    ClickText                   ${accountName}
    ClickText                   Delete
    VerifyText                  Are you sure you want to delete this account?
    ClickText                   Delete                      2
    VerifyText                  Undo
    VerifyNoText                Undo
    ClickText                   Accounts                    partial_match=False

Cleanup                   
    Login
    Sleep                       3
    LaunchApp                   Sales
    ClickText                   Accounts
    RunBlock                    VerifyNoAccounts            timeout=180s                exp_handler=DeleteData
    Sleep                       3

MFA Login
    ${isMFA}=                   IsText                      Verify Your Identity        #Determines MFA is prompted
    Log To Console              ${isMFA}
    IF                          ${isMFA}                    #Conditional Statement for if MFA verification is required to proceed
        ${mfa_code}=            GetOTP                      ${username}                 ${MY_SECRET}                ${password}
        TypeSecret              Code                        ${mfa_code}
        ClickText               Verify
    END

ExampleKey
    ClickText                   New
    UseModal                    On
    ClickText                   Account Name
    TypeText                    Account Name                App
    PickList                    Account Currency            USD - U.S. Dollar
    ClickText                   Save                        anchor=SaveEdit
    UseModal                    Off

Login_with_another_user
    [Documentation]             Login to Salesforce instance
    [Arguments]                 ${username}                 ${password}
    End suite
    Setup Browser
    GoTo                        ${login_url}
    TypeText                    Username                    ${username}
    TypeText                    Password                    ${password}
    ClickText                   Log In
    ${isMFA}=                   IsText                      Login Approval Required     #Determines MFA is prompted
    Log To Console              ${isMFA}
    IF                          ${isMFA}                    #Conditional Statement for if MFA verification is required to proceed
        ${mfa_code}=            GetOTP                      ${username}                 ${secret_hidde}             ${password}
        TypeSecret              Code                        ${mfa_code}
        ClickText               Verify
    END

Commonfunction
    ClickText                   Opportunities
    ClickText                   New
    UseModal                    On
    ClickText                   Complete this field.
    TypeText                    Close Date                  12/1/2022

    ClickText                   Complete this field.
    TypeText                    *Opportunity Name           Hidde BV
    ClickText                   Save                        partial_match=False
    PickList                    *Stage                      Prospecting
    ClickText                   Save                        partial_match=False
    UseModal                    Off

    ClickText                   View profile
    VerifyText                  TEST ROBOT
    ClickText                   Log Out

Login As
    [Documentation]             Login As different persona. User needs to be logged into Salesforce with Admin rights
    ...                         before calling this keyword to change persona.
    ...                         Example:
    ...                         LoginAs                     Chatter Expert
    [Arguments]                 ${persona}
    ClickText                   Setup
    ClickText                   Setup for current app
    SwitchWindow                NEW
    TypeText                    Search Setup                ${persona}                  delay=2
    ClickText                   User                        anchor=${persona}           delay=5                     # wait for list to populate, then click
    VerifyText                  Freeze                      timeout=45                  # this is slow, needs longer timeout
    ClickText                   Login                       anchor=Freeze               delay=1

Determine and Set Language
    [Documentation]             This keyword is used to determine the current language
    ...                         And if required it will set the correct language for the test script
    ...                         ${set_language} is the to be set language
    [Arguments]                 ${set_language}

    ${set_language}             Set Variable                nederlands
    ${nl_current_language}=     IsText                      Profiel weergeven
    ${en_current_language}=     IsText                      View profile
    ${fr_current_language}=     IsText                      Profiel weergeven

    IF                          '${nl_current_language}' == 'True'
        ${current_language}     Set Variable                nederlands
    ELSE IF                     '${en_current_language}' == 'True'
        ${current_language}     Set Variable                english
    ELSE IF                     '${fr_current_language}' == 'True'
        ${current_language}     Set Variable                french
    END

    IF                          '${current_language}' != '${set_language}'
        ClickText               ${${current_language}.app.profile}
        ClickText               ${${current_language}.profile.settings}                 partial_match=false
        ClickText               ${${current_language}.profile.language_and_time_zone}
        ${set_language}         Evaluate                    "${set_language}".capitalize()
        DropDown                ${${current_language}.profile.language}                 ${set_language}
        ClickText               ${${current_language}.buttons.save}
    END

Determine language
    ${nl_current_language}=     IsText                      Profiel weergeven
    ${en_current_language}=     IsText                      View profile
    # ${fr_current_language}=     IsText                      Profiel weergeven

    IF                          '${nl_current_language}' == 'True'
        ${current_language}     Set Variable                nederlands
    ELSE IF                     '${en_current_language}' == 'True'
        ${current_language}     Set Variable                english
    ELSE IF                     '${fr_current_language}' == 'True'
        ${current_language}     Set Variable                french
    END
    
    [Return]                 ${current_language}