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
        Set Suite Variable     ${Sales_App}             Sales
        Set Suite Variable     ${locator_leads}         Leads
        Set Suite Variable     ${locator_new_lead}      New
        Set Suite Variable     ${locator_salutation}    Salutation
        Set Suite Variable     ${locator_first_name}    First Name
    ELSE IF              '${language}' == 'NL'
        Set Suite Variable     ${Sales_App}             Verkoop
        Set Suite Variable     ${locator_leads}         Leads
        Set Suite Variable     ${locator_new_lead}      Nieuw
        Set Suite Variable     ${locator_salutation}    Aanhef
        Set Suite Variable     ${locator_first_name}    Voornaam
    ELSE IF              '${language}' == 'FR'
        Set Suite Variable     ${Sales_App}             Ventes
        Set Suite Variable     ${locator_leads}         Pistes
        Set Suite Variable     ${locator_new_lead}      Nouveau
        Set Suite Variable     ${locator_salutation}    Civilité
        Set Suite Variable     ${locator_first_name}    Prénom
    END