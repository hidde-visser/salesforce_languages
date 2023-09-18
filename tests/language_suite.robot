*** Settings ***
Library              QForce

Resource             ../resources/common.robot
Resource             ../resources/locators.robot

Variables            ../resources/languages.yaml

Suite Setup          Setup Browser
Suite Teardown       End suite

*** Variables ***
${leads.new_lead}
${client_id}=    3MVG9_kZcLde7U5prSAO1r6J3tzCZ3rK6bLahUf49gamQ2HX_E6836OWaD8xSBdzmCv3RNn3hTJ1OUKqaXEDu
${client_secret}=    40DB108FBD2B6A1DAA12B5FED222E2AEC6F5C8AD9CA19E17E31FBD384AF65D98

*** Test Cases ***
Create Lead
    Home

    #Set the application language
    Determine and Set Language    english

    #Enter a lead
    ${language}=     Set Variable                english
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

Delete Lead via API
    [Documentation]
    [Tags]
    Authenticate                ${client_id}                ${client_secret}    ${username}           ${password}     #sandbox=True 