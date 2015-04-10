; ********************** monthtab.asm *******************
        ORG     0100H
        JMP     start
lenkey  DW      3
table   DB      'Jan', 'Feb', 'Mar', 'Apr'
        DB      'May', 'Jun', 'Jul', 'Aug'
        DB      'Sep', 'Oct', 'Nov', 'Dec'
monnum  DW      10
msg     DB      'keyin month number (1-12) : ', '$'
monstr  DB      '    ', '$'
msg2    DB      'name of month is = '
monname DB      '    ', '$'
;
%include "..\mymacro\readstr.mac"
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\newline.mac"
%include "..\mymacro\strncpy.mac"
%include "..\mymacro\strtoi.mac"
;
start:
        dispstr msg                 ;顯示msg信息
        readstr monstr              ;鍵入月份數值
        newline                     ;換列
        strtoi  monstr, '$', monnum ;字串轉換數值monnum
;
        MOV     AX, [monnum]        ;AX=月份數
        DEC     AX                  ;從0算起
        MUL     WORD [lenkey]       ;AX=(月份數-1)*鍵長度
        ADD     AX, table           ;AX=AX+table位址
        MOV     BP, AX              ;BP=AX
                                    ;將找到的月份名稱
        strncpy monname, BP, lenkey ;拷貝至monname處
        dispstr msg2                ;顯示月份名稱
        MOV     AX, 4c00H
        INT     21H
