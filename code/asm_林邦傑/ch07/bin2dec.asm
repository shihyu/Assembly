; ************ bin2dec.asm ***************
        ORG    0100H
        JMP    start
len     DW     4
a       DB     0, 0, 0, 0, '$'
b       DB     00000111B
;
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\ubcdadd1.mac"
%include "..\mymacro\ubcdmul2.mac"
%include "..\mymacro\ubcd2asc.mac"
%include "..\mymacro\showbyte.mac"
%include "..\mymacro\newline.mac"
;
start:
      MOV      CX, 8
loop2:
      ubcdmul2 a, len
      showbyte a+2
      showbyte a+3
      SHL      BYTE [b], 1
      JNC      next
      ubcdadd1 a, len
next:
      showbyte a+2
      showbyte a+3
      newline
      DEC      CX
      JCXZ     next2
      JMP      loop2
next2:
      ubcd2asc a, len
      showbyte a
      showbyte a+1
      showbyte a+2
      showbyte a+3
      newline
;
      dispstr  a
      RET
