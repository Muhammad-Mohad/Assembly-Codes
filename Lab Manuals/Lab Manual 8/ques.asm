[org 0x0100]
 
jmp start

oldisr: dd 0
buffer: times 4000 db 0

kbisr:
	push ax
	push es

	in al, 0x60
	cmp al, 0x2e         ; check if 'c'
	jne continue
	call saveScreen
	mov al, 0x20
	out 0x20, al
	pop es
	pop ax
	iret

continue:
	cmp al, 0x2f        ; check if 'v'
	jne chain
	call restoreScreen

chain:
	pop es
	pop ax
	jmp far [cs:oldisr]
	
clrscr: 
	push es
	push ax
	push di

	mov ax, 0xb800
	mov es, ax
	mov di, 0 

	nextloc: mov word [es:di], 0x0720 
	add di, 2 
	cmp di, 4000 
	jne nextloc

	pop di
	pop ax
	pop es
	ret

saveScreen: 
	pusha

	mov cx, 4000 
	mov ax, 0xb800
	mov ds, ax 

	push cs
	pop es

	mov si, 0
	mov di, buffer

	cld 
	rep movsb 
	
	popa
	ret

restoreScreen: 
	pusha

	mov cx, 4000 
	mov ax, 0xb800
	mov es, ax 

	push cs
	pop ds

	mov si, buffer
	mov di, 0

	cld 
	rep movsb 

	popa
	ret

start:

	mov ax, 0
	mov es, ax

	mov ax, [es:9*4]
	mov [oldisr], ax
	mov ax, [es:9*4+2]
	mov [oldisr+2], ax

	cli
	mov word [es:9*4], kbisr
	mov word [es:9*4 + 2], cs
	sti

	mov dx, start

mov ax, 0x3100
int 0x21