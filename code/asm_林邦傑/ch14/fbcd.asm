; ************************* fbcd.asm *******************
        ORG   0100H
        JMP   start
fnum    DT    123456789123456789.0
fbcd    DT    0.0
msg     DB    '123456789123456789.0 convert to BCD = '
newline DB    13, 10, '$'
ascnum  DB    '                   ', '$'
;
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\bcdtostr.mac"
;
start:
        FINIT                  ;浮點堆疊初始化
        FLD     TWORD [fnum]   ;TOS=整數fnum
        FBSTP   TWORD [fbcd]   ;TOS轉成聚集BCD數
;
        dispstr  msg           ;顯示msg
        bcdtostr fbcd, ascnum  ;將聚集BCD數轉成ASCII數字
        dispstr  ascnum        ;顯示ASCII數字
;
        MOV     AX, 4c00H
        INT     21H
