#!/bin/bash

docker build . --tag gugod/perlcritic-reviewdog:latest --tag gugod/perlcritic-reviewdog:$(date +%Y%m%d)
