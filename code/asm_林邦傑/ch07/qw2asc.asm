; ************************* qw2asc.asm *******************
        ORG    0100H
        JMP    start
len     DW     18
a       TIMES  18 DB 0
num1    DD     12345678H
num2    DD     9ABCDEF0H
lownum  DD     0
hinum   DD     0
;
%include "..\mymacro\dispubcd.mac"
%include "..\mymacro\ubcdadd1.mac"
%include "..\mymacro\ubcdmul2.mac"
;
start:
      MOV      EAX, DWORD [num1]    ;EAX=num1值
      MUL      DWORD [num2]         ;EDX:EAX=num1值*num2值
      MOV      DWORD [lownum], EAX  ;lownum乘積低位數
      MOV      DWORD [hinum], EDX   ;hinum乘積高位數
;
      MOV      BH, 32             ;BH=32位元
      MOV      BL, 32             ;BL=32位元
loop2:
      ubcdmul2 a, len             ;BCD變數a*2
      SHL      DWORD [hinum], 1   ;hinum左移一個位元
      JNC      next2              ;CF?否,跳至next2
      ubcdadd1 a, len             ;是,a加上CF
next2:
      DEC      BH                 ;BH=BH-1
      JZ       loop3              ;跳出loop2進入loop3
      JMP      loop2              ;繼續迴圈
loop3:
      ubcdmul2 a, len             ;BCD變數a*2
      SHL      DWORD [lownum], 1  ;lownum左移一個位元
      JNC      next3              ;CF?否,跳至next3
      ubcdadd1 a, len             ;是,a加上CF
next3:
      DEC      BL                 ;BL=BL-1
      JZ       next               ;跳出loop3進入next
      JMP      loop3              ;繼續迴圈
next:
      dispubcd a, len             ;顯示ASCII數字
      MOV      AX, 4c00H
      INT      21H
