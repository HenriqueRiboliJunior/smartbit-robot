*** Settings ***
Documentation        Teste para verificar o slogan da smartbit da web

Library        Browser


*** Test Cases ***
Deve exibir o slogan da landing Page
    New Browser    browser=chromium    headless=false
    New Page    http://localhost:3000/
    #combinar class headline com tag h2 que é filho
    Get Text    css=.headline h2    equal    Sua Jornada Fitness Começa aqui!
    Sleep    5