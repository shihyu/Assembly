; ************* printchr.pro ************
;
; CALL printchr
;   將AL之字元顯示於螢幕
;   輸入參數 AL : 字元值
;
%ifndef PRINTCHR_PRO
%define PRINTCHR_PRO
printchr:
      PUSHA          ;儲存原來暫存器資料
      MOV   DL, AL   ;DL=字元
      MOV   AH, 02H  ;設定顯示字元功能
      INT   21H      ;顯示字元
      POPA           ;恢復原來暫存器資料
      RET
%endif
