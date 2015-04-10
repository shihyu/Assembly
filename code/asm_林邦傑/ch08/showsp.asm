; ***** showSP.asm *************
        ORG    0100H
        JMP    start
;
%include "..\mymacro\showSP.mac"
;
start:  showSP
        MOV      AX, 4c00H
        INT      21H
