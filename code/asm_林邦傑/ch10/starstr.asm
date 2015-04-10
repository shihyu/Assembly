; ******************* starstr.asm ****************
        ORG   0100H
        JMP   start
starstr TIMES 36 DB '*'
        DB    '$'
start:
        MOV   DX, starstr     ;DX=字串starstr位址
        MOV   AH, 09H         ;設定顯示字串功能
        INT   21H             ;顯示starstr字串
        MOV   AX, 4c00H
        INT   21H
