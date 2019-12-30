

SHELL := /bin/bash
PWD := $(shell pwd)
NEOVIM_CONF_DIR := $(HOME)/.config/nvim
FZF_HOME := $(HOME)/.local/src/fzf.git

.PHONY: ubuntu bin git vim neovim bash pyenv node flake8 postgres jshint fzf

# Run first with sudo
# -------------------
#
#     $ sudo -H make ubuntu
ubuntu:
	@apt-get update
	@apt-get -y install build-essential libssl-dev zlib1g-dev libbz2-dev
	@apt-get -y install libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev
	@apt-get -y install xz-utils tk-dev
	@apt-get -y install python-dev python-pip python3-dev python3-pip
	@apt-get -y install silversearcher-ag exuberant-ctags
	@apt-get -y install python-neovim python3-neovim
	@pip2 install -U pip
	@pip3 install -U pip
	@pip2 install -U pynvim jedi
	@pip3 install -U pynvim jedi
	@wget --quiet https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage --output-document nvim
	@chmod +x nvim
	@chown root:root nvim
	@mv nvim /usr/bin

#----------------------------------------------------------------------------------------
# install targets
#----------------------------------------------------------------------------------------
bin:
	@mkdir -p ~/bin/
	@ln -fs $(PWD)/bin/* ~/bin/

git:
	@ln -fs $(PWD)/git/gitconfig ~/.gitconfig
	@curl -o ~/.git-completion.bash https://github.com/git/git/raw/master/contrib/completion/git-completion.bash -OL

vim:
	@ln -fs $(PWD)/vimrc ~/.vimrc
	@mkdir -p ~/.vim
	@rm -rf ~/.vim/autoload
	@rm -rf ~/.vim/colors
	@rm -rf ~/.vim/syntax
	@ln -fs $(PWD)/vim/autoload ~/.vim/autoload
	@ln -fs $(PWD)/vim/colors ~/.vim/colors
	@ln -fs $(PWD)/vim/syntax ~/.vim/syntax
	@vim +PlugInstall +qall

neovim:
	@rm -rf $(NEOVIM_CONF_DIR) && mkdir -p $$(dirname $(NEOVIM_CONF_DIR)) && ln -fs $(PWD)/neovim/nvim $(NEOVIM_CONF_DIR)
	@nvim +PlugInstall +qall

bash:
	@ln -fs $(PWD)/bash/bashrc ~/.bashrc
	@ln -fs $(PWD)/bash/bash_profile ~/.bash_profile
	@if [ $$(uname) == "Darwin" ]; then ln -fs $(PWD)/bash/osx_profile ~/.osx_profile; fi
	@source ~/.bashrc

pyenv:
	@curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

node:
	@curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
	@source ~/.bashrc && nvm install --lts

flake8:
	@ln -fs $(PWD)/flake8 $(HOME)/.config/flake8

postgres:
	@ln -fs $(PWD)/psqlrc ~/.psqlrc

jshint:
	@ln -fs $(PWD)/jshintrc $(HOME)/.jshintrc

# fuzzy file finder https://github.com/junegunn/fzf
fzf:
	@test -d $(HOME)/.local/src || mkdir -p $(HOME)/.local/src
	@test -d $(FZF_HOME) || (git clone https://github.com/junegunn/fzf.git $(FZF_HOME) && cd $(FZF_HOME) && ./install)

install: bin git neovim bash postgres flake8 jshint fzf pyenv node



