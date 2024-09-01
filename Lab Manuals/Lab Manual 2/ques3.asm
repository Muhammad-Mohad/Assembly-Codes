[org 0x0100]

mov di, 0
mov si, 10	
mov cx, 6				

l1:		mov ax, [arr1 + si]	
		mov [arr2 + di], ax;
		add di, 2
		sub si, 2
		sub cx, 1		
		jnz l1			
						

mov ax, 0x4c00		
int 0x21

arr1:	dw 1, 2, 3, 4, 5, 6
arr2:   dw 0, 0, 0, 0, 0, 0