#!/bin/sh

for i in 1..100
do
    ./build.sh 2>&1 | grep INC | grep -o -E ' ([^ ]+?) module' | awk '{print $1}' | sort -u | perl -nle "print qq{requires '\$_';}" >> cpanfile
done
