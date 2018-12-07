all:
	scas os.asm && \
	mkrom ti84-forthos.rom 0x100000 os.bin:0x00 && \
	z80e-sdl --debug -d TI84p ti84-forthos.rom
