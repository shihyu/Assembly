; ************* short.asm **************
         ORG  0100H
         JMP  start
a        DD   17.5
;
%include  "..\mymacro\showbits.mac"
;
start:
         showbits  a+3   ;最高位元組
         showbits  a+2
         showbits  a+1
         showbits  a      ;最低位元組
;
         MOV      AX, 4c00H
         INT      21H
