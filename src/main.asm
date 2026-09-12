section .data
        msg db "hello world", 0

section .text
        global kernel_main

        extern clear
        extern print_byte
        extern print_string

kernel_main:
        mov edi, 0xb8000
        call clear
        
        mov ebx, msg
        call print_string
        
        hlt

