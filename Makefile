build:
	bundle install --path vendor
	gem pristine --all

run:
	bin/rake db:setup
	foreman start

build-docker:
	docker build -t api-codeunion-io .
	docker run -v /src:/src api-codeunion-io

start-docker: start-docker-postgres start-docker-rails

start-docker-postgres:
	docker run --rm --name postgres -P postgres

start-docker-rails:
	docker run -ti --rm --link postgres:postgres -e DATABASE_URL=postgres://postgres@postgres/db -v /src:/src -v /mnt:/mnt -P api-codeunion-io make run

start-docker-bash:
	docker run -ti --rm --link postgres:postgres -e DATABASE_URL=postgres://postgres@postgres/db -v /src:/src -v /mnt:/mnt -P api-codeunion-io bash -l
