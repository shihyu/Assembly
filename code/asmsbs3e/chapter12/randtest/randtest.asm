;  Source name     : RANDTEST.ASM
;  Executable name : RANDTEST
;  Version         : 2.0
;  Created date    : 12/1/1999
;  Last update     : 5/22/2009
;  Author          : Jeff Duntemann
;  Description     : A demo of Unix rand & srand using NASM 2.05
;
;  Build using these commands:
;    nasm -f elf -g -F stabs randtest.asm
;    gcc randtest.o -o randtest
;

[SECTION .data]			; Section containing initialised data

Pulls	   dd 36		;  How many numbers do we pull?
Display    db 10,'Here is an array of %d %d-bit random numbners:',10,0
ShowArray  db '%10d %10d %10d %10d %10d %10d',10,0		
CharTbl db '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-@'

[SECTION .bss]		; Section containing uninitialized data

BUFSIZE  equ 70		; # of randomly chosen chars
RandVal  resd 1		; Reserve an integer variable
Stash    resd 72	; Reserve an array of 72 integers for randoms
RandChar resb BUFSIZE+5	; Buffer for storing randomly chosen characters

[SECTION .text]		; Section containing code

extern printf	
extern puts
extern rand
extern scanf	
extern srand
extern time			
		
;------------------------------------------------------------------------------
;  Random number generator procedures  --  Last update 5/22/2009
;
;  This routine provides 5 entry points, and returns 5 different "sizes" of
;  pseudorandom numbers based on the value returned by rand. Note first of 
;  all that rand pulls a 31-bit value. The high 16 bits are the most "random"
;  so to return numbers in a smaller range, you fetch a 31-bit value and then
;  right shift it zero-fill all but the number of bits you want. An 8-bit
;  random value will range from 0-255, a 7-bit value from 0-127, and so on.
;  Respects EBP, ESI, EDI, EBX, and ESP. Returns random value in EAX.
;------------------------------------------------------------------------------
pull31: mov ecx,0		; For 31 bit random, we don't shift
	jmp pull
pull16: mov ecx,15		; For 16 bit random, shift by 15 bits
	jmp pull
pull8:	mov ecx,23		; For 8 bit random, shift by 23 bits
	jmp pull
pull7:  mov ecx,24		; For 7 bit random, shift by 24 bits
	jmp pull
pull6:	mov ecx,25		; For 6 bit random, shift by 25 bits
	jmp pull
pull4:	mov ecx,27		; For 4 bit random, shift by 27 bits
pull:	push ecx		; rand trashes ecx; save shift value on stack
	call rand		; Call rand for random value; returned in EAX
	pop ecx			; Pop stashed shift value back into ECX
	shr eax,cl		; Shift the random value by the chosen factor
				;  keeping in mind that part we want is in CL
	ret			; Go home with random number in EAX

;---------------------------------------------------------------------------
;  Newline outputter  --  Last update 5/22/2009
;
;  This routine allows you to output a number of newlines to stdout, given
;  by the value passed in EAX.  Legal values are 1-10. All sacred registers
;  are respected. Passing 0 in EAX will result in no newlines being issued.
;---------------------------------------------------------------------------
newline:
	mov ecx,10	; We need a skip value, which is 10 minus the
	sub ecx,eax	;  number of newlines the caller wants.
	add ecx,nl	; This skip value is added to the address of
	push ecx	;  the newline buffer nl before calling printf.
	call printf	; Display the selected number of newlines
	add esp,4	; Stack cleanup for one parm
	ret		; Go home
nl	db 10,10,10,10,10,10,10,10,10,10,0
	
		
	;; This subroutine displays numbers six at a time
	;; Not intended to be general-purpose...
shownums:	
	mov esi, dword [Pulls]	; Put pull count into ESI
.dorow:	mov edi,6		; Put row element counter into EDI
.pushr:	dec edi			; Decrement row element counter
	dec esi			; Decrement pulls counter
	push dword [Stash+esi*4]; Push number from array onto stack
	cmp edi,0		; Have we filled the row yet?
	jne .pushr		; If not, go push another one
	push ShowArray		; Push address of base display string
	call printf		; Display the random numbers
	add esp,28		; Stack cleanup: 7 items X 4 bytes = 28
	cmp esi,0		; See if pull count has gone to 0
	jnz .dorow		; If not, we go back and do another row!
	ret			; Done, so go home!
	
	;; This subroutine pulls random values and stuffs them into an
	;; integer array.  Not intended to be general purpose.  Note that
	;; the address of the random number generator entry point must
	;; be loaded into edi before this is called, or you'll seg fault!
puller:
	mov esi,dword [Pulls]	; Put pull count into ESI
.grab:	dec esi			; Decrement counter in ESI
	call edi		; Pull the value; it's returned in eax
	mov [Stash+esi*4],eax   ; Store random value in the array
	cmp esi,0		; See if we've pulled 4 yet
	jne .grab		; Do another if ESI <> 0 
	ret			; Otherwise, go home!

; MAIN PROGRAM:
					
global main			; Required so linker can find entry point
	
main:
        push ebp		; Set up stack frame for debugger
	mov ebp,esp
	push ebx		; Program must preserve EBP, EBX, ESI, & EDI
	push esi
	push edi
;;; Everything before this is boilerplate; use it for all ordinary apps!	

; Begin by seeding the random number generator with a time_t value:	
Seedit:	push 0		; Push a 32-bit null pointer to stack
	call time	; Returns time_t value (32-bit integer) in EAX
	add esp,4	; Stack cleanup for one parm
	push eax	; Push time_t value in EAX onto stack
	call srand	; Time_t value is the seed value for random # gen
	add esp,4	; Stack cleanup for one parm

; All of the following code blocks are identical except for the size of
; the random value being generated:
	
; Create and display an array of 31-bit random values
	mov edi,pull31	; Copy address of random # subroutine into EDI
	call puller	; Pull as many numbers as called for in [pulls]
	push 32		; Size of numbers being pulled, in bits
	push dword [Pulls] ; Number of random numbers generated
	push Display	; Address of base display string
	call printf	; Display the label
	add esp,12	; Stack cleanup: 3 parms X 4 bytes = 12
	call shownums	; Display the rows of random numbers
	
; Create and display an array of 16-bit random values
	mov edi,pull16	; Copy address of random # subroutine into edi
	call puller	; Pull as many numbers as called for in [pulls]
	push 16		; Size of numbers being pulled, in bits
	push dword [Pulls] ; Number of random numbers generated
	push Display	; Address of base display string
	call printf	; Display the label
	add esp,12	; Stack cleanup: 3 parms X 4 bytes = 12
	call shownums	; Display the rows of random numbers
	
; Create and display an array of 8-bit random values:
	mov edi,pull8	; Copy address of random # subroutine into edi
	call puller	; Pull as many numbers as called for in [pulls]
	push 8		; Size of numbers being pulled, in bits
	push dword [Pulls] ; Number of random numbers generated
	push Display	; Address of base display string
	call printf	; Display the label
	add esp,12	; Stack cleanup: 3 parms X 4 bytes = 12
	call shownums	; Display the rows of random numbers

; Create and display an array of 7-bit random values:
	mov edi,pull7	; Copy address of random # subroutine into edi
	call puller	; Pull as many numbers as called for in [pulls]				
	push 7		; Size of numbers being pulled, in bits
	push dword [Pulls] ; Number of random numbers generated
	push Display	; Address of base display string
	call printf	; Display the label
	add esp,12	; Stack cleanup: 3 parms X 4 bytes = 12
	call shownums	; Display the rows of random numbers

; Create and display an array of 4-bit random values:
	mov edi,pull4	; Copy addr. of random # subroutine into EDI
	call puller	; Pull as many #s as called for in [pulls]
	push 4		; Size of numbers being pulled, in bits
	push dword [Pulls] ; Number of random numbers generated
	push Display	; Address of base display string
	call printf	; Display the label
	add esp,12	; Stack cleanup: 3 parms X 4 bytes = 12
	call shownums	; Display the rows of random numbers

; Clear a buffer to nulls:
Bufclr:	mov ecx, BUFSIZE+5  ; Fill whole buffer plus 5 for safety
.loop:	dec ecx		    ; BUFSIZE is 1-based so decrement first!
	mov byte [RandChar+ecx],0     ; Mov null into the buffer
	cmp ecx,0	    ; Are we done yet?
	jnz .loop	    ; If not, go back and stuff another null

; Create a string of random alphanumeric characters:
Pulchr:	mov ebx, BUFSIZE	; BUFSIZE tells us how many chars to pull
.loop:	dec ebx			; BUFSIZE is 1-based, so decrement first!
	mov edi,pull6		; For random in the range 0-63
	call puller		; Go get a random number from 0-63
	mov cl,[CharTbl+eax]	; Use random # in eax as offset into table
	                        ;  and copy character from table into CL
	mov [RandChar+ebx],cl	; Copy char from CL to character buffer
	cmp ebx,0		; Are we done having fun yet?
	jne .loop		; If not, go back and pull another

; Display the string of random characters:
	mov eax,1	; Output a newline
	call newline	;  using the newline procedure
	push RandChar	; Push the address of the char buffer 
	call puts	; Call puts to display it
	add esp,4	; Stack cleanup for one parm
	mov eax,1	; Output a newline
	call newline	;  using the newline subroutine
		
;;; Everything after this is boilerplate; use it for all ordinary apps!
	pop edi		; Restore saved registers
	pop esi
	pop ebx
	mov esp,ebp	; Destroy stack frame before returning
	pop ebp
	ret		; Return control to Linux	
