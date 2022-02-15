org 0x7e00
jmp 0x0000:start

pos times 90 db 58h	;o vazio vai ser o X
pontuacao resb 30h  ;inicializa o valor da pontuacao com 0
var resb 0;

frase1 db 'Digite a linha ', 10, 13
frase2 db 'Digite a coluna', 10, 13
fraseFimdeJoso db 'FIM DE JOGO', 10, 13

;config_tela; define a resolução e cor da tela
;printarMapa; mostra as posicoes dos elementos
;interação;   retorna em dx a posicao selecionada
;inserirBomba;  inseri a posicao em que o resgistrador dx armazenar
;desvendar;    vai ate a posicao em que o jogador selecionou e caso seja a bomba chama telaend
;tela_end;  define o fim do jogo
;string; imprime na tela a string armazenada 
;pontuacao; ela incrimenta a pontuacao do jogador caso ele nao acerta a bomba
;funcao_modificar;  recebe como parametro o al, e altera na matriz, e recebe dx, a posicao para alterar a matriz
;fazer_leitura; faz a interrupção e armazena em al justamente o valor digitado
;printarTela; imprimi o conteudo de al, na linha em dh, e coluna dl

start:
    xor ax, ax
    mov ds, ax
    mov es, ax

    call config_tela

        .loopinitial:
        call printarMapa
        call interacao
        call inserirBomba

        jmp .loopinitial

done:

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
        mov si, fraseFimdeJoso
        call string

        call tela_end
        jmp done

    .modificar0:
        call pontuacao

        mov al, 'A'
        call funcao_modificar

        jmp .end_desvendar_posicao

    .modificar1:
        call pontuacao
        
        mov al, 'B'
        call funcao_modificar

        jmp .end_desvendar_posicao

    .modificar2:
        call pontuacao

        mov al, 'C'
        call funcao_modificar

        jmp .end_desvendar_posicao

    .modificar3:
        call pontuacao
        
        mov al, 'D'
        call funcao_modificar

        jmp .end_desvendar_posicao

    .modificar4:
        call pontuacao

        mov al, 'E'
        call funcao_modificar

        jmp .end_desvendar_posicao

    .modificar5:
        call pontuacao
        
        mov al, 'F'
        call funcao_modificar

        jmp .end_desvendar_posicao

    .modificar6:
        call pontuacao
        
        mov al, 'G'
        call funcao_modificar

        jmp .end_desvendar_posicao

    .modificar7:
        call pontuacao
        
        mov al, 'H'
        call funcao_modificar

        jmp .end_desvendar_posicao

    .modificar8:
        call pontuacao

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

inserirBomba:
    mov si, pos
    add si, dx
    
    mov di, si
    mov al, 'B'

    stosb

ret

fazer_leitura:
    mov ah, 0       ;numero da chamada
    int 16h         ;faz a leitura do tecxado e atribui em al

ret

config_tela:
    mov ah, 0       ;modo de video
    mov bh, 12h     ;modo de vga (360x200)
    int 10h

    mov ah, 0xb     ;modo da cor da tela
    mov bh, 0       ;ID paleta de cores
    mov bl, 8h      ;Cor desejada // cinza
    int 10h

ret

printarTela:
    mov ah, 2h
                ;dh vai ser a linha impressa
                ;dl vai ser a coluna impressa
    int 10h

    mov ah, 0xe    ;chamada para printar
    mov bh, 0      ;numero da pagina eh definido por bh 
    mov bl, 7h     ;cor da fonte
    int 10h        ;imprimi o conteudo eh defenido por al

ret

printarMapa:
    xor cx, cx     ;percorrer elemento por elemento

    .inicialprintarMapa:
    cmp cx, 90
        je .endprintarMapa
        
        call printarElemento
    jmp .inicialprintarMapa
    .endprintarMapa:
ret

printarElemento:
    mov si, pos
    add si, cx

    lodsb   ;al carrega a informação da posicao especifica
    
    cmp cx, 9
        jl .coluna0 

    cmp cx, 18
        jl .coluna1

    cmp cx, 27
        jl .coluna2

    cmp cx, 36
        jl .coluna3

    cmp cx, 45
        jl .coluna4

    cmp cx, 54
        jl .coluna5

    cmp cx, 63
        jl .coluna6

    cmp cx, 72
        jl .coluna7

    cmp cx, 81
        jl .coluna8

    cmp cx, 90
        jl .coluna9

ret

.coluna0:
    mov [var], cx
    mov dh, [var]

    mov dl, 0   ;dl vai representar o coluna impressa
    call printarTela
    
    inc cx;

ret

.coluna1:
    cmp cx, 9
        jl .endcoluna1

    sub cx, 9

    mov [var], cx

    mov dh, [var]
    mov dl, 1
    
    call printarTela
    add cx, 10

    .endcoluna1:
ret

.coluna2:
    cmp cx, 18
        jl .endcoluna2

    sub cx, 18

    mov [var], cx

    mov dh, [var]
    mov dl, 2
    
    call printarTela
    add cx, 19

    .endcoluna2:
ret

.coluna3:
    cmp cx, 27
        jl .endcoluna3

    sub cx, 27

    mov [var], cx

    mov dh, [var]
    mov dl, 3
    
    call printarTela
    add cx, 28

    .endcoluna3:
ret

.coluna4:
    cmp cx, 36
        jl .endcoluna4

    sub cx, 36

    mov [var], cx

    mov dh, [var]
    mov dl, 4
    
    call printarTela
    add cx, 37

    .endcoluna4:
ret

.coluna5:
    cmp cx, 45
        jl .endcoluna5

    sub cx, 45

    mov [var], cx

    mov dh, [var]
    mov dl, 5
    
    call printarTela
    add cx, 46

    .endcoluna5:
ret

.coluna6:
    cmp cx, 54
        jl .endcoluna6

    sub cx, 54

    mov [var], cx

    mov dh, [var]
    mov dl, 6
    
    call printarTela
    add cx, 55

    .endcoluna6:
ret

.coluna7:
    cmp cx, 63
        jl .endcoluna7

    sub cx, 63

    mov [var], cx

    mov dh, [var]
    mov dl, 7
    
    call printarTela
    add cx, 64

    .endcoluna7:
ret

.coluna8:
    cmp cx, 72
        jl .endcoluna8

    sub cx, 72

    mov [var], cx

    mov dh, [var]
    mov dl, 8
    
    call printarTela
    add cx, 73

    .endcoluna8:
ret

.coluna9:
    cmp cx, 81
        jl .endcoluna9

    sub cx, 81

    mov [var], cx

    mov dh, [var]
    mov dl, 9
    
    call printarTela
    add cx, 82

    .endcoluna9:
ret


    jmp $
