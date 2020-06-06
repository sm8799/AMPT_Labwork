org 0x7c00
bits 16
	push  0xb800
	pop   es     		; Set ES to the Video Memory
	;; Clear screen
	mov ax, 0x1000    	; Clean screen blue background
	call  cls
	;; Print message
	call print
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
	mov   ah, 0x1e		; Text Color :)

.loop:
	mov ah, 10h
	int 16h
	mov ah, 0x1e
    stosw	    ; Stores AX (char + color)
	jmp   .loop ;print next character

.end:
	ret


msg   db "Hello World!"
times 510-($-$$) db 0 ; Make it a disk sector
;Begin MBR Signature
db 0x55 ;byte 511 = 0x55
db 0xAA ;byte 512 = 0xAA
