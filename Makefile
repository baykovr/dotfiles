#!/usr/bin/env make

.PHONY: switch
switch:
	home-manager switch --flake .
