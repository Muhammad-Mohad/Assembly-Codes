[org 0x0100]

jmp start

set1: dw 1, 4, 6, 0 
set2: dw 1, 3, 5, 8, 0 
union_set: dw 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 

start:
    mov si, set1       
    mov di, set2       
    mov bx, union_set  
    mov cx, 10       

process_union:
    mov ax, [si]       ; Load element from set1
    mov dx, [di]       ; Load element from set2

    ; If either element is 0, break the loop
    cmp ax, 0
    je set1_done
    cmp dx, 0
    je set2_done

    ; Compare elements from set1 and set2
    cmp ax, dx
    je equal_elements 
    jl set1_less        
    jg set2_less     

set1_less:

    mov [bx], ax        
    add si, 2          
    add bx, 2           
    dec cx              
    jmp check_full

set2_less:

    mov [bx], dx       
    add di, 2           
    add bx, 2          
    dec cx              
    jmp check_full

equal_elements:

    mov [bx], ax        
    add si, 2           
    add di, 2           
    add bx, 2         
    dec cx             
    jmp check_full

check_full:
    cmp cx, 0           
    je finish
    jmp process_union 

set1_done:
    ; Copy remaining elements from set2 (if any)
    mov ax, [di]
    cmp ax, 0
    je finish
    mov [bx], ax
    add di, 2
    add bx, 2
    dec cx
    jmp check_full

set2_done:
    ; Copy remaining elements from set1 (if any)
    mov ax, [si]
    cmp ax, 0
    je finish
    mov [bx], ax
    add si, 2
    add bx, 2
    dec cx
    jmp check_full

finish:
    mov word [bx], 0        ; terminate the union set with 0

    mov ax, 0x4c00
    int 0x21
