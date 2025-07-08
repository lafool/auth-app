FROM registry.access.redhat.com/ubi9 AS builder

RUN dnf update -y && dnf install -y --allowerasing \
    git \
    curl \
    java-21-openjdk-devel \
    && dnf clean all

WORKDIR /app
