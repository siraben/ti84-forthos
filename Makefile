# `make` will build for the TI-84+ SE by default.
# Use e.g. `make TI73` to build for another platform
include platforms.make
PLATFORM:=TI84pSE
.DEFAULT_GOAL=TI84pSE

AS=scas
OUTDIR:=.build
ASFLAGS=-Iinclude/ -fexplicit-import -D$(PLATFORM)

# Targets for page 00
PAGE_00=\
	$(OUTDIR)/00/boot.S.o

# Targets for the boot page, whose assignment varies from model to model
PAGE_BOOT=\
	$(OUTDIR)/boot/base.S.o

$(OUTDIR)/boot.o: $(PAGE_BOOT)
	$(AS) -c $(ASFLAGS) -o $@ $^

$(OUTDIR)/page00.o: $(OUTDIR)/00/header.S.o $(PAGE_00)
	$(AS) -c $(ASFLAGS) -o $@ $^

kernel-%.rom: $(OUTDIR)/page00.bin $(OUTDIR)/boot.bin
	mkrom kernel-$(PLATFORM).rom $(LENGTH) \
		$(OUTDIR)/page00.bin:0x00 \
		$(OUTDIR)/boot.bin:0x$(BOOT)

$(OUTDIR)/%.S.o: src/%.S $(wildcard include/*.asm)
	@mkdir -p $(shell dirname $@)
	$(AS) $(ASFLAGS) -c -o $@ $<

$(OUTDIR)/%.bin: $(OUTDIR)/%.o
	$(AS) $(ASFLAGS) -o $@ $^

clean:
	rm -rf .build kernel-*.rom

z80e: kernel-$(PLATFORM).rom $(OUTDIR)/page00.o
	z80e-sdl -d $(PLATFORM) --debug \
		-o $(OUTDIR)/page00.o \
		-o $(OUTDIR)/boot.o \
		$<

.PHONY: clean z80e
