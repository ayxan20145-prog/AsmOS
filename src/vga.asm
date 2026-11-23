%include "vga.inc"

section .text
        global writer_init
        global writer_write_byte

; void writer_init(Writer *writer)
; edi is writer
writer_init:
        mov dword [edi + Writer.column], 0
        mov dword [edi + Writer.row], 0
        ret

; void writer_write_byte(Writer *writer, char c)
; edi is writer
; esi is c
writer_write_byte:
        push ebx ; position

        ; position = row * 80 + column
        mov ebx, dword [edi + Writer.row]
        imul ebx, 80
        add ebx, dword [edi + Writer.column]

        mov eax, esi
        mov byte [VGA_BUFFER + ebx * 2], al
        mov byte [VGA_BUFFER + ebx * 2 + 1], 0x0F

        inc dword [edi + Writer.column]
        
        pop ebx
        ret

; void writer_clear(Writer *writer)
; rdi is writer
writer_clear:
        push ebx ; i
        xor ebx, ebx
.loop:
        cmp ebx, 2000
        jnb .done

        mov byte [VGA_BUFFER + ebx * 2], ' '
        mov byte [VGA_BUFFER + ebx * 2 + 1], 0x0F

        inc ebx
        jmp .loop
.done:
        mov dword [edi + Writer.column], 0
        mov dword [edi + Writer.row], 0
        pop ebx
        ret
