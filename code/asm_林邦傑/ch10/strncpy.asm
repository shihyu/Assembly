; ************************ strncpy.asm *******************
        ORG   0100H
        JMP   start
str2    DB    'Good Morning!', '$'
len     DW    0
n       DW    4
msg     DB    'after strncpy, n increase 1 each time', '$'
str1    DB    '             ', '$'
;
%include "..\mymacro\strlen.mac"
%include "..\mymacro\strncpy.mac"
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\newline.mac"
;
start:
        dispstr  str2             ;顯示str2
        newline                   ;換列
        dispstr  msg              ;顯示msg
        newline                   ;換列
        strlen   str2, '$', len   ;len=str2長度
        MOV      CX, WORD [len]   ;CX=str2長度
        MOV      WORD [n], 1      ;n=1
loop2:
        strncpy  str1, str2, n    ;str2拷貝n個字元至str1
        dispstr  str1             ;顯示str1
        newline                   ;換列
        INC      WORD [n]         ;n=n+1
        LOOP     loop2            ;繼續迴圈
;
        MOV      AX, 4c00H
        INT      21H
