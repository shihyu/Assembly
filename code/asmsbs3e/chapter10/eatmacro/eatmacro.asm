;  Executable name : eatmacro
;  Version         : 1.0
;  Created date    : 2/21/2009
;  Last update     : 2/23/2009
;  Author          : Jeff Duntemann
;  Description     : A simple program in assembly for Linux, using 
;		   : NASM 2.05, demonstrating the use of escape 
;		   : sequences to do simple "full-screen" text output
;		   ; through macros rather than procedures
;
;  Build using these commands:
;    nasm -f elf -g -F stabs eatmacro.asm
;    ld -o eatmacro eatmacro.o
;
;
section .data		; Section containing initialised data

	SCRWIDTH:	equ 80	; By default we assume 80 chars wide
	PosTerm:	db 27,"[01;01H"	; <ESC>[<Y>;<X>H
	POSLEN:		equ $-PosTerm	; Length of term position string
	ClearTerm:      db 27,"[2J"	; <ESC>[2J
	CLEARLEN	equ $-ClearTerm	; Length of term clear string
	AdMsg: 		db "Eat At Joe's!"	; Ad message
	ADLEN: 		equ $-AdMsg		; Length of ad message
	Prompt:		db "Press Enter: "	; User prompt
	PROMPTLEN:	equ $-Prompt		; Length of user prompt

; This table gives us pairs of ASCII digits from 0-80. Rather than 
; calculate ASCII digits to insert in the terminal control string, 
; we look them up in the table and read back two digits at once to 
; a 16-bit register like DX, which we then poke into the terminal 
; control string PosTerm at the appropriate place. See GotoXY.
; If you intend to work on a larger console than 80 X 80, you must
; add additional ASCII digit encoding to the end of Digits. Keep in
; mind that the code shown here will only work up to 99 X 99.
	Digits:	db "0001020304050607080910111213141516171819"
		db "2021222324252627282930313233343536373839"
		db "4041424344454647484950515253545556575859"
		db "606162636465666768697071727374757677787980"

SECTION .bss		; Section containing uninitialized data

SECTION .text		; Section containing code

;-------------------------------------------------------------------------
; ExitProg: 	Terminate program and return to Linux
; UPDATED:	4/23/2009
; IN: 		Nothing
; RETURNS:	Nothing
; MODIFIES: 	Nothing
; CALLS:	Kernel sys_exit
; DESCRIPTION:	Calls sys_edit to terminate the program and return
;		control to Linux

%macro	ExitProg 0
	mov eax,1		; Code for Exit Syscall
	mov ebx,0		; Return a code of zero	
	int 80H			; Make kernel call
%endmacro


;-------------------------------------------------------------------------
; WaitEnter: 	Wait for the user to press Enter at the console
; UPDATED:	4/23/2009
; IN: 		Nothing
; RETURNS:	Nothing
; MODIFIES: 	Nothing
; CALLS:	Kernel sys_read
; DESCRIPTION:	Calls sys_read to wait for the user to type a newline at
;		the console

%macro	WaitEnter 0
	mov eax,3		; Code for sys_read
	mov ebx,0		; Specify File Descriptor 0: Stdin	
	int 80H			; Make kernel call
%endmacro


;-------------------------------------------------------------------------
; WriteStr: 	Send a string to the Linux console
; UPDATED:	4/21/2009
; IN: 		String address in %1, string length in %2
; RETURNS:	Nothing
; MODIFIES: 	Nothing
; CALLS:	Kernel sys_write
; DESCRIPTION:	Displays a string to the Linux console through a 
;		sys_write kernel call

%macro WriteStr 2		; %1 = String address; %2 = string length
	push eax		; Save pertinent registers
	push ebx
	mov ecx,%1		; Put string address into ECX
	mov edx,%2		; Put string length into EDX
	mov eax,4		; Specify sys_write call
	mov ebx,1		; Specify File Descriptor 1: Stdout
	int 80H			; Make the kernel call
	pop ebx			; Restore pertinent registers
	pop eax
%endmacro


;-------------------------------------------------------------------------
; ClrScr: 	Clear the Linux console
; UPDATED:	4/23/2009
; IN: 		Nothing
; RETURNS:	Nothing
; MODIFIES: 	Nothing
; CALLS:	Kernel sys_write
; DESCRIPTION:	Sends the predefined control string <ESC>[2J to the
;		console, which clears the full display

%macro ClrScr 0
	push eax	  ; Save pertinent registers
	push ebx
	push ecx
	push edx
; Use WriteStr macro to write control string to console:
	WriteStr ClearTerm,CLEARLEN
	pop edx		  ; Restore pertinent registers
	pop ecx
	pop ebx
	pop eax	
%endmacro


;-------------------------------------------------------------------------
; GotoXY: 	Position the Linux Console cursor to an X,Y position
; UPDATED:	4/23/2009
; IN: 		X in %1, Y in %2
; RETURNS:	Nothing
; MODIFIES: 	PosTerm terminal control sequence string
; CALLS:	Kernel sys_write
; DESCRIPTION:	Prepares a terminal control string for the X,Y coordinates
;		passed in AL and AH and calls sys_write to position the
;		console cursor to that X,Y position. Writing text to the
;		console after calling GotoXY will begin display of text
;		at that X,Y position.

%macro GotoXY 2			; %1 is X value; %2 id Y value		
	pushad			; Save caller's registers
	xor edx,edx		; Zero EDX
	xor ecx,ecx		; Ditto ECX
; Poke the Y digits:
	mov dl,%2		     ; Put Y value into offset term EDX
	mov cx,word [Digits+edx*2]   ; Fetch decimal digits to CX
	mov word [PosTerm+2],cx	     ; Poke digits into control string
; Poke the X digits:
	mov dl,%1		     ; Put X value into offset term EDX
	mov cx,word [Digits+edx*2]   ; Fetch decimal digits to CX
	mov word [PosTerm+5],cx	     ; Poke digits into control string
; Send control sequence to stdout:
	WriteStr PosTerm,POSLEN
; Wrap up and go home:
	popad			; Restore caller's registers
%endmacro

;-------------------------------------------------------------------------
; WriteCtr: 	Send a string centered to an 80-char wide Linux console
; UPDATED:	4/23/2009
; IN: 		Y value in %1, String address in %2, string length in %3
; RETURNS:	Nothing
; MODIFIES: 	PosTerm terminal control sequence string
; CALLS:	GotoXY, WriteStr
; DESCRIPTION:	Displays a string to the Linux console centered in an
;		80-column display. Calculates the X for the passed-in 
;		string length, then calls GotoXY and WriteStr to send 
;		the string to the console

%macro WriteCtr 3	; %1 = row; %2 = String addr; %3 = String length
	push ebx	; Save caller's EBX
	push edx	; Save caller's EDX
	mov edx,%3	; Load string length into EDX
	xor ebx,ebx	; Zero EBX
	mov bl,SCRWIDTH	; Load the screen width value to BL
	sub bl,dl	; Calc diff. of screen width and string length
	shr bl,1	; Divide difference by two for X value
	GotoXY bl,%1	; Position the cursor for display
	WriteStr %2,%3	; Write the string to the console
	pop edx		; Restore caller's EDX
	pop ebx		; Restore caller's EBX
%endmacro


global 	_start			; Linker needs this to find the entry point!

_start:
	nop			; This no-op keeps gdb happy...

; First we clear the terminal display...
	ClrScr
; Then we post the ad message centered on the 80-wide console:
	WriteCtr 12,AdMsg,ADLEN
; Position the cursor for the "Press Enter" prompt:
	GotoXY 1,23
; Display the "Press Enter" prompt:
	WriteStr Prompt,PROMPTLEN	
; Wait for the user to press Enter:
	WaitEnter
; ...and we're done!
	ExitProg
