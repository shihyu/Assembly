; ********************* wordstr.asm *********************
        ORG   0100H
        JMP   start
wordstr DW    'Good Morning!', '$'
char    DW    '  ', '$'
start:
        MOV   DX, wordstr          ;DX=字串wordstr位址
        MOV   AH, 09H              ;設定顯示字串功能
        INT   21H                  ;顯示wordstr字串
;
        MOV   DX, wordstr+5        ;DX=字串wordstr+5位址
        MOV   AH, 09H              ;設定顯示字串功能
        INT   21H                  ;顯示wordstr+5字串
;
        MOV   AX, WORD [wordstr+5] ;AX=wordstr+5位址字元
        MOV   WORD [char], AX      ;char位址內含為AX
        MOV   DX, char             ;DX=字串char位址
        MOV   AH, 09H              ;設定顯示字串功能
        INT   21H                  ;顯示char字串
        MOV   AX, 4c00H
        INT   21H
