FROM docker.io/library/perl:5.36
RUN curl -fsSL --compressed https://git.io/cpm > /usr/local/bin/cpm && chmod +x /usr/local/bin/cpm
RUN cpm install -g Task::PerlCriticAllPolicies \
    && rm -fr /root/.cpanm /root/.perl-cpm
CMD ["perlcritic"]
