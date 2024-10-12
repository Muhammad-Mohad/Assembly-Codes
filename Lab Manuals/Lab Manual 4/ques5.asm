[org 0x0100]

jmp start

arr: dw 1, 2, 8, 3, 4, 5, 9, 5, 6, 7
maximum: dw 0
minimum: dw 0

start:
	mov cx, 10
	mov ax, 0
	mov si, 0
	
	loop:
		add ax, [arr + si]
		add si, 2
		sub cx, 1
		jnz loop
		
	mov cx, 9
	mov ax, 0
	mov bx, 0
	mov di, 2
	
	minmax:
		mov ax, [arr]
		mov bx, [arr + di]
		cmp ax, bx
		jg max
		jng min
		add di, 2
		sub cx, 1
		jnz minmax
		
	max:
		mov [maximum], ax
	min:
		mov [minimum], bx

mov ax, 0x4c00
int 0x21