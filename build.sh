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
    rm -rf $TMPDIR > /dev/null 2>&1
    cd - >/dev/null 2>&1
}

perlenv=perl-5.22.0@perl-app-pack

cd $(dirname $0)
mkdir bin
eval "$(perlbrew init-in-bash)"
perlbrew use ${perlenv}

if [[ $? -eq 0 ]]; then
    echo "-- Using to $perlenv"
else
    echo "Require a perl+lib installation named exactly $perlenv"
    exit 1
fi

MODULES="App::Wallflower Perl::Strip App::ph Minilla Dist::Zilla App::hr App::pmuninstall App::Perldoc::Search App::PMUtils App::jt App::es App::YG App::cpm App::pmdir App::tchart App::xkcdpass App::sslmaker App::rainbarf App::perlfind App::PurePorxy App::Git::Spark App::scan_prereqs_cpanfile App::Git::Ribbon Pod::Cpandoc App::watcher App::St"
cpanm -L local $MODULES

PATH=`pwd`/local/bin:$PATH
PERL5LIB=`pwd`/local/lib/perl5:$PERL5LIB
hash -r

for executable in wallflower perlstrip ph minil dzil hr pm-uninstall perldoc-search pmlist jt es yg cpm pmdir tchart xkcdpass sslmaker rainbarf perlfind pureproxy git-vspark git-spark scan-prereqs-cpanfile git-ribbon cpandoc watcher st
do
    ex=`pwd`/local/bin/${executable}
    if [[ -f $ex ]]; then
        __fatpack_one_executable $ex > bin/$executable
        chmod +x bin/$executable
        git add bin/$executable
    else
        echo "ERROR: $ex is missing"
    fi
done

git_changed=$(git status --porcelain)

if [[ "$git_changed" == "" ]]; then
    echo "Nothing changed. Skip committing."
    exit 0
else
    git commit -m "rebuild"
    git pull --rebase && git push
fi
