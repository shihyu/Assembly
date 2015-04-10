; ******************* setpixel.asm ************************
;
        SEGMENT  code            ;程式碼分段
..start:                         ;開始執行位址
        MOV  AX, data
        MOV  DS, AX              ;DS=data分段位址
        MOV  AX, mystack
        MOV  SS, AX              ;DS=stack分段位址
        MOV  SP, stacktop        ;SP=堆疊頂端指標
;
       MOV   AX, 13H             ;設定顯示模式為AL=13H
       INT   10H                 ;  320x200 256色圖形模態
       MOV   AX, 0A000H          ;設定螢幕位址
       MOV   ES, AX              ;  ES=0a00H
       MOV   DI, 10 * 320 + 30   ;列數*螢幕寬度+行數
       MOV   CX, 100             ;設定100次
loop2:
       MOV   BYTE [ES:DI], 09H   ;設定藍色亮點
       INC   DI                  ;下一個位置
       LOOP  loop2               ;繼續100次(CX)
       MOV   AH, 10H
       INT   16H                 ;等待按鍵
       MOV   AX, 3
       INT   10H                 ;回復本文模式
       MOV   AX, 4c00H
       INT   21H                 ;返回作業系統
;----------------------------------------------------------
        SEGMENT data             ;資料分段
;----------------------------------------------------------
        SEGMENT mystack stack    ;堆疊分段
        RESB  100H
stacktop:
;----------------------------------------------------------
