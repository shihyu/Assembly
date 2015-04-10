;  Executable name : hexdump2
;  Version         : 1.0
;  Created date    : 4/15/2009
;  Last update     : 4/20/2009
;  Author          : Jeff Duntemann
;  Description     : A simple hex dump utility demonstrating the use of
;			assembly language procedures
;
;  Build using these commands:
;    nasm -f elf -g -F stabs hexdump2.asm
;    ld -o hexdump2 hexdump2.o 
;

SECTION .bss			; Section containing uninitialized data

	BUFFLEN EQU 10
	Buff	resb BUFFLEN

SECTION .data			; Section containing initialised data

; Here we have two parts of a single useful data structure, implementing
; the text line of a hex dump utility. The first part displays 16 bytes in
; hex separated by spaces. Immediately following is a 16-character line 
; delimited by vertical bar characters. Because they are adjacent, the two
; parts can be referenced separately or as a single contiguous unit.
; Remember that if DumpLin is to be used separately, you must append an
; EOL before sending it to the Linux console.

DumpLin:	db " 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
DUMPLEN		EQU $-DumpLin
ASCLin:		db "|................|",10
ASCLEN		EQU $-ASCLin
FULLLEN		EQU $-DumpLin

; The HexDigits table is used to convert numeric values to their hex
; equivalents. Index by nybble without a scale: [HexDigits+eax]
HexDigits:	db "0123456789ABCDEF"

; This table is used for ASCII character translation, into the ASCII
; portion of the hex dump line, via XLAT or ordinary memory lookup. 
; All printable characters "play through" as themselves. The high 128 
; characters are translated to ASCII period (2Eh). The non-printable
; characters in the low 128 are also translated to ASCII period, as is
; char 127.
DotXlat: 
	db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
	db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
	db 20h,21h,22h,23h,24h,25h,26h,27h,28h,29h,2Ah,2Bh,2Ch,2Dh,2Eh,2Fh
	db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,3Ah,3Bh,3Ch,3Dh,3Eh,3Fh
	db 40h,41h,42h,43h,44h,45h,46h,47h,48h,49h,4Ah,4Bh,4Ch,4Dh,4Eh,4Fh
	db 50h,51h,52h,53h,54h,55h,56h,57h,58h,59h,5Ah,5Bh,5Ch,5Dh,5Eh,5Fh
	db 60h,61h,62h,63h,64h,65h,66h,67h,68h,69h,6Ah,6Bh,6Ch,6Dh,6Eh,6Fh
	db 70h,71h,72h,73h,74h,75h,76h,77h,78h,79h,7Ah,7Bh,7Ch,7Dh,7Eh,2Eh
	db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
	db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
	db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
	db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
	db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
	db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
	db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
	db 2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh,2Eh
			
	
SECTION .text			; Section containing code

;-------------------------------------------------------------------------
; ClearLine: 	Clear a hex dump line string to 16 0 values
; UPDATED: 	4/15/2009
; IN: 		Nothing
; RETURNS:	Nothing
; MODIFIES: 	Nothing
; CALLS:	DumpChar
; DESCRIPTION:	The hex dump line string is cleared to binary 0 by
;		calling DumpChar 16 times, passing it 0 each time.

ClearLine:
	pushad		; Save all caller's GP registers
	mov edx,15	; We're going to go 16 pokes, counting from 0
.poke:	mov eax,0	; Tell DumpChar to poke a '0'
	call DumpChar	; Insert the '0' into the hex dump string
	sub edx,1	; DEC doesn't affect CF!
	jae .poke	; Loop back if EDX >= 0
	popad		; Restore all caller's GP registers
	ret		; Go home


;-------------------------------------------------------------------------
; DumpChar: 	"Poke" a value into the hex dump line string.
; UPDATED: 	4/15/2009
; IN: 		Pass the 8-bit value to be poked in EAX.
;     		Pass the value's position in the line (0-15) in EDX 
; RETURNS:	Nothing
; MODIFIES: 	EAX, ASCLin, DumpLin
; CALLS:	Nothing
; DESCRIPTION:	The value passed in EAX will be put in both the hex dump
;		portion and in the ASCII portion, at the position passed 
;		in EDX, represented by a space where it is not a
;		printable character.

DumpChar:
	push ebx		; Save caller's EBX
	push edi		; Save caller's EDI
; First we insert the input char into the ASCII portion of the dump line
	mov bl,byte [DotXlat+eax]	; Translate nonprintables to '.'
	mov byte [ASCLin+edx+1],bl	; Write to ASCII portion
; Next we insert the hex equivalent of the input char in the hex portion
; of the hex dump line:
	mov ebx,eax		; Save a second copy of the input char
	lea edi,[edx*2+edx]	; Calc offset into line string (ECX X 3)
; Look up low nybble character and insert it into the string:
	and eax,0000000Fh	     ; Mask out all but the low nybble
	mov al,byte [HexDigits+eax]  ; Look up the char equiv. of nybble
	mov byte [DumpLin+edi+2],al  ; Write the char equiv. to line string
; Look up high nybble character and insert it into the string:
	and ebx,000000F0h	; Mask out all the but second-lowest nybble
	shr ebx,4		; Shift high 4 bits of byte into low 4 bits
	mov bl,byte [HexDigits+ebx] ; Look up char equiv. of nybble
	mov byte [DumpLin+edi+1],bl ; Write the char equiv. to line string
;Done! Let's go home:
	pop edi			; Restore caller's EDI
	pop ebx			; Restore caller's EBX
	ret			; Return to caller


;-------------------------------------------------------------------------
; PrintLine: 	Displays DumpLin to stdout
; UPDATED: 	4/15/2009
; IN: 		Nothing
; RETURNS:	Nothing
; MODIFIES: 	Nothing
; CALLS:	Kernel sys_write
; DESCRIPTION:	The hex dump line string DumpLin is displayed to stdout 
; 		using INT 80h sys_write. All GP registers are preserved.

PrintLine:
	pushad		  ; Save all caller's GP registers
	mov eax,4	  ; Specify sys_write call
	mov ebx,1	  ; Specify File Descriptor 1: Standard output
	mov ecx,DumpLin	  ; Pass offset of line string
	mov edx,FULLLEN	  ; Pass size of the line string
	int 80h		  ; Make kernel call to display line string
	popad		  ; Restore all caller's GP registers
	ret		  ; Return to caller


;-------------------------------------------------------------------------
; LoadBuff: 	Fills a buffer with data from stdin via INT 80h sys_read
; UPDATED: 	4/15/2009
; IN: 		Nothing
; RETURNS:	# of bytes read in EBP
; MODIFIES: 	ECX, EBP, Buff
; CALLS:	Kernel sys_write
; DESCRIPTION:	Loads a buffer full of data (BUFFLEN bytes) from stdin 
;		using INT 80h sys_read and places it in Buff. Buffer
;		offset counter ECX is zeroed, because we're starting in
;		on a new buffer full of data. Caller must test value in
;		EBP: If EBP contains zero on return, we hit EOF on stdin.
;		Less than 0 in EBP on return indicates some kind of error.

LoadBuff:
	push eax	  ; Save caller's EAX
	push ebx	  ; Save caller's EBX
	push edx	  ; Save caller's EDX
	mov eax,3	  ; Specify sys_read call
	mov ebx,0	  ; Specify File Descriptor 0: Standard Input
	mov ecx,Buff	  ; Pass offset of the buffer to read to
	mov edx,BUFFLEN	  ; Pass number of bytes to read at one pass
	int 80h		  ; Call sys_read to fill the buffer
	mov ebp,eax	  ; Save # of bytes read from file for later
	xor ecx,ecx	  ; Clear buffer pointer ECX to 0
	pop edx		  ; Restore caller's EDX
	pop ebx		  ; Restore caller's EBX
	pop eax		  ; Restore caller's EAX
	ret		  ; And return to caller


GLOBAL _start

; ------------------------------------------------------------------------
; MAIN PROGRAM BEGINS HERE
;-------------------------------------------------------------------------
_start:
	nop			; No-ops for GDB
	nop

; Whatever initialization needs doing before the loop scan starts is here:
	xor esi,esi		; Clear total byte counter to 0
	call LoadBuff		; Read first buffer of data from stdin
	cmp ebp,0		; If ebp=0, sys_read reached EOF on stdin
	jbe Exit

; Go through the buffer and convert binary byte values to hex digits:
Scan:
	xor eax,eax		; Clear EAX to 0
	mov al,byte[Buff+ecx]	; Get a byte from the buffer into AL
	mov edx,esi		; Copy total counter into EDX
	and edx,0000000Fh	; Mask out lowest 4 bits of char counter
	call DumpChar		; Call the char poke procedure

; Bump the buffer pointer to the next character and see if buffer's done:
	inc esi			; Increment total chars processed counter
	inc ecx			; Increment buffer pointer
	cmp ecx,ebp		; Compare with # of chars in buffer
	jb .modTest		; If we've processed all chars in buffer...
	call LoadBuff		; ...go fill the buffer again
	cmp ebp,0		; If ebp=0, sys_read reached EOF on stdin
	jbe Done		; If we got EOF, we're done

; See if we're at the end of a block of 16 and need to display a line:
.modTest:
	test esi,0000000Fh  	; Test 4 lowest bits in counter for 0
	jnz Scan		; If counter is *not* modulo 16, loop back
	call PrintLine		; ...otherwise print the line
	call ClearLine		; Clear hex dump line to 0's
	jmp Scan		; Continue scanning the buffer

; All done! Let's end this party:
Done:
	call PrintLine		; Print the "leftovers" line
Exit:	mov eax,1		; Code for Exit Syscall
	mov ebx,0		; Return a code of zero	
	int 80H			; Make kernel call
