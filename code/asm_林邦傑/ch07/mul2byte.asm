; ******************* mul2byte.asm ***************
        ORG    0100H
        JMP    start
a       DB     7
b       DB     -5
c       DW     0
msg     DB     'c=a*b= '
cstr    DB     '    ', 13, 10, '$'
;
%include "../mymacro/itostr.mac"
;
start:  MOV    AL, [a]      ;AL=a
        IMUL   BYTE [b]     ;AX=a*b
        MOV    [c], AX      ;c=a*b
        itostr c, cstr, '$' ;將c轉換成字串
        MOV    DX, msg      ;顯示msg字串(內含c值)
        MOV    AH, 09H
        INT    21H
        MOV    AX, 4c00H
        INT    21H
