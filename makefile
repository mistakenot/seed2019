export APP_NAME = myapp

export PATH := $(PATH):$(PWD)/scripts/bin
export SHELL = /bin/bash

export DOCKER_VERSION = 10
export DOCKER_COMPOSE_VERSION = 10

export GOOGLE_APPLICATION_CREDENTIALS ?= $(HOME)/.config/gcloud/application_default_credentials.json

# Shortcut commands
# -----------------

# This command ensures that the working directory is set up for development.
init:
	chmod +x ./scripts/dev-repo-init.sh && source ./scripts/dev-repo-init.sh

test: server-test client-test

shell: dev-shell

# Development environment config and entrypoints.
# ----------------------------------------------
#  Used for quickly creating a shell environment
#  suitable for development and deployment. 
export DEV_IMAGE_NAME := $(APP_NAME)-dev

dev-build:
	docker build \
		-t $(DEV_IMAGE_NAME) \
		.

dev-shell: dev-build
	./scripts/dev-shell-start.sh

dev-up:
	docker-compose up

dev-down:
	docker-compose down

# Cloud operations config and entrypoints
# ---------------------------------------
#  Commands used for interacting with
#  a cloud environment.
gcp-up:
	terraform ...

gcp-down:
	terraform ...

# Api side operations
# ----------------------

api-build:
	...

api-build-docker:
	...

api-test:
	...

api-test-watch:
	...

api-debug:
	...

# Daatabase operations
# --------------------
SQL_POSTGRES_VERSION = ?
SQL_CONNECTION_STRING = ?
SQL_USERNAME = ?
SQL_PASSWORD = ?

sql-test:
	...

sql-start:
	...

sql-shell:
	...

# Client side operations
# ----------------------

client-build:
	...

client-test:
	...

client-serve:
	...