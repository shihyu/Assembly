; yasm helloworld.asm -f elf64 -o helloworld.o
; ld -s helloworld.o -o helloworld
; ./helloworld

section .data
        hello:     db 'Hello world!',10    ; 'Hello world!' plus a linefeed character
        helloLen:  equ $-hello             ; Length of the 'Hello world!' string
                                          ; (I'll explain soon)
        chr:           db 64              ;宣告存放要輸出字元之空間(A是65,因為一開始就會+1,所以是64)
        chrlen:        equ 1               ;輸出1個字元
        count:       dd 27                 ;有26個字母(因為一開始就會-1,所以是27)
        linefeed:    db 10                 ;換行字元
 
section .text
        global _start
 
_start:
        mov eax,4            ; The system call for write (sys_write)
        mov ebx,1            ; File descriptor 1 - standard output
        mov ecx,hello        ; Put the offset of hello in ecx
        mov edx,helloLen     ; helloLen is a constant, so we don't need to say
                            ;  mov edx,[helloLen] to get it's actual value
        int 80h              ; Call the kernel
 
next:   mov dl,[chr]         
        inc dl
        mov [chr],dl         ;這三行把chr加1 
         
        mov edx,[count]
        sub edx,1
        mov [count],edx      ;這三行把count減1
 
        mov eax,4
        mov ebx,1
        mov ecx,chr
        mov edx,chrlen
        int 80h              ;輸出文字
 
        mov ecx,[count]
