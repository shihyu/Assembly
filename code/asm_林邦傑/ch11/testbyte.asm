; ******************** testbyte.asm *******************
        ORG   0100H
        JMP   start
msg     DB    'please keyin a digit : ', '$'
char    DB    ' '
flag    DW    0
msgflag DB    'flag register : ', '$'
msgodd  DB    'you keyin an odd number!', '$'
msgeven DB    'you keyin an even number!', '$'
;
%include "..\mymacro\readchr.mac"
%include "..\mymacro\disp8bit.mac"
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\newline.mac"
;
start:
      dispstr  msg                ;顯示msg信息
      readchr  char               ;從鍵盤輸入一位數字
      newline                     ;換列
      TEST     BYTE [char], 01H   ;測試是否奇數
      PUSHF
      POP      WORD [flag]        ;flag=旗標暫存器值
      dispstr  msgflag            ;顯示msgflag信息
      disp8bit flag               ;顯示低8位元旗標
      newline                     ;換列
;
      PUSH     WORD [flag]
      POPF                        ;旗標暫存器值=flag值
      JNZ      oddNum             ;是奇數
      JZ       evenNum            ;是偶數
oddNum:
      dispstr  msgodd             ;顯示奇數信息
      JMP      next
evenNum:
      dispstr  msgeven            ;顯示偶數信息
next:
        MOV      AX, 4c00H
        INT      21H
