; ************************ okstr.asm *********************
      ORG   0100H
      JMP   start
okstr DB    'O', 'K', '$'
start:
      MOV   DL, BYTE [okstr]    ;okstr的偏移位址的內含值
      MOV   AH, 02H             ;顯示DL內含字元
      INT   21H
      MOV   DL, BYTE [okstr+1]  ;okstr+1的偏移位址的內含值
      MOV   AH, 02H             ;顯示DL內含字元
      INT   21H
      MOV   DL, BYTE [okstr+2]  ;okstr+2的偏移位址的內含值
      MOV   AH, 02H             ;顯示DL內含字元
      INT   21H
      MOV   AX, 4c00H
      INT   21H
