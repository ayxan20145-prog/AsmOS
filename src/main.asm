section .data
        msg db "hello world", 0
section .text
        global kernel_main

kernel_main:
        mov edi, 0xb8000

        call clear
        
        mov ebx, msg
        call print_string
        
        hlt

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
