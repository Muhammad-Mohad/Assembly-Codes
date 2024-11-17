org 0x0100
jmp start

arr: dw 1, 2, 8, 3, 4, 5, 9, 5, 6, 7
maximum: dw 0
minimum: dw 0

start:
    ; Initialize variables
    mov cx, 10           ; Total number of elements
    mov ax, [arr]       ; Start with the first element as both min and max
    mov [maximum], ax
    mov [minimum], ax

    ; Set up for the loop to find min and max
    mov si, 2           ; Start from the second element
    mov bx, ax          ; Set bx to initial value for comparison

minmax:
    cmp cx, 1           ; Check if there are more elements to process
    je done             ; If only one element left, finish

    mov ax, [arr + si]  ; Load the next element
    cmp ax, [maximum]   ; Compare with current maximum
    jg new_max          ; If greater, update maximum
    cmp ax, [minimum]   ; Compare with current minimum
    jl new_min          ; If smaller, update minimum

next:
    add si, 2           ; Move to the next element
    loop minmax         ; Decrement cx and loop

done:
    ; Prepare to exit
    mov ax, 0x4c00
    int 0x21

new_max:
    mov [maximum], ax   ; Update maximum
    jmp next

new_min:
    mov [minimum], ax   ; Update minimum
    jmp next
