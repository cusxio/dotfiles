XDG_CONFIG_HOME?=$(HOME)/.config
# NVM_DIR=$(XDG_CONFIG_HOME)/nvm

mac: xcode brew

brew:
	command -v brew >/dev/null 2>&1 || ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew update
	brew upgrade
	brew bundle --file=$(CURDIR)/homebrew/Brewfile

xcode:
	xcode-select --install || true

rust:
	curl https://sh.rustup.rs -fsS | sh -s -- --no-modify-path

# node:
	# requires nvm to be sourced after install, requires brew installation of yarn too
	# yarn global add now surge speed-test trash-cli

symlink:
	stow --target=$(HOME) \
		stow \
		macOS \
		git \
		vim \
		alacritty

# .PHONY: osx brew xcode

.SILENT: brew xcode rust symlink

# nix:
# 	curl https://nixos.org/nix/install | sh

# run stow first??
# set ZSH variable first to install nvm ? due to NVM_DIR?
