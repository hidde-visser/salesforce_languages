*** Settings ***
Library                QForce

Resource               ../resources/common.robot
Resource               ../resources/locators.robot
Suite Setup            Setup Browser
Suite Teardown         End suite

*** Test Cases ***
Fresh Start
    
    Login
    