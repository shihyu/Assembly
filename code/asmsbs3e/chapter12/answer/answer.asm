;  Source name     : ANSWER.ASM
;  Executable name : ANSWER
;  Version         : 2.0
;  Created date    : 11/1/1999
;  Last update     : 5/27/2009
;  Author          : Jeff Duntemann
;  Description     : A demonstration of how to call printf from assembly,
;    using NASM 2.05
;
;  Build using these commands:
;    nasm -f elf -g -F stabs answer.asm
;    gcc answer.o -o answer
;

[SECTION .data]			; Section containing initialised data
		
AnswerMsg  	db "The answer is %d, and don't you forget it!",10,0
MathMsg		db "%d + %d = %d ...for large values of %d.",10,0
MammalMsg	db "Does the set of %s contain the set of %s?",10,0
Mammals		db "mammals",0
Dugongs		db "dugongs",0
	
[SECTION .bss]		; Section containing uninitialized data			

[SECTION .text]		; Section containing code

extern printf						
global main		; Required so linker can find entry point
	
main:
        push ebp	; Set up stack frame for debugger
	mov ebp,esp
	push ebx	; Program must preserve ebp, ebx, esi, & edi
	push esi
	push edi
;;; Everything before this is boilerplate; use it for all ordinary apps!

; This call merges a single binary numeric value with the base string:
	push 42		; Push number to display onto the stack
	push AnswerMsg	; Push long pointer to message string
	call printf	; Call printf to display message & number
	add esp,8	; Clean up stack after call

; Here we merge several binary numeric values with the base string:
	push 2		; Push rightmost parameter
	push 5		; Push next parameter to the left
	push 2		; Push next parameter to the left
	push 2		; Push leftmost parameter
	push MathMsg	; Push address of base string
	call printf	; Call printf() to display the works
	add esp,20	; Stack cleanup: 5 parms X 4 bytes = 20

; Here we merge two substrings into the base string:
	push Dugongs	; Push rightmost parameter
	push Mammals	; Push next parameter to the left
	push MammalMsg	; Push address of base string
	call printf	; Call printf() to display it all
	add esp,12	; Stack cleanup: 3 parms x 4 bytes = 12

;;; Everything after this is boilerplate; use it for all ordinary apps!
	pop edi		; Restore saved registers
	pop esi
	pop ebx
	mov esp,ebp	; Destroy stack frame before returning
	pop ebp
	ret		; Return control to Linux

