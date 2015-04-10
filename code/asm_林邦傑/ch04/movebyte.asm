; *********************** movebyte.asm ***********************
       ORG   0100H
       JMP   start
nasm   DB    'N', 'A', 'S', 'M'
start: MOV   DL, [nasm]           ;搬移nasm位址內含('N')至DL
       MOV   AH, 02H              ;顯示DL內含功能
       INT   21H                  ;顯示DL內含'N'
;
       MOV   DL, [nasm+1]         ;搬移nasm+1位址內含('A')至DL
       MOV   AH, 02H              ;顯示DL內含功能
       INT   21H                  ;顯示DL內含'A'
;
       MOV   DL, [nasm+2]         ;搬移nasm+2位址內含('S')至DL
       MOV   AH, 02H              ;顯示DL內含功能
       INT   21H                  ;顯示DL內含'S'
;
       MOV   DL, [nasm+3]         ;搬移nasm+3位址內含('M')至DL
       MOV   AH, 02H              ;顯示DL內含功能
       INT   21H                  ;顯示DL內含'M'
;
       MOV   AX, 4c00H            ;程式結束功能
       INT   21H                  ;程式結束
