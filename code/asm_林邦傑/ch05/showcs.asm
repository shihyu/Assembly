; ************************ showcs.asm **********************
        ORG      0100H
        JMP      start
value   DW       123
csmsg   DB       'CS (in hex) = ', '$'
;
%include "../mymacro/showbyte.mac"
;
start:
        MOV      [value], CS  ;將CS存入value記憶體位址
        MOV      DX, csmsg    ;顯示16進位字串csstr
        MOV      AH, 09H
        INT      21H
        showbyte value+1      ;以16進位顯示value+1位址的內含
        showbyte value        ;以16進位顯示value位址的內含
        MOV      AX, 4c00H
        INT      21H 
