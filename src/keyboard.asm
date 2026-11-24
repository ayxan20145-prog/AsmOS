%include "keyboard.inc"

section .data
        keymap:
                db 0
                db 0
                db '1'
                db '2'
                times 124 db 0

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
.done:
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
        mov al, [ecx + edx] ; al = keymap[edx]
        ret
.label:
        mov al, 0
        ret
