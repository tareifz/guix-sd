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
      crystallang/crystal:1.2.2-alpine \
      crystal "$@";
else
    docker run \
      --interactive \
      --rm \
      --volume $PWD:/app \
      --workdir /app \
      --user=$(id -u):$(id -g) \
      crystallang/crystal:1.2.2-alpine \
      crystal "$@";
fi
