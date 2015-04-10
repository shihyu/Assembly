; ****************** ubcdadd1.asm ***************
        ORG    0100H
        JMP    start
len     DW     4
a       DB     0, 9, 9, 9
;
%include "..\mymacro\dispubcd.mac"
%include "..\mymacro\ubcdadd1.mac"
;
start:
      ubcdadd1 a, len       ;BCD變數a加一
      dispubcd a, len       ;顯示ASCII數字
      MOV      AX, 4c00H
      INT      21H
