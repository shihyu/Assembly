; ********************** strtonum.asm ********************
         ORG      0100H
         JMP      start
stri     DB       '987', '$'          ;俱计﹃
strl     DB       '-987654321', '$'   ;俱计﹃
strf     DB       '9876.5', '$'      ;疊翴计﹃
numi     DW       0
numl     DD       0
numf     DD       0.0
;
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\newline.mac"
%include "..\mymacro\strtoi.mac"
%include "..\mymacro\strtol.mac"
%include "..\mymacro\strtof.mac"
%include "..\mymacro\dispi.mac"
%include "..\mymacro\displ.mac"
%include "..\mymacro\dispf.mac"
;
start:
      FINIT
      strtoi   stri, '$', numi    ;俱计﹃锣Θ计numi
      dispi    numi               ;陪ボnumi
      newline                     ;传
      strtol   strl, '$', numl    ;俱计﹃锣Θ计numl
      displ    numl               ;陪ボnuml
      newline                     ;传
      strtof   strf, numf         ;疊翴计﹃锣Θ计numf
      dispf    numf, 2            ;陪ボnumf
      newline                     ;传
;
      MOV      AX, 4c00H
      INT      21H
