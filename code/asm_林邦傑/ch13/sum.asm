; ************************ sum.asm *********************
        ORG   0100H
        JMP   start
count   DW    8
ary     DW    18, 25, 13, 56, 44, 78, 99, 66
msg     DB    'sum of 8 numbers = ', '$'
sum     DW    0
;
%include "..\mymacro\dispi.mac"
%include "..\mymacro\dispstr.mac"
;
start:
        MOV     AX, 0               ;AX=累積器初值
        MOV     SI, 0               ;SI=陣列元素索引初值
        MOV     CX, [count]         ;CX=陣列元素個數
loop2:
        ADD     AX, WORD [ary+SI]   ;AX=AX+第SI元素值
        ADD     SI, 2               ;下一個元素索引
        LOOP    loop2               ;繼續
        MOV     WORD [sum], AX      ;sum為總和
        dispstr msg                 ;顯示msg信息
        dispi   sum                 ;顯示總和
        MOV     AX, 4c00H
        INT     21H
