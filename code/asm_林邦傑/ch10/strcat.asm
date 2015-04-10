; ******************** strcat.asm ******************
        ORG   0100H
        JMP   start
result  DW    0
str1    DB    'Good Morning!', '$'
        TIMES 80 DB ' '
str2    DB    'Good Night!  ', '$'
;
%include "..\mymacro\strcat.mac"
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\newline.mac"
;
start:
        dispstr  str1             ;顯示str1
        newline                   ;換列
        dispstr  str2             ;顯示str2
        newline                   ;換列
        strcat   str1, str2, '$'  ;str2附至str1尾端
        dispstr  str1             ;顯示str1
;
        MOV      AX, 4c00H
        INT      21H
