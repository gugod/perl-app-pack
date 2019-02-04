FROM perl:5.28
RUN cpanm -q --notest --no-man-pages \
    Perl::Critic                     \
    Perl::Critic::Bangs              \
    Perl::Critic::Freenode           \
    Perl::Critic::Itch               \
    Perl::Critic::More               \
    Perl::Critic::OTRS               \
    Perl::Critic::Pulp               \
    Perl::Critic::Swift              \
    Perl::Critic::Tics               \
    Perl::Critic::TooMuchCode        \
    Perl::Critic::Moose              \
    Perl::Critic::RENEEB             \
    && rm -fr ./cpanm /root/.cpanm   \
    && mkdir /usr/src/app
WORKDIR /usr/src/app
CMD ["perlcritic"]
