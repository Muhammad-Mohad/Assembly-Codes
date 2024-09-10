[org 0x0100]

jmp start

numbers: dw  9, 3, 4, 2, 17, 9, -12, 4, 8, 1  

start:
    mov si, numbers      
    mov cx, 10             

    mov ax, [si]           
    mov bx, ax          ; bx will store the minimum number
    mov dx, ax          ; dx will store the maximum number
    add si, 2        
    sub cx, 1
    jnz find_min_max              

find_min_max:
    mov ax, [si]           
    cmp ax, bx             
    jl update_min          
    cmp ax, dx             
    jg update_max         
    jmp next_number       

update_min:
    mov bx, ax            
    jmp next_number

update_max:
    mov dx, ax           

next_number:
    add si, 2              
    loop find_min_max      

    mov ax, 0x4c00
    int 0x21
