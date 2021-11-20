ARG \
    COMPOSER_IMAGE_VERSION=2.1.3 \
    PHP_VERSION=8.0 \
    PLATFORM=alpine \
    ECS_PACKAGE_VERSION=9.4.70

FROM composer:${COMPOSER_IMAGE_VERSION} AS build

ARG \
    PHP_VERSION \
    PLATFORM \
    ECS_PACKAGE_VERSION

RUN \
  set -xe && \
  composer --quiet --no-cache global require \
    symplify/easy-coding-standard:${ECS_PACKAGE_VERSION}

FROM php:${PHP_VERSION}-cli-${PLATFORM}

ARG PLATFORM

LABEL maintainer="Igor Ermentraut <ie@efsa.io>"

USER root

COPY ./ /docker
COPY ./tests /application

RUN \
    chmod +x "/docker/${PLATFORM}/application_user.sh" && \
    sh "/docker/${PLATFORM}/application_user.sh"

USER application
