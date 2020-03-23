PP=pp -I local/lib/perl5 -I local/lib/perl5/darwin-2level

.PHONY: deps clean

deps: cpanfile
	cpm install

local/bin/*: deps

%: local/bin/%
	${PP} -o $@ $<

dzil: local/bin/dzil
	${PP} -M Throwable -M App::Cmd:: -M Dist::Zilla:: -o $@ $<

mbtiny: local/bin/mbtiny
	${PP} -M Module::CPANfile -M Software::License:: -o $@ $<

jt: local/bin/jt
	${PP} -M Regexp::Common:: -o $@ -c $<

clean:
	rm dzil minicpan mbtiny
