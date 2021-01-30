FROM perl:5.32
RUN cpanm -q --notest --no-man-pages Task::PerlCriticAllPolicies \
    && rm -fr ./cpanm /root/.cpanm
CMD ["perlcritic"]
