PROFILE ?= mcsarch
WORKDIR ?= work
OUTDIR ?= out
MKARCHISO ?= mkarchiso

.PHONY: help build clean rebuild

help:
	@echo "Available targets:"
	@echo "  make build    - Build ISO using profile ./$(PROFILE)"
	@echo "  make clean    - Remove mkarchiso work and output directories"
	@echo "  make rebuild  - Clean and build again"
	@echo
	@echo "Variables (override with VAR=value):"
	@echo "  PROFILE=$(PROFILE)"
	@echo "  WORKDIR=$(WORKDIR)"
	@echo "  OUTDIR=$(OUTDIR)"
	@echo "  MKARCHISO=$(MKARCHISO)"

build:
	@test -d "$(PROFILE)" || (echo "Missing profile directory: $(PROFILE)" && exit 1)
	$(MKARCHISO) -r -v -w "$(WORKDIR)" -o "$(OUTDIR)" "$(PROFILE)"

clean:
	rm -rf "$(WORKDIR)" "$(OUTDIR)"

rebuild: clean build
