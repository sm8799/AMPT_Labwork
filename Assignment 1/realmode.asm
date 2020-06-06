SECTION .text

GLOBAL _start 
_start:

org 0x8000
bits 16
	push  0xb800
	pop   es     		; Set ES to the Video Memory
	;; Clear screen
	mov ax, 0x0000    	; Clean screen blue background
	call  cls
	;; Print message
	call  print
	;; Done!
	jmp $   ; this freezes the system, best for testing
	hlt	;this makes a real system halt
	ret     ;this makes qemu halt, to ensure everything works we add both

cls:
	xor   di,di
	mov   cx, 80*24		;Default console size
	repnz stosw
	ret

print:
	xor   di, di
	add di, 80
.loop:
	mov ah, 10H
	int 16H ; take first character
	mov bl, al
	mov ah, 10H ; take second character
	int 16H
        cmp al, bl ; compare both character
	jz .end
	jmp   .loop ; print next character

.end:
	mov si,msg
	mov ah, 0x1e
	.loop2:
		lodsb
		test al, al
		jz .ext
		stosw
		jmp .loop2
.ext:
	ret
		

SECTION .DATA	
	msg db "Hello world in Real Mode$"
times 512-($-$$) db 0 ; Make it a disk sector



