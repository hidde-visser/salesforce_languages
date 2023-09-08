*** Settings ***
Library    QWeb
Library    DataDriver    reader_class=TestDataApi    name=multi_languages.xlsx

Resource             ../resources/common.robot
Variables            ../resources/languages.yaml

Suite Setup       Setup Browser
Suite Teardown    End suite

Test Template     Example Test

*** Test Case ***
Example Test with ${language} ${salutation} ${first_name}

*** Keywords ***
Example Test
    [Arguments]    ${language}    ${salutation}    ${first_name}    ${last_name}    ${company}    ${lead_status}
    Login

    #Set the application language
    Determine and Set Language    ${language}

    #Enter a lead
    ${language}=     Set Variable                ${language}
    LaunchApp        ${${language}.app.sales}
    ClickText        ${${language}.tabs.leads}
    ClickText        ${${language}.leads.new_leads}
    UseModal         On
    PickList         ${${language}.new_lead.salutation}                 ${salutation}
    TypeText         ${${language}.new_lead.first_name}                 ${first_name}
    TypeText         ${${language}.new_lead.last_name}                  ${last_name}
    TypeText         ${${language}.new_lead.company}                    ${company}
    PickList         ${${language}.new_lead.lead_status}                ${lead_status}
    ClickText        ${${language}.new_lead.save}                       partial_match=false

  