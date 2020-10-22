.DEFAULT_GOAL:=help

.PHONY: up down build stop restart rm logs test images prune

up: ## Start coredns
	docker-compose up -d --build

build: ## Build coredns
	@docker-compose build

down: ## Down coredns
	@docker-compose down

stop: ## Stop coredns
	@docker-compose stop

restart: ## Restart coredns
	@docker-compose restart

rm: ## Remove coredns
	@docker-compose rm -f

logs: ## Tail all logs with -n 1000.
	@docker-compose logs --follow --tail=1000

test: ## Test the build
	@docker-compose -f docker-compose.yml -f docker-compose.test.yml build
	@docker-compose -f docker-compose.yml -f docker-compose.test.yml run sut
	@make prune

images: ## Show all Images of coredns
	@docker-compose images

prune: ## Remove coredns containers and delete volume data
	@make stop && make rm
	@docker volume prune -f

help: ## Show this help message
	@grep '^[a-zA-Z]' $(MAKEFILE_LIST) | sort | awk -F ':.*?## ' 'NF==2 {printf "\033[36m  %-25s\033[0m %s\n", $$1, $$2}'
