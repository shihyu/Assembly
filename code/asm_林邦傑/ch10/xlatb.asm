; *********************** xlatb.asm **********************
        ORG   0100H
        JMP   start
htab    DB    '0123456789ABCDEF'    ;十六進位數字表
num     DB    12
char    DB    ' '
;
%include "..\mymacro\dispchr.mac"
;
start:
        MOV      BX, htab           ;BX=htab偏移位址
        MOV      AL, BYTE [num]     ;AL=索引值
        XLATB                       ;AL=轉換為htab對應字元
        MOV      BYTE [char], AL    ;AL搬移至char
        dispchr  char               ;將char輸出
;
        MOV      AX, 4c00H
        INT      21H
