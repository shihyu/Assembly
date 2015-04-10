; ************************ avg4num.asm ********************
        ORG   0100H
        JMP   start
msg     DB    13, 10, 'keyin an integer(-128..127) : ', '$'
s       TIMES 81 DB ' '
;
count   DB    4
num     DB    0
avg     DB    0
sum     DW    0
;
msgsum  DB    13, 10, 'sum = '
sumstr  DB    '       ', '$'
msgavg  DB    13, 10, 'average = '
avgstr  DB    '       ', '$'
;
%include "../mymacro/readstr.mac"
%include "../mymacro/strtob.mac"
%include "../mymacro/btostr.mac"
%include "../mymacro/itostr.mac"
;
start:
        MOVSX   CX, BYTE [count] ;CX=count值
label:
        MOV     DX, msg          ;顯示msg字串
        MOV     AH, 09H
        INT     21H
        readstr s                ;鍵入一個字串至s
        strtob  s, '$', num      ;將字串s轉換為數值num
        MOVSX   AX, [num]        ;AX=num
        ADD     [sum], AX        ;sum=sum+num
        DEC     CX               ;CX=CX-1
        JCXZ    next             ;CX=0時跳出
        JMP     label            ;重複count次
next:
        itostr  sum, sumstr, '$' ;將sum轉成十進位數字
        MOV     DX, msgsum       ;顯示sum
        MOV     AH, 09H
        INT     21H
;
        MOV     AX, [sum]        ;AX=sum
        MOV     BL, BYTE [count] ;BL=count
        DIV     BL               ;sum/3
        MOV     [avg], AL        ;avg=sum/3
        btostr  avg, avgstr, '$' ;將avg轉成十進位數字
        MOV     DX, msgavg       ;顯示avg
        MOV     AH, 09H
        INT     21H
        MOV     AX, 4c00H
        INT     21H
