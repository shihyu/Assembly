; ******************* equip.asm ******************
        ORG   0100H
        JMP   start
equip   DW    0
numport DW    0
msg0    DB    'with floppy disk', 13, 10, '$'
msg1    DB    'with coprocessor', 13, 10, '$'
msg15   DB    'with parallel port number = '
portstr DB    '   '
;
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\dispi.mac"
%include "..\mymacro\itostr.mac"
;
start:
        INT      11H
        MOV      WORD [equip], AX
;
        TEST     WORD [equip], 0001H
        JZ       next
        dispstr  msg0
next:
        TEST     WORD [equip], 0002H
        JZ       next2
        dispstr  msg1
next2:
        MOV      AX, WORD [equip]
        SHR      AX, 14
        MOV      WORD [numport], AX
        itostr   numport, portstr, '$'
        dispstr  msg15
;
        MOV      AX, 4c00H
        INT      21H
