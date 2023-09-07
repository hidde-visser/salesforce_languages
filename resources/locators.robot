*** Variables ***
${Sales_App}
${locator_leads}
${locator_new_lead}
${locator_salutation}
${locator_first_name}

*** Keywords ***
Set Language
    [Documentation]      This keyword is used to set the Language locators
    [Arguments]          ${language}
    IF                   '${language}' == 'EN'
        Set Variable     ${Sales_App}             Sales
        Set Variable     ${locator_leads}         Leads
        Set Variable     ${locator_new_lead}      New
        Set Variable     ${locator_salutation}    Salutation
        Set Variable     ${locator_first_name}    First Name
    ELSE IF              '${language}' == 'NL'
        Set Variable     ${Sales_App}             Verkoop
        Set Variable     ${locator_leads}         Leads
        Set Variable     ${locator_new_lead}      Nieuw
        Set Variable     ${locator_salutation}    Aanhef
        Set Variable     ${locator_first_name}    Voornaam
    ELSE IF              '${language}' == 'FR'
        Set Variable     ${Sales_App}             Ventes
        Set Variable     ${locator_leads}         Pistes
        Set Variable     ${locator_new_lead}      Nouveau
        Set Variable     ${locator_salutation}    Civilité
        Set Variable     ${locator_first_name}    Prénom
    END