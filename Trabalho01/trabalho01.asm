jmp main

vetorEntrada: var #16
static vetorEntrada + #0, #20
static vetorEntrada + #1, #10
static vetorEntrada + #2, #30
static vetorEntrada + #3, #5
static vetorEntrada + #4, #70
static vetorEntrada + #5, #100
static vetorEntrada + #6, #94
static vetorEntrada + #7, #47
static vetorEntrada + #8, #2
static vetorEntrada + #9, #50
static vetorEntrada + #10, #33
static vetorEntrada + #11, #12
static vetorEntrada + #12, #41
static vetorEntrada + #13, #22
static vetorEntrada + #14, #37
static vetorEntrada + #15, #11


vetorSaida: var #16
vetorAuxiliar: var #16

tam: var #1
static tam + #0, #16   		; tamanho de vetor

main:

	loadn R0,#tam 				;r0 recebe a posição da variavel tamanho
	loadi R1,R0 				;r1 recebe o valor de r0, no caso de 16
	loadn R0,#vetorEntrada      ;r0 recebe a posição do vetor a ser ordenado


	;imprime o vetor original

	mov R2, R1
	loadn R1,#0
	call printVetor

	mov R1,R2
	loadn R2,#vetorSaida
	call copiaVetor

	;mov R0, R2
	;loadn R1, #240
	;loadn R2, #16
	;call printVetor

	;push R0
	;push R1
	;push R2

	mov R0, R2

	call merge

	mov R0, R2
	loadn R1, #80
	loadn R2, #16
	call printVetor

	;pop R2
	;pop R1
	;pop R0

halt


;----------------------------------
;	FUNCOES
;----------------------------------


;----------------------------------------------------
;	copiaVetor(R0,R1,R2) -> R2
; 	copia um vetor de um registrador para o outro

;	entradas:
;	R0 ponteiro para o vetor original
;   R1 tamanho do vetor original
;   R2 ponteiro para o vetor destino
;
;   saida
;   R2 ponteiro para o vetor destino
;----------------------------------------------------

copiaVetor:

	push R0
	push R1
	push R2
	push R3

	copiaVetor_loop:

		loadi R3,R0
		storei R2,R3
		inc R0
		inc R2
		dec R1
		jnz copiaVetor_loop

	pop R3
	pop R2
	pop R1
	pop R0

rts


;----------------------------------------------------
;	printNumero(R0,R1)
; 	printa um numero inteiro r0 comecando pel posicao r1 na tela

;	entradas:
;	R0 numero inteiro entre -65534 e 65535 (inteiro 16 bits com sinal)
;   R1 posicao da tela onde sera impresso
;
;
;   saida
;   R1 e printa o numero na tela
;----------------------------------------------------

printNumero:

	push R0
	push R2
	push R3
	push R4
	push R5

	loadn R3, #10    				; atribuindo base 10 para a multiplicação
	loadn R4, #48    				; variavel auxiliar a ser somada para se obter o numero ASCII
	loadn R5, #0     				; numero de casas decimais empilhadas

	printNumero_empilha:

		mod R2, R0, R3   				; Pega o digito mais significativo
		add R2, R2, R4   				; Soma 48 para obter o numero ASCII correto
		push R2
		inc R5
		div R0, R0, R3   				; Divide por 10 para pegar o proximo digito
		jnz printNumero_empilha 	; Continua empilhando até o resultado da divisao ser 0


	printNumero_desempilha:

		pop R2
		outchar R2, R1
		inc R1
		dec R5
		jnz printNumero_desempilha

	pop R5
	pop R4
	pop R3
	pop R2
	pop R0


rts


;----------------------------------------------------
;	printVetor(R0,R1,R2)
; 	printa um vetor R0 de tamanho R2 na posicao R1 da tela

;	entradas:
;	R0 posicao inicial do vetor
;   R1 posicao da tela onde sera impresso
;   R2 tamanho do vetor
;
;   saida
;   printa o numero na tela começando na posicao R1
;----------------------------------------------------


printVetor:

	push R0
	push R1
	push R2
	push R3

	mov R3, R0    		   ; Carrega a posicao inicial do vetor para ser usada na funcao de printNumero

	printVetor_loop:

		loadi R0, R3 	   ; Carregando o numero do vetor em R0
		call printNumero
		inc R1             ; Percorrendo o vetor e decrementando o tamanho para o fim do loop
		inc R3
		dec R2
		jnz printVetor_loop

	pop R3
	pop R2
	pop R1
	pop R0

rts

;----------------------------------------------------
;	printString(R0,R1)
; 	printa uma string apontada R0 na posicao R1 da tela
;
;	entradas:
;	R0 posicao inicial do vetor
;   R1 posicao da tela onde sera impresso
;
;   saida
;   printa o string na tela começando na posicao R1
;----------------------------------------------------

printString:

	push R0
	push R1
	push R2
	push R3

	loadn R3, #0     		    ; Carrega para ser comparado com '\0'

	printString_loop:

		loadi R2,R0  		    ; Carrega em r2 o conteudo de mem[R0]
		cmp R2,R3    		    ; Compara R2 com R3 a procura do fim da string
		jeq String_loop_fim

		;Se nao achou '/0' imprime o caracter

		outchar R2,R1          ; Imprime o caracter e incrementa a posicao
		inc R0                 ; para continumar o loop
		inc R1
		jmp printString_loop

	String_loop_fim:

	pop R3
	pop R2
	pop R1
	pop R0

rts

;----------------------------------------------------
;	bubble(R0,R1) -> R0
; 	printa um vetor R0 de tamanho R2 na posicao R1 da tela

;	entradas:
;	R0 posicao inicial do vetor a ser ordenado
;   R1 tamanho do vetor
;
;   saida
;   R0 é o novo vetor organizado
;----------------------------------------------------

bubble:

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


;----------------------------------------------------
;	merge(R0,R1) -> R0
; 	ordena um vetor em ordem crescente usando
;	mergesort recursivo
;
;	entradas:
;	R0 ponteiro para o vetor a ser organizado
;   R1 tamanho do vetor
;
;   saida
;   R0 é o novo vetor ordenado
;----------------------------------------------------


merge:

	push R0
	push R1
	push R2
	push R3
	push R4
	push R5
	push R6
	push R7


	loadn R2,#4 	; Carregando para R2 o valor minimo do vetor para iniciar o bubble sort
	cmp R1,R2
	cel bubble
	jel mergeFim

	;Caso o tamanho do vetor ainda seja maior que 4, continua o merge

	mov R3,R1          ; Carrega em R3 o tamanho do vetor contido em R1
	shiftr0 R1, #1     ; Dividindo R1 por 2 e pegando a parte mais significativa


	call merge 		   ; Chama o merge para a primeira metade

	push R0
	push R1

	add R0, R0, R1    ; R0 = R0 + R1 é a posicao da matade ae o fim do vetor
	sub R1, R3, R1    ; é o novo tamanho do vetor

	call merge        ; Chama o merge para a segunda metade

	mov R2, R0        ; R2 recebe a posicao para o começo do vetor
	mov R3, R1        ; R1 recebe o tamanho

	pop R1
	pop R0

	call mergeSort

	mergeFim:

	pop R7
	pop R6
	pop R5
	pop R4
	pop R3
	pop R2
	pop R1
	pop R0

rts

;----------------------------------------------------
;	mergeSort(R0,R1) -> R0
; 	Recebe 2 vetores e os ordena devolvendo um vetor só ordenado
;
;
;	entradas:
;	R0 ponteiro para o primeiro vetor a ser organizado
;   R1 tamanho do primeiro vetor
;   R2 ponteiro para o segundo vetor a ser organizado
;	R3 tamanho do segundo vetor
;
;	R4 ponteiro para um vetor auxiliar
;	R5 armazena o vetor1[i]
;   R6 armazena o vetor2[j]
;
;
;   saida
;   R0 é o novo vetor ordenado
;----------------------------------------------------

mergeSort:

	push R0
	push R1
	push R2
	push R3
	push R4
	push R5
	push R6
	push R7


	add R1, R1, R0     ; R1 = R1 + R0 armazena a última posição do primeiro vetor
	add R3, R3, R2     ; R3 = R3 + R2 armazena a última posição do segundo vetor

	loadn R4,#vetorAuxiliar

	loadi R5,R0       ; R5 = vetor1[R0]
	loadi R6,R2       ; R6 = vetor2[R2]

	mergeSort_loop:

		cmp R5,R6
		jle mergeSort_cmp_menor
		jmp mergeSort_cmp_maior

		mergeSort_cmp_menor:

			storei R4, R5
			inc R0
			inc R4
			cmp R0, R1
			jeq mergeSort_preenche_vetor1
			loadi R5, R0
			jmp mergeSort_loop

		mergeSort_cmp_maior:

			storei R4,R6
			inc R2
			inc R4
			cmp R2, R3
			jeq mergeSort_preenche_vetor2
			loadi R6, R2
			jmp mergeSort_loop


		mergeSort_preenche_vetor1:

			loadi R6, R2
			storei R4, R6
			inc R4
			inc R2
			cmp R2, R3
			jeq mergeSort_fim
			jmp mergeSort_preenche_vetor1

		mergeSort_preenche_vetor2:

			loadi  R5, R0
			storei R4, R5
			inc R4
			inc R0
			cmp R0, R1
			jeq mergeSort_fim
			jmp mergeSort_preenche_vetor2



	mergeSort_fim:

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
		push r2

		mov R2, R0
		add R1, R1, R3

		loadn R0, #vetorAuxiliar
		call copiaVetor

		pop R2
		pop R1
		pop R0

rts






