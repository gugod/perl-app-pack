FROM perl:5.30
RUN cpanm -q --notest --no-man-pages  \
    Perl::Critic                      \
    Perl::Critic::Bangs               \
    Perl::Critic::Freenode            \
    Perl::Critic::Itch                \
    Perl::Critic::More                \
    Perl::Critic::OTRS                \
    Perl::Critic::Pulp                \
    Perl::Critic::Swift               \
    Perl::Critic::Tics                \
    Perl::Critic::TooMuchCode         \
    Perl::Critic::Moose               \
    Perl::Critic::RENEEB              \
    Perl::Critic::CognitiveComplexity \
    && rm -fr ./cpanm /root/.cpanm   \
    && mkdir /usr/src/app
WORKDIR /usr/src/app
CMD ["perlcritic"]
