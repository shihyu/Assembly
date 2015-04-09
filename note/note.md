Gas
Forth をいじってるとどんどん低レベルの領域に興味が移っていく。gas を使って Hello World! 64bit バージョン。.code64 で 64bit 指定だと思う。。。32bit だと %eax とか書くレジスタを %rax と書く。

```
/* -*- mode: asm; coding: utf-8; -*-
as -o hello64.o hello64.s
ld -o hello64 hello64.o
./hello64
*/
.code64
.text

.global _start

_start:
        mov     $4,     %rax    # 出力システムコール
        mov     $1,     %rbx    # 標準出力
        mov     $msg,   %rcx    # 文字列のアドレス
        mov     $len,   %rdx    # 文字列の長さ
        int     $0x80           # システムコール実行

        mov     $1,     %rax    # exit システムコール
        mov     $0,     %rbx    # exit コード
        int     $0x80           # システムコール実行

.data

msg:    .ascii "Hello World!\nまみむめも♪\n"
msgend: len = msgend - msg
```


NASM でも
```
;; -*- mode: asm; coding: utf-8; -*-
;; nasm -f elf64 nasm.asm
;; ld -s -o nasm nasm.o
;; ./nasm

section .text

global _start

_start:
        mov     rax,     4    ; 出力システムコール
        mov     rbx,     1    ; 標準出力
        mov     rcx,   msg    ; 文字列のアドレス
        mov     rdx,   len    ; 文字列の長さ
        int     80h           ; システムコール実行

        mov     rax,     1    ; exit システムコール
        mov     rbx,     0    ; exit コード
        int     80h           ; システムコール実行

section .data

msg db 'Hello World!', 0ah, 'まみむめも♪', 0ah
len equ $ -msg
```


### http://syscalls.kernelgrok.com/


- PC = CS : IP


暫存器的不同主要體現在指令上
比如8086里的mul和div指令,就是乘法和除法,哪個暫存器是干什麼的都是定義好的
還有loop指令,是根據CX來判斷是否循環的
最重要的就是有的暫存器可以用來尋址而有的不能
比如ax不能用於尋址,就是說這樣的指令是錯誤的:
mov bx,[ax]
而bx可以用於尋址,這條指令就是正確的:
mov ax,[bx]











