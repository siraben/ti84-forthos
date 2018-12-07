# vim: set ft=make :
#
# Defines constants and targets for each platform
PLATFORM := TI84p
DEVICE := TI-84+
PRIVILEGED := F0000
KEY := 0A
UPGRADEEXT := 8xu
BOOT := FC000
LENGTH := 0x100000

.PHONY: TI84p
