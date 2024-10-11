[org 0x0100]
jmp start

allign:	
	push bp
	mov bp,sp
	push ax
	push cx
	push si
	push di
	push es
	push ds

	mov ax, 1
	mul byte [bp+4]
	push ax 
	shl ax, 1 
	
	mov si, 3998 
	sub si, ax 
	
	mov cx, 4000 
	sub cx, ax 
	shr ax,1

	mov ax, 0xb800
	mov es, ax 
	mov ds, ax 
	mov di, 3998 

	std 
	rep movsw 
	
	mov ax, 0x0720 
	pop cx 
	mov di,cx						
	rep stosw 

	pop ds
	pop es
	pop di
	pop si
	pop cx
	pop ax
	pop bp
	ret 2

start:
	mov ax, 10
	push ax 
	call allign 

	mov ax, 0x4c00 
	int 0x21