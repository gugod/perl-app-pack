# perl-app-pack

This repository mantain a collection of perl standalone executables that should be installable by
doing something like (using `bin/hr` for example):

    curl https://raw.githubusercontent.com/gugod/perl-app-pack/master/bin/hr > ~/bin/hr && chmod 0755 !#:3

To install everything, just clone this repo and add `bin/` to your `$PATH`.

Each programs inside `bin/` should be factpacked and directly runnable with system perl, or with any
perl installation. As long as a program is written in pure-perl, it can be distributed this style.

The selection of programs is a bit arbitrary, feel free to send pull requests.

