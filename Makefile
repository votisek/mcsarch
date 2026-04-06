PROFILE ?= mcsarch
WORKDIR ?= work
OUTDIR ?= out
MKARCHISO ?= mkarchiso
OVMF ?= /usr/share/ovmf/x64/OVMF_CODE.4m.fd
ISO ?= mcsarch.iso

.PHONY: help build clean rebuild

help:
	@echo "Available targets:"
	@echo "  make build         - Build ISO using profile ./$(PROFILE)"
	@echo "  make clean         - Remove mkarchiso work and output directories"
	@echo "  make rebuild       - Clean and build again"
	@echo "  make create-drive  - Create a virtual drive"
	@echo "  make test          - Tests installation on the virtual drive"
	@echo "  make format-drive  - Format the virtual drive"
	@echo
	@echo "Variables (override with VAR=value):"
	@echo "  PROFILE=$(PROFILE)"
	@echo "  WORKDIR=$(WORKDIR)"
	@echo "  OUTDIR=$(OUTDIR)"
	@echo "  MKARCHISO=$(MKARCHISO)"
	@echo "  OVMF=$(OVMF)"

build:
	@which "$(MKARCHISO)" >/dev/null 2>&1 || (echo "mkarchiso not found. Please install the 'archiso' package." && exit 1)
	$(MKARCHISO) -r -v -w "$(WORKDIR)" -o "$(OUTDIR)" "$(PROFILE)"

clean:
	rm -rf "$(WORKDIR)" "$(OUTDIR)"

rebuild: clean build

create-drive:
	@test -d "/usr/share/ovmf/x64" || (echo "OVMF firmware not found. Please install the 'ovmf' package." && exit 1)
	@which qemu-img >/dev/null 2>&1 || (echo "qemu-img not found. Please install the 'qemu' package." && exit 1)
	@echo "Creating virtual drive..."
	@qemu-img create -f qcow2 mcsarch.qcow2 20G

format-drive:
	@echo "Formatting virtual drive..."
	@qemu-img create -f qcow2 mcsarch.qcow2 20G

arch-all: build 
	$(MAKE) test ISO="$(OUTDIR)/$$(date --date=\"@$${SOURCE_DATE_EPOCH:-$$(date +%s)}\" +%Y%m).iso"

test:
	@echo "Launching QEMU..."
	@which qemu-system-x86_64 >/dev/null 2>&1 || (echo "qemu-system-x86_64 not found. Please install the 'qemu' package." && exit 1)
	@test -f mcsarch.qcow2 || (echo "Virtual drive not found. Please run 'make create-drive' first." && exit 1)
	@qemu-system-x86_64 \
		-enable-kvm \
		-m 4G \
		-drive if=pflash,format=raw,read-only=on,file="$(OVMF)" \
		-drive file=mcsarch.qcow2,format=qcow2 \
		-cdrom "$(ISO)" \
		-boot d