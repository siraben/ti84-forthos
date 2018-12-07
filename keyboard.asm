; OS Keyboard Routines
; Exposes routines for interfacing with the keyboard.

; Waits for a key to be pressed, then returns it
waitKey:
wk_loop:
        call getKey
	or a
	jr z, wk_loop
	ret
	
; Waits for all keys to be released
flushkeys:
	push af
fk_loop:
        call getKey
	or a
	jr nz, fk_loop
	pop af
	ret

;;; Returns key in A.
        
getKey:
	push bc
	push de
	push hl
gs_GetK2:
	ld b,7
gs_GetK_loop:
	ld a,7
	sub b
	ld hl,gs_keygroups
	ld d,0 \ ld e,a
	add hl,de
	ld a,(hl)
	ld c,a

	ld a,0x0ff
	out (1),a
	ld a,c
	out (1),a
	nop \ nop \ nop \ nop
	in a,(1)

	ld de,0
	cp 254 \ jr z,gs_GetK_254
	cp 253 \ jr z,gs_GetK_253
	cp 251 \ jr z,gs_GetK_251
	cp 247 \ jr z,gs_GetK_247
	cp 239 \ jr z,gs_GetK_239
	cp 223 \ jr z,gs_GetK_223
	cp 191 \ jr z,gs_GetK_191
	cp 127 \ jr z,gs_GetK_127

gs_GetK_loopend:
	djnz gs_GetK_loop

	xor a
	ld (FlashExecutableRAM),a
	jr gs_GetK_end
gs_GetK_127:
	inc e
gs_GetK_191:
	inc e
gs_GetK_223:
	inc e
gs_GetK_239:
	inc e
gs_GetK_247:
	inc e
gs_GetK_251:
	inc e
gs_GetK_253:
	inc e
gs_GetK_254:
	push de
	ld a,7
	sub b
	add a,a \ add a,a \ add a,a
	ld d,0 \ ld e,a
	ld hl,gs_keygroup1
	add hl,de
	pop de
	add hl,de
	ld a,(hl)

	ld d,a
	ld a,(FlashExecutableRAM)
	cp d \ jr z,gs_getK_end
	ld a,d
	ld (FlashExecutableRAM),a

gs_GetK_end:
	pop hl
	pop de
	pop bc
	ret

gs_keygroups:
	.db 0xFE, 0xFD, 0xFB, 0xF7, 0xEF, 0xDF, 0xBF
gs_keygroup1:
	.db 0x01, 0x02, 0x03, 0x04, 0x00, 0x00, 0x00, 0x00
gs_keygroup2:
	.db 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x00, 0x0F, 0x00
gs_keygroup3:
	.db 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x00
gs_keygroup4:
	.db 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F, 0x20
gs_keygroup5:
	.db 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28
gs_keygroup6:
	.db 0x00, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F, 0x30
gs_keygroup7:
	.db 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38
