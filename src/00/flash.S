#include <constants.asm>
#include <platform.asm>

rst 0 ; Prevent runaway code from unlocking flash

unlock_flash:
    push af
    push bc
        GET_BANK_A
        push af
            SET_BANK_A(PRIVILEGED_PAGE)
            ld b, 0x01
            ld c, 0x14
            call 0x4001
        pop af
        SET_BANK_A
    pop bc
    pop af
    ret

;; lockFlash [Flash]
;;  Locks Flash and locks protected ports.
lock_flash:
    push af
    push bc
        GET_BANK_A
        push af
            SET_BANK_A(PRIVILEGED_PAGE)
            ld b, 0x00
            ld c, 0x14
            call 0x4004
        pop af
        SET_BANK_A
    pop bc
    pop af
    ret
