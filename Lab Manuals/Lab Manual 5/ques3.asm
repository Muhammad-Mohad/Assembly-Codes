[org 0x0100]
		
			mov ax, 0xb800 					
			mov es, ax 				
			mov di, 0 	
								

firstportion: 	
		mov word [es:di], 0x075F 			
		add di, 2 						
		cmp di, 2240 					
		jne firstportion 
secondportion: 	
		mov word [es:di], 0x072E 			
		add di, 2 						
		cmp di, 4000 					
		jne secondportion 		
	

mov ax, 0x4c00 
int 0x21 