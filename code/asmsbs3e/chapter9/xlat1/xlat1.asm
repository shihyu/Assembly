;  Executable name : XLAT1
;  Version         : 1.0
;  Created date    : 2/11/2009
;  Last update     : 2/11/2009
;  Author          : Jeff Duntemann
;  Description     : A simple program in assembly for Linux, using NASM 2.05,
;    demonstrating the use of the XLAT instruction to alter text streams.
;
;  Build using these commands:
;    nasm -f elf -g -F stabs xlat1.asm
;    ld -o xlat1 xlat1.o
;

SECTION .data			; Section containing initialised data
	
	StatMsg: db "Processing...",10
	StatLen: equ $-StatMsg
	DoneMsg: db "...done!",10
	DoneLen: equ $-DoneMsg
	
; The following translation table translates all lowercase characters to
; uppercase. It also translates all non-printable characters to spaces,
; except for LF and HT.
	UpCase: 
	db 20h,20h,20h,20h,20h,20h,20h,20h,20h,09h,0Ah,20h,20h,20h,20h,20h
	db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
	db 20h,21h,22h,23h,24h,25h,26h,27h,28h,29h,2Ah,2Bh,2Ch,2Dh,2Eh,2Fh
	db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,3Ah,3Bh,3Ch,3Dh,3Eh,3Fh
	db 40h,41h,42h,43h,44h,45h,46h,47h,48h,49h,4Ah,4Bh,4Ch,4Dh,4Eh,4Fh
	db 50h,51h,52h,53h,54h,55h,56h,57h,58h,59h,5Ah,5Bh,5Ch,5Dh,5Eh,5Fh
	db 60h,41h,42h,43h,44h,45h,46h,47h,48h,49h,4Ah,4Bh,4Ch,4Dh,4Eh,4Fh
	db 50h,51h,52h,53h,54h,55h,56h,57h,58h,59h,5Ah,7Bh,7Ch,7Dh,7Eh,20h
	db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
	db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
	db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
	db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
	db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
	db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
	db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
	db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h

; The following translation table is "stock" in that it translates all
; printable characters as themselves, and converts all non-printable
; characters to spaces except for LF and HT. You can modify this to
; translate anything you want to any character you want.
	Custom: 
	db 20h,20h,20h,20h,20h,20h,20h,20h,20h,09h,0Ah,20h,20h,20h,20h,20h
	db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
	db 20h,21h,22h,23h,24h,25h,26h,27h,28h,29h,2Ah,2Bh,2Ch,2Dh,2Eh,2Fh
	db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,3Ah,3Bh,3Ch,3Dh,3Eh,3Fh
	db 40h,41h,42h,43h,44h,45h,46h,47h,48h,49h,4Ah,4Bh,4Ch,4Dh,4Eh,4Fh
	db 50h,51h,52h,53h,54h,55h,56h,57h,58h,59h,5Ah,5Bh,5Ch,5Dh,5Eh,5Fh
	db 60h,61h,62h,63h,64h,65h,66h,67h,68h,69h,6Ah,6Bh,6Ch,6Dh,6Eh,6Fh
	db 70h,71h,72h,73h,74h,75h,76h,77h,78h,79h,7Ah,7Bh,7Ch,7Dh,7Eh,20h
	db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
	db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
	db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
	db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
	db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
	db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
	db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h
	db 20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h,20h

SECTION .bss			; Section containing uninitialized data

	READLEN	    equ 1024		; Length of buffer
	ReadBuffer: resb READLEN	; Text buffer itself
	
SECTION .text			; Section containing code

global 	_start			; Linker needs this to find the entry point!
	
_start:
	nop			; This no-op keeps gdb happy...

; Display the "I'm working..." message via stderr:
	mov eax,4		; Specify sys_write call
	mov ebx,2		; Specify File Descriptor 2: Standard error
	mov ecx,StatMsg		; Pass offset of the message
	mov edx,StatLen		; Pass the length of the message
	int 80h			; Make kernel call

; Read a buffer full of text from stdin:
read:
	mov eax,3		; Specify sys_read call
	mov ebx,0		; Specify File Descriptor 0: Standard Input
	mov ecx,ReadBuffer	; Pass offset of the buffer to read to
	mov edx,READLEN		; Pass number of bytes to read at one pass
	int 80h
	mov ebp,eax		; Copy sys_read return value for safekeeping
	cmp eax,0		; If eax=0, sys_read reached EOF
	je done			; Jump If Equal (to 0, from compare)

; Set up the registers for the translate step:
	mov ebx,UpCase		; Place the offset of the table into ebx
	mov edx,ReadBuffer	; Place the offset of the buffer into edx
	mov ecx,ebp		; Place the number of bytes in the buffer into ecx

; Use the xlat instruction to translate the data in the buffer:
; (Note: the commented out instructions do the same work as XLAT; un-comment
; them and then comment out xlat to try it!
translate:
;	xor eax,eax		; Clear high 24 bits of eax
	mov al,byte [edx+ecx]	; Load character into AL for translation
;	mov al,byte [UpCase+eax] ; Translate character in AL via table
	xlat			; Translate character in AL via table
	mov byte [edx+ecx],al	; Put the translated character back in the buffer
	dec ecx			; Decrement character count
	jnz translate		; If there are more chars in the buffer, repeat

; Write the buffer full of translated text to stdout:
write:
	mov eax,4		; Specify sys_write call
	mov ebx,1		; Specify File Descriptor 1: Standard output
	mov ecx,ReadBuffer	; Pass offset of the buffer
	mov edx,ebp		; Pass the # of bytes of data in the buffer
	int 80h			; Make kernel call
	jmp read		; Loop back and load another buffer full

; Display the "I'm done" message via stderr:
done:	
	mov eax,4		; Specify sys_write call
	mov ebx,2		; Specify File Descriptor 2: Standard error
	mov ecx,DoneMsg		; Pass offset of the message
	mov edx,DoneLen		; Pass the length of the message
	int 80h			; Make kernel call

; All done! Let's end this party:
	mov eax,1		; Code for Exit Syscall
	mov ebx,0		; Return a code of zero	
	int 80H			; Make kernel call
