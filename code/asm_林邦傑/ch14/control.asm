; ******************** control.asm ***********************
;
          ORG   0100H
          JMP   start
f         DD    17.5
n         DD    0
ctrlword  DW    0
msg1      DB    'control word = ', '$'
msg2      DB    '  17.5 after rounded = ', '$'
msg3      DB    '  17.5 not   rounded = ', '$'
;
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\showbits.mac"
%include "..\mymacro\dispi.mac"
%include "..\mymacro\newline.mac"
;
start:
    FINIT                      ;浮點堆疊初始化
    FSTCW     WORD [ctrlword]  ;取得控制字組(要捨入)
    dispstr   msg1
    showbits  ctrlword+1       ;顯示高位元組
    showbits  ctrlword         ;顯示低位元組
    newline                    ;換列
    FLD       DWORD [f]        ;TOS=f
    FISTP     DWORD [n]        ;n=TOS
    dispstr   msg2
    dispi     n                ;顯示n值，4個位元組
    newline                    ;換列
;
    AND      WORD [ctrlword], 03ffH  ;將RC位元清除
    OR       WORD [ctrlword], 0400H  ;設RC=01不捨入
    FLDCW    WORD [ctrlword]         ;設定控制字組
    dispstr  msg1
    showbits ctrlword+1       ;顯示高位元組
    showbits ctrlword         ;顯示低位元組
    newline                   ;換列
    FLD      DWORD [f]        ;TOS=f
    FISTP    DWORD [n]        ;n=TOS
    dispstr  msg3
    dispi    n                ;顯示n值，4個位元組
;
    MOV      AX, 4c00H
    INT      21H              ;返回作業系統
