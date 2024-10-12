[org 0x0100]

jmp start
num1: dq 0x1234321445432343
num2: dq 0x0012010021002301

start:
mov ax, [num1]
mov bx, [num1 + 2]
mov cx, [num1 + 4]
mov dx, [num1 + 6]

mov di, [num2]
mov si, [num2 + 2]
mov sp, [num2 + 4]
mov bp, [num2 + 6]

adc ax, di
adc bx, si
adc cx, sp
adc dx, bp

mov ax,0x4c00
int 0x21