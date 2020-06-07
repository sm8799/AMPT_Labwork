bits 16
org 0x7c00

boot:

	mov ax, 0xB800
	mov es, ax
	mov ax, 0x1e00	
	xor   di,di
	mov   cx, 80*24		;Default console size
	repnz stosw
	mov ah, 0x00
	int 0x16
	mov ah, 0x1f
	mov si, msg_r
	xor   di, di
	.loop:
		lodsb           ;loads byte from si into al and increases si
		test  al, al    ;tests end of string
		jz    .end
		
		stosw	        ; Stores AX (char + color)
		jmp   .loop     ;print next character

	.end:

	    mov ah, 0x00
	    int 0x16

	    mov ax, 0x00
	    xor   di,di
        mov   cx, 80*24		;Default console size
        repnz stosw
	    
	    lgdt [gdt_pointer]      ; load the gdt table
	    mov eax, cr0 
	    or eax,0x1              ; set the protected mode bit on special CPU reg cr0
	    mov cr0, eax
	    jmp CODE_SEG:boot2      ; long jump to the code segment

gdt_start:
	dq 0x0

gdt_code:
	dw 0xFFFF
	dw 0x0
	db 0x0
	db 10011010b
	db 11001111b
	db 0x0

gdt_data:
	dw 0xFFFF
	dw 0x0
	db 0x0
	db 10010010b
	db 11001111b
	db 0x0

gdt_end:

gdt_pointer:
	dw gdt_end - gdt_start
	dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

bits 32
boot2:
	mov ax, DATA_SEG
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax
	mov ah, 0x1f
	mov esi,msg_p
	mov ebx,0xb8000

.loop1:
	lodsb
	or al,al
	jz halt
	or eax,0x0100
	mov [ebx], ax
	add ebx,2
	jmp .loop1


halt:
	cli
	mov ecx, 0x1fffffff
ag1:    
    dec ecx
	jnz ag1
	sti        
	hlt


	mov eax, cr0 
	and eax,0x7ffffffe      ; set the protected mode bit on special CPU reg cr0 PG and PE bit to be made 0
	mov cr0, eax
    jmp 0:boot	            ; Perform Far jump to set CS.

msg_p db "Protected Mode",0
msg_r   db "Real Mode", 0
times 510-($-$$) db 0
;Begin MBR Signature
db 0x55 ;byte 511 = 0x55
db 0xAA ;byte 512 = 0xAA

