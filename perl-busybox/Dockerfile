FROM docker.io/library/perl:5.36
RUN curl -fsSL --compressed https://git.io/cpm > /usr/local/bin/cpm && chmod +x /usr/local/bin/cpm && \
    cpm install -g \
    DateTime \
    DateTime::Format::Duration \
    Encode \
    Geo::Hash \
    JSON \
    List::MoreUtils \
    Mojolicious  \
    Path::Tiny \
    Text::CSV \
    Time::Moment \
    Twitter::API \
    YAML \
    && rm -rf /root/.cpanm /root/.perl-cpm
