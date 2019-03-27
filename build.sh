#!/bin/bash
# set -x

export PUREPERL_ONLY=1
export PERL_JSON_BACKEND=JSON::backportPP
export B_HOOKS_ENDOFSCOPE_IMPLEMENTATION=PP
export PACKAGE_STASH_IMPLEMENTATION=PP
export PARAMS_VALIDATE_IMPLEMENTATION=PP
export LIST_MOREUTILS_PP=1
export MOO_XS_DISABLE=1

# perlenv=perl-5.22.0@perl-app-pack
perlenv=v18@perl-app-pack

cd $(dirname $0)
mkdir -p bin
eval "$(perlbrew init-in-bash)"
perlbrew use ${perlenv}

if [[ $? -eq 0 ]]; then
    echo "-- Using to $perlenv"
else
    echo "Require a perl+lib installation named exactly $perlenv"
    exit 1
fi

# cpanm -L local --notest --installdeps .
cpm install -w 8 --pureperl-only --with-suggests --with-recommends -L local --target-perl 5.18.2
cpanm -L local --uninstall --force List::MoreUtils::XS List::Util::XS List::SomeUtils::XS WWW::FormUrlEncoded::XS Package::Stash::XS Class::Load::XS Cpanel::JSON::XS Params::Validate::XS

PATH=$(pwd)/local/bin:$PATH
PERL5LIB=$(pwd)/local/lib/perl5:$PERL5LIB
hash -r

find local -name '*.p[lm]' | xargs -P 8 perlstrip -s

rm -rf bin/*

for ex in $(pwd)/local/bin/*
do
    executable=$(basename $ex)
    perl -I local/lib/perl5 ./local/bin/fatpack-simple --no-strip --shebang '#!/usr/bin/env perl' -q -o bin/$executable $ex
done

chmod 755 bin/*

git_changed=$(git status --porcelain)

if [[ "$git_changed" == "" ]]; then
    echo "Nothing changed. Skip committing."
    exit 0
else
    git add bin
    git commit -m "rebuild"
fi
