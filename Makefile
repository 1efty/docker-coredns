.DEFAULT_GOAL:=help

# --------------------------

# load .env so that Docker Swarm Commands has .env values too. (https://github.com/moby/moby/issues/29133)
include .env
export

# --------------------------
.PHONY: up down

up:		    ## Start coredns
	docker-compose up -d --build

build:			## Build coredns
	@docker-compose build

down:			## Down coredns
	@docker-compose down

stop:			## Stop coredns
	@docker-compose stop

restart:		## Restart coredns
	@docker-compose restart

rm:				## Remove coredns
	@docker-compose rm -f

logs:			## Tail all logs with -n 1000.
	@docker-compose logs --follow --tail=1000

images:			## Show all Images of coredns
	@docker-compose images

prune:			## Remove coredns containers and delete volume data
	@make stop && make rm
	@docker volume prune -f

help:       	## Show this help.
	@echo "Make Application Docker Images and Containers using Docker-Compose files in 'docker' Dir."
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m (default: help)\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
