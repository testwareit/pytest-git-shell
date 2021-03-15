NAME := pytest-git-shell
TAG := 0.3
IMAGE_NAME := testwareit/$(NAME)

.PHONY: help build push clean

help:
	@printf "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)\n"

build:
	docker build --pull -t $(IMAGE_NAME):$(TAG) .
	
deploy-local: 
	docker-compose up -d

build-deploy: build deploy-local

push:
	docker build -t $(IMAGE_NAME):$(TAG) .
	docker tag $(IMAGE_NAME):$(TAG) $(IMAGE_NAME):latest
	docker push $(IMAGE_NAME):$(TAG)
	docker push $(IMAGE_NAME):latest

clean:
	docker-compose kill
	docker-compose rm -f
	docker rmi $(IMAGE_NAME):latest || true
	docker rmi $(IMAGE_NAME):$(TAG) || true