jmp main

vetorEntrada: var #16
static vetorEntrada + #0, #90
static vetorEntrada + #1, #72
static vetorEntrada + #2, #20
static vetorEntrada + #3, #25
static vetorEntrada + #4, #5
static vetorEntrada + #5, #50
;static vetorEntrada + #6, #30
;static vetorEntrada + #7, #12
;static vetorEntrada + #8, #80
;static vetorEntrada + #9, #55
;static vetorEntrada + #10, #77
;static vetorEntrada + #11, #43
;static vetorEntrada + #12, #40
;static vetorEntrada + #13, #12
;static vetorEntrada + #14, #29
;static vetorEntrada + #15, #4
;static vetorEntrada + #16, #61

tam: var #1
static tam + #0,#5

main:

loadn r0,#tam;	r0 recebe a posição da variael tamanho
loadi r1,r0;	r1 recebe o valor contido em tamanho

loadn r0,#vetorEntrada;	r0 recebe o início do vetor a ser ordenado

;call bubble

loadi r1, r0
inc r0
loadi r2, r0
inc r0
loadi r3, r0
inc r0
loadi r4, r0
inc r0
loadi r5, r0
inc r0
loadi r6, r0

halt


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




