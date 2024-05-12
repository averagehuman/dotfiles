

SHELL := /bin/bash
PWD := $(shell pwd)
USER_BIN := $(HOME)/bin

ubuntu.spacevim:
	@curl -sLf https://spacevim.org/install.sh | bash

ubuntu.neovim:
	@curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
	@chmod +x nvim.appimage
	@mv nvim.appimage $(USER_BIN)

ubuntu.nerdfont:
	@$(PWD)/getnf
