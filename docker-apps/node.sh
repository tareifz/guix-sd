#!/usr/bin/env bash

# Check if runs from terminal
if [ -t 1 ] ; then
    docker run \
      --tty \
      --interactive \
      --rm \
      --volume $PWD:/app \
      --workdir /app \
      --user=$(id -u):$(id -g) \
      node:17.1.0-alpine3.14 \
      "$@";
else
    docker run \
      --interactive \
      --rm \
      --volume $PWD:/app \
      --workdir /app \
      --user=$(id -u):$(id -g) \
      node:17.1.0-alpine3.14 \
      "$@";
fi
