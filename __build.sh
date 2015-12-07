#!/bin/bash

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

git clean -d -f
git pull

cpanm common::sense App::FatPacker Minilla || exit 1
hash -r

fatpack trace `which minil`
fatpack packlists-for `cat fatpacker.trace` >packlists
fatpack tree `cat packlists`
(echo "#!/usr/bin/env perl"; fatpack file; cat `which minil`) > minil
chmod +x minil

exit;

versions=$(perl -MApp::FatPacker -MMinilla -e 'print "minilla: " . Minilla->VERSION . " facpacker:" . App::FatPacker->VERSION . "\n"')

git add minil

git_changed=$(git status --porcelain minil | grep minil)

if [[ "$git_changed" == "" ]]; then
    echo "Nothing changed. Skip committing."
    exit 0
else
    git commit -m "rebuild with $versions"
    git push
    git clean -d -f
    git pull
fi

