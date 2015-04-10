; ***** showword.asm *************
        ORG    0100H
        JMP    start
wmem    DW     1234H
;
%include "..\mymacro\showword.mac"
;
start:  showword wmem
        MOV      AX, 4c00H
        INT      21H
