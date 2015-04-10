; *********************** copyfile.asm *******************
          ORG   0100H
          JMP   start
buffer    TIMES 80 DB ' '
lenbuf    EQU   $-buffer
byteread  DW    0
RW EQU    02H
infile    DB    "kbdfile.txt", 00H
inhand    DW    0
outfile   DB    "diskfile.txt", 00H
outhand   DW    0
start:
          MOV   AL, RW              ;開啟讀寫檔
          MOV   DX, infile          ;輸入的檔名
          MOV   AH, 3dH             ;開啟檔案功能
          INT   21H                 ;開啟檔案
          MOV   [inhand], AX        ;傳回檔案代號
;
          MOV   CX, 0020H           ;Archive檔
          MOV   DX, outfile         ;檔案路徑
          MOV   AH, 3cH             ;建立一個檔案代號功能
          INT   21H                 ;建立一個檔案代號
          MOV   [outhand], AX       ;傳回檔案代號
readline:
          MOV   BX, [inhand]        ;從inhand檔讀入
          MOV   CX, lenbuf          ;lenbuf個字元
          MOV   DX, buffer          ;緩衝器位址
          MOV   AH, 3fH             ;從inhand檔讀入功能
          INT   21H                 ;從handle檔讀入
          MOV   [byteread], AX      ;讀入字元個數
          CMP   WORD [byteread], 0  ;檔尾嗎?
          JE    endjob              ;是
;
          MOV   BX, [outhand]       ;否,寫入outhand輸出檔
          MOV   CX, [byteread]      ;字元個數
          MOV   DX, buffer          ;緩衝器位址
          MOV   AH, 40H             ;寫入outhand輸出檔功能
          INT   21H                 ;寫入outhand輸出檔
;
          JMP   readline            ;讀取下一筆資料
endjob:
          MOV   BX, [inhand]       ;關閉輸入檔
          MOV   AH, 3eH
          INT   21H
          MOV   BX, [outhand]       ;關閉輸出檔
          MOV   AH, 3eH
          INT   21H
;
          MOV   AX, 4c00H
          INT   21H
