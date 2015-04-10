; *********************** dispfile.asm *******************
         ORG   0100H
         JMP   start
buffer   TIMES 255 DB ' '
lenbuf   EQU   $-buffer
byteread DW    0
RW       EQU   02H
filename DB    "kbdfile.txt", 00H
handle   DW    0
;
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\newline.mac"
;
start:
        MOV   AL, RW                ;開啟讀寫檔
        MOV   DX, filename          ;輸入的檔名
        MOV   AH, 3dH               ;開啟檔案功能
        INT   21H                   ;開啟檔案
        MOV   [handle], AX          ;傳回檔案代號
;
readline:
        MOV   BX, [handle]          ;從handle檔讀入資料
        MOV   CX, lenbuf            ;lenbuf個字元
        MOV   DX, buffer            ;緩衝器位址
        MOV   AH, 3fH               ;從handle檔讀入功能
        INT   21H                   ;從handle檔讀入
        MOV   [byteread], AX        ;讀入字元個數
        CMP   WORD [byteread], 0    ;檔尾嗎?
        JE    endjob                ;是
;
        MOV   BX, [byteread]        ;BX=讀入字元個數
        MOV   BYTE [buffer+BX], '$' ;附加一個字串結束符號
        dispstr buffer              ;顯示讀入資料
        newline                     ;換列
;
        JMP   readline              ;讀下一筆資料
endjob:
        MOV   BX, [handle]         ;關閉輸入檔
        MOV   AH, 3eH
        INT   21H
;
        MOV   AX, 4c00H
        INT   21H
