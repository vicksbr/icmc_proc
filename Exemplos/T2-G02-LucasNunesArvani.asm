;TURMA 02
;GRUPO 02
;Lucas N. Arvani
;Gabriel T. Giancristofaro
;Fabio A. M. Pereira

jmp main

ordenado : var #20
desordenado : var #20
tamanho : var #1
posTela : var #1
numero : var #1
retorno : var #1

main:
	
	static tamanho + #0, #20	;tamanho do vetor
	
	static desordenado + #0,#38	;valores dos vetores
	static desordenado + #1,#52
	static desordenado + #2,#48
	static desordenado + #3,#49
	static desordenado + #4,#51
	static desordenado + #5,#52
	static desordenado + #6,#12
	static desordenado + #7,#29
	static desordenado + #8,#101
	static desordenado + #9,#11
	static desordenado + #10,#9
	static desordenado + #11,#14
	static desordenado + #12,#48
	static desordenado + #13,#49
	static desordenado + #14,#72
	static desordenado + #15,#72
	static desordenado + #16,#101
	static desordenado + #17,#110
	static desordenado + #18,#6
	static desordenado + #19,#122

	call Quicksort			;Chama a funcao Quicksort
	
	load r0, retorno		;carrega label 'retorno'
	loadn r1, #0			;comparador retorno

	cmp r0, r1			;compara se retorno é 0 ou 1
	jeq MsgRetorno			;caso retorno seja 0, imprime o erro			
	call PrintTelaFull		;imprime vetores no video caso reotnro seja 1
	jmp FimMain			

MsgRetorno:
	call PrintRetorno		;imprime erro de tamanho caso o retorno seja 0

FimMain:
	halt


;--------------------------------------------------------------Subrotinas---------------------------------------------------------------------

Quicksort:
	push r0			;inicio vetor
	push r1			;tamanho do vetor
	push r2			;comparador para tamanho
	push r3			;valor a ser inserido na label 'retorno'

	loadn r3, #1		;carrega r3 com valor '1'
	load r1, tamanho	;carrega tamanho inicial do vetor em r1
	dec r1			;decrementa em 1, pois o vetor começa do zer

	loadn r2, #19		;comparador para vereficar o tamanho do vetor
	cmp r1, r2		;compara se tamanho é maior que 20
	jgr RetornoZero		;vai para a label para retornar zero

	loadn r0, #0		;primeira posicao do vetor
	call CopiaVetor		;copia vetor desordenado para ordenado
	call QuicksortInicio	;chama o quicksort para ordenar vetor 'ordenado'
	store retorno, r3	;retorno recebe '1'
	jmp FimQuickSort	;vai para fim de quicksort

RetornoZero:
	dec r3			;valor de r3 vira 0
	store retorno, r3	;retorno recebe '0'

FimQuickSort:
	pop r3
	pop r2
	pop r1
	pop r0

	rts

QuicksortInicio:
	
	push r0			;inicio vetor
	push r1			;fim do vetor
	push r2			;aux para for
	push r3			;inicio vetor
	push r4			;pivo
	push r5
	push r6
	push r7

	loadn r7,#0				; r7 <- 0
	mov r2,r0				; i <- Posição inicial do vetor (r2 <- r0)

	loadn r5,#ordenado 			; Regitrador r5 recebe o endereço da primeira posição do vetor ordenado

	QuicksortLoopEncontraInicio:  		;for(r2=inicio;r2>0;r2--)

		cmp r2,r7				; Compara r2 com r7
		jeq QuicksortLoopEncontraInicioFim	; Se r2 == r7 ele sai do laco

		dec r2					; Decrementa r2
		inc r5					; Incrementa a posição do vetor ordenado (V[r5+1])	

		jmp QuicksortLoopEncontraInicio		; Volta para o início do loop

	QuicksortLoopEncontraInicioFim:			

	mov r2,r0					; i <- inicioVetor
	mov r3,r1					; j <- fimVetor
	
	loadn r6,#ordenado				; Carrega em r6 a posição inicial do vetor ordenado
	
	QuicksortLoopEncontraFim:  			;for(r3=fim;r3>0;r3--)

		cmp r3,r7				; Compara r3 com r7
		jeq QuicksortLoopEncontraFimFim		; Se r3 == r7, ele sai do loop

		dec r3					; Decrementa r3
		inc r6					; Incrementa a posição do vetor ordenado (V[r6+1])	

		jmp QuicksortLoopEncontraFim		; Volta para o início do loop


	QuicksortLoopEncontraFimFim:

	mov r3,r1			; r3 <- r1		
	loadi r4,r5			; pivo <- mem[r5]
	

	QuicksortLoop:

		cmp r2,r3		;enquanto (i < j)
		jeg QuicksortLoopFim	;caso i >= j desviamos

		QuicksortLoopI:

			loadi r7,r5			; r7 <- mem[posiçãofinal do vetor]
			cmp r7,r4			; enquanto(X[i] < pivo)
			jeg QuicksortLoopJ

			inc r2				;incrementa r2
			inc r5				;incrementa r5
	
			jmp QuicksortLoopI		

		QuicksortLoopJ:
			
			loadi r7,r6			;r7 <- mem[r6]
			cmp r7,r4			;enquanto(X[j] > pivo)
			jel QuicksortLoopJFim

			dec r3				;decrementa r3
			dec r6				;decrementa r4

			jmp QuicksortLoopJ

		QuicksortLoopJFim:

		cmp r2,r3				;if (i<=j)
		jgr QuicksortLoop

		loadi r7,r5			
		push r7

		loadi r7,r6
		storei r5,r7

		pop r7
		storei r6,r7

		inc r2
		inc r5
		dec r3
		dec r6

		jmp QuicksortLoop

	QuicksortLoopFim:

	cmp r3,r0	;if (j > iniVetor)
	jel QuicksortFimSe1

	push r0
	push r1
	mov r1,r3	; r1 = j

	call QuicksortInicio

	pop r1
	pop r0

	QuicksortFimSe1:
	cmp r2,r1	;if (i < fimVetor)
	jeg QuicksortFimSe2

	push r0
	push r1
	mov r0,r2	;r0 = i

	call QuicksortInicio		

	pop r0
	pop r1

	QuicksortFimSe2:

	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0

	rts

;---------------------------------------------------------------------------------------------------------------------------------------------

PrintTelaFull:

	push r0		;Numero a ser impresso
	push r1		;Posicao no video
	push r2		;Apontador para vetor
	push r3		;Tamanho do vetor
	push r4		;contador i para o loop
	push r5		;virgula

	
	call ImpressaoVetNaoOrd		;Imprime a expressao "Vetor nao ordenado"

	load r3, tamanho	;r3 = tamanho (recebe o tamanho do vetor)
	loadn r5, #44		;codigo ascii da 'virgula'


	loadn r2, #desordenado		;apontador para vetor desordenado r2 <- POS MEM
	loadn r1, #40			;posicao inicial video
	loadn r4, #1			;var i para ser usada no loop
	store posTela, r1		;guarda a posicao da tela para ser usada em 'Printnr'

	loopVetorDesordenado:		;for(i=1, i<=tamanho; i++)
		
		cmp r4, r3			;compara se 'i' com o tamanho do vetor		
		jeg saiLoopVetorDesordenado	;caso 'i' seja maior ou igual que tamanho ele sai do loop		

		loadi r0, r2			;pega numero do vetor na posicao r2
		store numero, r0		;guarda numero na variavel 'numero' que será usada em 'Printnr'
		call Printnr			;chama a funcao 'Printnr'
		load r1, posTela		;r1 recebe a nova posicao na tela (a frente do numero escrito)
		outchar r5, r1			;coloca a virgula (dps do numero)
		;inc r1				;coloca o espaço (na verdade soh deixa a posicao em branco)
		inc r1				;incrementa video para proxima posicao
		inc r2				;incrementa posicao vetor
		inc r4				;incrementa i
		store posTela, r1		;guarda a nova posicao de video
		jmp loopVetorDesordenado	;volta para o loop

saiLoopVetorDesordenado:

	;Imprime o ultimo numero, sem a virgula após ele.	
	loadi r0, r2			;pega o ultimo numero do vetor
	store numero, r0		;guarda na var 'numero' que será usada em 'Printnr'
	call Printnr			;chama funcao para imprimir a var 'numero'
	
	
	call ImpressaoOrd		;Imprime a expressao "Vetor ordenado"
	
	load r1, posTela		;Pega a posicao do ultimo caracter inserido
	loadn r2, #40			;usa r2 de auxiliar

	mod r4, r1, r2			;pega o resto da da divisao da posicao com 40 (linha)
	add r1, r1, r2			;soma em posicao mais 40 para pular uma linha
	sub r1, r1, r4			;subtrai o mod feito acima para posicionar no começo da linha

	loadn r2, #ordenado		;apontador para vetor ordenado r2 <- POS MEM
	loadn r4, #1			;var i para ser usada no loop
	store posTela, r1		;guarda a posicao da tela para ser usada em 'Printnr'

	loopVetorOrdenado:		;for(i=1, i<=tamanho; i++)
		
		cmp r4, r3			;compara se 'i' é menor que tamanho do vetor		
		jeg saiLoopVetorOrdenado	;caso 'i' seja maior ou igual que tamanho ele sai do loop		

		loadi r0, r2			;pega numero do vetor na posicao r2
		store numero, r0		;guarda numero na var 'numero'
		call Printnr			;imprime var 'numero'
		load r1, posTela		;carrega a nova posicao da Tela (depois do numero impresso)
		outchar r5, r1			;coloca a virgula
		;inc r1				;coloca o espaço (na verdade soh deixa a posicao em branco)
		inc r1				;incrementa video para proxima posicao
		inc r2				;incrementa posicao vetor
		inc r4				;incrementa i
		store posTela, r1		;grava a nova posicao da Tela na var 'posTela'
		jmp loopVetorOrdenado		;volta para o loop

saiLoopVetorOrdenado:

	;Imprime o ultimo numero, sem a virgula após ele.	
	loadi r0, r2		;pega o ultimo numero do vetor
	store numero, r0	;guarda o numero na var 'numero'
	call Printnr		;imprime a var 'numero'
	
		

FimPrintTela:

	pop r5			
	pop r4			
	pop r3			
	pop r2			
	pop r1			
	pop r0

	rts
;------------------------------------------------------------------------------------------------------------------------

Printnr:					; Imprime um numero sem sinal com todas as casas: 
						; Parametros: r0 - numero; r1 - posicao na tela
								
	push 	r0				; insere registradores na pilha 
	push 	r1
	push 	r2
	push 	r3
	push 	r4
	push    r5

	load r0, numero				;carrega em r0 o valor da var 'numero'
	load r1, posTela			;carrega em r1 o valor da var 'posTela'

	mov 	r2, sp				; copia o valor de sp para frame (r2)

	; se num eh ZERO, entao trata como um caso especial
	loadn 	r3, #0			; r3 e usado como var auxiliar.
					; Aqui auxilia comparacao se num2 == 0
	cmp 	r0, r3			; compara se num2 == zero  (num veio como ZERO)
	jne 	loop_ins_pilha		; se num > 0, imprime normalmente

	loadn 	r0, #48				; r3 e usado como var auxiliar. 
						; Aqui auxilia a soma do digito com 48.
	push 	r0				; insere na pilha o ASCII do ZERO

	jmp loop_imprime_pilha		; desvia para impressao do numero, pois num veio como ZERO

	
loop_ins_pilha:
	loadn 	r3, #0				; r3 e usado como var auxiliar.  
						; Aqui auxilia comparacao se num2 == 0
	cmp 	r0, r3				; compara se num2 == zero
	jeq 	loop_imprime_pilha		; saida do loop caso num2 == 0
	
	loadn 	r3, #10				; r3 e usado como var auxiliar.  Aqui auxilia a divisao por 10.
	mod 	r4, r0, r3			; r4 = num2 mod 10 
	div 	r0, r0, r3			; num2 = num2 / 10

	loadn 	r3, #48				; r3 e usado como var auxiliar. 
						; Aqui auxilia a soma do digito com 48.
	add 	r4, r4, r3			; incrementa o digito com 48, para se obter o codigo ascii 
						; do numero
	push 	r4				; insere na pilha o ASCII do digito menos significativo 
						; do numero
	
	jmp 	loop_ins_pilha			; retorna para o inicio do loop_ins_pilha

loop_imprime_pilha:
	mov     r5, sp				; copia sp para r5 para fazer a comparacao. 
						; Nao pode usar o sp na comparacao.
	cmp 	r5, r2				; sp == frame ?
	jeq 	sai_loop_print			; se sp == frame entao sai do loop
	pop 	r4				; retira digito mais significativo do numero que esta empilhado 
	outchar	r4, r1				; imprime o conteudo de r4 na posicao r1. Neste caso 
						; imprime o ASCII do digito mais significativo empilhado.
	inc 	r1				; incrementa posicao para imprimir
	jmp 	loop_imprime_pilha		; retorna para o inicio do loop_imprime_pilha

sai_loop_print:					; desempilha registradores empilhados para nao alterar 
	
	store posTela, r1			;grava nova posicao de tela na var 'posTela'
	pop     r5				; valores dos mesmos
	pop 	r4					
	pop 	r3
	pop 	r2
	pop 	r1
	pop 	r0	

	rts					; retorna para quem chamou Printnr
;----------------------------------------------------------------------------------------------------------------------------------------------
CopiaVetor:

	push r0			;apontador para o vetor desordenado
	push r1			;apontador para o vetor ordenado
	push r2			;tamanho do vetor
	push r3			;auxiliar 'i' para loop
	push r4			;numero a ser copiado para o outro vetor

	loadn r0, #desordenado		;r0 aponta para a primeira posicao do vetor desordenado
	loadn r1, #ordenado		;r1 aponta para a primeira posicao do vetor ordenado
	load r2, tamanho		;recebe o tamanho do vetor
	loadn r3, #0			;i = 0
	
	CopiaVetorLoop:			;

		loadi r4, r0		;r4 recebe o numero na posico 'i' do vetor ordenado
		storei r1, r4		;guarda o numero de r4 na posicao 'i' do vetor desordenado
	
		inc r0			;vai para a proxima posicao do vetor ordenado
		inc r1			;vai para a proxima posicao do vetor desordenado
		inc r3			;incrementa 'i'
	
		cmp r3, r2		;verefica se 'i' é maior que tamanho
		jle CopiaVetorLoop	;se for menor que tamanho volta para o loop
	
Fim:

	pop r4
	pop r3
	pop r2
	pop r1
	pop r0

	rts

;----------------------------------------------------------------------------------------------------------------------------------------------
ImpressaoVetNaoOrd:
	
	push r0
	push r1
	push r2
	push r3
	
	vetnaoord: string "nao-ordenado"
	
	loadn r1, #0 		; armazena a posição da tela em que o caracter vai ser impresso
	loadn r2, #0		; Armazena o valor 0 em r2 para verificar se chegou no final da string
	loadn r3, #vetnaoord 	; Carrega em r3 o endereço de memória apontada por string.	
	
	LoopImpressao:

		loadi r0, r3 		;Carrega em r0 o conteúdo da memória apontada pelo conteúdo de r3.
	
		cmp r0, r2		;Compara r0 com r2 para ver se a string chegou ao seu final
	
		jeq FimImpressao 	;Se r0==r2 && r2==0 então a string chegou ao seu fim 
					;e o programa salta para o endereço fim_programa
	
		;Caso contrário o programa continua aqui
		outchar r0, r1 		;Imprime um caracter
	
		inc r1 			;Incremente a posição de memória a ser impressa	
		inc r3 			;Incrementa o ponteiro para a string

		jmp LoopImpressao
	
FimImpressao:
	
	pop r3
	pop r2
	pop r1
	pop r0
	
rts

;----------------------------------------------------------------------------------------------------------------------------------------------

ImpressaoOrd:
	
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5

	loadn r5, #40			;auxiliar para pegar posicao
	vetord: string "ordenado"	
	
	load r1, posTela		; armazena a posição da tela em que o caracter vai ser impresso
	loadn r2, #0			; Armazena o valor 0 em r2 para verificar se chegou no final da string
	loadn r3, #vetord 		; Carrega em r3 o endereço de memória apontada por string.	
	
	mod r4, r1, r5			;pega o resto da divisao da posicao por uma linha
	
	loadn r5, #80			;carrega para pular linha
	add r1, r1, r5			;soma 80 para pular linha
	sub r1, r1, r4			;subtrai o mod calculado acima para começar no inicio da linha

	LoopImpressaoOrd:

		loadi r0, r3 		;Carrega em r0 o conteúdo da memória apontada pelo conteúdo de r3.
	
		cmp r0, r2		;Compara r0 com r2 para ver se a string chegou ao seu final
		jeq FimImpressaoOrd 	;Se r0==r2 && r2==0 então a string chegou ao seu fim
					;e o programa salta para o endereço fim_programa
	
		;Caso contrário o programa continua aqui
		outchar r0, r1 ;Imprime um caracter
	
		inc r1 ;Incremente a posição de memória a ser impressa	
		inc r3 ;Incrementa o ponteiro para a string
	
		jmp LoopImpressaoOrd
	
FimImpressaoOrd:
	
	store posTela, r1
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	
rts

;------------------------------------------------------------------------------------------------------------------------------------

PrintRetorno:
	
	push r0
	push r1
	push r2
	push r3

	msgReturn: string "ERRO: Vetor com mais de 20 posicoes."
	
	loadn r1, #0 		; armazena a posição da tela em que o caracter vai ser impresso
	loadn r2, #0		; Armazena o valor 0 em r2 para verificar se chegou no final da string
	loadn r3, #msgReturn 	; Carrega em r3 o endereço de memória apontada por string.	
	
	LoopPrintRetorno:

		loadi r0, r3 ; Carrega em r0 o conteúdo da memória apontada pelo conteúdo de r3.
	
		cmp r0, r2		;Compara r0 com r2 para ver se a string chegou ao seu final	
		jeq LoopPrintRetorno 	;Se r0==r2 && r2==0 então a string chegou ao seu fim e o 
					;programa salta para o endereço fim_programa

		;Caso contrário o programa continua aqui
		outchar r0, r1 ;Imprime um caracter
	
		inc r1 ;Incremente a posição de memória a ser impressa
		inc r3 ;Incrementa o ponteiro para a string
		
		jmp LoopPrintRetorno
	
FimImpressaoOrd:
	
	pop r3
	pop r2
	pop r1
	pop r0
	
rts
