%include "vga.inc"

section .text
        global writer_init
        global writer_write_byte
        global writer_write_str
        global writer_clear

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
        mov eax, esi
        cmp al, 10
        je .new_line

        cmp dword [edi + Writer.column], 80
        jae .next_row

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
.new_line:
        mov dword [edi + Writer.column], 0
        inc dword [edi + Writer.row]
        ret
.next_row:
        mov dword [edi + Writer.column], 0
        inc dword [edi + Writer.row]
        jmp writer_write_byte

; void writer_write_str(Writer *writer, char *s)
; edi is writer
; esi is s
writer_write_str:
        push ebx
        mov ebx, esi ; ebx = pointer
.loop:
        movzx esi, byte [ebx] ; esi = char
        cmp esi, 0
        je .done
        call writer_write_byte
        inc ebx
        jmp .loop
.done:
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
