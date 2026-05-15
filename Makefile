INSTALL_DIR ?= /usr/local/bin

.DEFAULT_GOAL := help

.PHONY: help test test-local install manpage

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*##' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*##"}; {printf "  %-12s %s\n", $$1, $$2}'

test: ## Run the full test suite (requires remote SSH hosts in test/environs.sh)
	cd test && bash test_all.sh

test-local: ## Run only local tests (no SSH required)
	cd test && bash test_all.sh --local

install: ## Install rsync_snapshots to INSTALL_DIR (default: /usr/local/bin)
	install -m 755 rsync_snapshots $(INSTALL_DIR)/rsync_snapshots

manpage: ## Generate and view the man page (requires help2man)
	help2man -h "-hv" -v "-Vv" --no-info --name="generate snapshot backups with rsync" ./rsync_snapshots >| /tmp/rsync_snapshots.1
	man -l /tmp/rsync_snapshots.1
