; ********************* ascii.asm ********************
        ORG   0100H
        JMP   start
;
%include "printchr.pro"
;
start:
        MOV   BL, 16        ;BL=16,每列16字元
        MOV   CL, 32        ;CL=32,從可印字元開始
loop2:
        MOVZX AX, CL        ;AX=CL
        DIV   BL            ;AX/BL
        CMP   AH, 0         ;商數AH為0嗎?
        JNZ   next          ;否,一列還為印滿
        MOV   AL, 0dH       ;印出CarriageReturn
        CALL  printchr      ;列印字頭返回
        MOV   AL, 0aH       ;印出LineFeed
        CALL  printchr      ;列印字頭降下一列
next:
        MOV   AL, ' '       ;列印一個空白字元
        CALL  printchr
        MOV   AL, CL        ;列印AL的ASCII碼
        CALL  printchr
        INC   CL            ;CL=下一個ASCII碼值
        CMP   CL, BYTE 128  ;CL與128比較
        JNZ   loop2         ;不相等時繼續
        MOV   AX, 4c00H
        INT   21H
