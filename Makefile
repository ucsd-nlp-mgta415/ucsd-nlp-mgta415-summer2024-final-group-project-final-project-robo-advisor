.PHONY: help, ci-black, ci-flake8, ci-test, isort, black, docs, dev-start, dev-stop

## Ensure this is the same name as in docker-compose.yml file
CONTAINER_NAME="mgta415_fp_robo_advisor"

PROJECT=mgta415_fp_robo_advisor

PROJ_DIR="/mnt/robo_advisor"
COMPOSE_FILE=docker/docker-compose.yml

.env: ## make an .env file
	touch .env

dev-start: .env ## Primary make command for devs, spins up containers
	docker-compose -f $(COMPOSE_FILE) --project-name $(PROJECT) up -d --no-recreate

dev-stop: ## Spin down active containers
	docker-compose -f $(COMPOSE_FILE) --project-name $(PROJECT) down

nb: dev-start ## Opens Jupyterlab in the browser
	@if [ "$(shell uname)" = "Darwin" ]; then \
		docker port $(CONTAINER_NAME) | grep 8888 | awk -F ' -> ' '{print "http://" $$2}' | xargs open ; \
	elif [ "$(shell uname)" = "Linux" ]; then \
		docker port $(CONTAINER_NAME) | grep 8888 | awk -F ' -> ' '{print "http://" $$2}' | xargs xdg-open ; \
	else \
		echo "Unsupported OS" ; \
	fi

# Useful when Dockerfile/requirements are updated)
dev-rebuild: .env ## Rebuild images for dev containers
	docker-compose -f $(COMPOSE_FILE) --project-name $(PROJECT) up -d --build

bash: dev-start ## Provides an interactive bash shell in the container
	docker exec -it $(CONTAINER_NAME) bash