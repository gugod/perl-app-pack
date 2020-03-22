PP=pp -I local/lib/perl5

.PHONY: deps clean

deps: cpanfile
	cpm install

local/bin/*: deps

%: local/bin/%
	${PP} -o $@ $<

dzil: local/bin/dzil
	${PP} -M Throwable -M App::Cmd:: -M Dist::Zilla:: -o $@ $<

clean:
	rm dzil minicpan mbtiny
