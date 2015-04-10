; *************************** queue.asm ********************
        ORG     0100H
        JMP     start
data    TIMES   100 DW 0
link    TIMES   100 DW 0
head    DW      0
tail    DW      0
msg     DB      'keyin number (0-65535, Enter end) : ', '$'
numstr  TIMES   80 DB ' '
numval  DW      0
blank   DB      ' $'
;
%include "..\mymacro\readstr.mac"
%include "..\mymacro\strtoi.mac"
%include "..\mymacro\dispi.mac"
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\newline.mac"
;
start:
        MOV     SI, 0               ;SI為佇列索引值
        MOV     WORD [head], SI     ;佇列頭節點索引值
        MOV     WORD [tail], SI     ;佇列尾節點索引值
        MOV     WORD [data], SI     ;佇列頭節點資料欄值
        MOV     WORD [link], SI     ;佇列頭節點鏈欄值
loop1:
        dispstr msg                 ;顯示輸入信息
        readstr numstr              ;輸入一個整數字串
        CMP     BYTE [numstr], '$'  ;輸入結束嗎?
        JNE     next                ;否
        JMP     endRead             ;是
next:
        newline                     ;換列
        strtoi  numstr, '$', numval ;整數字串轉成數值
;
        ADD     SI, 2               ;取得下一個可用結點
        MOV     AX, WORD [numval]
        MOV     WORD [data+SI], AX  ;SI結點資料欄值=numval
        MOV     WORD [link+SI], 0   ;SI結點鏈欄值=0
;
        MOV     DI, WORD [tail]     ;DI=尾結點索引值
        MOV     WORD [link+DI], SI  ;原尾結點鏈欄值=SI
        MOV     WORD [tail], SI     ;尾結點索引值=SI
        JMP     loop1               ;繼續
endRead:
        newline                     ;輸入完畢,換列
        MOV     BX, WORD [head]     ;BX=頭結點索引值
        MOV     BP, WORD [link+BX]  ;BP=頭結點鏈欄值
loop2:
        dispi   data+BP             ;顯示BP結點的資料欄值
        dispstr blank
        MOV     BP, [link+BP]       ;BP=下一個結點索引值
        CMP     BP, 0               ;最後一個結點嗎?
        JNZ     loop2               ;否
        MOV     AX, 4c00H
        INT     21H
