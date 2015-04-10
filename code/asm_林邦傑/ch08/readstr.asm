; ********************* readstr.asm ********************
        ORG    0100H
        JMP    start
msg     DB     'keyin a string (end with Enter) : ', '$'
msg2    DB     'the string you just keyin = ', '$'
s       TIMES 80 DB ' '
crlf    DB     13,10,'$'
;
%include "..\mymacro\readstr.mac"
%include "..\mymacro\dispstr.mac"
;
start:
        dispstr  msg       ;顯示msg
        readstr  s         ;從鍵盤輸入字串
        dispstr  crlf      ;換列
        dispstr  msg2      ;顯示msg2
        dispstr  s         ;顯示s字串
        MOV      AX, 4c00H
        INT      21H
