[org 0x0100]

mov ax, 5
mov dx, ax
mov bx, ax
sub bx, 2
mov cx, bx

loop1:

loop2:
	add ax, dx
	sub cx, 1
	jnz loop2
	
	mov dx, ax
	mov cx, bx
	sub cx, 1
	sub bx, 1
	jnz loop1

mov ax, 0x4c00
int 0x21