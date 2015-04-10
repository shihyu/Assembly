;  Executable name : SHOWARGS1
;  Version         : 1.0
;  Created date    : 4/17/2009
;  Last update     : 5/19/2009
;  Author          : Jeff Duntemann
;  Description     : A simple program in assembly for Linux, using NASM 2.05,
;    demonstrating the way to access command line arguments on the stack.
;
;  Build using these commands:
;    nasm -f elf -g -F stabs showargs1.asm
;    ld -o showargs1 showargs1.o
;

SECTION .data			; Section containing initialised data

	ErrMsg db "Terminated with error.",10
	ERRLEN equ $-ErrMsg
	
SECTION .bss			; Section containing uninitialized data	

; This program handles up to MAXARGS command-line arguments. Change the
; value of MAXARGS if you need to handle more arguments than the default 10.
; In essence we store pointers to the arguments in a 0-based array, with the
; first arg pointer at array element 0, the second at array element 1, etc.
; Ditto the arg lengths. Access the args and their lengths this way:
; 	Arg strings: 		[ArgPtrs + <index reg>*4]
;	Arg string lengths:	[ArgLens + <index reg>*4]
; Note that when the argument lengths are calculated, an EOL char (10h) is
; stored into each string where the terminating null was originally. This
; makes it easy to print out an argument using sys_write. This is not
; essential, and if you prefer to retain the 0-termination in the arguments, 
; you can comment out those lines as indicated.

	MAXARGS   equ  10	; Maximum # of args we support
	ArgCount: resd 1	; # of arguments passed to program
	ArgPtrs:  resd MAXARGS	; Table of pointers to arguments
	ArgLens:  resd MAXARGS	; Table of argument lengths

SECTION .text			; Section containing code

global 	_start			; Linker needs this to find the entry point!
	
_start:
	nop			; This no-op keeps gdb happy...

; Get the command line argument count off the stack and validate it:
	pop ecx 		; TOS contains the argument count
	cmp ecx,MAXARGS		; See if the arg count exceeds MAXARGS
	ja Error		; If so, exit with an error message
	mov dword [ArgCount],ecx ; Save arg count in memory variable

; Once we know how many args we have, a loop will pop them into ArgPtrs:
	xor edx,edx		; Zero a loop counter
SaveArgs:
	pop dword [ArgPtrs + edx*4]  ; Pop an arg into the memory table
	inc edx			; Bump the counter to the next argument
	cmp edx,ecx		; Is the counter = the argumemt count?
	jb SaveArgs		; If not, loop back and do another

; With the argument pointers stored in ArgPtrs, we calculate their lengths:
	xor eax,eax		; Searching for 0, so clear AL to 0
	xor ebx,ebx		; Pointer table offset starts at 0
ScanOne:
	mov ecx,0000ffffh	; Limit search to 65535 bytes max
	mov edi,dword [ArgPtrs+ebx*4] ; Put address of string to search in EDI
	mov edx,edi		; Copy starting address into EDX                                                                                                                                                                                                                                                                                                             
	cld			; Set search direction to up-memory
	repne scasb		; Search for null (0 char) in string at edi
; Comment out the following line if you need mull-terminated arguments:
	mov byte [edi-1],10	; Store an EOL where the null used to be
	sub edi,edx		; Subtract position of 0 from start address
	mov dword [ArgLens+ebx*4],edi	; Put length of arg into table
	inc ebx			; Add 1 to argument counter
	cmp ebx,[ArgCount]	; See if arg counter exceeds argument count
	jb ScanOne		; If not, loop back and do another one

; Display all arguments to stdout:
	xor esi,esi		; Start (for table addressing reasons) at 0
Showem:
	mov ecx,[ArgPtrs+esi*4]	; Pass offset of the message
	mov eax,4		; Specify sys_write call
	mov ebx,1		; Specify File Descriptor 1: Standard Output
	mov edx,[ArgLens+esi*4]	; Pass the length of the message
	int 80H			; Make kernel call
	inc esi			; Increment the argument counter
	cmp esi,[ArgCount]	; See if we've displayed all the arguments
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