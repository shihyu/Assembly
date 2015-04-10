; ********************** max.asm ********************
        ORG   0100H
        JMP   start
count   DW    8
array   DW   18, 25, 13, 56, 44, 78, 99, 66
msg     DB   'max element in array is = ', '$'
;
%include "..\mymacro\dispi.mac"
%include "..\mymacro\dispstr.mac"
;
start:
        MOV     CX, [count]     ;CX=陣列元素個數
        DEC     CX              ;從0計數
        MOV     SI, array       ;SI第0個元素偏移位址
        MOV     DI, array+2     ;DI第1個元素偏移位址
loop2:
        MOV     AX, WORD [SI]   ;AX=第SI個元素值
        MOV     DX, WORD [DI]   ;DX=第DI個元素值
        CMP     AX, DX          ;AX:DX
        JL      less            ;AX<DX
        XCHG    AX, DX          ;AX與DX互換
        MOV     WORD [SI], AX   ;第SI個元素值=AX
        MOV     WORD [DI], DX   ;第DI個元素值=DX
less:
        ADD     SI, 2           ;SI=SI-2
        ADD     DI, 2           ;DI=DI-2
        LOOP    loop2           ;繼續
;
        dispstr msg             ;顯示msg
        dispi   SI              ;顯示最大元素值
        MOV     AX, 4c00H
        INT     21H
