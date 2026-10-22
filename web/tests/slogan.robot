*** Settings ***

Documentation        Teste para verificar o slogan da smartbit

Library        Browser

*** Test Cases ***

Deve exibir o Slogan na landing page
    [Tags]    slogan
    New Browser    browser=chromium    headless=True
    New Page    http://localhost:3000
    Get Text    css=.headline h2    equal    Sua Jornada Fitness Começa aqui!    
    Sleep    5