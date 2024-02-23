#!/bin/sh

set -xe

USER='goferex'

IMAGE_BASE='debian'
IMAGE_TAG="${IMAGE_BASE}-20402323001"
SHORTHAND='debian'

docker login
docker tag "php-fpm:${IMAGE_TAG}" "${USER}/php-fpm:${IMAGE_TAG}"
docker push "${USER}/php-fpm:${IMAGE_TAG}"
docker tag "php-fpm:${IMAGE_TAG}" "${USER}/php-fpm:${SHORTHAND}"
docker push "${USER}/php-fpm:${SHORTHAND}"
