#!/bin/bash
set -x

function __fatpack_one_executable() {
    filename=$1
    TMPDIR=`mktemp -d /tmp/perl-app-pack.XXXXXX` || exit 1
    cd $TMPDIR
    fatpack trace $filename
    fatpack packlists-for `cat fatpacker.trace` >> packlists
    fatpack tree `cat packlists`
    (echo '#!/usr/bin/env perl'; fatpack file; cat $filename)
    # rm -rf $TMPDIR
    cd -
}

perlenv=perl-5.22.0@perl-app-pack

cd $(dirname $0)
rm -rf fatlib;

eval "$(perlbrew init-in-bash)"
perlbrew use ${perlenv}

if [[ $? -eq 0 ]]; then
    echo "-- Using to $perlenv"
else
    echo "Require a perl+lib installation named exactly $perlenv"
    exit 1
fi

MODULES="App::hr"
cpanm -L local $MODULES

PATH=`pwd`/local/bin:$PATH
PERL5LIB=`pwd`/local/lib/perl5:$PERL5LIB
hash -r

__fatpack_one_executable `pwd`/local/bin/hr > hr
chmod +x hr

git add hr

git_changed=$(git status --porcelain)

if [[ "$git_changed" == "" ]]; then
    echo "Nothing changed. Skip committing."
    exit 0
else
    git commit -m "rebuild"
    git push
    git clean -d -f
    git pull
fi

