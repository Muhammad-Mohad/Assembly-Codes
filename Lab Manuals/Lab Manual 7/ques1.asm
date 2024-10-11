[org 0x0100]
jmp start
message: db ' '
length: dw 1
clrscr: push es
push ax
push di

mov ax, 0xb800
mov es, ax
mov di, 0

nextloc: mov word [es:di], 0x0720
add di, 2
cmp di, 4000
jne nextloc

pop di
pop ax
pop es
ret
delay:
push bp
mov bp,sp
push cx
mov cx,0xffff
delay1:
loop delay1
pop cx
pop bp
ret

print_rect: 
push bp
mov bp, sp
push es
push ax
push cx
push si
push di
push bx
push dx

mov ax, 0xb800
mov es, ax
mov di, 0

mov si, [bp+10]
mov ah, 0x10
mov al,0x8F
mov dx,0
sub dx,[bp+8]
mov bx , [bp+6]
mov di , 0
mov di,[bp + 4]
rect:
mov cx, [bp+8]

printRectangle:
mov al,[si]
mov [es:di], ax
add di,2

loop printRectangle

add di,160
sub di,[bp+8]
sub di,[bp+8]
dec bx
jnz rect
pop dx
pop bx
pop di
pop si
pop cx
pop ax
pop es
pop bp
ret 6

start: 
call clrscr

mov ax, message
push ax

push 15
push 15
push 2000
call print_rect

push 10
push 10
push 160
call print_rect

push 5
push 5
push 510
call print_rect

mov ax, 0x4c00
int 0x21