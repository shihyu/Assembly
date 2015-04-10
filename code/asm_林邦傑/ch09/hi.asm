; **************** hi.asm **************
     ORG   0100H
     CALL  hi        ;呼叫hi程序
     CALL  hi        ;呼叫hi程序
     MOV   AX, 4c00H
     INT   21H
hi:                  ;hi程序
     PUSHA           ;保存所有暫存器值
     MOV   DL, 'H'   ;DL='H'
     MOV   AH, 02H   ;設定顯示字元功能
     INT   21H       ;顯示DL內含字元
     MOV   DL, 'i'   ;DL='i'
     MOV   AH, 02H   ;設定顯示字元功能
     INT   21H       ;顯示DL內含字元
     POPA            ;恢復所有暫存器值
     RET
