

SHELL := /bin/bash
PWD := $(shell pwd)
NEOVIM_CONF_DIR := $(HOME)/.config/nvim
FZF_HOME := $(HOME)/.local/src/fzf.git


# needs sudo
ubuntu:
	@apt-get -y install python-dev python-pip python3-dev python3-pip
	@add-apt-repository -y ppa:neovim-ppa/unstable
	@apt-get update
	@apt-get -y install neovim
	@apt-get -y install silversearcher-ag curl
	@pip install -U pip
	@pip3 install -U pip
	@pip install neovim
	@pip3 install neovim

#----------------------------------------------------------------------------------------
# install targets
#----------------------------------------------------------------------------------------
install-bin:
	@mkdir -p ~/bin/
	@ln -fs $(PWD)/bin/* ~/bin/

install-git:
	@ln -fs $(PWD)/git/gitconfig ~/.gitconfig
	@curl -o ~/.git-completion.bash https://github.com/git/git/raw/master/contrib/completion/git-completion.bash -OL

install-vim:
	@ln -fs $(PWD)/vimrc ~/.vimrc
	@mkdir -p ~/.vim
	@rm -rf ~/.vim/autoload
	@rm -rf ~/.vim/colors
	@rm -rf ~/.vim/syntax
	@ln -fs $(PWD)/vim/autoload ~/.vim/autoload
	@ln -fs $(PWD)/vim/colors ~/.vim/colors
	@ln -fs $(PWD)/vim/syntax ~/.vim/syntax
	@vim +PlugInstall +qall

install-neovim:
	@rm -rf $(NEOVIM_CONF_DIR) && mkdir -p $$(dirname $(NEOVIM_CONF_DIR)) && ln -fs $(PWD)/neovim/nvim $(NEOVIM_CONF_DIR)
	@nvim +PlugInstall +qall

install-bash:
	@ln -fs $(PWD)/bash/bashrc ~/.bashrc
	@ln -fs $(PWD)/bash/bash_profile ~/.bash_profile
	@if [ $$(uname) == "Darwin" ]; then ln -fs $(PWD)/bash/osx_profile ~/.osx_profile; fi

install-flake8:
	@ln -fs $(PWD)/flake8 $(HOME)/.config/flake8

install-postgres:
	@ln -fs $(PWD)/psqlrc ~/.psqlrc

install-jshint:
	@ln -fs $(PWD)/jshintrc $(HOME)/.jshintrc

# fuzzy file finder https://github.com/junegunn/fzf
install-fzf:
	@test -d $(HOME)/.local/src || mkdir -p $(HOME)/.local/src
	@test -d $(FZF_HOME) || (git clone https://github.com/junegunn/fzf.git $(FZF_HOME) && cd $(FZF_HOME) && ./install)

install: install-bin install-git install-neovim install-bash install-postgres install-flake8 install-jshint install-fzf


