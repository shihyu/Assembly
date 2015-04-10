; ******************* getchar.asm **************
        ORG   0100H
        JMP   start
msg     DB    'please keyin a character : ', '$'
msg2    DB    'the character you just keyin = '
char    DB    ' '
crlf    DB    13, 10, '$'
start:  MOV   DX, msg       ;顯示msg字串
        MOV   AH, 09H
        INT   21H
        MOV   AH, 01H       ;鍵入一個字元至AL
        INT   21H
        MOV   [char], AL    ;將AL存入char
        MOV   DX, crlf      ;換列
        MOV   AH, 09H
        INT   21H
        MOV   DX, msg2      ;顯示msg2字串
        MOV   AH, 09H
        INT   21H
        MOV   AX, 4c00H
        INT   21H
