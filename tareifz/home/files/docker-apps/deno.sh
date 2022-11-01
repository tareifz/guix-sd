#!/usr/bin/env bash

# Check if runs from terminal
if [ -t 1 ] ; then
    docker run \
      --tty \
      --interactive \
      --rm \
      --volume $PWD:/app \
      --volume $HOME/.deno:/deno-dir \
      --workdir /app \
      --user=$(id -u):$(id -g) \
      denoland/deno:alpine-1.16.2 \
      "$@";
else
    docker run \
      --interactive \
      --rm \
      --volume $PWD:/app \
      --volume $HOME/.deno:/deno-dir \
      --workdir /app \
      --user=$(id -u):$(id -g) \
      denoland/deno:alpine-1.16.2 \
      "$@";
fi
