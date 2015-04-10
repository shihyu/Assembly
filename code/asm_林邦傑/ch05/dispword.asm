; ******************** dispword.asm ***************
        ORG     0100H
        JMP     start
num     DW      1357
msg     DB      'decimal number = '
numstr  DB      '      ', '$'
;
%include "../mymacro/itostr.mac"
;
start:
        itostr  num, numstr, '$' ;num轉成十進位數字
        MOV     DX, msg          ;顯示msg
        MOV     AH, 09H
        INT     21H
        MOV     AX, 4c00H
        INT     21H
