#!/bin/bash

docker build . --tag docker.io/gugod/perlcritic-reviewdog:latest --tag docker.io/gugod/perlcritic-reviewdog:$(date +%Y%m%d)
