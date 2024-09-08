[org 0x0100]

mov cx, 10
mov si, 0
mov di, 2

elimination:
	mov dx, 0
	mov [array + si], dx
	jmp aftereliminate
	
loop:
	mov ax, [array + si]
	mov bx, [array + di]
	cmp ax, bx
	je elimination
	aftereliminate:
	add si, 2
	add di, 2
	sub cx, 1
	jnz loop
	
mov ax, 0x4c00
int 0x21

array: dw 2,2,2,3,4,4,5,5,5,6