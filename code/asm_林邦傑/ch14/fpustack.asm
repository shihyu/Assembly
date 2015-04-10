; ********************** fpustack.asm ********************
         ORG  0100H
         JMP  start
title    DB   '  B C3    ST    C2 C1 C0'
         DB   ' IR    PE UE OE ZE DE IE top', 13,10,'$'
space    DB   ' ', '$'
a        DD   1.23
b        DD   4.56
fpuFlag  DW   0
;
%include  "..\mymacro\disptos.mac"
%include  "..\mymacro\dispstr.mac"
%include  "..\mymacro\newline.mac"
%include  "disp8bit.mac"
;
start:
         dispstr  title           ;顯示表頭
         FINIT                    ;浮點堆疊初始化
         CALL     printTOS        ;顯示頂端浮點暫存器值
         FLD      DWORD [a]       ;疊入a
         CALL     printTOS
         FLD      DWORD [b]       ;疊入b
         CALL     printTOS
         FSTP     DWORD [a]       ;疊出至a
         CALL     printTOS
         FSTP     DWORD [b]       ;疊出至b
         CALL     printTOS
         RET
printTOS:
         FSTSW    WORD [fpuFlag]  ;疊出狀態字組
         disp8bit fpuFlag+1       ;顯示高8位元
         disp8bit fpuFlag         ;顯示低8位元
         dispstr  space           ;空一格
         disptos  4               ;小數4位
         newline                  ;換列
;
         MOV      AX, 4c00H
         INT      21H
