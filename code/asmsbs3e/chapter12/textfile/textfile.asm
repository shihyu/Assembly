;  Source name     : TEXTFILE.ASM
;  Executable name : TEXTFILE
;  Version         : 2.0
;  Created date    : 11/21/1999
;  Last update     : 5/29/2009
;  Author          : Jeff Duntemann
;  Description     : A text file I/O demo for Linux, using NASM 2.05
;
;  Build using these commands:
;    nasm -f elf -g -F stabs textfile.asm
;    nasm -f elf -g -F stabs linlib.asm
;    gcc textfile.o linlib.o -o textfile
;
;  Note that this program requires several procedures
;  in an external named LINLIB.ASM.

[SECTION .data]			; Section containing initialised data
		
IntFormat   dd '%d',0
WriteBase   db 'Line #%d: %s',10,0	
NewFilename db 'testeroo.txt',0			
DiskHelpNm  db 'helptextfile.txt',0
WriteCode   db 'w',0
OpenCode    db 'r',0			
CharTbl	    db '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-@'	
Err1        db 'ERROR: The first command line argument must be an integer!',10,0
HelpMsg     db 'TEXTTEST: Generates a test file.  Arg(1) should be the # of ',10,0
HELPSIZE    EQU $-HelpMsg
            db 'lines to write to the file.  All other args are concatenated',10,0
            db 'into a single line and written to the file.  If no text args',10,0
            db 'are entered, random text is written to the file.  This msg  ',10,0
            db 'appears only if the file HELPTEXTFILE.TXT cannot be opened. ',10,0
HelpEnd     dd 0
		
[SECTION .bss]			; Section containing uninitialized data

LineCount   resd 1		; Reserve integer to hold line count
HELPLEN     EQU 72		; Define length of a line of help text data
HelpLine    resb HELPLEN	; Reserve space for disk-based help text line
BUFSIZE     EQU 64		; Define length of text line buffer buff
Buff        resb BUFSIZE+5	; Reserve space for a line of text 
		
[SECTION .text]			; Section containing code

;; These externals are all from the glibc standard C library:	 
extern fopen
extern fclose
extern fgets	
extern fprintf
extern printf		
extern sscanf
extern time

;; These externals are from the associated library linlib.asm:
extern seedit			; Seeds the random number generator
extern pull6			; Generates a 6-bit random number from 0-63
extern newline			; Outputs a specified number of newline chars

global main			; Required so linker can find entry point
	
main:
        push ebp		; Set up stack frame for debugger
	mov ebp,esp
	push ebx		; Program must preserve EBP, EBX, ESI, & EDI
	push esi
	push edi
;;; Everything before this is boilerplate; use it for all ordinary apps!	

	call seedit		; Seed the random number generator
	
	;; First test is to see if there are command line arguments at all.
	;; If there are none, we show the help info as several lines.  Don't
	;; forget that the first arg is always the program name, so there's
	;; always at least 1 command-line argument!
	mov eax,[ebp+8]		; Load argument count from stack into EAX
	cmp eax,1		; If count is 1, there are no args
	ja chkarg2		; Continue if arg count is > 1
	mov ebx,DiskHelpNm	; Put address of help file name in ebx 
	call diskhelp		; If only 1 arg, show help info...
	jmp gohome		; ...and exit the program
	
	;; Next we check for a numeric command line argument 1:
chkarg2:	
	mov ebx,[ebp+12]	; Put pointer to argument table into ebx
	push LineCount		; Push address of line count integer for sscanf
	push IntFormat		; Push address of integer formatting code
	push dword [ebx+4]	; Push pointer to arg(1)
	call sscanf		; Call sscanf to convert arg(1) to an integer
	add esp,12		; Clean up the stack
	cmp eax,1		; Return value of 1 says we got a number
	je chkdata		; If we got a number, go on; else abort
	mov eax,Err1		; Load eax with address of error message #1
	call showerr		; Show the error message
	jmp gohome		; Exit the program

	;; Here we're looking to see if there are more arguments.  If there
	;; are, we concatenate them into a single string no more than BUFSIZE
	;; chars in size.  (Yes, I *know* this does what strncat does...)
chkdata:
	cmp dword [ebp+8],3	; Is there a second argument?
	jae getlns		; If so, we have text to fill a file with
	call randline		; If not, generate a line of random text
	                        ; Note that randline returns ptr to line in esi
	jmp genfile		; Go on to create the file

	;; Here we copy as much command line text as we have, up to BUFSIZE
	;; chars, into the line buffer buff. We skip the first two args
	;; (which at this point we know exist) but we know we have at least
	;; one text arg in arg(2).  Going into this section, we know that
	;; ebx contains the pointer to the arg table. All other bets are off.
getlns:	mov edx,2		; We know we have at least arg(2), start there
	mov edi,Buff		; Destination pointer is start of char buffer
	xor eax,eax		; Clear eax to 0 for the character counter
	cld			; Clear direction flag for up-memory movsb

grab:	mov esi,[ebx+edx*4]	; Copy pointer to next arg into esi
.copy:  cmp byte [esi],0	; Have we found the end of the arg?
	je .next		; If so, bounce to the next arg
	movsb			; Copy char from [esi] to [edi]; inc edi & esi
	inc eax			; Increment total character count
	cmp eax,BUFSIZE		; See if we've filled the buffer to max count
	je addnul		; If so, go add a null to buff & we're done
	jmp .copy
	
.next:	mov byte [edi],' '	; Copy space to buff to separate args
	inc edi			; Increment destion pointer for space
	inc eax			; Add one to character count too
	cmp eax,BUFSIZE		; See if we've now filled buff
	je addnul		; If so, go down to add a nul and we're done
	inc edx			; Otherwise, increment the argument count
	cmp edx, dword [ebp+8]	; Compare against argument count
	jae addnul		; If edx = arg count, we're done
	jmp grab		; And go back and copy it

addnul:	mov byte [edi],0	; Tuck a null on the end of buff
	mov esi,Buff		; File write code expects ptr to text in esi
	
	;; Now we create a file to fill with the text we have:	
genfile:
	push WriteCode		; Push pointer to file write/create code ('w')
	push NewFilename	; Push pointer to new file name
	call fopen		; Create/open file
	add esp,8		; Clean up the stack
	mov ebx,eax		; eax contains the file handle; save in ebx

	;; File is open.  Now let's fill it with text:	
	mov edi,[LineCount]	; The number of lines to be filled is in edi

	push esi		; esi is the pointer to the line of text
	push 1			; The first line number
	push WriteBase		; Push address of the base string
	push ebx		; Push the file handle of the open file
	
writeline:
	cmp dword edi,0		; Has the line count gone to 0?
	je donewrite		; If so, go down & clean up stack
	call fprintf		; Write the text line to the file
	dec edi			; Decrement the count of lines to be written
	add dword [esp+8],1	; Update the line number on the stack
	jmp writeline		; Loop back and do it again
donewrite:		
	add esp,16		; Clean up stack after call to fprintf
	
	;; We're done writing text; now let's close the file:
closeit:	
	push ebx		; Push the handle of the file to be closed
	call fclose		; Closes the file whose handle is on the stack
	add esp,4
	
	;;; Everything after this is boilerplate; use it for all ordinary apps!
gohome:	pop edi			; Restore saved registers
	pop esi
	pop ebx
	mov esp,ebp		; Destroy stack frame before returning
	pop ebp
	ret			; Return control to to the C shutdown code


;;; SUBROUTINES================================================================

;------------------------------------------------------------------------------
;  Disk-based mini-help subroutine  --  Last update 12/5/1999
;
;  This routine reads text from a text file, the name of which is passed by
;  way of a pointer to the name string in ebx. The routine opens the text file,   
;  reads the text from it, and displays it to standard output.  If the file   
;  cannot be opened, a very short memory-based message is displayed instead.          
;------------------------------------------------------------------------------	
diskhelp:
	push OpenCode		; Push pointer to open-for-read code "r"
	push ebx		; Pointer to name of help file is passed in ebx
	call fopen		; Attempt to open the file for reading
	add esp,8		; Clean up the stack
	cmp eax,0		; fopen returns null if attempted open failed
	jne .disk		; Read help info from disk, else from memory
	call memhelp		
	ret
.disk:	mov ebx,eax		; Save handle of opened file in ebx
.rdln:	push ebx		; Push file handle on the stack
	push dword HELPLEN	; Limit line length of text read
	push HelpLine		; Push address of help text line buffer
	call fgets		; Read a line of text from the file
	add esp,12		; Clean up the stack
	cmp eax,0		; A returned null indicates error or EOF
	jle .done		; If we get 0 in eax, close up & return
	push HelpLine		; Push address of help line on the stack
	call printf		; Call printf to display help line
	add esp,4		; Clean up the stack
	jmp .rdln
	
.done:	push ebx		; Push the handle of the file to be closed
	call fclose		; Closes the file whose handle is on the stack
	add esp,4		; Clean up the stack
	ret			; Go home
	
memhelp:
	mov eax,1
	call newline
	mov ebx,HelpMsg		; Load address of help text into eax
.chkln:	cmp dword [ebx],0	; Does help msg pointer point to a null?
	jne .show		; If not, show the help lines
	mov eax,1		; Load eax with number of newslines to output
	call newline		; Output the newlines
	ret			; If yes, go home
.show:	push ebx		; Push address of help line on the stack
	call printf		; Display the line
	add esp,4		; Clean up the stack
	add ebx,HELPSIZE	; Increment address by length of help line
	jmp .chkln		; Loop back and check to see if we done yet
	
showerr:
	push eax		; On entry, eax contains address of error message
	call printf		; Show the error message
	add esp,4		; Clean up the stack
	ret			; Go home; no returned values
	
randline:	
	mov ebx,BUFSIZE		; BUFSIZE tells us how many chars to pull
	mov byte [Buff+BUFSIZE+1],0  ; Put a null at the end of the buffer first
.loop:	dec ebx			; BUFSIZE is 1-based, so decrement
	call pull6		; Go get a random number from 0-63
	mov cl,[CharTbl+eax]	; Use random # in eax as offset into table
	                        ;  and copy character from table into cl
	mov [Buff+ebx],cl	; Copy char from cl to character buffer
	cmp ebx,0		; Are we done having fun yet?
	jne .loop		; If not, go back and pull another
	mov esi,Buff		; Copy address of the buffer into esi
	ret			;   and go home
