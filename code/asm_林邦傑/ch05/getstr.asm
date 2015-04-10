; ********************* getstr.asm *******************
        ORG   0100H
        JMP   start
msg     DB    'please keyin a string : ', '$'
crlf    DB    13, 10, '$'
buf     DB    80
count   DB    0
s       TIMES 81 DB ' '
start:  MOV   DX, msg             ;顯示msg字串
        MOV   AH, 09H
        INT   21H
        MOV   DX, buf             ;鍵入一個字串至buf
        MOV   AH, 0aH
        INT   21H
        MOV   BH, 0               ;將s中0dH改成'$'
        MOV   BL, [count]
        MOV   BYTE [BX+s], '$'
        MOV   DX, crlf            ;換列
        MOV   AH, 09H
        INT   21H
        MOV   DX, s               ;顯示s
        MOV   AH, 09H
        INT   21H
        MOV   AX, 4c00H
        INT   21H
