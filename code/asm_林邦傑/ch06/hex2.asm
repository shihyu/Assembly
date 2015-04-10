; *********************** hex2.asm ********************
        ORG   0100H
        JMP   start
msg     DB    'please keyin a character : ', '$'
ch2     DB    ' '
msghex  DB    13, 10, 'hex number = ', '$'
;
%include "../mymacro/showbyte.mac"
;
start:  MOV      DX, msg         ;顯示msg字串
        MOV      AH, 09H
        INT      21H
        MOV      AH, 01H         ;從鍵盤輸入一字元至AL
        INT      21H
        MOV      [ch2], AL       ;將AL字元拷貝至ch2變數
;
        MOV      DX, msghex      ;顯示msghex
        MOV      AH, 09H
        INT      21H
        showbyte ch2             ;ch2以16進位顯示
        MOV      AX, 4c00H
        INT      21H
