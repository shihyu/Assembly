; ******************* test.asm ************************
;
        SEGMENT  code              ;程式碼分段
..start:                           ;開始執行位址
        MOV  AX, data
        MOV  DS, AX                ;DS=data分段位址
        MOV  ES, AX
        MOV  AX, mystack
        MOV  SS, AX                ;DS=stack分段位址
        MOV  SP, stacktop          ;SP=堆疊頂端指標
;
        MOV  AH, 03H               ;取得游標位置DH列DL行
        INT  10H
;
        MOV  BP, msg               ;[ES:BP]指到msg位址
        MOV  CX, msglen            ;CX=msg長度
        MOV  BL, 7cH               ;BL=白底(7)紅字(c)
        MOV  BH, 00H               ;BH=current page
        MOV  AH, 13H               ;AH=13h列印字串功能
        MOV  AL, 01H               ;一字一字列印
        INT  10H                   ;執行列印字串功能
;
        MOV  AX, 4c00H
        INT  21H                   ;返回作業系統
;----------------------------------------------------------
        SEGMENT data               ;資料分段
msg     DB      'Hello, World', 0
msglen  EQU     $ - msg
;----------------------------------------------------------
        SEGMENT mystack stack      ;堆疊分段
        RESB  100H
stacktop:
;----------------------------------------------------------
