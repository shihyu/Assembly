; ************************ if2.asm ***********************
        ORG   0100H
        JMP   start
msg     DB    'please keyin a character : ', '$'
newline DB    13, 10, '$'
msgchar DB    "the result character = '"
ch2     DB    ' ', "'", 13, 10, '$'
start:
        MOV   DX, msg               ;顯示msg字串
        MOV   AH, 09H
        INT   21H
        MOV   AH, 01H               ;從鍵盤輸入一字元至AL
        INT   21H
        MOV   [ch2], AL             ;將AL字元拷貝至ch2變數
;
        MOV   DX, newline              ;換列
        MOV   AH, 09H
        INT   21H
;
        MOV   AL, [ch2]             ;拷貝ch2變數值至AL
        CMP   AL, 'a'               ;AL內含值與'a'比較
        JNE   next                  ;不相等時跳至next
        MOV   BYTE [ch2], 'A'       ;相等時將ch2轉換為'A'
next:
        MOV   DX, msgchar           ;以字元方式顯示ch2
        MOV   AH, 09H
        INT   21H
        MOV   AX, 4c00H
        INT   21H
