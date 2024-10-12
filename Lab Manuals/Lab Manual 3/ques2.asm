[org 0x0100]

jmp start
num: dq 0x1234321445432343

start:
mov ax, [num]
mov bx, [num + 2]
mov cx, [num + 4]
mov dx, [num + 6]

shl ax, 1
rcl word bx, 1
rcl word cx, 1 
rcl word dx, 1

mov ax,0x4c00
int 0x21