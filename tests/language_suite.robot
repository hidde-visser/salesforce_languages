*** Settings ***
Library           QForce

Resource          ../resources/common.robot
Resource          ../resources/locators.robot
Variables         ../resources/english.yaml
Suite Setup       Setup Browser
Suite Teardown    End suite

*** Variables ***
${leads.new_lead}

*** Test Cases ***
Fresh Start
    Login
    ${language}=    Set Variable    english
    LaunchApp     ${english.sales}
    ClickText     ${${language}.tabs.leads}
    ClickText     ${${language}.leads.new_lead}
    UseModal      On
    PickList      ${locator_salutation}

