#include <stdint.h>

void main() {
	uint8_t *screen = (uint8_t *)0x8000;
	int i;

	for (i = 0; i < 96 * 64 * 8; ++i) {
		screen[i] = 0xFF;
	}

	while (1) {
		// Do nothing
	}
}
