*** Settings ***
Documentation        Suite de testes de adesões de planos

Resource        ../resources/Base.resource


Test Setup           Start session
Test Teardown        Take Screenshot

*** Test Cases ***
Deve poder realizar uma nova adesão

    #Usando massa de dados do JSON
    ${data}    Get Json fixture        memberships    create   

    #Preparando o ambiente, deletando a conta e a adesão e criando uma conta nova 
    # assim o teste fica independente
    Delete Account By Email       ${data}[account][email]
    Insert Account                ${data}[account]
    
    #Logando com administrador
    Signin admin

    #Endereçando para página de matrícula
    Go to memberships

    #Criando uma nova adesão de membro
    Create new membership    ${data}

    #Validando o sucesso
    Toast should be    Matrícula cadastrada com sucesso.

Não deve realizar adesão duplicada

    #Usando massa de dados do JSON
    ${data}    Get Json fixture        memberships    duplicate   

    Insert Membership        ${data}

    #Logando com administrador
    Signin admin

    #Endereçando para página de matrícula
    Go to memberships

    #Criando uma nova adesão de membro
    Create new membership    ${data}


    # codigo comentado abaixo se refere ao teste caso não tivessemos intervenção no banco
    # Necessário para que o toast anterior de criação saia da tela em 8segundos
    # Para não conflitar com o toast da criação subsequente
    #Sleep    8
    # Recriando a  adesão duplicada de membro
    #Create new membership    ${data}

    #Validando o sucesso
    Toast should be    O usuário já possui matrícula.


Deve buscar por nome
    [Tags]    search
    ${data}    Get Json fixture    memberships    search 
    
    Insert Membership    ${data}

    Signin admin
    Go to memberships

    Search by name            ${data}[account][name]
    Should filter by name     ${data}[account][name]
    
Deve excluir uma matrícula
    [Tags]    remove

    ${data}    Get Json fixture    memberships    remove 
    
    Insert Membership    ${data}

    Signin admin
    Go to memberships
    Request removal    ${data}[account][name]
    Confirm removal

    Membership should not be visible    ${data}[account][name]

