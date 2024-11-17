[org 0x0100]
jmp start

message: db 'hello world' 
length: dw 11 

delay:
	push bp
	mov bp,sp
	push cx
	mov cx,0xffff
	delay1:
		loop delay1
		pop cx
		pop bp
	ret
			
clrscr:		push es
			push ax
			push di

			mov ax, 0xb800
			mov es, ax					; point es to video base
			mov di, 0					; point di to top left column

nextloc:	mov word [es:di], 0x0720	; clear next char on screen
			add di, 2					; move to next screen location
			cmp di, 4000				; has the whole screen cleared
			jne nextloc					; if no clear next position

			pop di
			pop ax
			pop es
			ret

printstr:	push bp
			mov bp, sp
			push es
			push ax
			push cx
			push si
			push di

			mov ax, 0xb800
			mov es, ax				; point es to video base
			mov di, [bp+4]				; point di to top left column
									; es:di --> b800:0000
			mov si, [bp+8]			; point si to string
			mov cx, [bp+6]			; load length of string in cx
			mov ah, 0x07			; normal attribute fixed in al
			
nextchar:	mov al, [si]			; load next char of string
			mov [es:di], ax			; show this char on screen
			add di, 2				; move to next screen location
			add si, 1				; move to next char in string			
			loop nextchar			; repeat the operation cx times
			
			pop di
			pop si
			pop cx
			pop ax
			pop es
			pop bp
			ret 4
			
scrollup:	push bp
			mov bp,sp
			push ax
			push cx
			push si
			push di
			push es
			push ds

			mov ax, 80 ; load chars per row in ax
			mul byte [bp+4] ; calculate source position
			mov si, ax ; load source position in si
			push si ; save position for later use
			shl si, 1 ; convert to byte offset

			mov cx, 2000 ; number of screen locations
			sub cx, ax ; count of words to move

			mov ax, 0xb800
			mov es, ax ; point es to video base
			mov ds, ax ; point ds to video base
		
			xor di, di ; point di to top left column
			cld ; set auto increment mode
			rep movsw ; scroll up
			;[es:di] = [ds:si]

			mov ax, 0x0720 ; space in normal attribute
			pop cx ; count of positions to clear
			rep stosw ; clear the scrolled space
		
			pop ds
			pop es
			pop di
			pop si
			pop cx
			pop ax
			pop bp
			ret 2	


scrolldown:	push bp
			mov bp,sp
			push ax
			push cx
			push si
			push di
			push es
			push ds

			mov ax, 80 ; load chars per row in ax
			mul byte [bp+4] ; calculate source position
			push ax ; save position for later use
			shl ax, 1 ; convert to byte offset
			
			mov si, 3998 ; last location on the screen
			sub si, ax ; load source position in si
			
			mov cx, 4000 ; number of screen locations
			sub cx, ax ; count of words to move
			shr ax,1

			mov ax, 0xb800
			mov es, ax ; point es to video base
			mov ds, ax ; point ds to video base
			mov di, 3998 ; point di to lower right column

			std ; set auto decrement mode
			rep movsw ; scroll up
			
			mov ax, 0x0720 ; space in normal attribute
			pop cx ; count of positions to clear
			mov di,cx						
			rep stosw ; clear the scrolled space

			pop ds
			pop es
			pop di
			pop si
			pop cx
			pop ax
			pop bp
			ret 2
infinite:
start:	call clrscr

		mov ax, message
		
		push ax					
		push word [length]		
		push 60               
		call printstr			
		
		push ax
		push word [length]
		push 220
		call printstr
		
		push ax
		push word [length]
		push 380
		call printstr
		
		push ax
		push word [length]
		push 540
		call printstr
		
		push ax
		push word [length]
		push 700
		call printstr
		
		push ax
		push word [length]
		push 3260
		call printstr
		
		push ax
		push word [length]
		push 3420
		call printstr
		
		push ax
		push word [length]
		push 3580
		call printstr
		
		push ax
		push word [length]
		push 3740
		call printstr
		
		push ax
		push word [length]
		push 3900
		call printstr
		
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay

		mov cx, 3
		cmp cx, 3
		je cont1
		cmp cx, 2
		je cont2
		cmp cx, 1
		je cont3

cont1:
		call clrscr
		mov ax, message
		

		push ax
		push word [length]
		push 540
		call printstr
		
		push ax
		push word [length]
		push 380
		call printstr
		
		push ax
		push word [length]
		push 220
		call printstr
		
		push ax
		push word [length]
		push 60
		call printstr
		
		push ax
		push word [length]
		push 3100
		call printstr
		
		push ax
		push word [length]
		push 3260
		call printstr
		
		push ax
		push word [length]
		push 3420
		call printstr
		
		push ax
		push word [length]
		push 3580
		call printstr
		
		push ax
		push word [length]
		push 3740
		call printstr
		
		push ax
		push word [length]
		push 3900
		call printstr
		
		dec cx
		
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		
cont2:
		call clrscr
		mov ax, message
		
		push ax
		push word [length]
		push 380
		call printstr
		
		push ax
		push word [length]
		push 220
		call printstr
		
		push ax
		push word [length]
		push 60
		call printstr
		
		push ax
		push word [length]
		push 2940
		call printstr
		
		push ax
		push word [length]
		push 3100
		call printstr
		
		push ax
		push word [length]
		push 3260
		call printstr
		
		push ax
		push word [length]
		push 3420
		call printstr
		
		push ax
		push word [length]
		push 3580
		call printstr
		
		push ax
		push word [length]
		push 3740
		call printstr
		
		push ax
		push word [length]
		push 3900
		call printstr
		
		dec cx
		
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		
cont3:
		call clrscr
		mov ax, message
		
		push ax					
		push word [length]		
		push 60               
		call printstr			
		
		push ax
		push word [length]
		push 220
		call printstr
		
		push ax
		push word [length]
		push 3260
		call printstr
		
		push ax
		push word [length]
		push 2940
		call printstr
		
		push ax
		push word [length]
		push 3100
		call printstr
		
		push ax
		push word [length]
		push 2780
		call printstr
		
		push ax
		push word [length]
		push 3420
		call printstr
		
		push ax
		push word [length]
		push 3580
		call printstr
		
		push ax
		push word [length]
		push 3740
		call printstr
		
		push ax
		push word [length]
		push 3900
		call printstr
		
		dec cx
		
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay

	
scrollDown:
	mov cx, 3
	cmp cx, 3
	je scroll1
	cmp cx, 2
	je scroll2
	cmp cx, 1
	je scroll3
	
scroll1:
		call clrscr

		mov ax, message
		
		push ax					
		push word [length]		
		push 60               
		call printstr			
		
		push ax
		push word [length]
		push 220
		call printstr
		
		push ax
		push word [length]
		push 380
		call printstr
		
		push ax
		push word [length]
		push 3260
		call printstr
		
		push ax
		push word [length]
		push 3420
		call printstr
		
		push ax
		push word [length]
		push 3580
		call printstr

		push ax
		push word [length]
		push 3740
		call printstr

		push ax
		push word [length]
		push 3900
		call printstr
		
		push ax
		push word [length]
		push 3100
		call printstr
		
		push ax
		push word [length]
		push 2940
		call printstr
		
		dec cx
		
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
	
scroll2:
		call clrscr

		mov ax, message
		
		push ax					
		push word [length]		
		push 60               
		call printstr			
		
		push ax
		push word [length]
		push 220
		call printstr
		
		push ax
		push word [length]
		push 380
		call printstr
		
		push ax
		push word [length]
		push 540
		call printstr
		
		push ax
		push word [length]
		push 3100
		call printstr
		
		push ax
		push word [length]
		push 3260
		call printstr
		
		push ax
		push word [length]
		push 3420
		call printstr
		
		push ax
		push word [length]
		push 3580
		call printstr
		
		push ax
		push word [length]
		push 3740
		call printstr
		
		push ax
		push word [length]
		push 3900
		call printstr
		
		dec cx
		
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		call delay
		
scroll3:
		call clrscr

		mov ax, message
		
		push ax					
		push word [length]		
		push 60               
		call printstr			
		
		push ax
		push word [length]
		push 220
		call printstr
		
		push ax
		push word [length]
		push 380
		call printstr
		
		push ax
		push word [length]
		push 540
		call printstr
		
		push ax
		push word [length]
		push 700
		call printstr
		
		push ax
		push word [length]
		push 3260
		call printstr
		
		push ax
		push word [length]
		push 3420
		call printstr
		
		push ax
		push word [length]
		push 3580
		call printstr
		
		push ax
		push word [length]
		push 3740
		call printstr
		
		push ax
		push word [length]
		push 3900
		call printstr
		
		push ax
		push word [length]
		push 3100
		call printstr
		
		dec cx
		
		jmp infinite
		
mov ax, 0x4c00
int 0x21