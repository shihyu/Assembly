; ************************* writestr.pro *************************
;
; CALL writestr
;   將BP暫存器所指字串，CX字串長度，BL屬性，在目前游標處顯示出來。
;   BP : 要顯示的字串記憶體位址。
;   CX : 字串長度，包括 00H 結束符號。
;   BL : 要顯示的字串屬性。位元 7-4 背景顏色，0-3 前景顏色。
;
%ifndef WRITESTR_PRO
%define WRITESTR_PRO
;
writestr:
      PUSHA             ;儲存原來暫存器資料
      MOV  AH, 03H      ;取得游標位置DH列DL行
      INT  10H
      MOV  BH, 00H             ;BH=current page
      MOV  AH, 13H             ;AH=13h列印字串功能
      MOV  AL, 01H             ;一字一字列印
      INT  10H                 ;執行列印字串功能
      POPA              ;恢復原來暫存器資料
      RET
%endif
