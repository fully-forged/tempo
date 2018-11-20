docker-shell:
	docker-compose exec app /bin/bash
.PHONY: docker-shell

docker-test:
	docker-compose exec app mix test
.PHONY: docker-test
