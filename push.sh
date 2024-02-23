#!/bin/sh

set -xe

USER='goferex'

IMAGE_BASE='debian'
GIT_TAG='20240223001'
IMAGE_TAG="${IMAGE_BASE}-${GIT_TAG}"
SHORTHAND='debian'

docker login
docker tag "php-fpm:${IMAGE_TAG}" "${USER}/php-fpm:${IMAGE_TAG}"
docker push "${USER}/php-fpm:${IMAGE_TAG}"
docker tag "php-fpm:${IMAGE_TAG}" "${USER}/php-fpm:${SHORTHAND}"
docker push "${USER}/php-fpm:${SHORTHAND}"
