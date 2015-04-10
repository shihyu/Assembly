; ************* hello4.asm *************
[BITS 16]
[ORG 0x0100]
       JMP   start
msg    DB    'Hello!',13,10,'$'
start: MOV   DX, msg
       MOV   AH, 9
       INT   21H
       MOV   AX, 4c00H
       INT   21H
