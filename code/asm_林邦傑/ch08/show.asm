; *********************** show.asm *******************
        ORG    0100H
        JMP    start
a       DB     12H
b       DW     1234H
c       DD     12345678H
space   DB     ' '
;
%include "..\mymacro\showbyte.mac"
%include "..\mymacro\dispchr.mac"
;
start:  showbyte a        ;aず16秈计陪ボ
        dispchr space     ;
        showbyte b        ;bず16秈计陪ボ
        showbyte b+1      ;b+1ず16秈计陪ボ
        dispchr space     ;
        showbyte c        ;cず16秈计陪ボ
        showbyte c+1      ;c+1ず16秈计陪ボ
        showbyte c+2      ;c+2ず16秈计陪ボ
        showbyte c+3      ;c+3ず16秈计陪ボ
        MOV      AX, 4c00H
        INT      21H
