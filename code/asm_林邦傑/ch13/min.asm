; ************************* min.asm **********************
        ORG   0100H
        JMP   start
count   DW    8
ary     DB    18, 25, 13, 56, 44, 78, 99, 66
msg     DB    'minimum number is = ', '$'
min     DB    0
;
%include "..\mymacro\dispb.mac"
%include "..\mymacro\dispstr.mac"
;
start:
        MOV     AL, BYTE [ary]      ;假設第0個元素值為最小
        MOV     SI, 1               ;SI=陣列第1個元素索引
        MOV     CX, [count]         ;CX=陣列元素個數
        DEC     CX
loop2:
        CMP     AL, BYTE [ary+SI]   ;AL:第SI元素值
        JL      next                ;AL較小
        XCHG    AL, BYTE [ary+SI]   ;互換
next:
        INC     SI                  ;下一個元素索引
        LOOP    loop2               ;繼續
        MOV     BYTE [min], AL      ;min為最小值
        dispstr msg                 ;顯示msg信息
        dispb   min                 ;顯示最小值
        MOV     AX, 4c00H
        INT     21H
