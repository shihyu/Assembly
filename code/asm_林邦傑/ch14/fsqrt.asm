; ********************* fsqrt.asm ****************
        ORG   0100H
        JMP   start
num     DD    3
sqrt    DD    0
factor  DD    10000
intpart DD    0
frapart DD    0
point   DB    '.', '$'
msg     DB    'square root of 3 = ', '$'
;
%include "..\mymacro\dispul.mac"
%include "..\mymacro\dispstr.mac"
;
start:
        FINIT                     ;浮點堆疊初始化
        FILD     DWORD [num]      ;TOS=整數num
        FSQRT                     ;TOS=TOS的平方根
        FIMUL    DWORD [factor]   ;TOS=TOS*factor
        FISTP    DWORD [sqrt]     ;sqrt=TOS
        MOV      EDX, 0           ;EDX=0
        MOV      EAX, [sqrt]      ;EAX=sqrt
        MOV      EBX, [factor]    ;EBX=factor
        DIV      EBX              ;EDX:EAX/EBX
        MOV      [intpart], EAX   ;intpart=商
        MOV      [frapart], EDX   ;frapart=餘數
        dispstr  msg              ;顯示msg
        dispul   intpart          ;顯示整數部份
        dispstr  point            ;顯示小數點
        dispul   frapart          ;顯示小數部份
;
        MOV      AX, 4c00H
        INT      21H
