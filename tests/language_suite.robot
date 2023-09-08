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
    LaunchApp     ${${language}.app.sales}
    ClickText     ${${language}.tabs.leads}
    ClickText     ${${language}.leads.new_leads}
    UseModal      On
    PickList      ${${language}.new_lead.salutation}    Mr.

