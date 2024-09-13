[org 0x0100]

mov bx, 0xb189
mov ax, 0xaba5                     

mov cx, 0 
mov dx, bx 

count_ones:
shr dx, 1 
jnc no_increment 
inc cx 

no_increment:
cmp dx, 0
jnz count_ones 

mov di, cx 
mov si, 0 

mov byte [mask], 1 
mov byte [shift_count], 0 

complement_bits:
mov cl, [shift_count] 
mov bl, [mask] 
shl bl, cl 
xor al, bl 


inc byte [shift_count] 
dec di 
jnz complement_bits 

mov ax, 0x4c00
int 0x21

mask db 0 
shift_count db 0 