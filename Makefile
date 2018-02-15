.PHONY: help shell psql populate

help:
	@echo Docker control commands:
	@echo
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo

shell: ## Run a shell in the environment
	docker-compose run --rm dev bash -l

psql: ## Start a local psql instance connected to the database
	PGPASSWORD=jmdictdb psql -U jmdictdb -d jmdict -h $(shell docker-compose port db 5432 | awk -F: '{print "127.0.0.1 -p",$$2}')

create-db: ## Load JMDict into the database
	docker-compose run --rm jmdictdb make HOST=db loadall

activate-db: ## Activate the JMDict database
	docker-compose run --rm jmdictdb make HOST=db activate
