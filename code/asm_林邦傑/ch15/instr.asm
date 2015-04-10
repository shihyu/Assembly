; ********************** instr.asm ************************
;
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
        MOV   BX, 0             ;BX=索引值
again:
        MOV   AH, 01H
        INT   21H               ;輸入一個字元至AL
        CMP   AL, 0dH           ;與CR(Carriage Return)比較
        JE    next              ;是CR字元
        MOV   BYTE [buf+BX], AL ;不是CR,存入buf第BX位置
        CMP   BX, 79            ;buf盡頭?
        JE    next              ;是
        INC   BX                ;否
        JMP   again
next:
        MOV   AL, '$'
        MOV   BYTE [buf+BX+1], AL  ;buf以$結束
;
        MOV   DX, msg2             ;DX=msg偏移位址
        MOV   AH, 9
        INT   21H                  ;顯示msg信息
;
        MOV   AX, 4c00H            ;返回作業系統
        INT   21H
;--------------------------------------------------
        SEGMENT data          ;資料分段
msg     DB    'keyin a string : ', '$'
msg2    DB    13, 10, 'you just keyin '
buf     TIMES 81 DB ' '
;--------------------------------------------------
        SEGMENT mystack stack   ;堆疊分段
        RESB  256
stacktop:
;--------------------------------------------------
