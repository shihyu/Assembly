; *********************** kbdfile.asm ********************
          ORG   0100H
          JMP   start
KEYBOARD  EQU   0000H
buffer    TIMES 80 DB ' '
lenbuf    EQU   $-buffer
byteread  DW    0
filename  DB    "kbdfile.txt", 00H
handle    DW    0
msg       DB    'please keyin a string : ', '$'
errmsg    DB    'keyin error!!', '$'
;
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\newline.mac"
;
start:
        MOV     CX, 0020H           ;Archive檔
        MOV     DX, filename        ;檔案路徑
        MOV     AH, 3cH             ;建立一個檔案代號功能
        INT     21H                 ;建立一個檔案代號
        MOV     [handle], AX        ;傳回檔案代號handle
keyin:
        dispstr msg                 ;顯示msg輸入信息
        MOV     BX, KEYBOARD        ;鍵盤檔案代號KEYBOARD
        MOV     CX, lenbuf          ;緩衝器長度
        MOV     DX, buffer          ;緩衝器位址
        MOV     AH, 3fH             ;鍵盤讀入功能
        INT     21H                 ;鍵盤讀入
        JC      kbdErr              ;錯誤時
        MOV     [byteread], AX      ;實際讀入長度
        CMP     WORD [byteread], 0  ;檔尾嗎?CtrlZ
        JE      endjob              ;是
        MOV     BX, [handle]        ;檔案代號
        MOV     CX, [byteread]      ;資料長度
        MOV     DX, buffer          ;緩衝器位址
        MOV     AH, 40H             ;寫入檔案功能
        INT     21H                 ;寫入檔案
        JMP     keyin               ;繼續從鍵盤輸入
kbdErr:
        dispstr errmsg              ;顯示鍵盤錯誤信息
endjob:
        MOV     BX, [handle]        ;檔案代號
        MOV     AH, 3eH             ;關閉檔案功能
        INT     21H                 ;關閉檔案
;
        MOV   AX, 4c00H
        INT   21H
