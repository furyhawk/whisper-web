# Variables
DOCKER_USERNAME ?= furyhawk
REPO_NAME ?= whisper-web
TAG ?= latest
PLATFORMS ?= linux/amd64,linux/arm64

# Default target
.PHONY: all
all: build push

# Build the Docker image for multiple architectures
.PHONY: build
build:
	docker buildx build --builder container --platform ${PLATFORMS} --provenance false -t ${DOCKER_USERNAME}/${REPO_NAME}:${TAG} .
	docker image prune -f

# Push the Docker image to Docker Hub
.PHONY: push
push: build
	docker buildx build --builder container --platform ${PLATFORMS} --provenance false -t $(DOCKER_USERNAME)/$(REPO_NAME):$(TAG) --push .

# Clean up local Docker images
.PHONY: clean
clean:
	docker rmi $(DOCKER_USERNAME)/$(REPO_NAME):$(TAG)