; ***************** putchar.asm ****************
        ORG   0100H
        MOV   DL, 'A'    ;顯示'A'字元
        MOV   AH, 02H
        INT   21H
        MOV   DL, 13     ;顯示CarriageReturn字元
        MOV   AH, 02H
        INT   21H
        MOV   DL, 10     ;顯示LineFeed字元
        MOV   AH, 02H
        INT   21H
        MOV   DL, 'B'    ;顯示'B'字元
        MOV   AH, 02H
        INT   21H
        MOV   DL, 7      ;顯示Beep字元
        MOV   AH, 02H
        INT   21H
        MOV   AX, 4c00H  ;End Process Function
        INT   21H 
