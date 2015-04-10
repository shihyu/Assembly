; ************************ jump.asm **********************
        ORG   0100H
        JMP   start                          ;往後長程跳躍
msg0    DB    'short jump to start', 13, 10, '$'
msg1    DB    'short jump forward to label1', 13, 10, '$'
msg2    DB    'short jump backward to label2', 13, 10, '$'
msg3    DB    'long jump forward to label3', 13, 10, '$'
msg4    DB    'short jump forward to endjob', 13, 10, '$'
table   TIMES 256 DB ' '
;
start:
        MOV    DX, msg0
        MOV    AH, 09H
        INT    21H
        JMP    SHORT  label1       ;往前短程跳躍至label1
        TIMES  127 NOP
label1:
        MOV    DX, msg1
        MOV    AH, 09H
        INT    21H
;
        MOV    CX, 2
label2:
        MOV    DX, msg2
        MOV    AH, 09H
        INT    21H
        JMP    SHORT  label3       ;往前短程跳躍至label3
        TIMES  127 NOP
label3:
        MOV    DX, msg3
        MOV    AH, 09H
        INT    21H
        DEC    CX
        JCXZ   endjob              ;往前短程跳躍至endjob
        JMP    label2              ;往回長程跳躍至label2
endjob:
        MOV    DX, msg4
        MOV    AH, 09H
        INT    21H
        MOV    AX, 4c00H
        INT    21H
