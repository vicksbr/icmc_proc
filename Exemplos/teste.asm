jmp main

mensagem: var #17
static mensagem + #0, #201
static mensagem + #1, #102
static mensagem + #2, #523
static mensagem + #3, #104
static mensagem + #4, #145
static mensagem + #5, #116
static mensagem + #6, #157
static mensagem + #7, #208
static mensagem + #8, #109
static mensagem + #9, #110
static mensagem + #10, #101
static mensagem + #11, #122
static mensagem + #12, #113
static mensagem + #13, #144
static mensagem + #14, #100
static mensagem + #15, #316
static mensagem + #16, #'\0'


main:
	loadn r3,#0
	loadn r4,#10
	loadn r5,#15
	loadn r0,#mensagem
	loadn r6,#mensagem
	loadn r7,#mensagem
	call Loop2
    
    halt

    
Loop2:
	loadi r1,r0
	cmp r4,r5
	jeq FimLoop
	inc r0
	inc r4
	loadn r3,#0
	push r0
	loadn r0,#mensagem
	
	Loop:
		loadi r2, r0		
		cmp r3,r5
		jeq Loop2
		inc r0
		inc r3
		jmp Loop


FimLoop:
	rts
