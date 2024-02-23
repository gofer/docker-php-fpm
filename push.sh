#!/bin/sh

set -xe

USER='goferex'

REPOSITORY_NAME='php-fpm'
IMAGE_BASE='debian'
GIT_TAG='20240223001'

IMAGE_TAG="${IMAGE_BASE}-${GIT_TAG}"
SHORTHAND='debian'

docker login
docker tag "${REPOSITORY_NAME}:${IMAGE_TAG}" "${USER}/${REPOSITORY_NAME}:${IMAGE_TAG}"
docker push "${USER}/${REPOSITORY_NAME}:${IMAGE_TAG}"
docker tag "${REPOSITORY_NAME}:${IMAGE_TAG}" "${USER}/${REPOSITORY_NAME}:${SHORTHAND}"
docker push "${USER}/${REPOSITORY_NAME}:${SHORTHAND}"
