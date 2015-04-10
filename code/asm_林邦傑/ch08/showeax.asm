; ***** showEAX.asm *************
        ORG    0100H
        JMP    start
;
%include "..\mymacro\showEAX.mac"
;
start:  MOV      EAX, 12345678H
        showEAX
        MOV      AX, 4c00H
        INT      21H
