; ********************** sqrt.asm ****************
        ORG   0100H
        JMP   start
num     DD    2
sqrt    DD    0
msg     DB    'square root of 2 = ', '$'
;
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\dispf.mac"
;
start:
        FINIT                     ;浮點堆疊初始化
        FILD     DWORD [num]      ;TOS=num
        FSQRT                     ;TOS=num的平方根
        FSTP     DWORD [sqrt]     ;sqrt=TOS
        dispstr  msg              ;顯示訊息
        dispf    sqrt, 6          ;顯示3的平方根
        MOV      AX, 4c00H
        INT      21H              ;返回作業系統
