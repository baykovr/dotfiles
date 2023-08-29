#!/usr/bin/env make

.PHONY: build
build:
	@nix run . -- build --flake .

.PHONY: switch
switch:
	@nix run . -- switch --flake .

.PHONY: hm-sw
hw-sw:
	@home-manager switch --flake .
