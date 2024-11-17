[org 0x0100]
jmp start

tickcount: dw 0
screen_pos: dw 0
previous_data: dw 0
startingmsg: db "Press A for tick mode and any other key for 1 second mode.", 10, 13, '$'
Tickmsg: db " ", 10, 13, '$'
SecondMsg: db " ", 10, 13, '$'
choice: times 1 db '$'

timer:
    push ax
    push bx
    push cx
    push es

    mov ax,0xb800
    mov es,ax

    mov bx, [cs:previous_data]
    mov di,word[cs:screen_pos]
    mov cx, [es:di]
    mov [cs:previous_data], cx

    mov ah,0x07
    mov al,'*'

    cmp dl,'L'
    je left_star
    cmp dl,'D'
    je down_star
    cmp dl,'R'
    je right_star
    cmp dl,'U'
    je up_star

left_star:
    mov di,word[cs:screen_pos]
    mov [es:di],ax
    add word[cs:screen_pos],2
    mov [es:di-2],bx
    cmp word[cs:screen_pos],158
    jne skip
    mov [es:156],bx
    mov dl,'D'
skip:
    jmp end

down_star:
    mov di,word[cs:screen_pos]
    mov [es:di],ax
    add word[cs:screen_pos],160
    mov [es:di-160],bx
    cmp word[cs:screen_pos],4000-2
    jne skip1
    mov [es:3838],bx
    mov dl,'R'
skip1:
    jmp end

up_star:
    mov di,word[cs:screen_pos]
    mov [es:di],ax
    sub word[cs:screen_pos],160
    mov [es:di+160],bx
    cmp word[cs:screen_pos],0
    jne skip3
    mov [es:160],bx
    mov dl,'L'
skip3:
    jmp end

right_star:
    mov di,word[cs:screen_pos]
    mov [es:di],ax
    sub word[cs:screen_pos],2
    mov [es:di+2],bx
    cmp word[cs:screen_pos],3840
    jne skip2
    mov [es:3842],bx
    mov dl,'U'
skip2:
    jmp end

end:
    mov al, 0x20
    out 0x20, al
    pop es
    pop cx
    pop bx
    pop ax
    iret

timer2:
    push ax
    push bx
    push cx
    push es

    inc word [cs:tickcount]
    cmp word [cs:tickcount], 18
    je .reset
    mov al, 0x20
    out 0x20, al
    pop es
    pop cx
    pop bx
    pop ax
    iret
.reset:
    mov word [cs:tickcount], 0

    mov ax,0xb800
    mov es,ax

    mov bx, [cs:previous_data]
    mov di,word[cs:screen_pos]
    mov cx, [es:di]
    mov [cs:previous_data], cx

    mov ah,0x07
    mov al,'*'

    cmp dl,'L'
    je left_star2
    cmp dl,'D'
    je down_star2
    cmp dl,'R'
    je right_star2
    cmp dl,'U'
    je up_star2

left_star2:
    mov di,word[cs:screen_pos]
    mov [es:di],ax
    add word[cs:screen_pos],2
    mov [es:di-2],bx
    cmp word[cs:screen_pos],158
    jne skip4
    mov [es:156],bx
    mov dl,'D'
skip4:
    jmp end2

down_star2:
    mov di,word[cs:screen_pos]
    mov [es:di],ax
    add word[cs:screen_pos],160
    mov [es:di-160],bx
    cmp word[cs:screen_pos],4000-2
    jne skip5
    mov [es:3838],bx
    mov dl,'R'
skip5:
    jmp end2

up_star2:
    mov di,word[cs:screen_pos]
    mov [es:di],ax
    sub word[cs:screen_pos],160
    mov [es:di+160],bx
    cmp word[cs:screen_pos],0
    jne skip6
    mov [es:160],bx
    mov dl,'L'
skip6:
    jmp end2

right_star2:
    mov di,word[cs:screen_pos]
    mov [es:di],ax
    sub word[cs:screen_pos],2
    mov [es:di+2],bx
    cmp word[cs:screen_pos],3840
    jne skip7
    mov [es:3842],bx
    mov dl,'U'
skip7:
    jmp end2

end2:
    mov al, 0x20
    out 0x20, al
    pop es
    pop cx
    pop bx
    pop ax
    iret

start:
    ; Print starting message
    mov ah, 0x09
    lea dx, [startingmsg]
    int 0x21

    ; Get user choice
    mov ah, 0x00
    int 0x16
    mov [choice], al

    ; Check if the user pressed 'A'
    cmp byte [choice], 'A'
    je tick_mode
    jmp one_second_mode

tick_mode:
    ; Set up timer interrupt for tick mode
    mov ah, 0x09
    lea dx, [Tickmsg]
    int 0x21

    push 0xb800
    pop es
    mov ax, [es:160]
    mov [previous_data], ax

    xor ax, ax
    mov es, ax
    cli
    mov word [es:8*4], timer
    mov [es:8*4+2], cs
    sti
    jmp terminate

one_second_mode:
    ; Set up timer interrupt for one-second mode
    mov ah, 0x09
    lea dx, [SecondMsg]
    int 0x21

    push 0xb800
    pop es
    mov ax, [es:160]
    mov [previous_data], ax

    xor ax, ax
    mov es, ax
    cli
    mov word [es:8*4], timer2
    mov [es:8*4+2], cs
    sti
    jmp terminate

terminate:
    ; Terminate the program
    mov dx, start
    add dx, 15
    mov cl, 4
    shr dx, cl
    mov ax, 0x3100
    int 0x21