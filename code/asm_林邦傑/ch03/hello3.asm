; ********* hello3.asm *********
       ORG   0100H
       JMP   start
msg    DB    'Hello!',13,10,'$'
start: MOV   DX, msg
       MOV   AH, 9
       INT   21H
       MOV   AX, 4c00H
       INT   21H
