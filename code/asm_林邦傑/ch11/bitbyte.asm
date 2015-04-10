; ********************** bitbyte.asm *******************
        ORG   0100H
        JMP   start
a       DB    11010101B
b       DB    11101100B
c       DB    0
msga    DB    '      a = ', '$'
msgb    DB    '      b = ', '$'
msgand  DB    'a AND b = ', '$'
msgor   DB    'a OR  b = ', '$'
msgxor  DB    'a XOR b = ', '$'
msgnot  DB    '  NOT a = ', '$'
;
%include "..\mymacro\disp8bit.mac"
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\newline.mac"
;
start:
        dispstr  msga
        disp8bit a
        newline
        dispstr  msgb
        disp8bit b
        newline
;
        MOV      AL, [a]
        AND      AL, BYTE [b]
        MOV      BYTE [c], AL
        dispstr  msgand
        disp8bit c
        newline
;
        MOV      AL, [a]
        OR       AL, BYTE [b]
        MOV      BYTE [c], AL
        dispstr  msgor
        disp8bit c
        newline
;
        MOV      AL, [a]
        XOR      AL, BYTE [b]
        MOV      BYTE [c], AL
        dispstr  msgxor
        disp8bit c
        newline
;
        MOV      AL, [a]
        NOT      AL
        MOV      BYTE [c], AL
        dispstr  msgnot
        disp8bit c
        newline
;
        MOV      AX, 4c00H
        INT      21H
