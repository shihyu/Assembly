; ********************* movsb.asm ********************
        ORG   0100H
        JMP   start
msg1    DB    'source string = '
str1    DB    'Good Morning!', '$'
len     DW    0
msg2    DB    'destination string = '
str2    DB    '             ', '$'
msg3    DB    'length of destination string = ', '$'
;
%include "..\mymacro\strlen.mac"
%include "..\mymacro\dispi.mac"
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\newline.mac"
;
start:
        strlen  str1, '$', len  ;來源字串str1長度
        MOV     CX, WORD [len]  ;CX=str1字串長度
        MOV     SI, str1        ;來源字串str1位址
        MOV     DI, str2        ;目的字串str2位址
        CLD                     ;方向,從左至右
loop2:
        MOVSB                   ;位元組搬移
        LOOP    loop2           ;重複CX次
        strlen  str2, '$', len  ;目的字串str2長度
        dispstr msg1            ;顯示msg字串(str1)
        newline                 ;換列
        dispstr msg2            ;顯示msg2字串(str2)
        newline                 ;換列
        dispstr msg3            ;顯示msg3字串
        dispi   len             ;顯示str2字串長度(len)
        MOV     AX, 4c00H
        INT     21H
