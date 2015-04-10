;  Executable name : hexdump3
;  Version         : 1.0
;  Created date    : 4/15/2009
;  Last update     : 4/20/2009
;  Author          : Jeff Duntemann
;  Description     : A simple hex dump utility demonstrating the use of
;			separately assembled code libraries via EXTERN
;
;  Build using these commands:
;    nasm -f elf -g -F stabs hexdump3.asm
;    ld -o hexdump3 hexdump3.o <path>/textlib.o
;
SECTION .bss			; Section containing uninitialized data
	BUFFLEN EQU 10
	Buff:	resb BUFFLEN

SECTION .data			; Section containing initialised data
		
SECTION .text			; Section containing code

EXTERN ClearLine, DumpChar, PrintLine, DUMPLEN

GLOBAL _start

_start:
	nop			; This no-op keeps gdb happy...
	nop
	xor esi,esi		; Clear total chars counter to 0

; Read a buffer full of text from stdin:
Read:
	mov eax,3		; Specify sys_read call
	mov ebx,0		; Specify File Descriptor 0: Standard Input
	mov ecx,Buff		; Pass offset of the buffer to read to
	mov edx,BUFFLEN		; Pass number of bytes to read at one pass
	int 80h			; Call sys_read to fill the buffer
	mov ebp,eax		; Save # of bytes read from file for later
	cmp eax,0		; If eax=0, sys_read reached EOF on stdin
	je Done			; Jump If Equal (to 0, from compare)

; Set up the registers for the process buffer step:
	xor ecx,ecx		; Clear buffer pointer to 0

; Go through the buffer and convert binary values to hex digits:
Scan:
	xor eax,eax		; Clear EAX to 0
	mov al,byte[Buff+ecx]	; Get a char from the buffer into AL
	mov edx,esi		; Copy total counter into EDX
	and edx,0000000Fh	; Mask out lowest 4 bits of char counter
	call DumpChar		; Call the char poke procedure

; Bump the buffer pointer to the next character and see if buffer's done:
	inc ecx			; Increment buffer pointer
	inc esi			; Increment total chars processed counter
	cmp ecx,ebp		; Compare with # of chars in buffer
	jae Read		; If we've done the buffer, go get more


; See if we're at the end of a block of 16 and need to display a line:
	test esi,0000000Fh  	; Test 4 lowest bits in counter for 0
	jnz Scan		; If counter is *not* modulo 16, loop back
	call PrintLine		; ...otherwise print the line
	call ClearLine		; Clear hex dump line to 0's
	jmp Scan		; Continue scanning the buffer

; All done! Let's end this party:
Done:
	call PrintLine		; Print the "leftovers" line
	mov ecx,DUMPLEN
	mov eax,1		; Code for Exit Syscall
	mov ebx,0		; Return a code of zero	
	int 80H			; Make kernel call
