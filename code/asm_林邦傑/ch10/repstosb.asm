; ***************** repstosb.asm ****************
        ORG   0100H
        JMP   start
str2    TIMES 80 DB ' '
        DB    '$'
;
%include "..\mymacro\dispstr.mac"
;
start:
        MOV       AL, '='   ;AL='='
        MOV       CX, 36    ;CX=來源字串str1長度
        MOV       DI, str2  ;目的字串str2位址
        CLD                 ;方向,從左至右
        REP STOSB           ;AL儲存至DI字元位址
        dispstr   str2      ;顯示str2信息
;
        MOV       AX, 4c00H
        INT       21H
