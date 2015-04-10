; ********************** booktab.asm ********************
        ORG     0100H
        JMP     start
lenkey  DW      5
lendata DW      16
lentab  DW      5
table   DB      '29033', 'Java programming',
        DB      '29034', 'JSP programming ',
        DB      '29009', 'C/C++Programming',
        DB      '29088', 'webpage design  ',
        DB      '31033', 'NASM programming'
;
result  DW      0
msgerr  DB      'book number not found!', '$'
msgdata DB      'book name = ',
data    DB      '                    ', '$'
msgkey  DB      'please keyin book number : ', '$'
key     DB      '     ', '$'
;
%include "..\mymacro\readstr.mac"
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\newline.mac"
%include "..\mymacro\strncpy.mac"
%include "..\mymacro\strncmp.mac"
;
start:
        dispstr msgkey                  ;顯示msgkey信息
        readstr key                     ;輸入書號(5位數字)
        newline                         ;換列
;
        MOV     CX, [lentab]            ;CX=表格總記錄數
        MOV     BP, table               ;BP=table位址
loop2:
        strncmp key, BP, lenkey, result ;key與記錄鍵比較
        CMP     WORD [result], 0        ;是否相同?
        JE      equal                   ;是,跳至equal
        ADD     BP, [lenkey]            ;BP=BP+鍵長度
        ADD     BP, [lendata]           ;BP=BP+資料長度
        LOOP    loop2                   ;繼續迴圈
notfound:
        dispstr msgerr                  ;找不到,顯示錯誤
        JMP     endjob                  ;結束
equal:
        ADD     BP, [lenkey]            ;BP=BP+鍵長度
        strncpy data, BP, lendata       ;將資料拷貝至data
        dispstr msgdata                 ;顯示資料
endjob:
        MOV     AX, 4c00H
        INT     21H
