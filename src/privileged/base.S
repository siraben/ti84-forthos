#include <constants.asm>

rst 0 ; Crash before runaway code breaks things
jp _unlock_flash
jp _lock_flash

_unlock_flash:
    ld a,i
    jp pe, ._
    ld a, i
._: push af
    di
    ld a, 1
    nop
    nop
    im 1
    di
    out (PORT_FLASHRWCONTROL), a
    pop af
    ret po
    ei
    ret
    
_lock_flash:
    ld a,i
    jp pe, ._
    ld a, i
._: push af
    di
    xor a
    nop
    nop
    im 1
    di
    out (PORT_FLASHRWCONTROL), a
    pop af
    ret po
    ei
    ret
