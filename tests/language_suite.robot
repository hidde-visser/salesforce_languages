*** Settings ***
Library           QForce

Resource          ../resources/common.robot
Resource          ../resources/locators.robot
Variables         ../resources/{language}.yaml
Suite Setup       Setup Browser
Suite Teardown    End suite

*** Variables ***
${leads.new_lead}

*** Test Cases ***
Fresh Start
    Login
    LaunchApp     ${apps.sales}
    ClickText     ${tabs.leads}
    ClickText     ${leads.new_lead}
    UseModal      On
    
    PickList      ${locator_salutation}

