; *************************** stack.asm ********************
        ORG     0100H
        JMP     start
data    TIMES   100 DW 0
link    TIMES   100 DW 0
top     DW      0
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
        MOV     SI, 0               ;SI為堆疊索引值
        MOV     WORD [top], SI      ;堆疊頂端頭節點索引值
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
        ADD     SI, 2               ;取得下一個可用節點
        MOV     BX, WORD [top]
        MOV     AX, WORD [numval]
        MOV     WORD [data+SI], AX  ;SI節點資料欄值=numval
        MOV     WORD [link+SI], BX  ;SI節點鏈欄值=top
        MOV     WORD [top], SI      ;top=SI
        JMP     loop1               ;繼續
endRead:
        newline                     ;輸入完畢,換列
        MOV     BP, WORD [top]      ;BX=top
loop2:
        dispi   data+BP             ;顯示BP節點的資料欄值
        dispstr blank
        MOV     BP, [link+BP]       ;BP=下一個節點索引值
        CMP     BP, 0               ;最後一個節點嗎?
        JNZ     loop2
        MOV     AX, 4c00H
        INT     21H
