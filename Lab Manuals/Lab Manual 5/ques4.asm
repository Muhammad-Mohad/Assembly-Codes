[org 0x0100]
jmp start

clrscr:		push es
			push ax
			push di

			mov ax, 0xb800
			mov es, ax					
			mov di, 0					
			mov ah, 0x07
			mov al, 0

nextloc:	mov word [es:di], AX	
			inc AL
			add di, 2					
			cmp di, 4000			
			jne nextloc				

			pop di
			pop ax
			pop es
			ret


start:	

mov AH,0x07
mov al, 0x00
int 0x10



call clrscr


mov ax, 0x4c00 
int 0x21