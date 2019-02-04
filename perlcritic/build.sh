#!/bin/bash

docker build . --tag gugod/perlcritic:$(date +%Y%m%d)
