#include <constants.asm>
#include <platform.asm>
#include <flash.asm>

boot:
    di
    ld sp, 0

    ; Configure some sane defaults
    ld a, 3 << MEM_TIMER_SPEED
    out (PORT_MEM_TIMER), a ; Memory mode 0

#ifdef FLASH4MB
    xor a
    out (PORT_MEMA_HIGH), a
    out (PORT_MEMB_HIGH), a
#endif

#ifdef CPU15
    ; Set memory mapping
    ; Bank 0: Flash Page 00
    ; Bank 1: Flash Page *
    ; Bank 2: RAM Page 01
    ; Bank 3: RAM Page 00 ; In this order for consistency with TI-83+ and TI-73 mapping
    ld a, 1 | BANKB_ISRAM_15MHZ
    out (PORT_BANKB), a
#else
    ; Set memory mapping
    ; Bank 0: Flash Page 00
    ; Bank 1: Flash Page *
    ; Bank 2: RAM Page 01
    ; Bank 3: RAM Page 00
    ld a, 1 | BANKB_ISRAM_6MHZ
    out (PORT_BANKB), a
#endif

#ifdef CPU15
    ld a, BIT_CPUSPEED_15MHZ
    out (PORT_CPUSPEED), a
#endif

    ; TODO: You should enable some interrupts
    xor a
    out (PORT_INT_MASK), a

    ; Remove RAM/Flash execution protection so we can execute code from anywhere
    call unlock_flash
#ifdef CPU15
    xor a
    out (PORT_RAMEXEC_LOWLIMIT), a
    dec a
    out (PORT_RAMEXEC_UPLIMIT), a
    out (PORT_FLASHEXEC_LOWLIMIT), a 
    out (PORT_FLASHEXEC_UPLIMIT), a
#else
    xor a
    out (PORT_RAM_PAGING), a
    out (PORT_FLASHEXCLUSION), a
    inc a
    out (PORT_RAM_PAGING), a
    xor a
    out (PORT_FLASHEXCLUSION), a
#endif
    call lock_flash

.import _main
    jp _main
