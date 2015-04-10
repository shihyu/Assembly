section .data

	EditBuff: db 'abcdefghijklm         '
	ENDPOS    equ 12
	INSRTPOS  equ 0
	
section .text
	global	_start
_start:
	nop
; Put your experiments between the two nops...

	std				; Up-memory transfer
	mov ebx,EditBuff+INSRTPOS
	mov esi,EditBuff+ENDPOS		; Start at end of text
	mov edi,EditBuff+ENDPOS+1	; Bump text right by 1
	mov ecx,ENDPOS-INSRTPOS+1	; # of chars to bump
	rep movsb			; Move 'em!
	mov byte [ebx],' '
; Put your experiments between the two nops...
	nop