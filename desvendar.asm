desvendar_posicao:   ;vai receber como parametro o registrador dx, que indica a posicao escolhida pelo jogador
    mov si, pos
    add si, dx

    lodsb   ;vai carregar o conteudo que esta na posicao em al

    cmp al, 'B'
        je .encerrar

    cmp al, 0
        je .modificar0

    cmp al, 1
        je .modificar1

    cmp al, 2
        je .modificar2

    cmp al, 3
        je .modificar3

    cmp al, 4
        je .modificar4

    cmp al, 5
        je .modificar5

    cmp al, 6
        je .modificar6

    cmp al, 7
        je .modificar7

    cmp al, 8
        je .modificar8

    .encerrar:
        call tela_end

        jmp done

    .modificar0:
        ;call pontuacao

        mov al, 'A'
        call funcao_modificar

        jmp .end_desvendar_posicao

    .modificar1:
        ;call pontuacao
        
        mov al, 'B'
        call funcao_modificar

        jmp .end_desvendar_posicao

    .modificar2:
        ;call pontuacao

        mov al, 'C'
        call funcao_modificar

        jmp .end_desvendar_posicao

    .modificar3:
        ;call pontuacao
        
        mov al, 'D'
        call funcao_modificar

        jmp .end_desvendar_posicao

    .modificar4:
        ;call pontuacao

        mov al, 'E'
        call funcao_modificar

        jmp .end_desvendar_posicao

    .modificar5:
        ;call pontuacao
        
        mov al, 'F'
        call funcao_modificar

        jmp .end_desvendar_posicao

    .modificar6:
        ;call pontuacao
        
        mov al, 'G'
        call funcao_modificar

        jmp .end_desvendar_posicao

    .modificar7:
        ;call pontuacao
        
        mov al, 'H'
        call funcao_modificar

        jmp .end_desvendar_posicao

    .modificar8:
        ;call pontuacao

        mov al, 'I'
        call funcao_modificar

        jmp .end_desvendar_posicao

    .end_desvendar_posicao:
ret

funcao_modificar:   ;recebe como parametro o valor do resgistrador al modificado
                    ;atualiza o si para posicao do vetor e de la modifica a posicao

        mov si, pos
        add si, dx

        mov di, si

        stosb

pontuacao:  ;funcao que incrimenta o valor da pontuacao
            ;nao recebe parametros, apenas incrimenta a pontuacao

    mov si, pontuacao
    lodsb

    mov si, pontuacao
    mov di, si

    inc al
    stosb

ret

tela_end:
    mov si, fraseFimdeJoso
    call string

ret