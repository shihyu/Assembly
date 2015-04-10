; ********************* divbyte.asm ******************
        ORG   0100H
        JMP   start
a       DW    123
b       DB    5
q       DB    0
r       DB    0
msgq    DB    'quotient  q=123/5= '
qstr    DB    '      ', '$'
msgr    DB    13, 10, 'remainder  r=123%5= '
rstr    DB    '      ', '$'
;
%include "../mymacro/btostr.mac"
;
start:  MOV    AX, [a]      ;AX=a
        DIV    BYTE [b]     ;q=a/b,r=a%b
        MOV    [q], AL      ;q=a/b
        MOV    [r], AH      ;r=a%b
        btostr q, qstr, '$' ;將q值轉成十進位數字
        MOV    DX, msgq     ;顯示msg字串(內含q值)
        MOV    AH, 09H
        INT    21H
;
        btostr r, rstr, '$' ;將r值轉成十進位數字
        MOV    DX, msgr     ;顯示msg字串(內含r值)
        MOV    AH, 09H
        INT    21H
        MOV    AX, 4c00H
        INT    21H
