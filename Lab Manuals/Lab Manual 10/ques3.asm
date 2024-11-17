[org 0x0100]

mov ax, 0x000D 
int 0x10 

mov ax, 0x0C07 
mov bx, 0
mov cx, 200 
mov dx, 200 

l1: 
int 0x10 
dec dx 
loop l1 

mov ah, 0 
int 0x16 

mov ax, 0x0003 
int 0x10 

mov ax, 0x4c00 
int 0x21