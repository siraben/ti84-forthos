clip_mask		.equ 0x8000 ; one byte of free RAM
FlashExecutableRAM	.equ 0x8000 ; Flash code is loaded here for execution
FlashExecutableRAMSize	.equ 100   ; This is the amount of space you leave for flash RAM (KnightOS uses this RAM for other stuff, so it's really like temp RAM)

SwapSector				.equ 0x38

.org 0x0000

OSHeader:
        jr Boot
        .db 0,0,0,0,0,0
        .db 0,0      ; rst 08h
        .db 0,0,0,0,0
        .db 0,0      ; rst 10h
        .db 0,0,0,0,0
        .db 0,0      ; rst 18h
        .db 0,0,0,0,0
        .db 0,0      ; rst 20h
        .db 0,0,0,0,0
        .db 0,0      ; rst 28h
        .db 0,0,0,0,0
        .db 0,0      ; rst 30h
        .db 0,0,0,0,0,0,0
        .dw SysInterrupt   ; rst 38h / System Interrupt
        .db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        .db 0,0,0,0,0,0,0,0,0
        jp Boot
        .db 0xff, 0xa5, 0xff
Boot:
        jr Start_Of_OS
SysInterrupt:
        exx
        ex af, af'
        in a, (4)
        bit 0, a
        jr nz, HandleON
        bit 1, a
        jr nz, HandleTimer1
        bit 2, a
        jr nz, HandleTimer2
        bit 4, a
        jr nz, HandleLink
        jr InterruptDone
HandleON:
        in a, (3)
        res 0, a
        out (3), a
        set 0, a
        out (3), a
        ; ON interrupt
        jr InterruptDone
HandleTimer1:
        in a, (3)
        res 1, a
        out (3), a
        set 1, a
        out (3), a
        ; Timer one interrupt (might be best to merge with timer 2)
        jr InterruptDone
HandleTimer2:
        in a, (3)
        res 2, a
        out (3), a
        set 2, a
        out (3), a
        ; Timer two interrupt
        jr InterruptDone
HandleLink:
        in a, (3)
        res 4, a
        out (3), a
        set 4, a
        out (3), a
        ; Link interrupt
InterruptDone:
        ex af, af'
        exx
        ei
        ret
Start_Of_OS:
        jp after_boot

#include "constants.asm"
#include "display.asm"
#include "keyboard.asm"
#include "os.asm"
