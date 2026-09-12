section .data
        row dd 0
        column dd 0

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
        mov dword [row], 0
        mov dword [column], 0
        ret

print_byte:

        cmp dword [column], 80
        je .next_row

        mov edx, eax

        mov eax, [row]
        imul eax, 80
        add eax, [column]

        mov [edi + eax * 2], dl
        mov [edi + eax * 2 + 1], 0x0F

        inc dword [column]
        ret
.next_row:
        mov dword [column], 0
        inc dword [row]
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

