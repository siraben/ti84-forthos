# `make` will build for the TI-84+ SE by default.
# Use e.g. `make TI73` to build for another platform
include platforms.make
.DEFAULT_GOAL=TI84p

AS=scas
ASFLAGS=-Iinclude/ -fexplicit-import -D$(PLATFORM)
CC=kcc
CFLAGS=-Iinclude/

OUTDIR:=.build

# Space delimited list of flash pages to include in upgrade files
FLASH_PAGES=00

# Targets for page 00
PAGE_00=\
	$(OUTDIR)/00/boot.S.o \
	$(OUTDIR)/00/display.c.o \
	$(OUTDIR)/00/display.S.o \
	$(OUTDIR)/00/flash.S.o \
	$(OUTDIR)/00/interrupt.S.o \
	$(OUTDIR)/00/main.c.o

# Targets for the boot page, whose assignment varies from model to model
PAGE_BOOT=\
	$(OUTDIR)/boot/base.S.o

# Targets for the privileged page, which can unlock/lock flash
PAGE_PRIVILEGED=\
	$(OUTDIR)/privileged/base.S.o

$(OUTDIR)/page00.o: $(OUTDIR)/00/header.S.o $(PAGE_00)
	$(AS) -c $(ASFLAGS) -o $@ $^

$(OUTDIR)/boot.o: $(PAGE_BOOT)
	$(AS) -c $(ASFLAGS) -o $@ $^

$(OUTDIR)/privileged.o: $(PAGE_PRIVILEGED)
	$(AS) -c $(ASFLAGS) -forigin=0x4000 -fexplicit-export -o $@ $^

hiti-%.rom: $(OUTDIR)/page00.bin $(OUTDIR)/boot.bin $(OUTDIR)/privileged.bin
	mkrom hiti-$(PLATFORM).rom $(LENGTH) \
		$(OUTDIR)/page00.bin:0x00 \
		$(OUTDIR)/boot.bin:0x$(BOOT) \
		$(OUTDIR)/privileged.bin:0x$(PRIVILEGED) \

hiti-%.73u: hiti-%.rom
	mktiupgrade -p -k keys/$(KEY).key -d $(DEVICE) \
		hiti-$(PLATFORM).rom \
		hiti-$(PLATFORM).73u \
		$(FLASH_PAGES)

hiti-%.8xu: hiti-%.rom
	mktiupgrade -p -k keys/$(KEY).key -d $(DEVICE) \
		hiti-$(PLATFORM).rom \
		hiti-$(PLATFORM).8xu \
		$(FLASH_PAGES)

hiti-%.8cu: hiti-%.rom
	mktiupgrade -p -k keys/$(KEY).key -d $(DEVICE) \
		hiti-$(PLATFORM).rom \
		hiti-$(PLATFORM).8cu \
		$(FLASH_PAGES)

$(OUTDIR)/%.S.o: src/%.S $(wildcard include/*.asm)
	@mkdir -p $(shell dirname $@)
	$(AS) $(ASFLAGS) -c -o $@ $<

$(OUTDIR)/%.c.o: src/%.c $(wildcard include/*.h)
	@mkdir -p $(shell dirname $@)
	$(CC) $(CFLAGS) -c -o $@ $<

$(OUTDIR)/%.bin: $(OUTDIR)/%.o
	$(AS) $(ASFLAGS) -o $@ $^

clean:
	rm -rf .build hiti-*.rom hiti-*.73u hiti-*.8xu hiti-*.8cu

z80e: hiti-$(PLATFORM).rom $(OUTDIR)/page00.o
	z80e-sdl -d $(PLATFORM) --debug \
		-o $(OUTDIR)/page00.o \
		-o $(OUTDIR)/boot.o \
		-o $(OUTDIR)/privileged.o \
		$<

.PHONY: clean z80e
