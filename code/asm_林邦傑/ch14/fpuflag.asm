; ********************** fpuflag.asm *******************
          ORG   0100H
          JMP   start
title     DB    '  B C3    ST    C2 C1 C0'
          DB    ' IR    PE UE OE ZE DE IE top',13,10,'$'
newline   DB    13, 10, '$'
space     DB    ' ', '$'
negnum    DD    -1.0
zeronum   DD    0.0
posnum    DD    1.0
fpuFlag   DW    0
;
%include  "..\mymacro\disptos.mac"
%include  "..\mymacro\dispstr.mac"
%include  "disp8bit.mac"
;
start:
          dispstr  title          ;顯示表頭
          FINIT                   ;浮點堆疊初始化
          FTST                    ;頂端暫存器值與0比較
          CALL dispTOS            ;顯示狀態字組
          FLD  DWORD [negnum]     ;疊入negnum
          FTST                    ;頂端暫存器值與0比較
          CALL dispTOS            ;顯示狀態字組
          FLD  DWORD [zeronum]    ;疊入zeronum
          FTST                    ;頂端暫存器值與0比較
          CALL dispTOS            ;顯示狀態字組
          FLD  DWORD [posnum]     ;疊入posnum
          FTST                    ;頂端暫存器值與0比較
          CALL dispTOS            ;顯示狀態字組
          RET
dispTOS:
          FSTSW    WORD [fpuFlag] ;疊出狀態字組
          disp8bit fpuFlag+1      ;顯示高8位元
          disp8bit fpuFlag        ;顯示低8位元
          dispstr  space          ;空一格
          disptos  4              ;小數4位
          dispstr  newline        ;換列
;
          MOV     AX, 4c00H
          INT     21H
