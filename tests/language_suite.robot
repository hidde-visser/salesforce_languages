*** Settings ***
Library              QForce

Resource             ../resources/common.robot
Resource             ../resources/locators.robot
Variables            ../resources/languages.yaml
Suite Setup          Setup Browser
Suite Teardown       End suite

*** Variables ***
${leads.new_lead}

*** Test Cases ***
Fresh Start
    Home

    #Set the application language
    Determine and Set Language    nederlands

    #Enter a lead
    ${language}=     Set Variable                nederlands
    LaunchApp        ${${language}.app.sales}
    ClickText        ${${language}.tabs.leads}
    Sleep            1s
    ClickText     ${${language}.leads.new_leads}
    # ClickItemUntil   ${${language}.modal.new_lead}    
    
    # ClickText        ${${language}.leads.new_leads}
    UseModal         On
    PickList         ${${language}.new_lead.salutation}                 Mr.
    TypeText         ${${language}.new_lead.first_name}                 Hidde
    TypeText         ${${language}.new_lead.last_name}                  Visser
    TypeText         ${${language}.new_lead.company}                    Copado
    PickList         ${${language}.new_lead.lead_status}                Working - Contacted
    ClickText        ${${language}.buttons.save}                       partial_match=false
