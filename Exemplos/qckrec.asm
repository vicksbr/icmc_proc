;void Quicksort(int[] A,int low,int high){
;   int pivot;
;   if(low < high){  
;     pivot=partition(A,low,high);
;   }
;   Quicksort(A,low,pivot-1); // quicksort para metade esquerda
;   Quicksort(A,pivot+1,high); // quicksort p/ metade direita
;}
;int partition(int[] A,int low,int high){
;   pivot=A[low];
;   int leftwall = pivot;
;   for(int i = low+1 ; i < high ; i++){
;      if(A[i] < pivot){
;        leftwall += 1;
;        swap(A[i],A[leftwall]);
;      }
;   }
;   swap(A[low],A[leftwall]]);
;
;   return leftwall;
;}
;void swap(int a,int b){
;  int aux=a;
;  a=b;
;  b=aux; 
;}
A: var #20

load r1,A    ;endereco primeiro elemento de A

loadn r2,#0  ;low

loadn r3,#10 ;high

loadi r4,r1; ;pivo começa sendo A[0]

Quicksort:
    cmp r2,r3
    jle partition	
	dec r3
	call Quicksort
	inc r3
	inc r3
	call Quicksort
	;1681153922
    

partition:

  ; push r4           ; joga conteudo de r4 na pilha p/ q não seja perdido
  ;  load r4,r1       ; determina qual é o pivo ,retornando o conteudo de A[low]
  ;  push r5
   mov r5,r4          ; r5 eh leftwall
   mov r6,r2          ; r6 eh usado como i
   inc r6             ; i=low+1
                      
   call swap_for_loop ; vai para swap(A[low],A[leftwall]) 
   jmp Quicksort      ; retorna p/ Quicksort
   
for_loop:   
    
	cmp r3,r6         ; compara i com high
    jeg partition     ; se i >= high,volta p/ partition 
    load r7,A[i]      ; carrega A[i] para r6
    cmp r7,r4         ; compara A[i] com pivo
    jle for_loop      ; se(A[i]<pivo),volta p/ loop
    inc r5            ; leftwall+=1  
	call swap          
    jmp for_loop   
   
swap_for_loop:
   ;swap(A[low],A[leftwall])
   push r1
   

swap:
   ;swap(A[i],A[leftwall]);
   mov r3,r1
   mov r1,r2
   mov r2,r3
