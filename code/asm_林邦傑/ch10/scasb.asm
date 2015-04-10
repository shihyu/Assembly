; ********************** scasb.asm *********************
        ORG   0100H
        JMP   start
len     DW    0
msg2    DB    'destination string = '
str2    DB    'Good Night!', '$'
char    DB    'N'
pos     DW    0
msgnf   DB    'N not found!', '$'
msgf    DB    'find N, at (count from 0) = ', '$'
;
%include "..\mymacro\strlen.mac"
%include "..\mymacro\dispi.mac"
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\newline.mac"
;
start:
        strlen   str2, '$', len   ;目的字串str2長度
        dispstr  msg2             ;顯示目的字串str2
        newline                   ;換列
        MOV      AL, [char]       ;AL=搜尋字元'N'
        MOV      CX, [len]        ;CX=目的字串str2長度
        MOV      DI, str2         ;DI=目的字串str2位址
        CLD                       ;方向,從左至右
loop2:
        SCASB                     ;比較AL直到相等或CX次
        PUSHF                     ;疊入旗標暫存器
        dispi    pos              ;顯示剛比較字元位置
        newline                   ;換列
        INC      WORD [pos]       ;位置增加一
        POPF                      ;疊出旗標暫存器
        LOOPNE   loop2            ;若不相等或CX>0則繼續
;
        CMP      CX, 0            ;CX是否為0
        JE       notfound         ;CX=0,跳至notfound
found:
        DEC      WORD [pos]       ;位置值減一,從0計數
        dispstr  msgf             ;顯示找到信息
        dispi    pos              ;顯示pos數值
        JMP      next             ;跳至next
notfound:
        dispstr  msgnf            ;顯示找不到信息
next:
        MOV      AX, 4c00H
        INT      21H
