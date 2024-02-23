#!/bin/sh

set -xe

DOCKER_FILE='debian.dockerfile'

REPOSITORY_NAME='php-fpm'
IMAGE_BASE='debian'
GIT_TAG='20240223001'

IMAGE_TAG="${IMAGE_BASE}-${GIT_TAG}"

CPU_PERIOD=100000
CPU_QUOTA=20000

CONTAINER_NAME='artifact'
ARTIFACT_NAME='root.tar.gz'

IMAGE_NAME="${REPOSITORY_NAME}:${IMAGE_TAG}"
BUILD_IMAGE_NAME="${REPOSITORY_NAME}-builder:${IMAGE_TAG}"

docker build \
  --file "${DOCKER_FILE}" \
  --tag "${BUILD_IMAGE_NAME}" \
  --cpu-period="${CPU_PERIOD}" \
  --cpu-quota="${CPU_QUOTA}" \
  .

docker run \
  --detach \
  --name "${CONTAINER_NAME}" \
  "${BUILD_IMAGE_NAME}"

docker export \
  --output "${ARTIFACT_NAME}" \
  "${CONTAINER_NAME}"

docker stop "${CONTAINER_NAME}"

docker rm "${CONTAINER_NAME}"

docker build \
  --file 'image.dockerfile' \
  --tag "${IMAGE_NAME}" \
  --cpu-period="${CPU_PERIOD}" \
  --cpu-quota="${CPU_QUOTA}" \
  .
