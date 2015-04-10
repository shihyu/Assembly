; *********************** cmpsb.asm **********************
        ORG   0100H
        JMP   start
len     DW    0
msg1    DB    'source string = '
str1    DB    'Good Morning!', '$'
msg2    DB    'destination string = '
str2    DB    'Good Night!', '$'
pos     DW    0
msge    DB    'equal', '$'
msgne   DB    'not equal, position (count from 0) = ', '$'
;
%include "..\mymacro\strlen.mac"
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\newline.mac"
%include "..\mymacro\dispi.mac"
;
start:
        strlen   str1, '$', len   ;來源字串str1長度
        dispstr  msg1             ;顯示msg1來源字串
        newline                   ;換列
        dispstr  msg2             ;顯示msg2目的字串
        newline                   ;換列
;
        MOV      CX, WORD [len]   ;CX=來源字串str1長度
        MOV      SI, str1         ;SI=來源字串str1位址
        MOV      DI, str2         ;DI=目的字串str2位址
        CLD                       ;方向,從左至右
        MOV      WORD [pos], 0    ;pos=0
loop2:
        CMPSB                     ;比較不相等或CX次
        PUSHF                     ;疊入旗標暫存器
        dispi    pos              ;顯示剛比較字元位置
        newline                   ;換列
        INC      WORD [pos]       ;位置增加一
        POPF                      ;疊出旗標暫存器
        LOOPE    loop2            ;若相等或CX>0則繼續迴圈
;
        CMP      CX, 0            ;字串每一個字元均比較過?
        JE       equal            ;是,跳至equal
        DEC      WORD [pos]       ;位置值減一,從0計數
        dispstr  msgne            ;顯示不相等信息
        dispi    pos              ;  顯示pos數值
        JMP      next             ;  跳至next
equal:
        dispstr  msge             ;顯示相等信息
next:
        MOV      AX, 4c00H
        INT      21H
