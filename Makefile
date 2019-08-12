# Settings
JEKYLL=jekyll
PORT?=4000
HOST?=localhost
FLAGS?=""
MINICONDA_URL=https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
SHELL=bash
RUBY_VERSION=2.5.1
CONDA_ENV=website_builder

ifeq ($(shell uname -s),Darwin)
	CHROME=/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome
	MINICONDA_URL=https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
endif

CONDA=$(shell which conda)
ifeq ($(CONDA),)
	CONDA=${HOME}/miniconda3/bin/conda
endif

default: help

install-conda: ## install Miniconda
	curl $(MINICONDA_URL) -o miniconda.sh
	bash miniconda.sh -b
.PHONY: install-conda

create-env: ## create conda environment
	if ${CONDA} env list | grep '^${CONDA_ENV}'; then \
	    ${CONDA} env update -f environment.yml; \
	else \
	    ${CONDA} env create -f environment.yml; \
	fi
.PHONY: create-env

ACTIVATE_ENV = source $(shell dirname $(dir $(CONDA)))/bin/activate $(CONDA_ENV)

install: ## install dependencies
	$(ACTIVATE_ENV) && \
		gem update --system && \
		gem install bundle && \
		bundle install
.PHONY: install

run: ## Launch jekyll locally
	$(ACTIVATE_ENV) && \
		bundler exec ${JEKYLL} serve
.PHONY: run

runi: ## Launch jekyll locally, incremental rebuild
	$(ACTIVATE_ENV) && \
		bundler exec ${JEKYLL} serve --incremental
.PHONY: runi

build: ## Build the site once and exit
	$(ACTIVATE_ENV) && \
		bundler exec ${JEKYLL} build
.PHONY: build

clean: ## Remove any generated URLs
	$(ACTIVATE_ENV) && \
		bundler exec ${JEKYLL} clean
.PHONY: clean

check_http_urls:
	$(ACTIVATE_ENV) && \
		bundler exec htmlproofer ./_site/ --check-html --allow-hash-href --assume-extension --disable-external --url-swap "http\://localhost:https\://usegalaxy-au.github.io" --enforce-https 2>&1 | grep 'is not' | sed 's/link .*//g' | sort | uniq -c | sort -nk1
.PHONY: check_http_urls

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.PHONY: help
