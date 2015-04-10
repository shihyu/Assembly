; *********************** avgary.asm *********************
        ORG   0100H
        JMP   start
msg     DB    13, 10, 'keyin an integer(-128..127) : ', '$'
s       TIMES 81 DB ' '
;
number  DB    0
num     DB    0, 0, 0
avg     DB    0
sum     DW    0
numptr  DW    num
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
        MOV     CX, 3
        MOV     SI, 0
label:
        MOV     DX, msg           ;顯示msg字串
        MOV     AH, 09H
        INT     21H
        readstr s                 ;鍵入一個字串至s
        strtob  s, '$', number    ;字串s轉換成整數
;
        MOV     AL, BYTE [number] ;AL=number
        MOV     BYTE [num+SI], AL ;存入num第SI個數
        INC     SI                ;SI=SI+1
        DEC     CX                ;CX=CX-1
        JCXZ    next              ;CX=0時跳出
        JMP     label             ;繼續迴圈
next:
        MOV     CX, 3             ;CX=3
        MOV     SI, 0             ;SI=0
loop3:
        MOVSX   AX, BYTE [num+SI] ;AX=num第SI個數
        ADD     WORD [sum], AX    ;累加至sum
        INC     SI                ;SI=SI+1
        LOOP    loop3             ;繼續迴圈
;
        btostr  sum, sumstr, '$'  ;將sum轉成十進位數字
        MOV     DX, msgsum        ;顯示sum
        MOV     AH, 09H
        INT     21H
;
        MOV     AX, [sum]         ;AX=sum
        MOV     BL, 3             ;BL=3
        DIV     BL                ;sum/3
        MOV     [avg], AL         ;avg=sum/3
        btostr  avg, avgstr, '$'  ;將avg轉成十進位數字
        MOV     DX, msgavg        ;顯示avg
        MOV     AH, 09H
        INT     21H
        MOV     AX, 4c00H
        INT     21H
