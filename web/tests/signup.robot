*** Settings ***

Documentation        Cenários de testes do pré cadastro de clientes



Resource        ../resources/Base.resource
 
Test Setup    Start session
Test Teardown    Take Screenshot


*** Test Cases ***

Deve iniciar cadastro do cliente
    [Tags]    smoke
    
    ${account}    Create Dictionary
    ...           name=Henrique Junior
    ...           email=henrique@gmail.com
    ...           cpf=46463404020     

    Delete Account By Email    ${account}[email]
    
    Submit signup form    ${account}
    Verify welcome message
    

# Campo nome deve ser obrigatório

#     ${account}        Create Dictionary
#     ...    name=${EMPTY}
#     ...    email=henrique@gmail.com 
#     ...    cpf=89509508047

#     Submit signup form    ${account} 
#     Notice should be    Por favor informe o seu nome completo
    

# Campo email deve ser obrigatório
 
#     ${account}        Create Dictionary
#     ...    name=Henrique Junior
#     ...    email=${EMPTY}
#     ...    cpf=89509508047

#     Submit signup form    ${account}
#     Notice should be    Por favor, informe o seu melhor e-mail  
    

# Campo cpf deve ser obrigatório
    
#     ${account}        Create Dictionary
#     ...    name=Henrique Junior
#     ...    email=henrique@gmail.com
#     ...    cpf=${EMPTY}

#     Submit signup form    ${account}
#     Notice should be    Por favor, informe o seu CPF     
    

# Email no formato inválido
#     [Tags]    inv
    
#     ${account}        Create Dictionary
#     ...    name=Henrique Junior
#     ...    email=henrique.gmail.com
#     ...    cpf=89509508047

#     Submit signup form    ${account}
#     Notice should be    Oops! O email informado é inválido
    

# CPF no formato inválido
#     [Tags]    inv
    
#     ${account}        Create Dictionary
#     ...    name=Henrique Junior
#     ...    email=henrique@gmail.com
#     ...    cpf=895095080aa

#     Submit signup form    ${account}
#     Notice should be    Oops! O CPF informado é inválido  
    
Tentativas de pré-cadastro
    [Template]    Attempt signup
    ${EMPTY}           henrique@gmail.com    89509508047    Por favor informe o seu nome completo
    Henrique Junior    ${EMPTY}              89509508047    Por favor, informe o seu melhor e-mail
    Henrique Junior    henrique@gmail.com    ${EMPTY}       Por favor, informe o seu CPF  
    Henrique Junior    henrique.gmail.com    89509508047    Oops! O email informado é inválido
    Henrique Junior    henrique@gmail.com    895095080aa    Oops! O CPF informado é inválido


*** Keywords ***

Attempt signup
    [Arguments]    ${name}    ${email}    ${cpf}    ${output_message}

    ${account}        Create Dictionary
    ...    name=${name}
    ...    email=${email}
    ...    cpf=${cpf}

    Submit signup form    ${account}
    Notice should be    ${output_message}