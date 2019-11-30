section .data
msg0 db 	'Digite seu nome: ', 0dh,0ah
tammsg0 	EQU $-msg0
msg1 db 	'Hola, '
tammsg1		EQU $-msg1
msg2 db 	'Bem-vindo ao programa de CALC IA-32',0dh,0ah
tammsg2		EQU $-msg2
msg3 db 	'Escolha uma opcao: 1-soma, 2-subtracao, 3-multiplicacao, 4-divisao, 5-mod, 6-sair',0dh,0ah
tammsg3		EQU $-msg3
msg4 db		'Digite primeiro operando: ',0dh,0ah
tammsg4		EQU $-msg4
msg5 db		'Digite segundo operando: ',0dh,0ah
tammsg5		EQU $-msg5


section .bss
nome resb 20
opcao resb 1
operando1 resb 12
operando2 resb 12
resposta resb 11



section .text
global _start
_start:
	mov ecx msg0 ; mensagem digite seu nome
	mov edx tammsg0
	push ecx
	push edx
	call ESCREVESTRING
	
	mov ecx nome
	;passar endereço nome push dw nome
	call LESTRING
	;mov eax,3 ;pega o nome
	;mov ebx,0
	;mov ecx,nome
	;mov edx,20
	;int 80h
	
	mov ecx msg1 ; mensagem hola
	mov edx tammsg1
	push ecx
	push edx
	call ESCREVESTRING
	
	
	;passar endereço nome push dw nome
	call ESCREVESTRING
	;mov eax,4 ;printa o nome
	;mov ebx,1
	;mov ecx,nome
	;mov edx,20
	;int 80h
	
	mov ecx msg2 ; mensagem de bem vindo
	mov edx tammsg2
	push ecx
	push edx
	call ESCREVESTRING

MENU:	
	mov ecx msg3 ; mensagem de menu
	mov edx tammsg3
	push ecx
	push edx
	call ESCREVESTRING
	
	;passar endereço nome push dw opcao
	call ESCREVESTRING
	mov eax,3 ;pega opcao do menu
	mov ebx,0
	mov ecx,opcao
	mov edx,2
	int 80h
	
	mov ecx,0 ;converte opcao de ascii para numero
	mov CL,[opcao]
	sub CL,0x30
	
	cmp CL,6 ;if opcao ==6 jump para exit
	jne FINAL
	cmp CL,1 ;if opcao ==1 jump para soma
	jne SOMA
	cmp CL,2 ;if opcao ==2 jump para subtracao
	jne SUBSTRACAO
	cmp CL,3 ;if opcao ==3 jump para multiplicacao
	jne MULTIPLICACAO
	cmp CL,4 ;if opcao ==4 jump para divisao
	jne DIVISAO
	cmp CL,5 ;if opcao ==5 jump para mod
	jne MOD
	
SOMA:	
	mov ecx msg4 ; mensagem de operando1
	mov edx tammsg4
	push ecx
	push edx
	call ESCREVESTRING
	
	;passar endereço push dw operando1
	call LESTRING
	;mov eax,3 ;pega operando1
	;mov ebx,0
	;mov ecx,operando1
	;mov edx,12
	;int 80h
	
	mov ecx msg5 ; mensagem de operando2
	mov edx tammsg5
	push ecx
	push edx
	call ESCREVESTRING
	
	;passar endereço push dw operando2
	call LESTRING
	;mov eax,3 ;pega operando2
	;mov ebx,0
	;mov ecx,operando2
	;mov edx,12
	;int 80h
	
	;faz a conta
	;printa a resposta
	
	JMP MENU

SUBTRACAO:
	push endereço da msg4
	call ESCREVESTRING
	
	;passar endereço push dw operando1
	call LESTRING
	
	push endereço da msg5
	call ESCREVESTRING
	
	;passar endereço push dw operando2
	call LESTRING
	
	;faz a conta
	;printa a resposta
	
	JMP MENU
	

MULTIPLICACAO:
	push endereço da msg4
	call ESCREVESTRING
	
	;passar endereço push dw operando1
	call LESTRING
	
	push endereço da msg5
	call ESCREVESTRING
	
	;passar endereço push dw operando2
	call LESTRING
	
	;faz a conta
	;printa a resposta
	
	JMP MENU

DIVISAO:
	push endereço da msg4
	call ESCREVESTRING
	
	;passar endereço push dw operando1
	call LESTRING
	
	push endereço da msg5
	call ESCREVESTRING
	
	;passar endereço push dw operando2
	call LESTRING
	
	;faz a conta
	;printa a resposta
	
	JMP MENU

MOD: 
	push endereço da msg4
	call ESCREVESTRING
	
	;passar endereço push dw operando1
	call LESTRING
	
	push endereço da msg5
	call ESCREVESTRING
	
	;passar endereço push dw operando2
	call LESTRING
	
	;faz a conta
	;printa a resposta
	
	
	
	
	JMP MENU
	
FINAL:
	mov eax, 1 ; Exit code
	mov ebx, 0
	int 80h
	
	
	
	
	
	
	
	
LESTRING: ; 
    push ebp        ;cria frame de pilha
    mov ebp, esp   
    pusha
    mov eax,3 
    mov ebx,0
    mov ecx, ebp+4
    mov edx,[ebp+8]
    int 80h
    
    popa

    pop ebp ;removing stack frame
    ret 0;return 



ESCREVESTRING:

  push ebp        ;cria frame de pilha
    mov ebp, esp   
    pusha
    
    mov eax,4 ;printa 
	mov ebx,1
	mov ecx, ebp+8
    	mov edx,ebp+4
	int 80h
    
	popa
    pop ebp ;removed stack frame
    ret 4 ;returns and removes the arguments received from stack


LEINTEIRO:
	;receive integer (ascii string) input
    push ebp        ;creating stack frame
    mov ebp, esp    ;creating stack frame
    push ebx    ;dont push eax because eax is the return value
    push ecx    ;counter of elements
    push edx    ;pointer for char string
    push esi    ;flag for negative

    push dword 0    ;reserve space to use as buffer
    push dword 0
    push dword 0
    ;ask for input

    push edi
    push dword 0 ;reserve buffer to read the extra chars
    mov ecx, esp    ;move the buffer to ecx
    sub esi, esi    ;reset counter
    mov edi, esp ;pointer to string
    add edi, 8

    get_input_charbychar_integer:
    mov eax, 3
    mov ebx, 0  ;0 = stdin - teclado
    mov edx, 1
    int 0X80
    cmp byte [ecx], 0X0A    ;check if char is ENTER
    je finish_input_integer ;if enter - finish input
    mov eax, [ecx]  ;move the char into the string
    mov byte [edi + esi], al
    inc esi ;increment char counter
    cmp esi, 12  ;check if string is full --> counter == string size
    je check_extra_char_enter_integer   ;if yes = string full but still no enter, read and trash next chars until enter
    jmp get_input_charbychar_integer    ;keep getting input

    check_extra_char_enter_integer: ;read char and throw it away until enter
    mov eax, 3
    mov ebx, 0  ;0 = stdin - teclado
    mov edx, 1
    int 0X80
    cmp byte [ecx], 0X0A    ;check if char is ENTER
    jne check_extra_char_enter_integer

    finish_input_integer:   ;finish getting inputs

    add esp, 4  ;remove buffer
    pop edi ;pops edi back



    sub eax, eax ;reset the accumulator to zero
    mov edx, esp   ;put address in edx
    ; add edx, 8
    push dword 10 ;stack the value 10 to multiply
    sub esi, esi  ;zero the negative number flag
    sub ecx, ecx ; zero the counter


convert_charint:
    cmp ecx, 11 ;avoids acessing an extra element
    je finish_charint
    movzx ebx, byte [edx] ;get char
    inc edx ;prepare next char
    inc ecx ;increment counter
    cmp ebx, '-' ;check for negative
    je negative_charint ;set negative flag

    cmp ebx, '0'    ;check if integer
    jb finish_charint
    cmp ebx, '9'    ;check if integer
    ja finish_charint
    sub ebx, '0' ;convert to integer
    push edx    ;save edx before ultiplication
    imul dword [esp+4] ;multiply eax by 10 = get ready for next digit
    pop edx ;no use for edx, maximum value of multiplication fits eax
    add eax, ebx    ;adds toacumulator value
    jmp convert_charint ;jump until finished
negative_charint:
    mov esi, 1  ;esi is a flag or negative
    jmp convert_charint

finish_charint:
    dec ecx ; counter will have 1 extra from the ending char
    add esp, 16  ;remove 10 and buffer from top of stack
    cmp esi, 1 ;check if negative
    jne finish_after_check_charint  ;if not negative, go on to finish
    imul eax, -1    ;if negative, multiply by -1
finish_after_check_charint:
    mov edx, [ebp + 8]
    mov [edx], eax   ;no arguments - return value is ebp + 8 bytes pushed by call and frame creation (return and ebp)
    mov eax, ecx    ;move counter into eax - number of characters input

    pop esi ;pops original value of: esi
    pop edx ; -edx
    pop ecx ; -ecx
    pop ebx ; -ebx

    pop ebp ;removing stack frame
    ret 4


ESCREVEINTEIRO:
;print integer (ascii string) output
    push ebp    ;creating stack frame
    mov ebp, esp    ;creating stack frame
    push ebx    ;dont push eax because eax is the return value
    push ecx    ;digit counter
    push edx    ;rest of division - number to convert
    push esi    ;flag for negative

    push dword 0    ;reserve space to use as buffer
    push dword 0
    push dword 0




    mov eax, [ebp + 8]   ;number - passed as argument through stack
    mov ebx, esp   ;string
    ; add ebx, 12
    mov ecx, 0  ;digit counter
    push dword 10 ;stack the value 10 to divide

check_negative:
    sub esi, esi    ;set negative flag to zero
    cmp eax, 0  ;check if number is smaller then 0
    jge convert_intchar ;jump if number is positive
    mov edx, -1 ;put -1 on edx for multiplication
    imul edx     ;if negative multiply number by -1 to operate on unsigned number
    mov esi, 1 ; esi is a negative flag
convert_intchar:
    sub edx, edx    ;zero edx (rest of division - number to convert)
    idiv dword [esp + ecx * 2] ;divide by 10
    add edx, '0'    ;convert digit to ascii char
    push dx ;stack number converted to ascii - stack works with a minimum 16 bits
    inc ecx ;count number of digits converted
    cmp eax, 0  ;check if eax is 0 or if there is still stuff to divide
    jne convert_intchar ;jumps while not finished



output_intchar:
    mov eax, 0  ;reset eax to use it as counter of chars added to string
    cmp esi, 0  ;check if negative
    je unstack_result_integer   ;if positive, jumps
    mov byte [ebx + eax], '-'   ;adds '-' to start of string
    inc eax ;increment eax - counter of chars added to string
    inc ecx ;increment ecx - counter of digits converted - + the negative char
    unstack_result_integer:
    pop dx  ;pops the chars converted to get the right order
    mov [ebx + eax], dl ;moves the actual byte of the char to the string buffer and ignores the empty dh
    inc eax ;increments eax - counter of chars unstacked
    cmp eax, ecx    ;check with ecx if finished unstacking all chars
    jne unstack_result_integer  ;jump if not finished
    cmp esi, 0  ;checks if negative again
    sub edx, edx    ;resets edx
    je finish_after_check_intchar   ;jumps if positive
    inc edx ;edx will have 1 more byte to print, in case of negative

    finish_after_check_intchar:
    add esp, 4 ;remove the value 10from top of stack
print_output_integer:
    ;outputs number
    push ecx    ;saves ecx - digits converted
    mov eax, 4
    mov ebx, 1
    add edx, ecx
    mov ecx, esp
    add ecx, 4 ;4 bytes of pushed ecx - get to the start of the buffer
    int 0X80

    ;outputs a linebreak
    push dword 0X0D0A ;add linebreak to stack
    mov eax, 4
    mov ebx, 1
    mov ecx, esp
    mov edx, 2
    int 0X80
    add esp, 4 ;remove linebreak from stack

    pop eax ;moved ecx into eax - digit counter
    add esp, 12    ;remove buffer from top of stack
    pop esi ;unstacking orgiginal values of: -esi
    pop edx ;-edx
    pop ecx ;-ecx
    pop ebx ;-ebx

    pop ebp ;removed stack frame
    ret 4 ;returns and removes the argument received from stack
