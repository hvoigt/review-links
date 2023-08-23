IMAGE_NAME = "registry.jimdo-platform.net/jimdo/review-links:${VERSION}"

VERSION = $(shell git describe --tags --always --dirty)
PLATFORM := --platform linux/amd64

build:
	docker build $(PLATFORM) -t $(IMAGE_NAME) .

push: build
	wl2 docker push $(IMAGE_NAME)

deploy: push
	wl2 -e stage deploy -f wonderland2.yaml

run: build
	docker run -p 8080:80 $(PLATFORM) $(IMAGE_NAME)
