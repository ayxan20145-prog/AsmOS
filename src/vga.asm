%define VGA_BUFFER 0xb8000

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

        mov [VGA_BUFFER + edx * 2], ' '
        mov [VGA_BUFFER + edx * 2 + 1], 0x0F

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

        mov [VGA_BUFFER + eax * 2], dl
        mov [VGA_BUFFER + eax * 2 + 1], 0x0F

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

