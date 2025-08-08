*** Settings ***
Documentation        Suite de testes de adesões de planos

Resource        ../resources/Base.resource


Test Setup           Start session
Test Teardown        Take Screenshot

*** Test Cases ***
Deve poder realizar uma nova adesão


    ${data}    Get Json fixture        memberships    create   


    Delete Account By Email       ${data}[account][email]
    Insert Account                ${data}[account]
    
    
    Go to login page
    Submit login form    sac@smartbit.com    pwd123
    User is logged in    sac@smartbit.com

    Go to memberships
    Go to memberships form
    Select account        ${data}[account][name]    ${data}[account][cpf]
    Select plan           ${data}[plan]
    Fill payment          ${data}[credit_card]

    Click    css=button[type=submit] >> text=Cadastrar
    
    Toast should be    Matrícula cadastrada com sucesso.

*** Keywords ***    
Go to memberships

    Click    css=a[href="/memberships"]

    Wait For Elements State    css=h1 >> text=Matrículas    
    ...    visible    5  
  

Go to memberships form
    
    Click    css=a[href="/memberships/new"]

    Wait For Elements State    css=h1 >> text=Nova matrícula    
    ...    visible    5


Select account
    [Arguments]        ${name}    ${cpf}

    Fill Text    css=input[aria-label="select_account"]    ${name}
    Click        css=[data-testid="${cpf}"]

Select plan
    [Arguments]        ${plan_name}

    Fill Text    css=input[aria-label=select_plan]      ${plan_name}
    Click        css=div[class$=option] >> text=${plan_name}


Fill payment    
    [Arguments]    ${card}

    Fill Text    css=input[name=card_number]            ${card}[number]
    Fill Text    css=input[name=card_holder]            ${card}[holder]
    Fill Text    css=input[name=card_month]             ${card}[month]
    Fill Text    css=input[name=card_year]              ${card}[year]
    Fill Text    css=input[name=card_cvv]               ${card}[cvv]