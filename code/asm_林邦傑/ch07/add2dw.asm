; ********************** add2dw.asm *******************
        ORG    0100H
        JMP    start
a       DB     7
f       DD     123456789
g       DD     0
msg     DB     'g=a+f= '
gstr    DB     '         ', 13, 10, '$'
;
%include "../mymacro/ltostr.mac"
;
start:
        MOVSX  EAX, BYTE [a]
;       MOV    AL, [a]       ;AL=a
;       CBW                  ;將AL高位元擴展至整個AH
;       CWDE                 ;將AX高位元擴展至整個EAX
        ADD    EAX, [f]      ;EAX=a+f
        MOV    [g], EAX      ;g=a+f
        ltostr g, gstr, '$'  ;將g值轉成十進位數字
        MOV    DX, msg       ;顯示msg字串(內含e值)
        MOV    AH, 09H
        INT    21H
        MOV    AX, 4c00H
        INT    21H
