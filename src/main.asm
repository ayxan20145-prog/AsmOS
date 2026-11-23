%include "vga.inc"

section .bss
        writer: resb Writer_size

section .text
        global kernel_main

kernel_main:
        lea edi, [writer]
        call writer_init
        
        lea edi, [writer]
        mov esi, 'h'
        call writer_write_byte
        lea edi, [writer]
        mov esi, 'i'
        call writer_write_byte

        hlt
