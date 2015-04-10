; ********************** salbyte.asm *******************
        ORG   0100H
        JMP   start
a       DB    11010101B
flag    DW    0
count   DW    8
msga    DB    '      a =', '$'
msg     DB    'SAL a,1 =', '$'
msgflag DB    '  flag reg =', '$'
;
%include "..\mymacro\disp8bit.mac"
%include "..\mymacro\newline.mac"
%include "..\mymacro\dispstr.mac"
;
start:
        dispstr  msga             ;顯示msga信息
        disp8bit a                ;顯示a的各位元值
        newline                   ;換列
;
        MOV      CX, WORD [count] ;CX=count之值(8)
loop2:
        SAL      BYTE [a], 1      ;a算術左移一位元
        PUSHF
        POP      WORD [flag]
        dispstr  msg              ;顯示msg信息
        disp8bit a                ;顯示a的各位元值
        dispstr  msgflag          ;顯示msgflag信息
        disp8bit flag             ;顯示flag的各位元值
        newline                   ;換列
        DEC      CX
        JZ       endjob
        JMP      loop2            ;繼續
endjob:
        MOV      AX, 4c00H
        INT      21H
