FROM perl:5.28
RUN cpanm -q --notest --no-man-pages Perl::Critic Perl::Critic::Pulp Perl::Critic::Bangs \
    Perl::Critic::Freenode Perl::Critic::Swift Perl::Critic::Itch \
    Perl::Critic::Swift Perl::Critic::Tics  Perl::Critic::TooMuchCode \
    && rm -fr ./cpanm /root/.cpanm
CMD ["perlcritic"]
