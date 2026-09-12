section .text
        global kernel_main

kernel_main:
        mov edi, 0xb8000

        call clear
        
        mov [edi], 'H'
        mov [edi + 1], 0x0F
        mov [edi + 2], 'i'
        mov [edi + 3], 0x0F

        hlt

clear:
        xor edx, edx
.loop:
        cmp edx, 2000
        je .done

        mov [edi + edx * 2], ' '
        mov [edi + edx * 2 + 1], 0x0F

        inc edx
        jmp .loop
.done:
        ret
