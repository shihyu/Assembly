; ***** showCS.asm *************
        ORG    0100H
        JMP    start
;
%include "..\mymacro\showCS.mac"
;
start:  showCS
        MOV      AX, 4c00H
        INT      21H
