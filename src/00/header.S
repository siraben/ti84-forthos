.import boot
.import interrupt

; RST 0x00
    jp boot

; RST 0x08
.block 0x08-$
    ret ; unused

.block 0x10-$
; RST 0x10
    ret ; unused

.block 0x18-$
; RST 0x18
    ret ; unused

.block 0x20-$
; RST 0x20
    ret ; unused

.block 0x28-$
; RST 0x28
    ret ; unused

.block 0x30-$    
; RST 0x30
    ret ; unused

.block 0x38-$
; RST 0x38
; SYSTEM INTERRUPT
    jp interrupt

.block 0x53-$
    jp boot

; 0x0056
; Magic number the boot code expects
.db 0xFF, 0xA5, 0xFF
