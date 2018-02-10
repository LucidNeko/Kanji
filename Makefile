.PHONY: help shell psql populate

help:
	@echo Docker control commands:
	@echo
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo

shell: ## Run a shell in the environment
	docker-compose run --rm dev bash -l

psql: ## Start a local psql instance connected to the database
	PGPASSWORD=jmdictdb psql -U jmdictdb -d jmdict -h $(shell docker-compose port db 5432 | sed 's/:/ -p /')

populate: ## Load JMDict into the database
	docker-compose run --rm populate make DB=jmdict HOST=db loadall
