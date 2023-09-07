*** Settings ***
Library           QForce

Resource          ../resources/common.robot
Resource          ../resources/locators.robot
Variables         ../resources/english.yaml
Suite Setup       Setup Browser
Suite Teardown    End suite

*** Test Cases ***
Fresh Start
    Login
    LaunchApp     ${apps.sales}
    ClickText     ${tabs.leads}
    ClickText     ${leads.new_lead}
    ClickText     ${locator_new_lead}
    UseModal      On
    PickList      ${locator_salutation}

