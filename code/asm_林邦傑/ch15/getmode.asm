; ********************* getmode.asm ************************
;
        SEGMENT  code               ;程式碼分段
..start:                            ;開始執行位址
        MOV  AX, data
        MOV  DS, AX                 ;DS=data分段位址
        MOV  AX, mystack
        MOV  SS, AX                 ;DS=stack分段位址
        MOV  SP, stacktop           ;SP=堆疊頂端指標
;
%include "..\mymacro\dispb.mac"
%include "..\mymacro\dispstr.mac"
;
       MOV      AH, 0fH             ;傳回Video狀態
       INT      10H
;
       dispstr  mode
       MOV      BYTE [bmen], AL     ;mode
       dispb    bmen
;
       dispstr  cols
       MOV      BYTE [bmen], AH     ;columns
       dispb    bmen
;
       dispstr  pagenum
       MOV      BYTE [bmen], BH     ;current display page
       dispb    bmen
;
       MOV   AX, 4c00H
       INT   21H                    ;返回作業系統
;-----------------------------------------------------------
        SEGMENT data                ;資料分段
bmen    DB   ' '
mode    DB   13, 10, "current mode = ", '$'
cols    DB   13, 10, "number of columns = ", '$'
pagenum DB   13, 10, "current display page = ", '$'
;-----------------------------------------------------------
        SEGMENT mystack stack       ;堆疊分段
        RESB  100H
stacktop:
;-----------------------------------------------------------
