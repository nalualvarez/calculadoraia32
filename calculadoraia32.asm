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
opcao resb 4
operando1 resb 12
operando2 resb 12
resposta resb 11
resto resb 11


section .text
global _start
_start:
	mov eax,4 ;printa solicitacao de nome
	mov ebx,1
	mov ecx,msg0
	mov edx,tammsg0
	int 80h
	
	mov eax,3 ;pega o nome
	mov ebx,0
	mov ecx,nome
	mov edx,20
	int 80h
	
	mov eax,4 ;printa mensagem de hola
	mov ebx,1
	mov ecx,msg1
	mov edx,tammsg1
	int 80h
	
	mov eax,4 ;printa o nome
	mov ebx,1
	mov ecx,nome
	mov edx,20
	int 80h
	
	mov eax,4 ;printa mensagem de boas vindas
	mov ebx,1
	mov ecx,msg2
	mov edx,tammsg2
	int 80h

MENU:	
	mov eax,4 ;printa menu
	mov ebx,1
	mov ecx,msg3
	mov edx,tammsg3
	int 80h
	
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
		
	mov eax,4 ;printa solicitacao de operando1
	mov ebx,1
	mov ecx,msg4
	mov edx,tammsg4
	int 80h
	
	mov eax,3 ;pega operando1
	mov ebx,0
	mov ecx,operando1
	mov edx,12
	int 80h
	
	mov eax,4 ;printa solicitacao de operando2
	mov ebx,1
	mov ecx,msg5
	mov edx,tammsg5
	int 80h
	
	mov eax,3 ;pega operando2
	mov ebx,0
	mov ecx,operando2
	mov edx,12
	int 80h
	
	JMP MENU
	
FINAL:
	mov eax, 1 ; Exit code
	mov ebx, 0
	int 80h
	
	
	
	
	
	
	
	