section .text
        global kernel_main

kernel_main:
        mov edi, 0xb8000

        mov [edi], 'H'
        mov [edi + 1], 0x0F
        mov [edi + 2], 'i'
        mov [edi + 3], 0x0F

        hlt
