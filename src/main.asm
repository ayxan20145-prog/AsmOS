section .data
        msg db "hello world", 0

section .text
        global kernel_main

        extern clear
        extern print_byte
        extern print_string

kernel_main:
        call clear
        
        mov ebx, msg
        call print_string
        
        hlt

