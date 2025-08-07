*** Settings ***
Documentation        Cenários de testes login SAC

Resource        ../resources/Base.resource

Test Setup       Start session
Test Teardown    Take Screenshot


*** Test Cases ***
Deve logar como gestor de academia

    Go to login page
    Submit login form    sac@smartbit.com    pwd123
    User is logged in    sac@smartbit.com




    