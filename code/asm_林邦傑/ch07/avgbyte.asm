; ************************ avgbyte.asm ********************
        ORG   0100H
        JMP   start
msg     DB    13, 10, 'keyin an integer(-128..127) : ', '$'
s       TIMES 81 DB ' '
;
num1    DB    0
num2    DB    0
num3    DB    0
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
start:  MOV     DX, msg          ;顯示msg字串
        MOV     AH, 09H
        INT     21H
        readstr s
        strtob  s, '$', num1     ;將字串s轉換為數值num1
;
        MOV     DX, msg          ;顯示msg字串
        MOV     AH, 09H
        INT     21H
        readstr s
        strtob  s, '$', num2     ;將字串s轉換為數值num2
;
        MOV     DX, msg          ;顯示msg字串
        MOV     AH, 09H
        INT     21H
        readstr s
        strtob  s, '$',num3      ;將字串s轉換為數值num3
;
        MOVSX   AX, [num1]       ;AX=num1
        ADD     [sum], AX        ;sum=sum+num1
        MOVSX   AX, [num2]       ;AX=num2
        ADD     [sum], AX        ;sum=sum+num2
        MOVSX   AX, [num3]       ;AX=num3
        ADD     [sum], AX        ;sum=sum+num3
        itostr  sum, sumstr, '$' ;將sum轉成十進位數字
        MOV     DX, msgsum       ;顯示sum
        MOV     AH, 09H
        INT     21H
;
        MOV     AX, [sum]        ;AX=sum
        MOV     BL, 3            ;BL=3
        DIV     BL               ;sum/3
        MOV     [avg], AL        ;avg=sum/3
        btostr  avg, avgstr, '$' ;將avg轉成十進位數字
        MOV     DX, msgavg       ;顯示avg
        MOV     AH, 09H
        INT     21H
        MOV     AX, 4c00H
        INT     21H
