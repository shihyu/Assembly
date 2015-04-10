; ************************ datetab.asm *******************
;
; 呼叫 21H 插斷功能 AH=0aH 時傳回下列值：
;
;   AL = day of week (sunday=0) 星期天數(星期日為0算起)
;   CX = year (1980-2099)       年數
;   DH = month (01-12)          月份
;   DL = day (01-31)            日數
;
          ORG   0100H
          JMP   start
lenmon    DW    3
montab    DB    'Jan', 'Feb', 'Mar', 'Apr'
          DB    'May', 'Jun', 'Jul', 'Aug'
          DB    'Sep', 'Oct', 'Nov', 'Dec'
month     DW    0
;
lenweek   DW    9
weektab   DB    'Sunday   ', 'Monday   ', 'Tuesday  ',
          DB    'Wednesday', 'Thursday ', 'Friday   '
          DB    'Saturday '
week      DW    0
year      DW    0
day       DW    0
;
msg       DB    'current date & time = ', '$'
monthstr  DB    '    ', '$'
weekstr   DB    '          ', '$'
blank     DB    ' $'
;
%include "..\mymacro\dispstr.mac"
%include "..\mymacro\strncpy.mac"
%include "..\mymacro\dispi.mac"
;
start:
      MOV     AH, 2aH                ;設定取得日期功能
      INT     21H                    ;取得日期
      MOV     BYTE [week], AL        ;將星期數存入week
      MOV     WORD [year], CX        ;將年數存入year
      MOV     BYTE [month], DH       ;將月份數存入month
      MOV     BYTE [day], DL         ;將日數存入day
;
      MOV     AX, [month]            ;AX=月份數
      DEC     AX                     ;從0算起
      MOV     BX, [lenmon]           ;BX=月份表鍵長度
      MUL     BX                     ;AX=(月份數-1)*鍵長度
      MOV     BP, montab             ;BP=montab位址
      ADD     BP, AX                 ;BP=montab位址+AX
                                     ;將找到的月份名稱
      strncpy  monthstr, BP, lenmon  ;拷貝至monthstr處
;
      MOV     AX, WORD [week]        ;AX=星期數(從0算起)
      MOV     BX, WORD [lenweek]     ;BX=星期表鍵長度
      MUL     BX                     ;AX=(星期數-1)*鍵長度
      MOV     BP, weektab            ;BP=weektab位址
      ADD     BP, AX                 ;BP=weektab位址+AX
                                     ;將找到的星期名稱
      strncpy  weekstr, BP, lenweek  ;拷貝至weekstr處
      dispstr  msg                   ;顯示msg信息
      dispstr  weekstr               ;星期名稱
      dispstr  monthstr              ;月份名稱
      dispi    day                   ;日數
      dispstr  blank
      dispi    year                  ;年份
      MOV      AX, 4c00H
      INT      21H
