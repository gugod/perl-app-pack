PP=perl -Mlib=local/lib/perl5 ./local/bin/pp

.PHONY: deps clean all clean

all: build/bin/urifind build/bin/cpanm build/bin/cpandoc build/bin/jt build/bin/mbtiny build/bin/dzil build/bin/perlbrew

clean:
	rm -rf build

deps: cpanfile
	cpm install

local/bin/*: deps

build/bin/%: local/bin/%
	${PP} -o $@ $<

build/bin/dzil: local/bin/dzil
	${PP} -M Throwable -M App::Cmd:: -M Dist::Zilla:: -o $@ $<

build/bin/mbtiny: local/bin/mbtiny
	${PP} -M Module::CPANfile -M Software::License:: -o $@ $<

build/bin/jt: local/bin/jt
	${PP} -M Regexp::Common:: -o $@ -c $<

build/bin/cpandoc: local/bin/cpandoc
	${PP} -M Pod::Perldoc::Totext -M Pod::Cpandoc -o $@ $<
