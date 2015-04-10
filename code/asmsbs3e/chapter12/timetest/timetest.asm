;  Source name     : TIMETEST.ASM
;  Executable name : TIMETEST
;  Version         : 2.0
;  Created date    : 12/2/1999
;  Last update     : 5/26/2009
;  Author          : Jeff Duntemann
;  Description     : A demo of time-related functions for Linux, using
;	NASM 2.05
;
;  Build using these commands:
;    nasm -f elf -g -F stabs timetest.asm
;    gcc timetest.o -o timetest
;

[SECTION .data]			; Section containing initialised data

TimeMsg  db "Hey, what time is it?  It's %s",10,0
YrMsg	 db "The year is %d.",10,0
Elapsed  db "A total of %d seconds has elapsed since program began running.",10,0	
	
[SECTION .bss]			; Section containing uninitialized data

OldTime	 resd 1			; Reserve 3 integers (doubles) for time values
NewTime  resd 1
TimeDiff resd 1	
TimeStr  resb 40		; Reserve 40 bytes for time string
TmCopy	 resd 9			; Reserve 9 integer fields for time struct tm			
[SECTION .text]			; Section containing code

extern ctime
extern difftime
extern getchar
extern printf
extern localtime	
extern strftime	
extern time
									
global main			; Required so linker can find entry point
	
main:
        push ebp		; Set up stack frame for debugger
	mov ebp,esp
	push ebx		; Program must preserve EBP, EBX, ESI, & EDI
	push esi
	push edi
;;; Everything before this is boilerplate; use it for all ordinary apps!	

; Generate a time_t calendar time value with clib's time function
	push 0			; Push a 32-bit null pointer to stack,
				;   since we don't need a buffer.
	call time		; Returns calendar time in EAX
	add esp,4		; Clean up stack after call
	mov [OldTime],eax	; Save time value in memory variable

; Generate a string summary of local time with clib's ctime function
	push OldTime		; Push address of calendar time value
	call ctime		; Returns pointer to ASCII time string in EAX
        add esp,4		; Stack cleanup for 1 parm

	push eax		; Push pointer to ASCII time string on stack
	push TimeMsg		; Push pointer to base message text string
	call printf		; Merge and display the two strings
	add esp,8		; Stack cleanup: 2 parms X 4 bytes = 8

; Generate local time values into clib's static tm struct
	push dword OldTime	; Push address of calendar time value
	call localtime		; Returns pointer to static time structure in EAX
	add esp,4		; Stack cleanup for 1 parm

; Make a local copy of clib's static tm struct
	mov esi,eax		; Copy address of static tm from eax to ESI
	mov edi,TmCopy		; Put the address of the local tm copy in EDI
	mov ecx,9		; A tm struct is 9 dwords in size under Linux
	cld			; Clear DF so we move up-memory
	rep movsd		; Copy static tm struct to local copy

; Display one of the fields in the tm structure
	mov edx,dword [TmCopy+20] ; Year field is 20 bytes offset into tm
	add edx,1900		; Year field is # of years since 1900
	push edx		; Push value onto the stack
	push YrMsg		; Push address of the base string
	call printf		; Display string and year value with printf
	add esp,8		; Stack cleanup: 2 parms X 4 bytes = 8
		
; Wait a few seconds for user to press Enter so we have a time difference:
	call getchar		; Wait for user to press Enter
	
; Calculating seconds passed since program began running:
	push dword 0		; Push null ptr; we'll take value in EAX
	call time		; Get current time value; return in EAX
	add esp,4		; Clean up the stack	
	mov [NewTime],eax	; Save new time value
	
	sub eax,[OldTime]	; Calculate time difference value
	mov [TimeDiff],eax	; Save time difference value
	
	push dword [TimeDiff]	; Push difference in seconds onto the stack
	push Elapsed		; Push addr. of elapsed time message string
	call printf		; Display elapsed time
	add esp,8		; Stack cleanup for 1 parm	
			
;;; Everything after this is boilerplate; use it for all ordinary apps!
	pop edi			; Restore saved registers
	pop esi
	pop ebx
	mov esp,ebp		; Destroy stack frame before returning
	pop ebp
	ret			; Return control to Linux
