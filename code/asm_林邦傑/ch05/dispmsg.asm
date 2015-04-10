; ************* dispmsg.asm **************
        ORG   0100H
        JMP   start
msg     DB    'Good Morning!', 13, 10, '$'
start:  MOV   DX, msg
        MOV   AH, 09H
        INT   21H
        MOV   AX, 4c00H
        INT   21H
