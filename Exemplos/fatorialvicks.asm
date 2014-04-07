; Fatorial não recursivo

jmp main

mensagem : string "O fatorial de "
mensagem2 : string "eh"

main: 
	loadn r0, #6   
	loadn r7, #6
	call Fatorial  
	mov r0, r1     
	
	push r0
	push r1
	push r2
	push r3
	loadn r0, #2
	loadn r2, #512
	loadn r1, #mensagem
	call Imprimestr		
	pop r3
	pop r2
	pop r1
	pop r0
	
	push r0
	mov r0, r7 
	loadn r1, #16
	call Printnr	
	pop r0

	push r0
	push r1
	push r2
	push r3
	loadn r0, #18
	loadn r2, #1024
	loadn r1, #mensagem2
	call Imprimestr		
	pop r3
	pop r2
	pop r1
	pop r0

	loadn r1, #21
	call Printnr
	halt 		   

Fatorial: 		   
	push r0
	push r2

	loadn r1, #1
	loadn r1, #1

FatorialLoop:
	mul r1, r1, r0 
	dec r0
	cmp r0, r2	   
	
	jgr FatorialLoop 

	pop r2
	pop r0

	rts		      

Printnr:	
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6

	loadn r3, #9
	loadn r2, #48
	cmp r0, r3
	jgr PrintnrDezena 
	add r0, r0, r2	
	outchar r0, r1	
	jmp PrintnrRts	

PrintnrDezena:
	loadn r3, #99
	cmp r0, r3
	jgr PrintnrCentena
	loadn r6, #10
	div r4, r0, r6
	loadn r2, #48
	add r5, r4, r2
	outchar r5, r1
	mul r4, r4, r6
	sub r0, r0, r4
	add r0, r0, r2
	inc r1
	outchar r0, r1
	jmp PrintnrRts	

PrintnrCentena:
	loadn r3, #999
	cmp r0, r3
	jgr PrintnrMilhar
	loadn r6, #100
	div r4, r0, r6
	loadn r2, #48
	add r5, r4, r2
	outchar r5, r1
	mul r4, r4, r6
	sub r4, r0, r4
	loadn r6, #10
	div r0, r4, r6
	loadn r2, #48
	add r5, r0, r2
	inc r1
	outchar r5, r1
	mul r0, r0, r6
	sub r0, r4, r0
	add r0, r0, r2
	inc r1
	outchar r0, r1
	jmp PrintnrRts	;

PrintnrMilhar:		;
	loadn r0, #'?'
	outchar r0, r1
	inc r1
	outchar r0, r1
	inc r1
	outchar r0, r1
	inc r1
	outchar r0, r1
	
	
PrintnrRts:	;
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts	; 
	
;-----Func ImprimeStr-----------------------------------------------------------
; r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso
; r1 = endereco onde comeca a mensagem
; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
;---------------------------------------------------------------------------------

Imprimestr:
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	
	loadn r3, #'\0'	; Criterio de parada

ImprimestrLoop:	
	loadi r4, r1
	cmp r4, r3
	jeq ImprimestrSai
	add r4, r2, r4
	outchar r4, r0
	inc r0
	inc r1
	jmp ImprimestrLoop
	
ImprimestrSai:	
	pop r4	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r3
	pop r2
	pop r1
	pop r0
	rts

;-----Fim da ImprimeStr------------------------------------------------------