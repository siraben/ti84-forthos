#ifdef TI84p
#define CPU15
#define CRYSTAL_TIMERS
#define LINK_ASSIST
#define MD5_ACCELERATION
#define USB
#define CLOCK
.equ PRIVILEGED_PAGE 0x3C
.equ BOOT_PAGE       0x3F
#endif

.macro lcdout(reg, value)
    ld a, reg
    ld hl, value
    call writeLcdRegister
.endmacro

.macro SET_BANK_A
    out (6), a
.endmacro

.macro SET_BANK_A(page)
    ld a, page
    out (6), a
.endmacro

.macro GET_BANK_A
    in a, (6)
.endmacro

.macro SET_BANK_B
    out (7), a
.endmacro

.macro SET_BANK_B(page)
    ld a, page
    out (7), a
.endmacro

.macro GET_BANK_B
    in a, (7)
.endmacro
