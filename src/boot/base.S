#include <constants.asm>

; Dummy boot page to get emulators to boot
    jr _
    .block 0x0F - $
    .db "Emulated", 0 ; Boot code version
_:
; Set the Flash chip size and jumps to the OS
#ifdef TI84p
    in a, (PORT_FLASHRAMSIZE)
    res BIT_FLASHRAMSIZE_FLASHCHIP, a
    out (PORT_FLASHRAMSIZE), a
#else
    in a, (PORT_FLASHRAMSIZE)
    set BIT_FLASHRAMSIZE_FLASHCHIP, a
    out (PORT_FLASHRAMSIZE), a
#endif
    jp 0x4000
