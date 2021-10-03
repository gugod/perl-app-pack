#!/bin/bash
cmd=podman
if which docker
then
    cmd=docker
fi

$cmd build . --tag docker.io/gugod/perlcritic-reviewdog:latest --tag docker.io/gugod/perlcritic-reviewdog:"$(date +%Y%m%d)"
