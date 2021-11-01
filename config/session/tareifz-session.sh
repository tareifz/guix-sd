#!/bin/sh

if [ -z "$(pgrep -u tareifz shepherd)" ]; then
   shepherd &
fi
