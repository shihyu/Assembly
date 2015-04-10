; ******************** readestr.asm ********************
        ORG    0100H
        JMP    start
msg     DB     'keyin a string (end with Enter) : ', '$'
newline DB     13, 10, '$'
buf     DB     80
n       DB     0
s       TIMES  81  DB  ' '
space   DB     ' '
;
%include "..\mymacro\readestr.mac"
%include "..\mymacro\showbyte.mac"
%include "..\mymacro\dispchr.mac"
%include "..\mymacro\dispstr.mac"
;
start:  dispstr  msg        ;顯示msg字串
        readestr 10, buf    ;從鍵盤輸入最多10個字元至buf
        dispstr  newline    ;換列
        MOV      CX, 10+3   ;13次(多出buf,n,0D位元組)
        MOV      SI, 0      ;下一個位元組位置
repeat:
        showbyte buf+SI     ;顯示下一個位元組內含(16進位)
        dispchr  space      ;空一格
        INC      SI         ;指向下一個位元組
        LOOP     repeat     ;重複執行共13次
        MOV      AX, 4c00H
        INT      21H
