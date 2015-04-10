; ****************** fiadd.asm *****************
        ORG   0100H
        JMP   start
num1    DD    12345678H
num2    DD    12345678H
sum     DD    0
msg     DB    'sum = ', '$'
;
%include "..\mymacro\showbyte.mac"
%include "..\mymacro\dispstr.mac"
;
start:
        FINIT                   ;浮點堆疊初始化
        FILD     DWORD [num1]   ;TOS=整數num1
        FIADD    DWORD [num2]   ;TOS=num1+num2
        FISTP    DWORD [sum]    ;sum=TOS
        dispstr  msg
        showbyte sum+3          ;sum最高位元組
        showbyte sum+2
        showbyte sum+1
        showbyte sum+0          ;sum最低位元組
;
        MOV     AX, 4c00H
        INT     21H
