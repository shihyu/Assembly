; ************************ dumpfile.asm *******************
         ORG   0100H
         JMP   start
char     DB    ' '
count    DW    0
byteread DW    0
RW       EQU   02H
filename TIMES 36 DB ' '
handle   DW    0
space    DB    ' ', '$'
msg      DB    'please keyin file name : ', '$'
;
%include "..\mymacro\readzstr.mac"
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\newline.mac"
%include "..\mymacro\showbyte.mac"
;
start:
        dispstr  msg              ;顯示msg信息
        readzstr filename         ;從鍵盤輸入檔名ASCIIZ字串
        newline                   ;換列
;
        MOV   AL, RW              ;開啟讀寫檔
        MOV   DX, filename        ;輸入的檔名
        MOV   AH, 3dH             ;開啟檔案功能
        INT   21H                 ;開啟檔案
        MOV   [handle], AX        ;傳回檔案代號
;
readbyte:
        MOV   BX, [handle]        ;從handle檔讀入一個字元
        MOV   CX, 1               ;一個字元
        MOV   DX, char            ;字元存放位址
        MOV   AH, 3fH             ;從handle檔讀入功能
        INT   21H                 ;從handle檔讀入
        MOV   [byteread], AX      ;字元個數
        CMP   WORD [byteread], 0  ;檔尾嗎?
        JE    endjob              ;是
;
        showbyte char             ;以16進位顯示讀入字元
        dispstr  space            ;空白
        INC      WORD [count]     ;count值=count值+1
        MOV      AX, WORD [count] ;AX=count值
        MOV      BL, 16           ;BL=16
        DIV      BL               ;AX/16
        CMP      AH, 0            ;餘數0?
        JNE      next             ;否
        newline                   ;換列
next:
        JMP   readbyte            ;繼續讀下一個字元
endjob:
        MOV   BX, [handle]        ;關閉輸入檔
        MOV   AH, 3eH
        INT   21H
;
        MOV   AX, 4c00H
        INT   21H
