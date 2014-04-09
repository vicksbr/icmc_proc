jmp main

vetorEntrada: var #16
static vetorEntrada + #0, #90
static vetorEntrada + #1, #72
static vetorEntrada + #2, #20
static vetorEntrada + #3, #25
static vetorEntrada + #4, #15
static vetorEntrada + #5, #50
static vetorEntrada + #6, #30
static vetorEntrada + #7, #19
static vetorEntrada + #8, #80
static vetorEntrada + #9, #55
static vetorEntrada + #10, #77
static vetorEntrada + #11, #43
static vetorEntrada + #12, #40
static vetorEntrada + #13, #12
static vetorEntrada + #14, #29
static vetorEntrada + #15, #14
static vetorEntrada + #16, #61

vetorSaida: var #16
vetorAuxiliar: var #16

tam: var #1
static tam + #0,#16

main:

loadn r0,#tam;	r0 recebe a posição da variael tamanho
loadi r1,r0;	r1 recebe o valor contido em tamanho
loadn r0,#vetorEntrada;	r0 recebe o início do vetor a ser ordenado

;imprime o vetor original
mov R2, R1
loadn R1, #0
call print_vector


;copia do vetorEntrada para o vetorSaida
mov R1, R2  ;R1 recebe o tamanho do vetor
loadn R2, #vetorSaida   ;R2 recebe o ponteiro para o segundo vetor
call copy_vector
push R0
push R1
push R2
mov R0, R2
call merge
mov R2, R1
loadn R1, #80
call print_vector
pop R2
pop R1
pop R0

halt



merge_concatena:
;entradas
;R0 -   inicio do primeiro vetor
;R1 -   tamanho do primeiro vetor
;R2 -   inicio do segundo vetor
;R3 -   tamanho do segundo vetor

;R4 -   ponteiro para o vetorAuxiliar
;R5 -   armazena o vetor1[i]
;R6 -   armazena o vetor2[j]

;debug
;loadn R6, #'x'
;loadn R7, #160
;outchar R6, R7

push R0
push R1
push R2
push R3
push R4
push R5
push R6
push R7

add R1, R1, R0  ;R1 armazena o a última posição do primeiro vetor
add R3, R3, R2  ;R3 armazena o a última posição do segundo vetor
loadn R4, #vetorAuxiliar    ;Carrega o ponteiro do vetor auxiliar

loadi R5, R0    ;R5 = vetor1[R0]
loadi R6, R2    ;R6 = vetor[R2]
merge_concatena_loop_principal:
    cmp R5, R6
    jle merge_concatena_R5_menor
    jmp merge_concatena_R6_menor

    merge_concatena_R5_menor:
        storei R4, R5
        inc R0
        inc R4
        cmp R0, R1
        jeq merge_concatena_termina_vetor1
        loadi R5, R0
        jmp merge_concatena_loop_principal

    merge_concatena_R6_menor:
        storei R4, R6
        inc R2
        inc R4
        cmp R2, R3
        jeq merge_concatena_termina_vetor2
        loadi R6, R2
        jmp merge_concatena_loop_principal

merge_concatena_termina_vetor1:
    loadi R6, R2
    storei R4, R6
    inc R4
    inc R2
    cmp R2, R3
    jeq merge_concatena_fim
    jmp merge_concatena_termina_vetor1

merge_concatena_termina_vetor2:
    loadi R5, R0
    storei R4, R5
    inc R4
    inc R0
    cmp R0, R1
    jeq merge_concatena_fim
    jmp merge_concatena_termina_vetor2

merge_concatena_fim:

pop R7
pop R6
pop R5
pop R4
pop R3
pop R2
pop R1
pop R0

push R0
push R1
push R2
mov R2, R0
add R1, R1, R3

loadn R0, #vetorAuxiliar    ;Carrega o ponteiro do vetor auxiliar
call copy_vector
pop R2
pop R1
pop R0

;copy_vector:
;entradas
;R0 -   ponteiro para o vetor original
;R1 -   tamanho do vetor
;R2 -   ponteiro para o vetor destino

rts



;R0 -   inicio do primeiro vetor
;R1 -   tamanho do primeiro vetor
;R2 -   inicio do segundo vetor
;R3 -   tamanho do segundo vetor






merge:
;entradas
;r0 - ponteiro pro vetor
;r1 - tamanho do vetor

push R0
push R1
push R2
push R3
push R4
push R5
push R6
push R7


loadn R2, #4
cmp R1, R2
cel bubble
jel merge_fim



;Se o vetor ainda for maior do que 4, aplica o merge novamente
mov R3, R1  ;Move o tamanho para R3
shiftr0 R1, #1  ;Divide o tamanho armazenado em R1 por 2 (arredondando para menos)
call merge

push R0
push R1

add R0, R0, R1
sub R1, R3, R1  ;R1 = R3 - R1, ou seja, R3 passará a ter o valor da segunda parte do vetor
call merge

mov R2, R0
mov R3, R1
pop R1
pop R0

call merge_concatena

merge_fim:

pop R7
pop R6
pop R5
pop R4
pop R3
pop R2
pop R1
pop R0

rts





bubble:
;parametros de entrada:
;r0 - ponteiro para o inicio do vetor a ser ordenado
;r1 - tamanho do vetor a ser ordenado

	push r0  ; vetor entrada
	push r1  ; tamanho
	push r2  ; indice i
	push r3  ; indice j
	push r4  ; vetor entrada [j-1]
	push r5  ; vetor entrada [j]

	mov r2,r0      ;r2 recebe a posição do inicio do vetor (ponteiro para o vetor)
	add r1,r0,r1   ;r1 passa a armazenar a posição na memória do fim do vetor (posição do último elemento)

    dec R1

	bubble_loop_1:	;primeiro for (for(i=0;i<n;i++))

		mov r3,r0;	r3 recebe a posição do inicio do vetor (ponteiro para o vetor)

		bubble_loop_2:	;segundo for (for(j=0;j<n-1;j++))

			loadi r4,r3;	r4 <- vet[j]
			inc r3
			loadi r5,r3;	r5 <- vet[j+1]

			cmp r4,r5				;   comparando vet[j] com vet[j+1]
			jel bubble_dont_swap	;   se i < j, não trocar
			dec r3					;	decrementando para arrumar o indice e trocar
			storei r3,r5			;	armazena vet[j+1] no lugar de vet[j]
			inc r3					;	j incrementa para (j+1)
			storei r3,r4			;	armazena vet[j] no lugar de vet[j+1]

			bubble_dont_swap:		;	continua sem trocar
			cmp r1, r3				;	enquanto o "j" menor que o fim do vetor, continua no loop
			jne	bubble_loop_2

		inc r2
		cmp r1, r2
		jne bubble_loop_1			;	enquanto o "i" menor que o fim do vetor, continua no loop

	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0

rts

;------------------------------------------------------------------------------

copy_vector:
;entradas
;R0 -   ponteiro para o vetor original
;R1 -   tamanho do vetor
;R2 -   ponteiro para o vetor destino
;saídas
;R2 -   ponteiro para o vetor destino

    push R0
    push R1
    push R2
    push R3

    copy_vector_loop:
        loadi R3, R0    ;Carrega o elemento do vetor de origem para o R3 (buffer)
        storei R2, R3   ;Salva o elemento armazenado em R3 (buffer) no vetor destino
        inc R0
        inc R2
        dec R1
        jnz copy_vector_loop
    pop R3
    pop R2
    pop R1
    pop R0
    rts

;------------------------------------------------------------------------------

print_vector:
;entradas
;R0 -   posição inicial do vetor
;R1 -   posição na tela onde será impresso o vetor
;R2 -   tamanho do vetor
;saídas
;R1 -   posição na tela após impimir o vetor
    push R0
    push R1
    push R2
    push R3

    mov R3, R0      ;A função utilizada para imprimir o inteiro utiliza o registrador R0 como entrada do número, portanto o valor do inicio
                    ;do vetor é passado para R3

    print_vector_loop:
        loadi R0, R3    ;Carrega em R0 o valor armazenado na posição R3 da memória
        call print_int  ;Chama a rotina de imprimir um número inteiro
        inc R1          ;Pula um espaço entre os números impressos
        inc R3          ;Move uma posição na memória para obter o próximo número
        dec R2          ;Decrementa o tamanho do vetor até que todos os números sejam impressos
        jnz print_vector_loop

    pop R3
    pop R2
    pop R1
    pop R0

    rts

;------------------------------------------------------------------------------

print_int:  ;Imprime um inteiro entre -65354 e 65355
;argumentos de entrada:
;R0 -   número a ser impresso
;R1 -   posição inicial do vídeo onde o número será impresso
;argumentos de saída
;R1 -   posição final de saída no vídeo logo após a impressão do inteiro

    ;R0 -   Valor total do inteiro a ser impresso
    ;R2 -   caractere do número a ser impresso
    ;R3 -   Recebe o valor 10 para trabalhar com os dígitos do número
    ;R4 -   Recebe o valor 48 a ser somado para um dígito assumir o valor de seu caractere
    ;R5 -   Guarda o número de dígitos que foram armazenados na pilha

    ;armazena os valores dos registradores a serem utilizados
    push R0
    push R2
    push R3
    push R4
    push R5

    ;Atribuições de números chave para o processo
    loadn R3, #10       ;R3 recebe 10 pois o número recebido estará na base 10
    loadn R4, #48       ;R4 recebe 48 pois serão impressos números, e o código ASCII de um número (de 0 a 9) é o seu valor + 48
    loadn R5, #0        ;R5 indicará o número de dígitos empilhados. Será utilizada a pilha do processador

    print_int_empilha_digito:
        mod R2, R0, R3      ;R2 recebe o último dígito do número (por meio da operação de resto pela divisão por 10)
        add R2, R2, R4      ;Soma-se R2 (48) ao R2 (dígito menos significativo de R0) para que ele passe a ter o seu valor na tabela ASCII
        push R2             ;Empilha o valor ASCII do dígito menos significativo de R0
        inc R5              ;Incrementa R5, pois o dígito foi armazenado na pilha
        div R0, R0, R3      ;Reduz o número dividindo ele por
        jnz print_int_empilha_digito  ;Continua empilhando os dígitos até o número ser reduzido à zero

    print_int_desempilha_digito:
        pop R2;                 ;Desempilha o dígito a ser impresso
        outchar R2, R1          ;Imprime o dígito desempilhado
        inc R1                  ;Incrementa a posição do vídeo onde será impresso o próximo dígito
        dec R5                  ;Decrementa o contador do topo da pilha
        jnz print_int_desempilha_digito   ;Se ainda tem dígitos empilhados na pilha, continua desempilhando

    ;retorna os valores anteriores dos registradores utilizados
    pop R5
    pop R4
    pop R3
    pop R2
    pop R0

    rts

;------------------------------------------------------------------------------

print_str:  ;Imprime uma string dada
;argumentos de entrada:
;R0 -   posição inicial da string
;R1 -   posição inicial do vídeo onde a string será impressa
;argumentos de saída
;R1 -   posição final de saída no vídeo logo após a string (posição no vídeo do '\0' da string)

    ;R0 -   é a posição inicial da string passado como parâmetro
    ;R1 -   é a posição inicial da tela onde a string será impressa
    ;R2 -   é o caractere na string a ser impresso
    ;R3 -   é o valor de '\0' no código ASCII utilizado para o fim do loop

    ;armazena os valores dos registradores a serem utilizados
    push R0
    push R2
    push R3

    loadn R3, #0    ;Atribui o valore de '\0' em R3
    print_str_loop:
        loadi R2, R0        ;R2 recebe o caractere na posição [R0] da string
        cmp R2, R3          ;Checa se chegou ao fim do vetor ('\0')
        jeq fim_de_string   ;Se chegou ao fim da string, então sai do loop
        ;Se não chegou ao fim da string, continua neste loop
        outchar R2, R1      ;imprime o caractere desejado na tela
        inc R0              ;incrementa a posição da string que terá o caractere impresso
        inc R1              ;incrementa a posição na tela onde será impresso o próximo caractere
        jmp print_str_loop            ;continua no loop

    fim_de_string:  ;ao chegar no fim da string, o loop é quebrado

    ;retorna os valores anteriores dos registradores utilizados
    pop R3
    pop R2
    pop R0

    rts
