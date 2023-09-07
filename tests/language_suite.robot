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
    ClickText     ${locator_leads}
    ClickText     ${locator_new_lead}
    UseModal      On
    PickList      ${locator_salutation}

