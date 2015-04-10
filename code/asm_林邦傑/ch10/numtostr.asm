; ********************* numtostr.asm *********************
        ORG   0100H
        JMP   start
numi    DW    -12345               ;整數
numl    DD    123456789            ;長整數
numf    DD    -1234.567            ;浮點數
stri    TIMES 30 DB ' '            ;整數字串
strl    TIMES 30 DB ' '            ;長整數字串
strf    TIMES 30 DB ' '            ;浮點數字串
;
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\newline.mac"
%include "..\mymacro\itostr.mac"
%include "..\mymacro\ultostr.mac"
%include "..\mymacro\ftostr.mac"
;
start:
      FINIT                        ;浮點堆疊初始化
      ftostr   numf, 3, strf       ;浮點數轉成strf字串
      dispstr  strf                ;顯示strf字串
      newline                      ;換列
      ultostr  numl, strl, '$'     ;無號長整數轉成strl字串
      dispstr  strl                ;顯示strl字串
      newline                      ;換列
      itostr   numi, stri, '$'     ;有號整數轉成stri字串
      dispstr  stri                ;顯示stri字串
      newline                      ;換列
;
      MOV      AX, 4c00H
      INT      21H
