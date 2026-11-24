%include "io.inc"

section .text
        global outb

; void outb(uint16_t port, uint8_t val)
; edi is port
; esi is val
outb:
        mov edx, edi
        mov eax, esi
        out dx, al
        ret
