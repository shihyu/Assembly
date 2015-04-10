; *********** dispi.asm ************
        ORG   0100H
        JMP   start
a       DW    123
b       DW    -123
;
%include "..\mymacro\dispi.mac"
%include "..\mymacro\newline.mac"
;
start:
      dispi  a          ;顯示a數值
      newline           ;換列
      dispi  b          ;顯示b數值
      MOV    AX, 4c00H
      INT    21H
