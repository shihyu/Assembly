; ******************** sub2word.asm ****************
        ORG    0100H
        JMP    start
b       DB     -5
d       DW     3
e       DW     0
msg     DB     'e=b-d= '
estr    DB     '   ', 13, 10, '$'
;
%include "../mymacro/itostr.mac"
;
start:  MOV    AL, [b]      ;AL=b
        CBW                 ;將AL高位元擴展至整個AH
        SUB    AX, [d]      ;AX=b-d
        MOV    [e], AX      ;e=b-d
        itostr e, estr, '$' ;將e值轉成十進位數字
        MOV    DX, msg      ;顯示msg字串(內含e值)
        MOV    AH, 09H
        INT    21H
        MOV    AX, 4c00H
        INT    21H
