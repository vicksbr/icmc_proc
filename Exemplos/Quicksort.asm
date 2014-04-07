;OBSERVAÇÕES: - ainda faltam implementar os seguintes procedimentos: swap e printstr(que jah tah em outro codigo fornecido pelo Paulo Sergio)
;             - nos comentarios eu coloquei bastante informacao relevante sobre o codigo.Apesar de ter seguido o modelo do codigo em C abaixo,nunca eh a msm coisa em assembly!hahaha
;             - qdo fiz essa "traducao", assumi q esse codigo esteja certo.Como falei,a maior parte das coisas jah foi implementada e,apesar de ser dificil avaliar sem o simulador,não vi nenhum erro absurdo.
; Se vc puder testá-lo,agradeceria muito!Boa diversão!hahahah
;
;void swap(int a,int b){
;  int aux=a;
;  a=b;
;  b=aux; 
;}
;             
;void quicksort(int list[],int low,int high)
;{
 ;   int key,i,j,pivot;
 ;   if( low < high)
 ;   {
 ;       pivot = choose_pivot(low,high);
 ;       swap(&list[low],&list[pivot]);
 ;       key = list[low];
 ;       i = low+1;
 ;       j = high;
 ;       while(i <= j)
 ;       {
 ;          while((i <= high) && (list[i] <= key //final dia 22/04
 ;               i++;
 ;           while((j >= low) && (list[j] > key))
 ;               j--;
 ;           if( i < j)
 ;               swap(&list[i],&list[j]);
 ;       }
 ;       /* swap two elements */
 ;       swap(&list[low],&list[j]);
 
 ;       /* recursively sort the lesser list */
 ;       quicksort(list,low,j-1);
 ;       quicksort(list,j+1,high);
 ;   }
;}
A: var #20        ;declaracao do vetor A,assumindo q ele tenha 20 posicoes

size: var #1

aux: var #1       ;pega o conteúdo de um dos registradores e mantem em memoria enquanto são usados p/ uma operação lógica/aritmética  

low: var #1       ;

high: var #1      ;

key: var #1       ;

pivot: var #1     ;

load r1,A         ;endereco primeiro elemento de A

loadn r2,#0       ;low

loadn r3,#10      ;high

entrada_invalida: string "A entrada eh invalida!"

jmp main

main:

    load r0,#20       ; usa na comparacao p/ determinar se entrada eh valida
	load r1,#size     ; carrega(ou deveria carregar) em r1 o tamanho do vetor
	call quicksort
	halt
	
quicksort:
     
    cmp r1,r0         ; compara o tamanho do vetor com 20 e vê se eh valido ou nao
    jgr tamanho_invalido
	load r0,A         ; carrega em r0 o end da primeira posicao de A
	load r1,#low      ; carrega em r1 o conteudo de low(que,por sinal,deve ser o elemento seguinte em relacao ao pivot)
	loadi r2,r0       ; determina que pivot eh A[0]
	load r3,#high     ; carrega em r1 o conteudo de high(que,por sinal,deve ser o "último" elemento do vetor ou sub vetor)
	cmp r1,r3         ; compara low com high (if(low<high))
	jeg main   
	call swap         ; chama a funcao swap
	load r4           ; r4 eh usado(ou deveria ser) como key
	load r5,low       ; r5 eh usado como i
	inc r5            ; i = low +1  
	load r6,high      ; r6 eh usado como j     
	
while_ext:
    
	   cmp r6,r5      ; compara i com j(while(i<=j))
       jge            ; retorna(ou deveria retornar) quicksort
	   cmp r5,r3      ; valida primeira condicao do primeiro while interno
	       cel i_less_than_high    ; procedimento pra validar a segunda condicao do primeiro while interno
	   cmp r1,r6      ; valida primeira condicao do segundo while interno 
           cle j_greater_than_low  ; procedimento pra validar a segunda condicao do segundo while interno
       cmp r5,r6      ; if(low<high)
           cle swap   
       jmp while_ext
  	
	call swap
	dec r6
	call quicksort
	inc r6
	inc r6
	call quicksort
	rts
	
i_less_than_high:
    
	add r7,r0,r5
	loadi r7,r7
	cmp r7,r4
	cel increment_i
	rts

increment_i:
    
    inc r5
    jmp i_less_than_high

j_greater_than_low:

    add r7,r0,r6
    loadi r7,r7
    cmp r7,r4	
	cle decrement_j
	rts
	
decrement_j:
    
    dec r6
    jmp j_greater_than_low	