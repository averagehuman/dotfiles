

SHELL := /bin/bash
PWD := $(shell pwd)
NEOVIM_PY2_ENV := $(HOME)/.pyenv/neovim
NEOVIM_PY3_ENV := $(HOME)/.pyenv3/neovim
NEOVIM_CONF_DIR := $(HOME)/.config/nvim

environ:
	@echo $(NEOVIM_PY2_ENV)

# fuzzy file finder https://github.com/junegunn/fzf
fzf:
	@if [ ! -e $(HOME)/.fzf ]; then \
		git clone https://github.com/junegunn/fzf.git $(HOME)/.fzf; \
	else \
	     cd $(HOME)/.fzf && git pull; \
	fi
	@cd $(HOME)/.fzf && ./install --no-key-bindings --no-completion --no-update-rc

ubuntu-support:
	@apt-get -y install python-dev python-pip python3-dev python3-pip
	@add-apt-repository -y ppa:neovim-ppa/unstable
	@apt-get update
	@apt-get -y install neovim
	@apt-get -y install silversearcher-ag

# needs sudo
ubuntu: ubuntu-support fzf

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
	@if [ ! -e $(NEOVIM_PY2_ENV) ]; then \
		mkdir -p $(NEOVIM_PY2_ENV) && virtualenv --python=python2 $(NEOVIM_PY2_ENV); \
		$(NEOVIM_PY2_ENV)/bin/pip install -U pip; \
	fi
	@$(NEOVIM_PY2_ENV)/bin/pip install -r $(PWD)/neovim/requirements.txt
	@if [ ! -e $(NEOVIM_PY3_ENV) ]; then \
		mkdir -p $(NEOVIM_PY3_ENV) && virtualenv --python=python3 $(NEOVIM_PY3_ENV); \
		$(NEOVIM_PY3_ENV)/bin/pip install -U pip; \
	fi
	@$(NEOVIM_PY3_ENV)/bin/pip install -r $(PWD)/neovim/requirements.txt
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

install: install-bin install-git install-neovim install-bash install-postgres install-flake8 install-jshint


