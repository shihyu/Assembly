; ********************** sortword.asm ********************
        ORG   0100H
        JMP   start
count   DW    8
array   DW    18, 25, 13, 56, 44, 78, 99, 66
blank   DB    ' $'
;
%include "..\mymacro\dispi.mac"
%include "..\mymacro\dispstr.mac"
;
start:
        MOV     BX, WORD [count]  ;BX=陣列元素個數
begin:
        MOV     CX, [count]       ;CX=陣列元素個數
        DEC     CX                ;從0計數
        MOV     SI, array         ;SI第0個元素偏移位址
        MOV     DI, array+2       ;DI第1個元素偏移位址
loop2:
        MOV     AX, WORD [SI]     ;AX=第SI個元素值
        MOV     DX, WORD [DI]     ;DX=第DI個元素值
        CMP     AX, DX            ;AX:DX
        JL      less              ;AX<DX
        XCHG    AX, DX            ;AX與DX互換
        MOV     WORD [SI], AX     ;第SI個元素值=AX
        MOV     WORD [DI], DX     ;第DI個元素值=DX
less:
        ADD     SI, 2             ;SI=SI-2
        ADD     DI, 2             ;DI=DI-2
        LOOP    loop2             ;繼續
;
        DEC     BX                ;BX=BX-1
        CMP     BX, 1             ;BX=1?
        JG      begin             ;否
;
        MOV     CX, WORD [count]  ;CX=陣列元素個數
        MOV     BX, array         ;BX=array起始位址
loop3:
        dispi   BX                ;顯示BX所指元素內含值
        dispstr blank
        ADD     BX, 2             ;BX指向下一個元素
        LOOP    loop3             ;繼續
        MOV     AX, 4c00H
        INT     21H
