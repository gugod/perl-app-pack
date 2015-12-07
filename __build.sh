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
    rm -rf $TMPDIR
    cd -
}

perlenv=perl-5.22.0@perl-app-pack

cd $(dirname $0)

eval "$(perlbrew init-in-bash)"
perlbrew use ${perlenv}

if [[ $? -eq 0 ]]; then
    echo "-- Using to $perlenv"
else
    echo "Require a perl+lib installation named exactly $perlenv"
    exit 1
fi

MODULES="App::hr App::pmuninstall App::Perldoc::Search App::PMUtils"
cpanm -L local $MODULES

PATH=`pwd`/local/bin:$PATH
PERL5LIB=`pwd`/local/lib/perl5:$PERL5LIB
hash -r

for executable in hr pm-uninstall perldoc-search pmlist
do
    __fatpack_one_executable `pwd`/local/bin/${executable} > $executable
    chmod +x $executable
    git add $executable
done

git_changed=$(git status --porcelain)

if [[ "$git_changed" == "" ]]; then
    echo "Nothing changed. Skip committing."
    exit 0
else
    git commit -m "rebuild"
    git pull --rebase && git push
fi
