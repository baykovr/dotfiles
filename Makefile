#!/usr/bin/env make

# Variables for consistency
FLAKE_DIR := .
HM_SWITCH := home-manager switch --flake $(FLAKE_DIR)

.PHONY: help
help:
	@echo "Available targets:"
	@echo "  switch     - Build and activate new home-manager configuration"
	@echo "  build      - Build configuration without activating"
	@echo "  update     - Update flake inputs"
	@echo "  diff       - Show what would change"
	@echo "  clean      - Remove build artifacts and old generations"
	@echo "  history    - Show generation history"

.PHONY: build
build:
	@home-manager build --flake $(FLAKE_DIR)

.PHONY: switch
switch:
	@$(HM_SWITCH)
	@echo "Configuration activated. Run 'source ~/.zshrc' manually to reload shell."

.PHONY: update
update:
	@nix flake update --flake $(FLAKE_DIR)

.PHONY: diff
diff:
	@nix profile diff-closures --profile ~/.local/state/home-manager/profiles/home-manager

.PHONY: clean
clean:
	@home-manager expire-generations "-7 days"
	@nix-collect-garbage -d

.PHONY: history
history:
	@home-manager generations
