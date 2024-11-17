[org 0x0100]

mov ax, 0xb800          
mov es, ax
mov ax, 0x2000
mov ds, ax
mov si, 0
mov di, 0
mov cx, 960

copy:
	mov ax, [es:di]
	mov [ds:si], ax
	add di, 2
	add si, 2
	loop copy
	
mov si, 0
mov di, 1920
mov cx, 960
rep movsw

mov ax, 0x4c00
int 0x21