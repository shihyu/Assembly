; ********************* prnhex.mac *******************
;
; prnhex cmem, byteCountValue
; 將cmem記憶體開始，共byteCountValue個內含值以十六進位
; 形式顯示於螢幕
;   cmem           : 字元所存放記憶體位址 (傳址)
;   byteCountValue : 共byteCountValue個位元組 (傳值)
;
%ifndef PRNHEX_MAC
%define PRNHEX_MAC
%MACRO prnhex 2             ;二個參數
       PUSHA                ;儲存原來暫存器資料
       MOV    CX, %2        ;字元數
       MOV    BP, 0         ;第一個字元
%%loop2:
        MOV   AL, [%+BP]   ;AL=要顯示的字元
        MOV   BL, 16       ;除數BL=16
        MOV   AH, 0        ;AH=0
        DIV   BL         ;AX/BL
        MOV   DH, AH     ;DH=低位數
        MOV   DL, AL     ;DL=高位數
        CMP   DL, 10     ;高位數<10?
        JL    %%less10H  ;是,跳至%%less10H
        ADD   DL, 7      ;10至15值DL=DL+7
%%less10H:
        ADD   DL, 30H    ;數值轉換為數字
        MOV   AH, 02H    ;設定顯示字元功能
        INT   21H        ;顯示字元
        MOV   DL, DH     ;DL=低位數
        CMP   DL, 10     ;低位數<10?
        JL    %%less10L  ;是,跳至%%less10L
        ADD   DL, 7      ;10至15值DL=DL+7
%%less10L:
        ADD   DL, 30H    ;數值轉換為數字
        MOV   AH, 02H    ;設定顯示字元功能
        INT   21H        ;顯示字元
       INC    BP            ;下一個字元
       LOOP   %%loop2       ;繼續
       POPA                 ;恢復原來暫存器資料
%ENDMACRO
%endif
