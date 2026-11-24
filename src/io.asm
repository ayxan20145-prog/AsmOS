%include "io.inc"

section .text
        global outb
        global inb

; void outb(uint16_t port, uint8_t val)
; edi is port
; esi is val
outb:
        mov edx, edi
        mov eax, esi
        out dx, al
        ret

; uint8_t inb(uint16_t port)
; edi is port
inb:
        mov edx, edi
        in al, dx
        ret
