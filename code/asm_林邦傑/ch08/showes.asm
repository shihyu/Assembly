; ***** showES.asm *************
        ORG    0100H
        JMP    start
;
%include "..\mymacro\showES.mac"
;
start:  showES
        MOV      AX, 4c00H
        INT      21H
