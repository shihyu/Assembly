; ***** showDS.asm *************
        ORG    0100H
        JMP    start
;
%include "..\mymacro\showDS.mac"
;
start:  showDS
        MOV      AX, 4c00H
        INT      21H
