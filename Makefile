build:
	sh ./run.sh

rebuild:
	docker-compose build --no-cache

docker-build:
	docker build -t atkinchris/archiso:latest .

docker-push:
	docker push atkinchris/archiso:latest
