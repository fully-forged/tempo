build:
	docker-compose build
.PHONY: build

docker-shell:
	docker-compose exec app /bin/bash
.PHONY: docker-shell

docker-test:
	docker-compose exec app mix test
.PHONY: docker-test

docker-serve:
	docker-compose exec app mix phx.server
.PHONY: docker-serve

clean:
	docker-compose down
	rm -rf data/*
.PHONY: clean
