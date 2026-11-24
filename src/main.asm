%include "vga.inc"
%include "keyboard.inc"

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

.loop:
        call read_key
        cmp al, 0
        je .loop
        
        lea edi, [writer]
        movzx esi, al
        call writer_write_byte
        jmp .loop
