# Project info
PROJECT = inception
EXERCISE = 42
CONTAINERS = nginx wordpress mariadb redis ftp static_site adminer API
VOLUME_DIRS = wordpress mariadb redis static_html API

# Paths
VOLUMES_PATH = $(HOME)/data

# Colors
ORANGE = \033[0;33m
GREEN = \033[0;32m
RED = \033[0;31m
CYAN = \033[38;5;39m
BLUE = \033[38;5;33m
DARK = \033[38;5;63m
RESET = \033[0m

# Main targets
all: header setup_volumes build up

header:
	@echo "$(CYAN)—————————————————————————————————————————————————————————$(RESET)"
	@echo "$(BLUE)|   $(PROJECT)   |  $(EXERCISE)   |    make    |   $(words $(CONTAINERS)) services    |$(RESET)"
	@echo "$(DARK)—————————————————————————————————————————————————————————$(RESET)"
	@echo "$(ORANGE)Starting Inception…$(RESET)"

setup_volumes:
	@echo "$(ORANGE)Setting up data volumes...$(RESET)"
	@mkdir -p $(VOLUMES_PATH)
	@set -e; \
	for dir in $(VOLUME_DIRS); do \
		if [ ! -d "$(VOLUMES_PATH)/$$dir" ]; then \
			echo "Creating volume directory: $(VOLUMES_PATH)/$$dir"; \
			mkdir -p "$(VOLUMES_PATH)/$$dir"; \
		fi; \
		sudo chown -R $(USER):$(USER) "$(VOLUMES_PATH)/$$dir" || true; \
		sudo chmod 755 "$(VOLUMES_PATH)/$$dir" || true; \
	done
	@echo "➡️  $(GREEN)Volumes setup complete ✅$(RESET)"

build:
	@echo "$(ORANGE)Building containers...$(RESET)"
	@docker compose -f docker-compose.yml build && \
	echo "" && \
	echo "➡️  $(GREEN)\033[4mContainers built successfully ✅\033[0m$(RESET)" || \
	(echo "$(RED)➡️  Error while building containers$(RESET) ❌" && exit 1)

up: setup_volumes
	@echo "$(ORANGE)Starting containers...$(RESET)"
	@docker compose -f docker-compose.yml up -d && \
	echo "" && \
	echo "➡️  $(GREEN)\033[4mContainers started successfully ✅\033[0m$(RESET)" || \
	(echo "$(RED)➡️  Error while starting containers$(RESET) ❌" && exit 1)

down:
	@echo "$(ORANGE)Stopping containers...$(RESET)"
	@docker compose -f docker-compose.yml down && \
	echo "" && \
	echo "➡️  $(GREEN)\033[4mContainers stopped and removed 🗑️\033[0m$(RESET)" || \
	echo "$(RED)➡️  Error while stopping containers$(RESET) ❌"

clean: down
	@echo "$(ORANGE)Cleaning Docker system…$(RESET)"
	@docker system prune -a -f
	@echo "➡️  $(GREEN)System cleaned ✅$(RESET)"

fclean: clean
	@echo "$(ORANGE)Removing volume directories...$(RESET)"
	@set -e; \
	for dir in $(VOLUME_DIRS); do \
		if [ -d "$(VOLUMES_PATH)/$$dir" ]; then \
			echo "Removing: $(VOLUMES_PATH)/$$dir"; \
			sudo rm -rf "$(VOLUMES_PATH)/$$dir"; \
		fi; \
	done
	@if [ -d "$(VOLUMES_PATH)" ]; then \
		sudo rm -rf "$(VOLUMES_PATH)"; \
	fi
	@volumes=$$(docker volume ls -q); \
	if [ -n "$$volumes" ]; then \
		docker volume rm $$volumes; \
	fi
	@echo "$(RED)All Docker resources cleaned$(RESET)"

re: fclean all

.PHONY: all build up down clean fclean re header setup_volumes
