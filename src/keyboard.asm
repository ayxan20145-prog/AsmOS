%include "keyboard.inc"

section .data
keymap:
        ; 0x00 - 0x0F
        db 0, 27, '1', '2', '3', '4', '5', '6'
        db '7', '8', '9', '0', '-', '=', 8, 9

        ; 0x10 - 0x1F
        db 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i'
        db 'o', 'p', '[', ']', 10, 0, 'a', 's'

        ; 0x20 - 0x2F
        db 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';'
        db "'", '`', 0, 0x5C, 'z', 'x', 'c', 'v'

        ; 0x30 - 0x3F
        db 'b', 'n', 'm', ',', '.', '/', 0, '*'
        db 0, ' ', 0, 0, 0, 0, 0, 0

        ; 0x40 - 0x4F
        db 0, 0, 0, 0, 0, 0, 0, '7'
        db '8', '9', '-', '4', '5', '6', '+', '1'

        ; 0x50 - 0x5F
        db '2', '3', '0', '.', 0, 0, 0, 0
        times 8 db 0

        ; 0x60 - 0x6F
        times 16 db 0

        ; 0x70 - 0x7F
        times 16 db 0

section .text
        global read_scancode
        global read_key

; uint8_t read_scancode()
read_scancode:
.loop:
        mov edi, 0x64
        call inb
        and al, 1
        cmp al, 0
        je .loop

        mov edi, 0x60
        call inb
        ret

; char read_key()
read_key:
        call read_scancode

        test al, 0x80
        jnz .label

        movzx edx, al
        lea ecx, [keymap]
        mov al, [ecx + edx]
        ret

.label:
        xor al, al
        ret
