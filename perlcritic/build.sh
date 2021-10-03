#!/bin/bash

cmd=podman
if which docker
then
    cmd=docker
fi

$cmd build . --tag docker.io/gugod/perlcritic:"$(date +%Y%m%d)"
