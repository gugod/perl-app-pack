#!/bin/bash

cpm install -g App::Uni Unicode::GCString

pp -M Unicode::GCString -o uni -c $(which uni)
