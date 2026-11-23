section .text
        global kernel_main

kernel_main:
        mov edi, 0xb8000
        mov byte [edi], 'h'
        mov byte [edi + 1], 0x0F
        mov byte [edi + 2], 'i'
        mov byte [edi + 3], 0x0F
        hlt
