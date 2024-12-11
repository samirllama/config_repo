# Configuration paths
XDG_CONFIG_HOME ?= $(HOME)/.config
REPO_CONFIG_DIR := $(CURDIR)/xdg_config
ZSH_CONFIG_DIR := $(REPO_CONFIG_DIR)/zsh
SYSTEM_ZSH_DIR := $(XDG_CONFIG_HOME)/zsh

.PHONY: all setup deploy backup clean lint test help

all: help

help:
	@echo "Available targets:"
	@echo "  setup   - Initial setup of configurations"
	@echo "  deploy  - Deploy configurations to system"
	@echo "  backup  - Backup existing configurations"
	@echo "  clean   - Clean generated files"
	@echo "  lint    - Lint configuration files"
	@echo "  test    - Test configurations"

setup: backup
	@echo "Setting up configurations..."
	mkdir -p $(XDG_CONFIG_HOME)
	mkdir -p $(SYSTEM_ZSH_DIR)

deploy: setup
	@echo "Deploying configurations..."
	# Deploy Zsh configurations
	cp -r $(ZSH_CONFIG_DIR)/* $(SYSTEM_ZSH_DIR)/
	# Link zshrc to home directory for compatibility
	ln -sf $(SYSTEM_ZSH_DIR)/zshrc $(HOME)/.zshrc
	ln -sf $(SYSTEM_ZSH_DIR)/zshenv $(HOME)/.zshenv

backup:
	@echo "Backing up existing configurations..."
	@if [ -d "$(SYSTEM_ZSH_DIR)" ]; then \
		mv $(SYSTEM_ZSH_DIR) $(SYSTEM_ZSH_DIR).bak.$(shell date +%Y%m%d_%H%M%S); \
	fi
	@if [ -f "$(HOME)/.zshrc" ]; then \
		mv $(HOME)/.zshrc $(HOME)/.zshrc.bak.$(shell date +%Y%m%d_%H%M%S); \
	fi
	@if [ -f "$(HOME)/.zshenv" ]; then \
		mv $(HOME)/.zshenv $(HOME)/.zshenv.bak.$(shell date +%Y%m%d_%H%M%S); \
	fi

clean:
	@echo "Cleaning generated files..."
	find . -name "*.zwc" -delete
	find . -name "*.zwc.old" -delete
	find . -name "*.zcompdump" -delete

lint:
	@echo "Linting configuration files..."
	@find $(REPO_CONFIG_DIR) -type f -name "*.zsh" -exec zsh -n {} \;
	@find $(REPO_CONFIG_DIR) -type f -name "zshrc" -exec zsh -n {} \;
	@find $(REPO_CONFIG_DIR) -type f -name "zshenv" -exec zsh -n {} \;

test:
	@echo "Testing configurations..."
	@zsh -c 'source $(ZSH_CONFIG_DIR)/zshrc && echo "Zsh configuration test: OK"'
