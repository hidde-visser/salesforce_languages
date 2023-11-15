*** Settings ***
Library                         QForce
Library                         JSONLibrary

Resource                        ../resources/common.robot
Resource                        ../resources/locators.robot

Variables                       ../resources/languages.yaml

Suite Setup                     Setup Browser
Suite Teardown                  End suite

*** Variables ***
${leads.new_lead}

*** Test Cases ***
Create Lead
    Home

    #Set the application language
    Determine and Set Language                              english

    #Enter a lead
    ${language}=                Set Variable                english
    LaunchApp                   ${${language}.app.sales}
    ClickText                   ${${language}.tabs.leads}
    Sleep                       1s
    ClickText                   ${${language}.leads.new_leads}
    # ClickItemUntil            ${${language}.modal.new_lead}

    # ClickText                 ${${language}.leads.new_leads}
    UseModal                    On
    PickList                    ${${language}.new_lead.salutation}                      Mr.
    TypeText                    ${${language}.new_lead.first_name}                      test
    TypeText                    ${${language}.new_lead.last_name}                       Visser
    TypeText                    ${${language}.new_lead.company}                         Copado
    PickList                    ${${language}.new_lead.lead_status}                     Working - Contacted
    ClickText                   ${${language}.buttons.save}                             partial_match=false

Delete Lead via API
    [Documentation]
    [Tags]
    Delete Leads by LastName    Brown
    Delete Leads by LastName    Visser