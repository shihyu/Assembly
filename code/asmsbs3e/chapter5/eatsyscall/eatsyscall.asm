;  Executable name : EATSYSCALL
;  Version         : 1.0
;  Created date    : 1/7/2009
;  Last update     : 2/18/2009
;  Author          : Jeff Duntemann
;  Description     : A simple program in assembly for Linux, using NASM 2.05,
;    demonstrating the use of Linux INT 80H syscalls to display text.
;
;  Build using these commands:
;    nasm -f elf -g -F stabs eatsyscall.asm
;    ld -o eatsyscall eatsyscall.o
;

SECTION .data			; Section containing initialised data
	
	EatMsg: db "Eat at Joe's!",10
	EatLen: equ $-EatMsg	
	
SECTION .bss			; Section containing uninitialized data	

SECTION .text			; Section containing code

global 	_start			; Linker needs this to find the entry point!
	
_start:
	nop			; This no-op keeps gdb happy...
	mov eax,4		; Specify sys_write call
	mov ebx,1		; Specify File Descriptor 1: Standard Output
	mov ecx,EatMsg		; Pass offset of the message
	mov edx,EatLen		; Pass the length of the message
	int 80H			; Make kernel call

	MOV eax,1		; Code for Exit Syscall
	mov ebx,0		; Return a code of zero	
	int 80H			; Make kernel call




























