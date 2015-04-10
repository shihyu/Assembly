;  Source name     : SHOWARGS3.ASM
;  Executable name : SHOWARGS3
;  Version         : 2.0
;  Created date    : 10/1/1999
;  Last update     : 12/28/2009
;  Author          : Jeff Duntemann
;  Description     : A demo that shows how to access command line arguments
;		      stored on the stack by addressing them relative to ebp.
;
;  Build using these commands:
;    nasm -f elf -g -F stabs showargs3.asm
;    gcc showargs3.o -o showargs3
;

[SECTION .data]			; Section containing initialised data
		
ArgMsg	db "Argument %d: %s",10,0
		
[SECTION .bss]			; Section containing uninitialized data
	
		
[SECTION .text]			; Section containing code
					
global main			; Required so linker can find entry point
extern printf			; Notify linker that we're calling printf
		
main:
        push ebp	; Set up stack frame for debugger
	mov ebp,esp
	push ebx	; Program must preserve ebp, ebx, esi, & edi
	push esi
	push edi
;;; Everything before this is boilerplate; use it for all ordinary apps!	

	mov edi,[ebp+8]	 ; Load argument count into EDI
	mov ebx,[ebp+12] ; Load pointer to argument table into EBX
	xor esi,esi	 ; Clear ESI to 0
.showit:
	push dword [ebx+esi*4]	; Push addr. of an argument on the stack
	push esi	; Push argument number
	push ArgMsg	; Push address of display string
	call printf	; Display the argument # and argument
	add esp,12 	; Stack cleanup: 3 parms x 4 bytes = 12
	inc esi		; Bump argument # to next argument
	dec edi		; Decrement argument counter by 1
	jnz .showit	; If argument count is 0, we're done
	
;;; Everything after this is boilerplate; use it for all ordinary apps!
	pop edi		; Restore saved registers
	pop esi
	pop ebx
	mov esp,ebp	; Destroy stack frame before returning
	pop ebp
	ret		; Return control to Linux
