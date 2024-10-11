[org 0x0100]
jmp start
message: db ' '
length: dw 1

clrscr: 
push es
push ax
push di

mov ax, 0xb800
mov es, ax
mov di, 0

nextloc: 
mov word [es:di], 0x0720
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

printstr: 
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

mov si, [bp+8]
mov ah, 0x10
mov al,0x8F
mov dx,0
sub dx,[bp+6]
mov bx , [bp+4]
mov di , 0


triangle:
mov cx, [bp+6]

print_triangle:
mov al,[si]
mov [es:di], ax
call delay
call delay
add di,2
add dx,1
loop print_triangle 

add di,160
sub di,cx
dec bx
jnz triangle

add dx, 1
printbase:
mov al,[si]
mov [es:di], ax
sub di,2
sub dx,1
jnz printbase

printhypo:
mov al,[si]
mov [es:di], ax
call delay
call delay
sub di,160
jnz printhypo

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
push 200
push ax
push 1
push 20
call printstr
call clrscr

mov ax, message
push 200
push ax
push 1
push 10
call printstr

mov ax, 0x4c00
int 0x21
