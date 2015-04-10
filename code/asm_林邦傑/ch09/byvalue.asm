; ********************* byvalue.asm ******************
        ORG   0100H
        MOV   AL, 'B'       ;列印一個'B'字元
        CALL  Printchr
        MOV   AL, 20H       ;列印一個空白字元
        CALL  Printchr
        MOV   AL, 'y'       ;列印一個'y'字元
        CALL  Printchr
        MOV   AX, 4c00H
        INT   21H
;-----------------------------------------------------
Printchr:
        PUSHA               ;儲存原來暫存器資料
        MOV   DL, AL        ;DL=ASCII字元值
        MOV   AH, 02H       ;設定顯示字元功能
        INT   21H           ;顯示字元
        POPA                ;恢復原來暫存器資料
        RET
