; *********************** dw2asc.asm *******************
        ORG    0100H
        JMP    start
len     DW     10
a       TIMES  10 DB 0
b       DD     0FFFFFFFFH
;
%include "..\mymacro\ubcdadd1.mac"
%include "..\mymacro\ubcdmul2.mac"
%include "..\mymacro\dispubcd.mac"
;
start:
      MOV      CX, 32         ;CX=雙字組共32個位元
loop2:
      ubcdmul2 a, len         ;BCD變數a共len個位元組*2
      SHL      DWORD [b], 1   ;b左移一個位元
      JNC      next           ;沒有CF
      ubcdadd1 a, len         ;a加上CF的1值
next:
      DEC      CX             ;CX=CX-1
      JCXZ     next2          ;若CX=0則跳至next2
      JMP      loop2          ;繼續迴圈
next2:
      dispubcd a, len         ;顯示BCD的a數字
      MOV      AX, 4c00H
      INT      21H
