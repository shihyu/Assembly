; ********************** repmovsb.asm ********************
        ORG   0100H
        JMP   start
lenpat  DW    4
len     DW    44
strpat  DB    '*--*'
        TIMES 40 DB ' '
        DB    '$'
msgpat  DB    'pattern string : ', '$'
msgfill DB    'after fill pattern string : ', '$'
;
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\newline.mac"
;
start:
      dispstr  msgpat             ;顯示msgpat信息
      newline                     ;換列
      dispstr  strpat             ;顯示樣板字串strpat
      newline                     ;換列
      MOV      CX, [len]          ;CX=字串strpat長度
      SUB      CX, WORD [lenpat]  ;減去樣式長度
      MOV      SI, strpat         ;SI=來源字串strpat位址
      MOV      DI, strpat         ;DI=目的字串strpat位址
      ADD      DI, WORD [lenpat]  ;跳過樣式
      CLD                         ;方向,從左至右
      REP MOVSB                   ;重複拷貝樣板
      dispstr  msgfill            ;顯示msgfill信息
      newline                     ;換列
      dispstr  strpat             ;顯示目的字串strpat
      MOV      AX, 4c00H
      INT      21H
