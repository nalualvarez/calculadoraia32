section .data
msg0 db 	'Digite seu nome: '
tammsg0 dd 17
msg1 db 	'Hola, '
tammsg1 dd 6
msg2 db 	'Bem-vindo ao programa de CALC IA-32. '
tammsg2 dd 37
msg3 db 	'Escolha uma opcao: 1-soma, 2-subtracao, 3-multiplicacao, 4-divisao, 5-mod, 6-sair '
tammsg3	dd 82
msg4 db		'Digite primeiro operando: '
tammsg4	dd 26
msg5 db		'Digite segundo operando: '
tammsg5	dd 25
msgmul db 'Multipicacao nao disponivel. '
tammsgmul dd 29
operando1 dd 0, 0, 0, 0
operando2 dd 0, 0, 0, 0
resultado dd 0, 0, 0, 0
opcao dd 0
ent dd 0



tamnome dd 20


section .bss
nome resb 20

section .text
global _start
_start:

	push DWORD msg0 ; mensagem digite seu nome
	push DWORD [tammsg0]
	call ESCREVESTRING

	push DWORD nome ;pega nome do usuario
	push DWORD [tamnome]
	call LESTRING

	push DWORD msg1 ; mensagem hola
	push DWORD [tammsg1]
	call ESCREVESTRING

	push DWORD nome ; nome
	push DWORD [tamnome]
	call ESCREVESTRING

	push DWORD msg2 ; mensagem bem vindo
	push DWORD [tammsg2]
	call ESCREVESTRING


MENU:
	push DWORD msg3 ; mensagem do menu
	push DWORD [tammsg3]
	call ESCREVESTRING


	mov eax, 3
	mov ebx, 0
	mov ecx, opcao
	mov edx, 2
	int 80h

	cmp byte [opcao], 36h
	je FINAL
	cmp byte [opcao], 31h
	je SOMA
	cmp byte [opcao], 32h
	je SUBTRACAO
	cmp byte [opcao], 33h
	je MULTIPLICACAO
	cmp byte [opcao], 34h
	je DIVISAO
	cmp byte [opcao], 35h
	je MOD



SOMA:
	push DWORD msg4 ; mensagem operando1
	push DWORD [tammsg4]
	call ESCREVESTRING

	push DWORD operando1 ;pega operando1 do usuario
	call LEINTEIRO

	push DWORD msg5 ; mensagem operando2
	push DWORD [tammsg5]
	call ESCREVESTRING

	push DWORD operando2 ;pega operando2 do usuario
	call LEINTEIRO

	mov ebx, [operando1]
	add ebx, [operando2]
	mov [resultado], ebx

	push DWORD [resultado]
	call ESCREVEINTEIRO

	JMP MENU

SUBTRACAO:
	push DWORD msg4 ; mensagem operando1
	push DWORD [tammsg4]
	call ESCREVESTRING

	push DWORD operando1 ;pega operando1 do usuario
	call LEINTEIRO

	push DWORD msg5 ; mensagem operando2
	push DWORD [tammsg5]
	call ESCREVESTRING

	push DWORD operando2 ;pega operando2 do usuario
	call LEINTEIRO

	mov ebx, [operando1]
	sub ebx, [operando2]
	mov [resultado], ebx

	push DWORD [resultado]
	call ESCREVEINTEIRO

	JMP MENU


MULTIPLICACAO:
	push DWORD msgmul
	push DWORD [tammsgmul]
	call ESCREVESTRING

	JMP MENU

DIVISAO:

	push DWORD msg4 ; mensagem operando1
	push DWORD [tammsg4]
	call ESCREVESTRING

	push DWORD operando1 ;pega operando1 do usuario
	call LEINTEIRO

	push DWORD msg5 ; mensagem operando2
	push DWORD [tammsg5]
	call ESCREVESTRING

	push DWORD operando2 ;pega operando2 do usuario
	call LEINTEIRO

	mov eax, [operando1]
	mov ebx, [operando2]
	cdq
	idiv ebx
	mov [resultado], al

	push DWORD [resultado]
	call ESCREVEINTEIRO

	JMP MENU

MOD:
	push DWORD msg4 ; mensagem operando1
	push DWORD [tammsg4]
	call ESCREVESTRING

	push DWORD operando1 ;pega operando1 do usuario
	call LEINTEIRO

	push DWORD msg5 ; mensagem operando2
	push DWORD [tammsg5]
	call ESCREVESTRING

	push DWORD operando2 ;pega operando2 do usuario
	call LEINTEIRO

	mov eax, [operando1]
	mov ebx, [operando2]
	cdq
	idiv ebx
	mov [resultado], edx

	push DWORD [resultado]
	call ESCREVEINTEIRO

	JMP MENU

FINAL:
	mov eax, 1 ; Exit code
	mov ebx, 0
	int 80h

;funcoes abaixo

LESTRING: ;
	push ebp ;cria frame da pilha
	mov ebp,esp
	mov eax,3
	mov ebx,0
	mov ecx, [ebp+12]
	mov edx, [ebp+8]
	int 80h ;syscall pega do teclado
	pop ebp ;remove frame da pilha
	ret 0;return

ESCREVESTRING:
	push ebp ;cria frame da pilha
	mov ebp,esp
	mov eax,4
	mov ebx,1
	mov ecx, [ebp+12]
	mov edx, [ebp+8]
	int 80h ;syscall printa na tela
	pop ebp ;remove frame da pilha
	ret 0;return


LEINTEIRO:
    push ebp        ;cria frame da pilha
    mov ebp, esp
    push ebx
    push ecx
    push edx
    push esi    ;flag negativo

    push dword 0    ;buffer
    push dword 0
    push dword 0

    push edi
    push dword 0
    mov ecx, esp
    sub esi, esi    ;contador =0
    mov edi, esp
    add edi, 8

    charachar:
    mov eax, 3
    mov ebx, 0
    mov edx, 1
    int 0X80
    cmp byte [ecx], 0X0A    ;ve se eh o enter
    je deuenter
    mov eax, [ecx]
    mov byte [edi + esi], al
    inc esi
    cmp esi, 12  ;ve se a string ja completou
    je sementer   ;se completou sem enterif yes = string full but still no enter, read and trash next chars until enter
    jmp charachar    ;keep getting input

    sementer: ;descarta os char até ser enter
    mov eax, 3
    mov ebx, 0
    mov edx, 1
    int 0X80
    cmp byte [ecx], 0X0A    ;ve se deu ENTER
    jne sementer

    deuenter:   ; para de pegar char
    add esp, 4  ;
    pop edi

    sub eax, eax
    mov edx, esp
    push dword 10 ;salva 10 pra poder mutiplicar
    sub esi, esi  ;zera a flag
    sub ecx, ecx ; zera o contador


charparaint:
    cmp ecx, 11
    je charintfim
    movzx ebx, byte [edx]
    inc edx
    inc ecx
    cmp ebx, '-' ;ve se eh negativo
    je negat

    cmp ebx, '0'
    jb charintfim
    cmp ebx, '9'
    ja charintfim
    sub ebx, '0'
    push edx
    imul dword [esp+4] ;a cada digito, multipĺica por 10
    pop edx
    add eax, ebx
    jmp charparaint ;vai convertendo ate acabar
negat:
    mov esi, 1
    jmp charparaint

charintfim:
    dec ecx ;
    add esp, 16
    cmp esi, 1 ; ve se eh negativo
    jne naonegfim  ;se nao for negativo, pode sair
    imul eax, -1    ;se for negativo, multiplica por -1

naonegfim:
    mov edx, [ebp + 8]
    mov [edx], eax
    mov eax, ecx

    pop esi
    pop edx
    pop ecx
    pop ebx
    pop ebp ;remove frame de pilha
    ret 4


ESCREVEINTEIRO:
    push ebp    ;cria frame de pilha
    mov ebp, esp
    push ebx
    push ecx
    push edx
    push esi

    push dword 0
    push dword 0
    push dword 0

    mov eax, [ebp + 8]   ;numero pra printar
    mov ebx, esp   ;string
    mov ecx, 0
    push dword 10 ;guarda 10 pra dividir

ehneg:
    sub esi, esi    ;zera a flag de negativo
    jge intchar ;pula se for positivo
    mov edx, -1 ;guarda -1 pra multiplicar
    imul edx     ;se for negativo, multiplica por -1
    mov esi, 1  ;seta a flag de negativo

intchar:
    sub edx, edx
    idiv dword [esp + ecx * 2] ;divide por 10
    add edx, '0'    ;converte
    push dx ;
    inc ecx ;conta o numero de digitos convertidos
    cmp eax, 0  ;ve se foi o ultimo algarismo
    jne intchar ;se nao, segue convertendo

output_intchar:
    mov eax, 0
    cmp esi, 0  ;ve se deu negativo
    je desempilha   ;se positivo, pula
    mov byte [ebx + eax], '-'   ;coloca o negativo
    inc eax
    inc ecx ;
    desempilha:
    pop dx  ;vai tirando os chars
    mov [ebx + eax], dl ;
    inc eax
    cmp eax, ecx    ;ve se ja foram todos os ints
    jne desempilha  ;pula se nao foram
    cmp esi, 0  ;ve se eh negativo
    sub edx, edx
    je terminachecarintchar
    inc edx

    terminachecarintchar:
    add esp, 4

printasaida:
    push ecx
    mov eax, 4
    mov ebx, 1
    add edx, ecx
    mov ecx, esp
    add ecx, 4
    int 0X80

    push dword 0X0D0A ;da um enter
    mov eax, 4
    mov ebx, 1
    mov ecx, esp
    mov edx, 2
    int 0X80
    add esp, 4

    pop eax
    add esp, 12
    pop esi
    pop edx
    pop ecx
    pop ebx

    pop ebp
    ret 4
