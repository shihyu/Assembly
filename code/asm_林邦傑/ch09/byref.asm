; ********************* byref.asm ********************
        ORG   0100H
        JMP   start
msg     DB    '3', '2', '1', '$'
;
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\newline.mac"
;
start:
        dispstr msg           ;呼叫printmsg程序之前
        newline               ;換列
        MOV     BX, msg       ;msg位址當引數存入BX
        CALL    printmsg      ;呼叫printmsg程序
        dispstr msg           ;呼叫printmsg程序之後
        newline               ;換列
        MOV     AX, 4c00H
        INT     21H
;-----------------------------------------------------
printmsg:
        PUSHA                 ;儲存原來暫存器資料
        MOV   BYTE [BX], '9'  ;將'9'搬移至BX所指位址
        POPA                  ;恢復原來暫存器資料
        RET
