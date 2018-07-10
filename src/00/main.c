#include <stdint.h>
#include <display.h>

void main() {
	uint8_t *buffer = (uint8_t *)0x8000;
	uint8_t mask = 0xAA;
	int row, col;

	for (row = 0; row < DISPLAY_HEIGHT; ++row) {
		for (col = 0; col < DISPLAY_WIDTH / 8; ++col) {
			buffer[row * DISPLAY_WIDTH / 8 + col] = mask;
		}
		if ((mask & 1)) {
			mask = mask << 1;
		} else {
			mask = mask << 1 | 1;
		}
	}

	display_copy(buffer);

	while (1) {
		// Do nothing
	}
}
