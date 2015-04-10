;  Executable name : SHOWENV2
;  Version         : 1.0
;  Created date    : 5/21/2009
;  Last update     : 5/21/2009
;  Author          : Jeff Duntemann
;  Description     : A simple program in assembly for Linux, using NASM 2.05,
;    demonstrating the way to access Linux environment variables on the stack.
;    This version accesses the stack "nondestructively" by using memory
;    references rather than POP instructions.
;
;  Build using these commands:
;    nasm -f elf -g -F stabs showenv2.asm
;    ld -o showenv2 showenv2.o
;

SECTION .data			; Section containing initialised data

	ErrMsg db "Terminated with error.",10
	ERRLEN equ $-ErrMsg
	
SECTION .bss			; Section containing uninitialized data	
	MAXVARS	 equ 300
	VarLens: resd MAXVARS	; Table of argument lengths

SECTION .text			; Section containing code

global 	_start			; Linker needs this to find the entry point!
	
_start:
	nop			; This no-op keeps gdb happy...

	mov ebp,esp		; Save the initial stack pointer in EBP
	xor eax,eax		; Searching for 0, so clear EAX to 0
FindEnv:
	mov ecx,0000ffffh	; Limit search to 65535 bytes max
	mov edi,ebp 		; Put address of string to search in EDI
	mov edx,edi		; Copy starting address into EDX                                                                                                                                                                                                                                                                                                             
	cld			; Set search direction to up-memory
	repne scasd		; Search for null ptr in string at edi
	jnz Error		; REPNE SCASB ended without finding AL
	mov ebp,edi		; Env var addrs begin after null ptr
	xor ebx,ebx		; Zero EBX for use as addr counter

; We now have the address of the first env var address in EBP. Now we scan
; through them and determine their lengths:
ScanOne:
	mov ecx,0000ffffh	; Limit search to 65535 bytes max
	mov edi,dword [ebp+ebx*4] ; Put address of string to search in EDI
	cmp edi,0		; See if we hit the second null ptr
	je Showem		; If so, we've scanned em all, so show 'em
	mov edx,edi		; Copy starting address into EDX                                                                                                                                                                                                                                                                                                             
	cld			; Set search direction to up-memory
	repne scasb		; Search for null (0 char) in string at edi
	jnz Error		; REPNE SCASB ended without finding AL
	mov byte [edi-1],10	; Store an EOL where the null used to be
	sub edi,edx		; Subtract position of 0 from start address
	mov dword [VarLens+ebx*4],edi	; Put length of var into table
	inc ebx			; Add 1 to environment variable counter
	jmp ScanOne		; If not, loop back and do another one

; Display all environment variables to stdout:
	xor esi,esi		; Start (argumentsfor table addressing reasons) at 0
Showem:
	mov ecx,[ebp+esi*4]	; Pass offset of the environment var
	mov eax,4		; Specify sys_write call
	mov ebx,1		; Specify File Descriptor 1: Standard Output
	mov edx,[VarLens+esi*4]	; Pass the length of the message
	int 80H			; Make kernel call
	inc esi			; Increment the env var counter
	cmp dword [ebp+esi*4],0	; See if we've displayed all the variables
	jne Showem		; If not, loop back and do another
	jmp Exit		; We're done! Let's pack it in!

Error: 	mov eax,4		; Specify sys_write call
	mov ebx,1		; Specify File Descriptor 2: Standard Error
	mov ecx,ErrMsg		; Pass offset of the error message
	mov edx,ERRLEN		; Pass the length of the message
	int 80H			; Make kernel call

Exit:	mov eax,1		; Code for Exit Syscall
	mov ebx,0		; Return a code of zero	
	int 80H			; Make kernel call