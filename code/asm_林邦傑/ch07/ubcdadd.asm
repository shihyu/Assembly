; ********************** ubcdadd.asm ********************
        ORG    0100H
        JMP    start
len     DW     4
a       DB     0, 3, 2, 1
b       DB     0, 4, 8, 5
;
%include "../mymacro/dispubcd.mac"
;
start:
      MOV     AL, BYTE [a+3]    ;最低位元組相加
      ADD     AL, BYTE [b+3]    ;二進位相加
      AAA                       ;調整為ASCII數字
      MOV     BYTE [a+3], AL    ;存回相加結果
;
      MOV     AL, BYTE [a+2]    ;低位元組相加
      ADC     AL, BYTE [b+2]    ;帶CF旗標值之二進位相加
      AAA                       ;調整為ASCII數字
      MOV     BYTE [a+2], AL    ;存回相加結果
;
      MOV     AL, BYTE [a+1]    ;最高位元組相加
      ADC     AL, BYTE [b+1]    ;帶CF旗標值之二進位相加
      MOV     AH, 0             ;只要進位
      AAA                       ;調整為ASCII數字
      MOV     BYTE [a+1], AL    ;存回相加結果
;
      MOV     BYTE [a], AH      ;最高位元組只存入進位
;
      dispubcd a, len
      MOV      AX, 4c00H
      INT      21H
