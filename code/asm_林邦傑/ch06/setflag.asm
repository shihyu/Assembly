; ********************** setflag.asm ****************
        ORG      0100H
        JMP      start
flag    DW       0
msg     DB       'flag register (in hex) = ', '$'
;
%include "../mymacro/showword.mac"
;
start:
        SUB      AX, AX       ;設定ZF值為1
        STC                   ;設定CF值為1
        STD                   ;設定DF值為1
        STI                   ;設定IF值為1
        PUSHFW                ;將旗標暫存器疊入堆疊
        POP      WORD [flag]  ;疊出至flag字組
        MOV      DX, msg      ;將msg位址存入DX
        MOV      AH, 09H      ;顯示字串功能
        INT      21H          ;顯示字串msg
        showword flag         ;顯示旗標暫存器(16進位)
;
        MOV      AX, 4c00H    ;結束程式功能
        INT      21H          ;結束程式
