*** Settings ***
Documentation        Ações e elementos do componente de caixa de notificação

Library        Browser


*** Keywords ***
Notice should be
    [Arguments]        ${target}

    ${element}    Set Variable    css=form .notice

    # aguardar até que um elemento esteja visivel ou oculto entre outros
    Wait For Elements State    ${element}    visible    5
    Get Text    ${element}    equal    ${target}