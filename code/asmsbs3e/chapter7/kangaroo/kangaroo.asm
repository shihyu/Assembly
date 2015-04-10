section .data
	Snippet	db "KANGAROO"

section .text
	global	_start
_start:
	nop
; Put your experiments between the two nops...

	mov ebx,Snippet
	mov eax,8
DoMore:	add byte [ebx],32
	inc ebx
	dec eax
	jnz DoMore
	
; Put your experiments between the two nops...
	nop
