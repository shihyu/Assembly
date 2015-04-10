; *********************** pbcdsub.asm *******************
        ORG    0100H
        JMP    start
a       DB     00H, 56H, 43H, 21H
b       DB     00H, 45H, 68H, 54H
msg     DB     'BCD error in subtraction!!', 13, 10, '$'
;
%include "../mymacro/showbyte.mac"
%include "../mymacro/dispstr.mac"
;
start:
      MOV     AL, BYTE [a+3]    ;最低位元組相減
      SUB     AL, BYTE [b+3]    ;二進位相減
      DAS                       ;調整為ASCII數字
      MOV     BYTE [a+3], AL    ;存回相減結果
;
      MOV     AL, BYTE [a+2]    ;低位元組相減
      SBB     AL, BYTE [b+2]    ;帶CF旗標值之二進位相減
      DAS                       ;調整為ASCII數字
      MOV     BYTE [a+2], AL    ;存回相減結果
;
      MOV     AL, BYTE [a+1]    ;最高位元組相減
      SBB     AL, BYTE [b+1]    ;帶CF旗標值之二進位相減
      DAS                       ;調整為ASCII數字
      MOV     BYTE [a+1], AL    ;存回相減結果
;
      JC      suberr            ;錯誤發生
      JNC     next
suberr:
      dispstr msg               ;顯示錯誤信息
      JMP     endjob
next:
      MOV     SI, 0
loop2:
      showbyte a+SI              ;顯示BCD數字
      INC      SI
      CMP      SI, 4             ;共4位數
      JNE      loop2
endjob:
      MOV      AX, 4c00H
      INT      21H
