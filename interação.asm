interacao:
    mov si, frase1
    call string

    call fazer_leitura  ;bl vai receber a linha
    mov bl, al

    mov si, frase2
    call string  ;bh vai receber a coluna

    call fazer_leitura
    mov bh, al

    add bl, 48  ;conversao do caracter em numero
    add bh, 48

    mov al, 9
    mul bl  ;multiplica por 9 e transforma em unico valor
    add bl, bh

    mov [var], bl
    mov dx,[var] ;dx armazena a posicao em inteiro da posicao do jogador

ret

string:
    lodsb
    cmp al, 10
    je .exit

    mov ah, 0xe
    int 10h

    jmp string
    .exit:
ret