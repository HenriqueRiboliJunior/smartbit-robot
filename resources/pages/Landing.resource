*** Settings ***
Documentation        Ações e elementos da Landing Page
 
Library        Browser


*** Keywords ***
Submit signup form
    [Arguments]        ${account}

#combinar id signup com tag h2 que é filho
    Get Text    css=#signup h2    
    ...    equal    
    ...    Faça seu cadastro e venha para a Smartbit!

    Fill Text    id=name        ${account}[name]
    Fill Text    id=email       ${account}[email]
    Fill Text    id=cpf    ${account}[cpf]

    # os dois locators fazem o mesmo serviço mas o segundo é mais clean
    #Click       xpath=//button[text()="Cadastrar"]
    Click        css=button >> text=Cadastrar


Notice should be
    [Arguments]        ${target}

    ${element}    Set Variable    css=form .notice

    # aguardar até que um elemento esteja visivel ou oculto entre outros
    Wait For Elements State
    ...    ${element}
    ...    visible    5
    
    Get Text    
    ...    ${element}    
    ...    equal    ${target}