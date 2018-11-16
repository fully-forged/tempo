docker-build:
	docker-compose build
.PHONY: docker-build

docker-up:
	docker-compose up
.PHONY: docker-up

docker-shell:
	docker-compose exec app /bin/bash
.PHONY: docker-shell

docker-test:
	docker-compose exec app mix test
.PHONY: docker-test
