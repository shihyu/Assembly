; ************************ hex.asm ***********************
        ORG   0100H
        JMP   start
msg     DB    'please keyin a character : ', '$'
ch2     DB    ' '
msghex  DB    13, 10, 'hex number = ', '$'
;
start:  MOV   DX, msg               ;顯示msg字串
        MOV   AH, 09H
        INT   21H
        MOV   AH, 01H               ;從鍵盤輸入一字元至AL
        INT   21H
        MOV   [ch2], AL             ;將AL字元拷貝至ch2變數
;
        MOV   DX, msghex            ;顯示msghex字串
        MOV   AH, 09H
        INT   21H
;
        MOV   DL, [ch2]             ;顯示ch2高位(16進位數)
        MOV   CL, 4
        SHR   DL, CL
        CMP   DL, 10
        JL    high
        ADD   DL, 7
high:   ADD   DL, 30H
        MOV   AH, 02H
        INT   21H
;
        MOV   DL, [ch2]             ;顯示ch2低位(16進位數)
        AND   DL, 0fH
        CMP   DL, 10
        JL    low
        ADD   DL, 7
low:    ADD   DL, 30H
        MOV   AH, 02H
        INT   21H
;
        MOV   AX, 4c00H
        INT   21H
