; ****************** strcpy.asm *******************
        ORG   0100H
        JMP   start
result  DW    0
str1    DB    'Good Morning!', '$'
str2    DB    'Good Night!  ', '$'
;
%include "..\mymacro\strcpy.mac"
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\newline.mac"
;
start:
        dispstr  str1             ;顯示str1
        newline                   ;換列
        dispstr  str2             ;顯示str2
        newline                   ;換列
        strcpy   str2, str1, '$'  ;拷貝str1至str2
        dispstr  str2             ;顯示str2
;
        MOV      AX, 4c00H
        INT      21H
