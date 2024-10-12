[org 0x0100]

	jmp start
	num1: dw -5,-4,3,2,-1
	start:
		mov si, 0
	outerloop:
		mov di, si
		add di, 2
	innerloop:
		mov ax, [num1+si]
		cmp ax, [num1+di]
		jl noswap
		mov dx, [num1+di]
		mov [num1+si], dx
		mov [num1+di], ax
	noswap:
		add di, 2
		cmp di, 10
	jb innerloop
		add si,2
		cmp si, 8
	jb outerloop

mov ax, 0x4c00
int 0x21