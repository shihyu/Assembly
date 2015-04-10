; ********************** readstr.asm ********************
        ORG   0100H
        JMP   start
msg     DB    'please keyin a string : ', '$'
msg2    DB    13, 10, 'the string you just keyin = ', '$'
s       TIMES 80 DB ' '
crlf    DB    13,10,'$'
;
%include "..\mymacro\readstr.mac"
;
start:
        MOV      DX, msg    ;顯示msg信息
        MOV      AH, 09H
        INT      21H
        readstr  s          ;從鍵盤讀入字串以'$'結束
        MOV      DX, msg2   ;顯示msg2信息
        MOV      AH, 09H
        INT      21H
        MOV      DX, s      ;顯示剛剛讀入的s字串
        MOV      AH, 09H
        INT      21H
        MOV      AX, 4c00H
        INT      21H
