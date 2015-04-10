; ********************** ubcdsub.asm ********************
        ORG    0100H
        JMP    start
len     DW     4
a       DB     0, 5, 2, 1
b       DB     0, 4, 8, 4
;
%include "../mymacro/dispubcd.mac"
;
start:
      MOV     AL, BYTE [a+3]    ;最低位元組相減
      SUB     AL, BYTE [b+3]    ;二進位相減
      AAS                       ;調整為ASCII數字
      MOV     BYTE [a+3], AL    ;存回相減結果
;
      MOV     AL, BYTE [a+2]    ;低位元組相減
      SBB     AL, BYTE [b+2]    ;帶CF旗標值之二進位相減
      AAS                       ;調整為ASCII數字
      MOV     BYTE [a+2], AL    ;存回相加結果
;
      MOV     AL, BYTE [a+1]    ;最高位元組相減
      SBB     AL, BYTE [b+1]    ;帶CF旗標值之二進位相減
      AAS                       ;調整為ASCII數字
      MOV     BYTE [a+1], AL    ;存回相減結果
;
      dispubcd a, len
      MOV      AX, 4c00H
      INT      21H
