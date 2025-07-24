# Variables
PROJECT_DIR := $(shell pwd)
ENVIRONMENT ?= dev
ACCOUNT_ID := $(shell aws sts get-caller-identity --query 'Account' --output text)
REGION := ap-northeast-1
REGISTRY_PATH := $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com

ECR_IMAGE_NAME := $(REGISTRY_PATH)/$(ENVIRONMENT)-lafool-auth

# Phony targets
.PHONY: help ecr_login build push

# Default target
help:
	@echo "------------------------------------------ Makefile ------------------------------------------"
	@echo "Usage: make [target] [ENVIRONMENT=environment]"
	@echo "  ecr_login: login to ECR"
	@echo "  build:     build the keycloak image"
	@echo "  push:      push the keycloak image to ECR"
	@echo "  help:      show this help message"
	@echo ""
	@echo "examples:"
	@echo "  make build ENVIRONMENT=dev"
	@echo "  make push ENVIRONMENT=dev"
	@echo "  make ecr_login"
	@echo "-----------------------------------------------------------------------------------------------"

# ECR login
ecr_login:
	aws ecr get-login-password --region $(REGION) | docker login --username AWS --password-stdin $(REGISTRY_PATH)

setup:
	docker build --platform linux/amd64 -t keycloak-java-runtime .

build:
	docker run -it --rm -v $(PWD):/app keycloak-java-runtime /bin/bash -c "cd /app && ./mvnw -pl quarkus/deployment,quarkus/dist -am -DskipTests clean install"

dist:
	cp ./quarkus/dist/target/keycloak-999.0.0-SNAPSHOT.tar.gz ./quarkus/container/keycloak-999.0.0-SNAPSHOT.tar.gz
	cd ./quarkus/container && docker build --platform linux/amd64 -t ${ECR_IMAGE_NAME}:latest --build-arg KEYCLOAK_DIST=keycloak-999.0.0-SNAPSHOT.tar.gz .

disable-ssl:
	docker compose exec keycloak /opt/keycloak/bin/kcadm.sh config credentials --server http://localhost:8080 --realm master --user admin
	docker compose exec keycloak /opt/keycloak/bin/kcadm.sh update realms/master -s sslRequired=NONE

# Push Docker image
push:
	@echo "Pushing image: $(ECR_IMAGE_NAME):latest"
	docker push $(ECR_IMAGE_NAME):latest

# Convenience target to build and push
deploy: dist push
	@echo "Build and push completed for $(ENVIRONMENT)" 