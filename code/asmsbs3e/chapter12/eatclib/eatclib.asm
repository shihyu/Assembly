;  Source name     : EATCLIB.ASM
;  Executable name : EATCLIB
;  Version         : 2.0
;  Created date    : 10/1/1999
;  Last update     : 5/26/2009
;  Author          : Jeff Duntemann
;  Description     : Demonstrates calls made into clib, using NASM 2.05 
;	to send a short text string to stdout with puts().
;
;  Build using these commands:
;    nasm -f elf -g -F stabs eatclib.asm
;    gcc eatclib.o -o boiler

[SECTION .data]		; Section containing initialised data
	
EatMsg: db "Eat at Joe's!",0	
	
[SECTION .bss]		; Section containing uninitialized data
		
[SECTION .text]		; Section containing code
	
extern puts		; Simple "put string" routine from clib
global main		; Required so linker can find entry point
	
main:
        push ebp	; Set up stack frame for debugger
	mov ebp,esp
	push ebx	; Must preserve ebp, ebx, esi, & edi
	push esi
	push edi
;;; Everything before this is boilerplate; use it for all ordinary apps!
		
        push EatMsg	; Push address of message on the stack
	call puts	; Call clib function for displaying strings
        add esp,4	; Clean stack by adjusting ESP back 4 bytes

;;; Everything after this is boilerplate; use it for all ordinary apps!
	pop edi		; Restore saved registers
	pop esi
	pop ebx
	mov esp,ebp	; Destroy stack frame before returning
	pop ebp
	ret		; Return control to Linux