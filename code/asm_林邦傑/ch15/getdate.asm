; ********************** getdate.asm ************************
;
        SEGMENT  code         ;程式碼分段
..start:                      ;開始執行位址
        MOV  AX, data
        MOV  DS, AX           ;DS=data分段位址
        MOV  AX, mystack
        MOV  SS, AX           ;DS=stack分段位址
        MOV  SP, stacktop     ;SP=堆疊頂端指標
;
%include "..\mymacro\dispb.mac"
%include "..\mymacro\dispi.mac"
%include "..\mymacro\dispstr.mac"
;
        MOV   AH, 2aH
        INT   21H               ;讀取日期
        MOV   WORD [year], CX   ;年
        MOV   BYTE [month], DH  ;月
        MOV   BYTE [day], DL    ;日
;
        dispstr  msg1
        dispi    year
        dispstr  msg2
        dispb    month
        dispstr  msg3
        dispb    day
;
        MOV   AX, 4c00H            ;返回作業系統
        INT   21H
;--------------------------------------------------
        SEGMENT data          ;資料分段
msg1    DB    13, 10, 'year = ', '$'
msg2    DB    13, 10, 'month =  ', '$'
msg3    DB    13, 10, 'day = ', '$'
year    DW    0
month   DB    0
day     DB    0
;--------------------------------------------------
        SEGMENT mystack stack   ;堆疊分段
        RESB    256
stacktop:
;--------------------------------------------------
