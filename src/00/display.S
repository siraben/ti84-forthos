#include <constants.asm>

display_copy:
        push hl
        push bc
        push af
        push de
            ld a, i
            push af
                push iy \ pop hl
    
                ld c, PORT_LCD_CMD
                ld a, LCD_CMD_SETROW
.setRow:
                in f, (c)
                jp m, .setRow
                out (PORT_LCD_CMD), a
                ld de, 12
                ld a, LCD_CMD_SETCOLUMN
.col:
                in f, (c)
                jp m, .col
                out (PORT_LCD_CMD),a
                push af
                    ld b,64
.row:
                    ld a, (hl)
.rowWait:
                    in f, (c)
                    jp m, .rowWait
                    out (PORT_LCD_DATA), a
                    add hl, de
                    djnz .row
                pop af
                dec h
                dec h
                dec h
                inc hl
                inc a
                cp 0x0C + LCD_CMD_SETCOLUMN
                jp nz, .col
            pop af
        jp po, ._
        ei
._: pop de
    pop af
    pop bc
    pop hl
    ret
