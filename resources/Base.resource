*** Settings ***
Documentation        Arquivo principal do projeto RObot
 
Library        Browser
Library        libs/Account.py

Resource        pages/Landing.resource
Resource        pages/Welcome.resource
Resource        pages/Login.resource        
Resource        pages/Accounts.resource

*** Keywords ***

Start session
    New Browser    browser=chromium    headless=false
    New Page    http://localhost:3000/