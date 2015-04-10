; *********************** pbcdadd.asm *******************
        ORG    0100H
        JMP    start
a       DB     00H, 56H, 43H, 21H
b       DB     00H, 45H, 68H, 54H
;
%include "../mymacro/showbyte.mac"
;
start:
      MOV     AL, BYTE [a+3]    ;最低位元組相加
      ADD     AL, BYTE [b+3]    ;二進位相加
      DAA                       ;調整為ASCII數字
      MOV     BYTE [a+3], AL    ;存回相加結果
;
      MOV     AL, BYTE [a+2]    ;低位元組相加
      ADC     AL, BYTE [b+2]    ;帶CF旗標值之二進位相加
      DAA                       ;調整為ASCII數字
      MOV     BYTE [a+2], AL    ;存回相加結果
;
      MOV     AL, BYTE [a+1]    ;最高位元組相加
      ADC     AL, BYTE [b+1]    ;帶CF旗標值之二進位相加
      DAA                       ;調整為ASCII數字
      MOV     BYTE [a+1], AL    ;存回相加結果
;
      JC      set1              ;最高位元組相加後有進位
      JNC     set0              ;最高位元組相加後沒有進位
set1:
      MOV     BYTE [a], 1
      JMP     next
set0:
      MOV     BYTE [a], 0
next:
      MOV     SI, 0
loop2:
      showbyte a+SI              ;顯示BCD數字
      INC      SI
      CMP      SI, 4             ;共4位數
      JNE      loop2
      MOV      AX, 4c00H
      INT      21H
