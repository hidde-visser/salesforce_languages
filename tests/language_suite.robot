*** Settings ***
Library              QForce

Resource             ../resources/common.robot
Resource             ../resources/locators.robot
Variables            ../resources/english.yaml
Suite Setup          Setup Browser
Suite Teardown       End suite

*** Variables ***
${leads.new_lead}

*** Test Cases ***
Fresh Start
    Login
    ${language}=     Set Variable                english
    LaunchApp        ${${language}.app.sales}
    ClickText        ${${language}.tabs.leads}
    ClickText        ${${language}.leads.new_leads}
    UseModal         On
    PickList         ${${language}.new_lead.salutation}                 Mr.
    TypeText         ${${language}.new_lead.first_name}                 Hidde
    TypeText         ${${language}.new_lead.last_name}                  Visser
    TypeText         ${${language}.new_lead.company}                    Copado
    PickList         ${${language}.new_lead.lead_status}                Working - Contacted
    ClickText        ${${language}.new_lead.save}                       partial_match=false
