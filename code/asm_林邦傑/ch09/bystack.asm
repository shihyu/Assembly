; *********************** bystack.asm ********************
        ORG   0100H
        MOV   AX, 64      ;AX=64
        PUSH  AX          ;疊入堆疊頂端當usestack輸入參數
        CALL  usestack    ;呼叫usestack程序
        POP   DX          ;疊出usestack頂端資料項至DX
        MOV   AH, 02H     ;顯示DL字元
        INT   21H
        MOV   AX, 4c00H
        INT   21H
usestack:
        MOV   BP, SP      ;BP=SP
        PUSHA             ;儲存原來暫存器資料
        INC   WORD [BP+2] ;AX=AX+1
        POPA              ;恢復原來暫存器資料
        RET
