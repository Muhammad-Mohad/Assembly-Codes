[org 0x0100]         

jmp start

globalVar:  dw 0         
answer1: dw 0         
answer2: dw 0         
answer3: dw 0

start:
    push 0xA     
    push 0x1      
    push 0x2      
    push 0x2    
    call subtract
    mov ax, [globalVar]    
    mov [answer1], ax   


    push 0x9      
    push 0x1     
    push 0x5      
    push 0x0      
    call subtract
    mov ax, [globalVar]    
    mov [answer2], ax   


    push 0xF     
    push 0x1    
    push 0x8    
    push 0x4      
    call subtract
    mov ax, [globalVar]    
    mov [answer3], ax   

    mov ax, 0x4c00
    int 0x21

subtract:
    push bp               
    mov  bp, sp           
    mov  ax, [bp+10]      
    sub  ax, [bp+8]       
    sub  ax, [bp+6]       
    sub  ax, [bp+4]       
    mov  [globalVar], ax
    pop  bp               
    ret 8            