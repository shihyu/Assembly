; ********************** mul2word.asm ****************
        ORG    0100H
        JMP    start
a       DW     1234
b       DW     5678
f       DD     0
msg     DB     'f=a*b= '
fstr    DB     '          ', 13, 10, '$'
;
%include "../mymacro/ltostr.mac"
;
start:  MOV    AX, [a]      ;AX=a
        MUL    WORD [b]     ;DX:AX=a*b
        MOV    [f], AX      ;將乘積低字組存入f低字組
        MOV    [f+2], DX    ;將乘積高字組存入f高字組
        ltostr f, fstr, '$' ;將f值轉成十進位數字
        MOV    DX, msg      ;顯示msg字串(內含f值)
        MOV    AH, 09H
        INT    21H
        MOV    AX, 4c00H
        INT    21H
