#!/usr/bin/env make

.PHONY: build
build:
	@nix run . -- build --flake .

.PHONY: switch
switch:
	@nix run . -- switch --flake .

.PHONY: hmsw
hwsw:
	@home-manager switch --flake ~/.config/home-manager && source ~/.zshrc
