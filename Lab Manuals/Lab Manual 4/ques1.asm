[org 0x0100]

mov ax, 0x0784
shl ax, 1
shr ax, 2
sar ax, 1

mov ax, 0x4c00
int 0x21