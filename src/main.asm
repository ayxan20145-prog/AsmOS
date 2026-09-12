section .text
        global kernel_main

kernel_main:
        mov edi, 0xb8000

        call clear
        
        mov al, 'H'
        call print

        mov al, 'i'
        call print
        
        hlt

print:
        mov [edi], al
        mov [edi + 1], 0x0F
        add edi, 2
        ret

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
