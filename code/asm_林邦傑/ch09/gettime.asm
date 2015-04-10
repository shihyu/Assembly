; ******************** gettime.asm *******************
        ORG     0100H
        CALL    Disptime
        MOV     AX, 4c00H
        INT     21H
;-----------------------------------------------------
Printub:
        PUSHA               ;儲存原來暫存器資料
        MOV     AH, 0       ;AH=0
        MOV     BL, 10      ;BL=除數為10(十進位)
        DIV     BL          ;AX/10
        OR      AX, 3030H   ;轉換為ASCII數字
        PUSH    AX
        MOV     DL, AL      ;商數,高位
        MOV     AH, 02H     ;顯示
        INT     21H
        POP     AX
        MOV     DL, AH      ;餘數,低為
        MOV     AH, 02H     ;顯示
        INT     21H
        POPA
        RET
;-----------------------------------------------------
Disptime:
        PUSHA               ;儲存原來暫存器資料
        MOV   AH, 2cH       ;取得系統時間
        INT   21H
        MOV   AL, CH        ;小時(00-23)
        CALL  Printub       ;顯示小時
        MOV   DL, ':'       ;顯示冒號(:)
        MOV   AH, 02H
        INT   21H
        MOV   AL, CL        ;分鐘(00-59)
        CALL  Printub       ;顯示分鐘
        MOV   DL, ':'       ;顯示冒號(:)
        MOV   AH, 02H
        INT   21H
        MOV   AL, DH        ;秒數(00-59)
        CALL  Printub       ;顯示秒數
        POPA                ;恢復原來暫存器資料
        RET
