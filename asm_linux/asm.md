### 安裝開發環境
```
sudo apt-get install build-essential gdb yasm nasm
```

- 基本上，我們已經有了組合語言的開發環境，下面是我從 Linux Assembly Tutorial Step-by-Step Guide 取得的範例程式碼再加上我自已寫的程式

```
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
        loop next            ;如果count是0,則跳離迴圈
 
        mov eax,4
        mov ebx,1
        mov ecx,linefeed
        mov edx,chrlen
        int 80h             ;輸出文字換行字元
         
 
 
        mov eax,1            ; The system call for exit (sys_exit)
        mov ebx,1            ; Exit with return code of 0 (no error)
        int 80h
```


```
yasm helloworld.asm -f elf -o helloworld.o // 32bit
yasm helloworld.asm -f elf64 -o helloworld.o  // 64bit
ld -s helloworld.o -o helloworld
./helloworld
```

- Debug資訊之產生之使用：為了能夠正確使用Debugger，我們要讓組譯器產生除錯資訊：

- 使用yasm
```
yasm -g dwarf2 helloworld.asm -f elf -o helloworld.o  // 32bit
yasm -g dwarf2 helloworld.asm -f elf64 -o helloworld.o  // 64bit
```
- 使用nasm
```
nasm -g helloworld.asm -f elf -o helloworld.o   // 32bit
nasm -g helloworld.asm -f elf64 -o helloworld.o  // 64bit
```

- 連結：
```
ld helloworld.o -o helloworld
```