
all:
	scas base.asm && \
	mkrom ti84-forthos.rom 0x100000 base.bin:0x00

debug:
	scas base.asm && \
	mkrom ti84-forthos.rom 0x100000 base.bin:0x00 && \
	z80e-sdl --debug -d TI84p ti84-forthos.rom

run:
	scas base.asm && \
	mkrom ti84-forthos.rom 0x100000 base.bin:0x00 && \
	z80e-sdl -d TI84p ti84-forthos.rom

