[org 0x0100]

mov bx, [num1]	
mov cx, [num1]				
mov ax, 0				

l1:		add ax, bx		
		sub bx, 1		
		sub cx, 1		
		jnz l1	
				
mov [total], ax 			

mov ax, 0x4c00 			
int 0x21

num1: dw 6
total: dw 0