[org 0x0100]
jmp start

multiplicand: dq 0xD0004565
multiplier: dq 0xF0005678
result: dq 0

start: 
mov cl, 32
mov eax, [multiplier]   
mov ebx, [multiplicand]  
mov edx, [multiplicand+4]  
xor edi, edi               

checkbit:
test eax, 1                
jz skip                  

add edi, ebx            
adc dword [result+4], edx  

skip:
shl ebx, 1                
rcl edx, 1                 
shr eax, 1                  
dec cl                      
jnz checkbit             


mov [result], edi           
mov [result+4], edx        

mov ax, 0x4C00
int 0x21