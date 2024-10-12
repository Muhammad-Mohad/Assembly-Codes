[org 0x0100]

mov bx, 0x0784
rol bx, 3
mov cx, bx

mov bx, 0x0784
ror bx, 4
mov dx, bx

mov ax, 0x4c00
int 0x21