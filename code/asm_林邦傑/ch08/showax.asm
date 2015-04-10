; ***** showAX.asm *************
        ORG    0100H
        JMP    start
;
%include "..\mymacro\showAX.mac"
;
start:  MOV      AX, 1234H
        showAX
        MOV      AX, 4c00H
        INT      21H
