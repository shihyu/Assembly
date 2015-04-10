; ********************* string.asm *******************
        ORG   0100H
        JMP   start
string  DB    'Good Morning!', '$'
char    DB    ' ', '$'
start:
        MOV   DX, string          ;DX=字串string位址
        MOV   AH, 09H             ;設定顯示字串功能
        INT   21H                 ;顯示string字串
;
        MOV   DX, string+5        ;DX=字串string位址
        MOV   AH, 09H             ;設定顯示字串功能
        INT   21H                 ;顯示string字串
;
        MOV   AL, BYTE [string+5] ;AL=string+5位址字元
        MOV   BYTE [char], AL     ;char位址內含為AL
        MOV   DX, char            ;DX=字串char位址
        MOV   AH, 09H             ;設定顯示字串功能
        INT   21H                 ;顯示char字串
        MOV   AX, 4c00H
        INT   21H
