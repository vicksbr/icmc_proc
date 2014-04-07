jmp main

mensagem: var #17
static mensagem + #0, #9
static mensagem + #1, #7
static mensagem + #2, #2
static mensagem + #3, #8
static mensagem + #4, #1


main:
	loadn r3,#0
	loadn r4,#0
	loadn r5,#5
	loadn r0,#mensagem
	loadn r6,#mensagem
	loadn r7,#mensagem
	call Loop2
    
    halt

;r0 = endereço para o começo da mensagem
    
Loop2:
	loadi r1,r7
	cmp r4,r5
	jeq FimLoop
	inc r7
	inc r4
	loadi r0,r7
	loadn r3,#0
	
	Loop:
		loadi r2, r0		
		cmp r3,r5
		jeq Loop2
		inc r0
		inc r3
		
		Swap:
			cmp r1,r2
			jle Loop
			mov r6, r7
			mov r7, r0
			mov r0, r6

		jmp Loop

FimLoop:
	rts
