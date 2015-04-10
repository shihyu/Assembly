; ********************** ubcdmul.asm ********************
        ORG   0100H
        JMP   start
len     DW    3
a       DB    0, 7, 8
b       DB    2
c       TIMES 80 DB 0
;
%include "..\mymacro\dispubcd.mac"
;
start:
        MOV     CX, WORD [len]    ;被乘數位元組數
        MOV     DL, BYTE [b]      ;乘數
        MOV     DI, WORD [len]    ;乘積最低位元組索引值
        DEC     DI
        MOV     BYTE [c+DI], 00H  ;乘積最低位元組0值
        MOV     SI, WORD [len]
        DEC     SI                ;被乘數最低位元組索引值
begin:
        MOV     AL, [a+SI]      ;被乘數第SI位元組
        DEC     SI              ;被乘數下一個位元組索引值
        MUL     DL              ;相乘
        AAM                     ;乘法調整為BCD數字
        ADD     AL, [c+DI]      ;加上上次的進位
        AAA                     ;加法調整為BCD數字
        MOV     [c+DI], AL      ;結果存入乘積第DI位元組
        DEC     DI              ;乘積下一個位元組索引值
        MOV     [c+DI], AH      ;進位存入第DI位元組
        LOOP    begin           ;繼續
;
        dispubcd c, len         ;顯示乘積,len位數
        MOV      AX, 4c00H
        INT      21H
