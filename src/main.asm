%include "vga.inc"

section .bss
        writer: resb Writer_size

section .data
        msg db "Hello world", 10, "hi", 0

section .text
        global kernel_main

kernel_main:
        lea edi, [writer]
        call writer_init
        
        lea edi, [writer]
        call writer_clear

        lea edi, [writer]
        mov esi, msg
        call writer_write_str

        hlt
