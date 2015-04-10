; *********************** rnd.asm **********************
;
        ORG   0100H
        JMP   start
msg1    DB    13, 10, '1 occurs times = ', '$'
msg0    DB    13, 10, '0 occurs times = ', '$'
sum1    DW    0
sum0    DW    0
randnum DW    0
;
%include "..\mymacro\dispui.mac"
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\randgen.mac"
;
start:
      MOV      CX, 40000            ;4萬次
loop2:
      randgen  randnum              ;隨機數randnum
      MOV      AX, WORD [randnum]   ;AX=隨機數randnum
      TEST     AL, 00000001B        ;測試第0位元
      JZ       next0                ;0值
      INC      WORD [sum1]          ;1值,累積sum1
      JMP      next
next0:
      INC      WORD [sum0]          ;0值,累積sum0
next:
      LOOP     loop2                ;重複
;
      dispstr  msg1                 ;顯示msg1
      dispui   sum1                 ;顯示sum1
      dispstr  msg0                 ;顯示msg0
      dispui   sum0                 ;顯示sum0
;
      MOV      AX, 4c00H
      INT      21H
