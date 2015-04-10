; ********************** bymem.asm *********************
        ORG   0100H
        JMP   start
ary     DW    1, 3, 5, 7, 9     ;ary陣列含五個元素
aryptr  DW    ary               ;ary陣列位址
count   DW    5                 ;ary陣列元素個數
sum     DW    0                 ;ary陣列元素總和
;
%include "..\mymacro\dispui.mac"
;
start:
        MOV     BX, aryptr      ;BX=參數起始位址
        CALL    usemem          ;呼叫usemem程序
        dispui  sum             ;顯示陣列ary各元素總和
        MOV     AX, 4c00H
        INT     21H
usemem:
        PUSHA                   ;儲存原來暫存器資料
        MOV     BP, [BX]        ;將ary陣列位址存入BP
        MOV     CX, [BX+2]      ;CX=ary陣列元素個數
        MOV     AX, 0           ;AX=0
        MOV     SI, 0           ;SI=0
.loop2:
        ADD     AX, [BP+SI]     ;ary陣列第SI元素值累積至AX
        INC     SI              ;SI=SI+1
        INC     SI              ;SI=SI+1,索引至下一元素
        LOOP    .loop2          ;繼續
        MOV     WORD [BX+4], AX ;sum=AX
        POPA                    ;恢復原來暫存器資料
        RET
