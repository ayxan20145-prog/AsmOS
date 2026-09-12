section .text
        global clear
        global print_byte
        global print_string
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

print_byte:
        mov [edi], al
        mov [edi + 1], 0x0F
        add edi, 2
        ret

print_string:
.loop:
        mov al, [ebx]
        cmp al, 0
        je .done

        call print_byte

        inc ebx
        jmp .loop
.done:
        ret

