; ******************** ubcdmul2.asm ********************
        ORG    0100H
        JMP    start
len     DW     4
astr    TIMES  80 DB ' '
a       TIMES  80 DB 0
msg     DB     'keyin a number with leading zero: ', '$'
;
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\readstr.mac"
%include "..\mymacro\str2ubcd.mac"
%include "..\mymacro\ubcdmul2.mac"
%include "..\mymacro\str2ubcd.mac"
%include "..\mymacro\dispubcd.mac"
%include "..\mymacro\newline.mac"
;
start:
      MOV      CX, -1            ;永遠迴圈
begin:
      dispstr  msg               ;顯示msg信息
      readstr  astr              ;鍵入數字字串
      newline                    ;換列
      CMP      BYTE [astr], '$'  ;Enter鍵?
      JNE      next              ;否
      JMP      endjob            ;是
next:
      str2ubcd astr, '$', a, len ;ASCII數字轉成BCD
      ubcdmul2 a, len            ;a*2
      dispubcd a, len
      newline
      JMP      begin             ;繼續
endjob:
      MOV      AX, 4c00H
      INT      21H
