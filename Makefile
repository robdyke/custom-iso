build:
	sh ./run.sh

rebuild:
	docker-compose build --no-cache

docker-build:
	docker build -t atkinchris/custom-iso:latest .

docker-push:
	docker push atkinchris/custom-iso:latest

docker-run:
	docker run --name builder --privileged atkinchris/custom-iso:latest
