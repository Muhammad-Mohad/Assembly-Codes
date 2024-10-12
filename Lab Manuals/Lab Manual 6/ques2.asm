[org 0x0100]

jmp start

temp1: dw 0
temp2: dw 0
answer1: dw 0
answer2: dw 0
answer3: dw 0

start:
    push 0xA
    push 0x1
    push 0x2
    push 0x2
    call AnotherFunction
    mov ax, [temp1]
    add ax, [temp2]
    mov [answer1], ax

    push 0x9
    push 0x1
    push 0x5
    push 0x0
    call AnotherFunction
    mov ax, [temp1]
    add ax, [temp2]
    mov [answer2], ax

    push 0xF
    push 0x1
    push 0x8
    push 0x4
    call AnotherFunction
    mov ax, [temp1]
    add ax, [temp2]
    mov [answer3], ax

    mov ax, 0x4c00
    int 0x21

AnotherFunction:
    push bp
    mov bp, sp
    mov ax, [bp + 10]
    mov bx, [bp + 8]
    mov cx, [bp + 6]
    mov dx, [bp + 4]
    call subtract
    mov [temp1], si
    mov si, 0
    mov ax, cx
    mov bx, dx
    mov cx, 0
    mov dx, 0
    call subtract
    mov [temp2], si
    pop bp
    ret 8

subtract:
    push bp
    mov bp, sp              
    mov si, ax
    sub si, bx              
    sub si, cx              
    sub si, dx
    pop bp              
    ret