[org 0x0100]
jmp start

tickcount: dw 0
screen_pos: dw 0
previous_data: dw 0
oldkbisr: dw 0,0
move_star: db 0


; Keyboard interrupt service routine
kbisr:
    pusha
    push es 
    in al, 0x60

    ; Check if left shift key is pressed
    cmp al, 0x2A
    jne .checkNext
        mov byte [cs: move_star], 1
        jmp .chain
    .checkNext:
    ; Check if right shift key is pressed
    cmp al, 0x36
    jne .chain
        mov byte [cs:move_star], 0
    .chain:
        pop es
        popa
        jmp far [cs:oldkbisr];

; Exit the timer interrupt
exitTimer:
    mov al, 0x20
    out 0x20, al
    pop es
    pop cx
    pop bx
    pop ax
    iret

; Timer interrupt service routine
timer:
    push ax
    push bx
    push cx
    push es

    ; Check if the star should move
    cmp byte [cs:move_star], 0
    je exitTimer

    ; Set video segment
    mov ax,0xb800
    mov es,ax

    ; Save the previous character at the current position
    mov bx, [cs:previous_data]
    mov di,word[cs:screen_pos]
    mov cx, [es:di]
    mov [cs:previous_data], cx

    ; Set the character to be displayed as '*'
    mov ah,0x07
    mov al,'*'

    ; Determine the direction of movement
    cmp dl,'L'
    je left_star
    cmp dl,'D'
    je down_star
    cmp dl,'R'
    je right_star
    cmp dl,'U'
    je up_star

    ; Move the star to the left
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

    ; Move the star downwards
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

    ; Move the star upwards
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

    ; Move the star to the right
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

; Program entry point
start:
    ; call clear_screen
    push 0xb800
    pop es
    mov ax, [es:160]
    mov [previous_data], ax

    ; Save the old keyboard interrupt vector
    xor ax, ax
    mov es, ax
    mov bx, [es:9*4]
    mov [oldkbisr], bx
    mov bx, [es:9*4+2]
    mov [oldkbisr+2], bx

    ; Set the new timer and keyboard interrupt vectors
    cli
    mov word [es:8*4], timer
    mov [es:8*4+2], cs
    mov word [es:9*4], kbisr
    mov [es:9*4+2], cs
    sti

    ; Terminate the program
    mov dx, start
    add dx, 15
    mov cl, 4
    shr dx, cl
    mov ax, 0x3100
    int 0x21