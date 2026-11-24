%ifndef VGA_INC
%define VGA_INC

%include "io.inc"

%define VGA_BUFFER 0xb8000

struc Writer
        .column: resd 1
        .row: resd 1
endstruc

extern writer_init
extern writer_write_byte
extern writer_write_str
extern writer_clear
extern writer_update_cursor

%endif
