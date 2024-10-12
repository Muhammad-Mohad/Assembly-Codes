[org 0x0100]

jmp start

arr1: dw 1, 2, 2, 3, 4, 5, 5, 6, 7, 6
arr2: dw 2, 3, 4, 5, 6, 7, 8, 4, 4, 3
greater: dw 0

start:
	mov cx, 10
	mov ax, 0
	mov bx, 0
	mov di, 0
	mov si, 0
	
	loop:
		add ax, [arr1 + si]
		add bx, [arr2 + di]
		add si, 2
		add di, 2
		sub cx, 1
		jnz loop
		
	cmp ax, bx
	jg great
	jng less
	
great:
	mov [greater], ax
	
less:
	mov [greater], bx

mov ax, 0x4c00
int 0x21