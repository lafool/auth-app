# Variables
PROJECT_DIR := $(shell pwd)
ENVIRONMENT ?= dev
ACCOUNT_ID := $(shell aws sts get-caller-identity --query 'Account' --output text)
REGION := ap-northeast-1
REGISTRY_PATH := $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com

ECR_IMAGE_NAME := $(REGISTRY_PATH)/$(ENVIRONMENT)-lafool-auth

# Taskfile migrated variables
PROFILE_PREFIX := lafool-auth

# Phony targets
.PHONY: help ecr_login build push sso_configure_dev sso_configure_stg sso_configure_prd port_forward_dev port_forward_stg port_forward_prd sso_login_dev sso_login_stg sso_login_prd

# Default target
help:
	@echo "------------------------------------------ Makefile ------------------------------------------"
	@echo "Usage: make [target] [ENVIRONMENT=environment]"
	@echo ""
	@echo "Keycloak Build & Deploy:"
	@echo "  ecr_login:           login to ECR"
	@echo "  build:               build the keycloak image"
	@echo "  push:                push the keycloak image to ECR"
	@echo "  deploy:              build and push the keycloak image"
	@echo ""
	@echo "AWS SSO Configuration:"
	@echo "  sso_configure_dev:   configure AWS SSO for dev environment"
	@echo "  sso_configure_stg:   configure AWS SSO for staging environment"
	@echo "  sso_configure_prd:   configure AWS SSO for production environment"
	@echo ""
	@echo "AWS SSO Login:"
	@echo "  sso_login_dev:       login to AWS SSO for dev environment"
	@echo "  sso_login_stg:       login to AWS SSO for staging environment"
	@echo "  sso_login_prd:       login to AWS SSO for production environment"
	@echo ""
	@echo "Port Forwarding:"
	@echo "  port_forward_dev:    connect to EC2 instance in dev environment"
	@echo "  port_forward_stg:    connect to EC2 instance in staging environment"
	@echo "  port_forward_prd:    connect to EC2 instance in production environment"
	@echo ""
	@echo "  help:                show this help message"
	@echo ""
	@echo "examples:"
	@echo "  make build ENVIRONMENT=dev"
	@echo "  make push ENVIRONMENT=dev"
	@echo "  make sso_login_dev"
	@echo "  make port_forward_dev"
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

sso_configure_dev:
	aws configure sso --profile $(PROFILE_PREFIX)-dev

sso_configure_stg:
	aws configure sso --profile $(PROFILE_PREFIX)-stg

sso_configure_prd:
	aws configure sso --profile $(PROFILE_PREFIX)-prd

sso_login_dev:
	aws sso login --profile $(PROFILE_PREFIX)-dev

sso_login_stg:
	aws sso login --profile $(PROFILE_PREFIX)-stg

sso_login_prd:
	aws sso login --profile $(PROFILE_PREFIX)-prd

port_forward_dev:
	aws ssm start-session --profile $(PROFILE_PREFIX)-dev --target i-0f13b5039169bde5a --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters '{"host":["dev-lafool-auth.cluster-cpeiggoem0pr.ap-northeast-1.rds.amazonaws.com"],"portNumber":["5432"], "localPortNumber":["55432"]}'

port_forward_stg:
	aws ssm start-session --profile $(PROFILE_PREFIX)-stg --target i-094a3e8f3c1fde3ca --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters '{"host":[""],"portNumber":["5432"], "localPortNumber":["55432"]}'

port_forward_prd:
	aws ssm start-session --profile $(PROFILE_PREFIX)-prd --target i-094a3e8f3c1fde3ca --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters '{"host":[""],"portNumber":["5432"], "localPortNumber":["55432"]}'
