default:
	make build
	make push-builds

build:
	./run.sh

rebuild:
	docker-compose build --no-cache

docker-build:
	docker build -t atkinchris/custom-iso:latest .

docker-push:
	docker push atkinchris/custom-iso:latest

docker-run:
	docker run --name builder --privileged -it atkinchris/custom-iso:latest

push-builds:
	aws s3 sync ./builds s3://iso-builds
