# Configuration paths
XDG_CONFIG_HOME ?= $(HOME)/.config
REPO_CONFIG_DIR := $(CURDIR)/xdg_config
ZSH_CONFIG_DIR := $(REPO_CONFIG_DIR)/zsh
SYSTEM_ZSH_DIR := $(XDG_CONFIG_HOME)/zsh
WEZTERM_CONFIG_DIR := $(REPO_CONFIG_DIR)/wezterm
SYSTEM_WEZTERM_DIR := $(XDG_CONFIG_HOME)/wezterm
KITTY_CONFIG_DIR := $(REPO_CONFIG_DIR)/kitty
SYSTEM_KITTY_DIR := $(XDG_CONFIG_HOME)/kitty
XDG_LOCAL_BIN ?= $(HOME)/.local/bin
REPO_BIN_DIR := $(CURDIR)/bin

.PHONY: all setup deploy backup clean lint test help setup-bin

all: help

help:
	@echo "Available targets:"
	@echo "  setup   - Initial setup of configurations"
	@echo "  deploy  - Deploy configurations to system"
	@echo "  backup  - Backup existing configurations"
	@echo "  clean   - Clean generated files"
	@echo "  lint    - Lint configuration files"
	@echo "  test    - Test configurations"

setup: backup setup-bin
	@echo "Setting up configurations..."
	mkdir -p $(XDG_CONFIG_HOME)
	mkdir -p $(SYSTEM_ZSH_DIR)
	mkdir -p $(SYSTEM_WEZTERM_DIR)
	mkdir -p $(SYSTEM_KITTY_DIR)

setup-bin:
	@echo "Setting up binary scripts..."
	mkdir -p $(XDG_LOCAL_BIN)
	@for script in $(REPO_BIN_DIR)/*; do \
		if [ -f "$$script" ]; then \
			chmod +x "$$script"; \
			ln -sf "$$script" "$(XDG_LOCAL_BIN)/"; \
		fi \
	done

deploy: setup
	@echo "Deploying configurations..."
	# Deploy Zsh configurations
	cp -r $(ZSH_CONFIG_DIR)/* $(SYSTEM_ZSH_DIR)/
	cp -r $(ZSH_CONFIG_DIR)/.zshrc $(SYSTEM_ZSH_DIR)/
	cp -r $(ZSH_CONFIG_DIR)/.zprofile $(SYSTEM_ZSH_DIR)/
	# Link Zsh files to home directory for compatibility
	ln -sf $(SYSTEM_ZSH_DIR)/.zshrc $(HOME)/.zshrc
	ln -sf $(SYSTEM_ZSH_DIR)/.zprofile $(HOME)/.zprofile
	ln -sf $(SYSTEM_ZSH_DIR)/zshenv $(HOME)/.zshenv
	# Deploy terminal configurations
	cp -r $(WEZTERM_CONFIG_DIR)/* $(SYSTEM_WEZTERM_DIR)/
	cp -r $(KITTY_CONFIG_DIR)/* $(SYSTEM_KITTY_DIR)/

backup:
	@echo "Backing up existing configurations..."
	@if [ -d "$(SYSTEM_ZSH_DIR)" ]; then \
		mv $(SYSTEM_ZSH_DIR) $(SYSTEM_ZSH_DIR).bak.$(shell date +%Y%m%d_%H%M%S); \
	fi
	@if [ -f "$(HOME)/.zshrc" ]; then \
		mv $(HOME)/.zshrc $(HOME)/.zshrc.bak.$(shell date +%Y%m%d_%H%M%S); \
	fi
	@if [ -f "$(HOME)/.zprofile" ]; then \
		mv $(HOME)/.zprofile $(HOME)/.zprofile.bak.$(shell date +%Y%m%d_%H%M%S); \
	fi
	@if [ -f "$(HOME)/.zshenv" ]; then \
		mv $(HOME)/.zshenv $(HOME)/.zshenv.bak.$(shell date +%Y%m%d_%H%M%S); \
	fi
	@if [ -d "$(SYSTEM_WEZTERM_DIR)" ]; then \
		mv $(SYSTEM_WEZTERM_DIR) $(SYSTEM_WEZTERM_DIR).bak.$(shell date +%Y%m%d_%H%M%S); \
	fi
	@if [ -d "$(SYSTEM_KITTY_DIR)" ]; then \
		mv $(SYSTEM_KITTY_DIR) $(SYSTEM_KITTY_DIR).bak.$(shell date +%Y%m%d_%H%M%S); \
	fi

clean:
	@echo "Cleaning generated files..."
	find . -name "*.zwc" -delete
	find . -name "*.zwc.old" -delete
	find . -name "*.zcompdump" -delete
	@echo "Cleaning binary symlinks..."
	@for script in $(REPO_BIN_DIR)/*; do \
		if [ -f "$$script" ]; then \
			rm -f "$(XDG_LOCAL_BIN)/$$(basename $$script)"; \
		fi \
	done

lint:
	@echo "Linting configuration files..."
	@find $(REPO_CONFIG_DIR) -type f -name "*.zsh" -exec zsh -n {} \;
	@find $(REPO_CONFIG_DIR) -type f -name ".zshrc" -exec zsh -n {} \;
	@find $(REPO_CONFIG_DIR) -type f -name ".zprofile" -exec zsh -n {} \;
	@find $(REPO_CONFIG_DIR) -type f -name "zshenv" -exec zsh -n {} \;
	@if command -v lua > /dev/null; then \
		find $(REPO_CONFIG_DIR) -type f -name "*.lua" -exec lua -c {} \; ; \
	fi
	@if command -v kitty > /dev/null; then \
		kitty +runpy "from kitty.config import validate_config; validate_config(Path('$(KITTY_CONFIG_DIR)/kitty.conf'))" ; \
	fi

test:
	@echo "Testing configurations..."
	@zsh -c 'source $(ZSH_CONFIG_DIR)/.zshrc && echo "Zsh configuration test: OK"'
	@if command -v wezterm > /dev/null; then \
		wezterm --config-file $(WEZTERM_CONFIG_DIR)/wezterm.lua show-config > /dev/null && \
		echo "Wezterm configuration test: OK"; \
	fi
	@if command -v kitty > /dev/null; then \
		kitty +runpy "from kitty.config import validate_config; validate_config(Path('$(KITTY_CONFIG_DIR)/kitty.conf'))" > /dev/null && \
		echo "Kitty configuration test: OK"; \
	fi
