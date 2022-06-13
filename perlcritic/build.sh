#!/bin/bash

docker build . --tag docker.io/gugod/perlcritic:$(date +%Y%m%d)
