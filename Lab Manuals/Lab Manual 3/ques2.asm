[org 0x0100]

mov cx, 10         
mov si, 0        
mov di, 2       

elimination:
    mov dx, 0
    mov [array + si], dx
    jmp aftereliminate

loop:
    mov ax, [array + si] 
    mov bx, [array + di]  
    cmp ax, bx             
    je elimination        
aftereliminate:
    add si, 2             
    add di, 2            
    sub cx, 1              
    jnz loop              

mov cx, 10         
mov si, 0         
mov di, 0         
zero_pointer:
    mov ax, [array + si]  
    cmp ax, 0              
    je next_element        
    mov [array + di], ax   
    add di, 2              
next_element:
    add si, 2              
    loop zero_pointer      

fill_zeros:
    cmp di, 20             
    je done                
    mov word [array + di], 0 
    add di, 2             
    jmp fill_zeros        

done:
    mov ax, 0x4c00        
    int 0x21

array: dw 2, 2, 2, 3, 4, 4, 5, 5, 5, 6
