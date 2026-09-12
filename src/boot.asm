section .multiboot2_header
align 8

header_start:
    dd 0xe85250d6
    dd 0
    dd header_end - header_start
    dd 0x100000000 - (0xe85250d6 + 0 + (header_end - header_start))

    align 8
    dw 0
    dw 0
    dd 8

header_end:


section .text
bits 32

global start
extern kernel_main

start:
    mov esp, stack_top
    call kernel_main

    cli
    hlt


section .bss
align 16

stack_bottom:
    resb 4096

stack_top:
