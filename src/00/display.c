#include <stdint.h>

void display_copy(uint8_t *screen) __naked {
	__asm
	POP HL
	POP IY
	CALL display_copy
	PUSH IY
	PUSH HL
	RET
	__endasm;

	screen;
}
