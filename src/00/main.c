#include <stdint.h>
#include <display.h>

int mod(int a, int b) {
  if (a < b) {
    return a;
  } else {
    return mod(a - b, b);
  }
}
int pos(int row, int col) {
  return (row * DISPLAY_WIDTH / 8 + col);
}

int mul(int x, int y) {
  if (x == 1) {
    return y;
  } else if (y == 1) {
    return x;
  }
  int res = 0;
  while(y != 0) {
    res += x;
    y--;
  }
  return res;
}
int prime(int n) {
  if (n < 3) {
    return (n == 2) ? 1 : 0;
  } else {
    for (int x = 2; mul(x,x) <= n; x++) {
      if (mod(n, x) == 0) {
        return 0;
      }
    }
    return 1;
  }
}
void main() {
	uint8_t *buffer = (uint8_t *)0x8000;
	uint8_t mask = 0;
	int row, col;

	for (row = 0; row < DISPLAY_HEIGHT; ++row) {
		for (col = 0; col < DISPLAY_WIDTH / 8; ++col) {
                  buffer[pos(row, col)] = prime(pos(row, col) >> 2) ? 0xff : 0;
		}
	}

	display_copy(buffer);

	while (1) {
          display_copy(buffer);
          buffer[0]++;
	}
}
