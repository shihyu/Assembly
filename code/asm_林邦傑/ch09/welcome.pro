; **************** welcome.pro ******************
;
; CALL welcome
;   顯示 Welcome!! 信息
;
welcome:                      ;welcome程序
        JMP   .begin
.msg    DB    'Welcome!!', 13, 10, '$'
.begin:
        PUSHA                 ;保存所有暫存器值
        MOV   DX, .msg        ;DX=.msg位址
        MOV   AH, 09H         ;設定顯示字串功能
        INT   21H             ;顯示.msg字串
        POPA                  ;恢復所有暫存器值
        RET
