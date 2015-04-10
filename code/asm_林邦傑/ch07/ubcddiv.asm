; ****************** ubcddiv.asm ***********************
        ORG   0100H
        JMP   start
len     DW    2
a       DB    7, 8
b       DB    2
c       TIMES 80 DB 0
r       DB    0
;
%include "..\mymacro\dispubcd.mac"
;
start:
        MOV     CX, [len]   ;被除數位元組數
        MOV     DL, [b]     ;除數
        MOV     DI, c       ;商最高位元組位址
        MOV     SI, a       ;被除數最高位元組位址
        XOR     AH, AH      ;AH=0
begin:
        MOV     AL, [SI]    ;AL=被除數第SI位元組
        INC     SI          ;被除數下一個位元組
        AAD                 ;除法調整
        DIV     DL          ;相除
        MOV     [DI], AL    ;存入商數第DI位元組
        INC     DI          ;商數下一個位元組
        LOOP    begin       ;繼續
;
        MOV     [r], AL     ;餘數存入r變數
;
        dispubcd c, len     ;顯示商數,len位數
        MOV      AX, 4c00H
        INT      21H
