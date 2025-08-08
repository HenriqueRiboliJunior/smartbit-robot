*** Settings ***
Documentation        Cenários de testes de pré cadastro

Resource        ../resources/Base.resource

Test Setup           Start session    
Test Teardown        Take Screenshot

*** Test Cases ***
Deve iniciar o cadastro do cliente

    # Metodo para gerar massa de dados fake
    #${account}    Get Fake Account

    ${account}    Create Dictionary    
    ...        name=Henrique Junior
    ...        email=henrique@msn.com
    ...        cpf=28381238072
    
    Delete Account By Email    ${account}[email]

    Submit signup form    ${account}
    Verify welcome message

Tentativa de pré-cadastro
    [Template]        Attempt signup
    ${EMPTY}           teste@gmail.com       09165407075    Por favor informe o seu nome completo
    Henrique testes    ${EMPTY}              09165407075    Por favor, informe o seu melhor e-mail
    Henrique testes    henrique@gmail.com    ${EMPTY}       Por favor, informe o seu CPF
    Henrique testes    henrique*gmail.com    09165407075    Oops! O email informado é inválido
    Henrique testes    henrique@gmail.com    0916540707a    Oops! O CPF informado é inválido


*** Keywords ***
Attempt signup
    [Arguments]    ${name}    ${email}    ${cpf}    ${output_message}

    ${account}        Create Dictionary    
    ...    name=${name}
    ...    email=${email}
    ...    cpf=${cpf}
 
    Submit signup form      ${account}
    Notice should be        ${output_message}