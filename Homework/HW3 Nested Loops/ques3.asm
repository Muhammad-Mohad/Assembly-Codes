[org 0x0100]

jmp start

set1: dw 1, 4, 6, 0     
set2: dw 1, 3, 6, 8, 0   
intersection_set: dw 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

start:
    mov si, set1      
    mov di, set2       
    mov bx, intersection_set  

process_intersection:

    mov ax, [si]      
    mov dx, [di]     

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
    add si, 2           
    jmp process_intersection

set2_less:
    add di, 2           
    jmp process_intersection

equal_elements:
    ; Insert equal element into intersection_set
    mov [bx], ax       
    add si, 2           
    add di, 2         
    add bx, 2           
    jmp process_intersection

set1_done:
set2_done:

    mov word [bx], 0
    mov ax, 0x4c00
    int 0x21
