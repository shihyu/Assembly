;  Executable name : SHOWARGS2
;  Version         : 1.0
;  Created date    : 5/11/2009
;  Last update     : 5/21/2009
;  Author          : Jeff Duntemann
;  Description     : A simple program in assembly for Linux, using NASM 2.05,
;    demonstrating the way to access command line arguments on the stack.
;    This version accesses the stack "nondestructively" by using memory
;    references rather than POP instructions.
;
;  Build using these commands:
;    nasm -f elf -g -F stabs showargs2.asm
;    ld -o showargs2 showargs2.o
;

SECTION .data			; Section containing initialised data

	ErrMsg db "Terminated with error.",10
	ERRLEN equ $-ErrMsg
	
SECTION .bss			; Section containing uninitialized data	

; This program handles up to MAXARGS command-line arguments. Change the
; value of MAXARGS if you need to handle more arguments than the default 10.
; Argument lengths are stored in a table. Access arg lengths this way:
;	[ArgLens + <index reg>*4]
; Note that when the argument lengths are calculated, an EOL char (10h) is
; stored into each string where the terminating null was originally. This
; makes it easy to print out an argument using sys_write. 

	MAXARGS   equ  10	; Maximum # of args we support
	ArgLens:  resd MAXARGS	; Table of argument lengths

SECTION .text			; Section containing code

global 	_start			; Linker needs this to find the entry point!
	
_start:
	nop			; This no-op keeps gdb happy...

	mov ebp,esp		; Save the initial stack pointer in EBP
; Copy the command line argument count from the stack and validate it:
	cmp dword [ebp],MAXARGS	; See if the arg count exceeds MAXARGS
	ja Error		; If so, exit with an error message

; Here we calculate argument lengths and store lengths in table ArgLens:
	xor eax,eax		; Searching for 0, so clear AL to 0
	xor ebx,ebx		; Stack address offset starts at 0
ScanOne:
	mov ecx,0000ffffh	; Limit search to 65535 bytes max
	mov edi,dword [ebp+4+ebx*4] ; Put address of string to search in EDI
	mov edx,edi		; Copy starting address into EDX                                                                                                                                                                                                                                                                                                             
	cld			; Set search direction to up-memory
	repne scasb		; Search for null (0 char) in string at edi
	jnz Error		; REPNE SCASB ended without finding AL
	mov byte [edi-1],10	; Store an EOL where the null used to be
	sub edi,edx		; Subtract position of 0 from start address
	mov dword [ArgLens+ebx*4],edi	; Put length of arg into table
	inc ebx			; Add 1 to argument counter
	cmp ebx,[ebp]		; See if arg counter exceeds argument count
	jb ScanOne		; If not, loop back and do another one

; Display all arguments to stdout:
	xor esi,esi		; Start (for table addressing reasons) at 0
Showem:
	mov ecx,[ebp+4+esi*4]	; Pass offset of the message
	mov eax,4		; Specify sys_write call
	mov ebx,1		; Specify File Descriptor 1: Standard Output
	mov edx,[ArgLens+esi*4]	; Pass the length of the message
	int 80H			; Make kernel call
	inc esi			; Increment the argument counter
	cmp esi,[ebp]	; See if we've displayed all the arguments
	jb Showem		; If not, loop back and do another
	jmp Exit		; We're done! Let's pack it in!

Error: 	mov eax,4		; Specify sys_write call
	mov ebx,1		; Specify File Descriptor 2: Standard Error
	mov ecx,ErrMsg		; Pass offset of the error message
	mov edx,ERRLEN		; Pass the length of the message
	int 80H			; Make kernel call

Exit:	mov eax,1		; Code for Exit Syscall
	mov ebx,0		; Return a code of zero	
	int 80H			; Make kernel call