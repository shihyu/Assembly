; ***************** inchar.asm *****************
        SEGMENT  code         ;程式碼分段
..start:                      ;開始執行位址
        MOV  AX, data
        MOV  DS, AX           ;DS=data分段位址
        MOV  AX, mystack
        MOV  SS, AX           ;DS=stack分段位址
        MOV  SP, stacktop     ;SP=堆疊頂端指標
;
        MOV   DX, msg         ;DX=msg偏移位址
        MOV   AH, 9
        INT   21H             ;顯示msg信息
;
        MOV   AH, 01H
        INT   21H             ;輸入一個字元至AL
;
        MOV   BYTE [ch2], AL
        MOV   DX, msg2        ;DX=msg偏移位址
        MOV   AH, 9
        INT   21H             ;顯示msg信息
;
        MOV   AX, 4c00H       ;返回作業系統
        INT   21H
;----------------------------------------------
        SEGMENT data          ;資料分段
msg     DB    'keyin a char Y or N : ', '$'
msg2    DB    13, 10, 'you just keyin '
ch2     DB    ' '
        DB    13, 10 , '$'
;----------------------------------------------
        SEGMENT mystack stack   ;堆疊分段
        RESB  256
stacktop:
