jmp main

vetorEntrada: var #16

static vetorEntrada + #0, #72
static vetorEntrada + #1, #52
static vetorEntrada + #2, #100
static vetorEntrada + #3, #30
static vetorEntrada + #4, #60
static vetorEntrada + #5, #10
static vetorEntrada + #6, #15
static vetorEntrada + #7, #99


tam: var #1
static tam + #0,#8



main:

loadn r0,#tam    ; r0 recebe a posicao de tamanho
loadi r1,r0       ; r1 recebe o valor contido em tamanho 

loadn r0,#vetorEntrada   ; r0 recebe a posicao inicial do vetor entrada 
loadn r2,#0               ; r2 controlara o meio, iniciando com 0


call merge 

halt					

merge:

; r1 tamanho do vetor
; r2 controla o meio(mid)

loadn r6,#0    ; compara
loadn r7,#2    ; carrega r7 com valor pra dividir
cmp r1, r6
div r2, r1,r7  ; mid = tamanhoVetor / 2
jeq fim_merge

mov r1, r2 

push r0
push r1
push r2
push r3
push r4

call merge ;pro lado esquerdo
;loadn r4, #9999
;loadn r4, #9999
;loadn r4, #9999
;call merge ;pro lado direito
	
pop r0
pop r1
pop r2
pop r3
pop r4

fim_merge:

rts





