; ******************** roundctr.asm ***********************
;
          ORG   0100H
          JMP   start
n         DD    17.5
f         DD    0
ctrlword  DW    0    
;
%include "..\mymacro\disp8bit.mac"
%include "..\mymacro\dispul.mac"
%include "..\mymacro\newline.mac"
;
start:
    FINIT                             ;浮點堆疊初始化
    FSTCW    WORD [ctrlword]          ;取得控制字組(要捨入)
    disp8bit ctrlword+1               ;顯示高位元組
    disp8bit ctrlword                 ;顯示低位元組
    newline                           ;換列
    FLD     DWORD [n]                 ;TOS=n
    FISTP   DWORD [f]                 ;f=TOS
    dispul  f                         ;顯示f值
    newline                           ;換列
;
    AND      WORD [ctrlword], 03ffH   ;將RC及PC位元清除
    OR       WORD [ctrlword], 0400H   ;設RC=01不捨入
    FLDCW    WORD [ctrlword]          ;設定控制字組
    disp8bit ctrlword+1               ;顯示高位元組
    disp8bit ctrlword                 ;顯示低位元組
    newline                           ;換列
    FLD     DWORD [n]                 ;TOS=n
    FISTP   DWORD [f]                 ;f=TOS
    dispul  f                         ;顯示f值
;
    MOV     AX, 4c00H
    INT     21H
