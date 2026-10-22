*** Settings ***
Documentation        Suite de testes de login

Resource        ../resources/Base.resource

Test Setup           Start session
Test Teardown        Finish session

*** Test Cases ***
Deve logar com cpf e IP

    ${data}    Get Json fixture    login
    Insert Membership    ${data}

    Signin with document    ${data}[account][cpf]
    User is logged in
    
    
Não deve logar com cpf não cadastrado

    Signin with document    79554813058
    Popup have text    Acesso não autorizado! Entre em contato com a central de atendimento


Não deve logar com cpf com digito inválido
    [Tags]    temp

    Signin with document    00000014144
    Popup have text    CPF inválido, tente novamente