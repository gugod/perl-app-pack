FROM perl:5.34
RUN curl -fsSL --compressed https://git.io/cpm > /usr/local/bin/cpm && chmod +x /usr/local/bin/cpm && \
    cpm install -g \
    DateTime \
    DateTime::Format::Duration \
    Encode \
    Geo::Hash \
    JSON \
    Mojolicious  \
    Path::Tiny \
    Text::CSV \
    Time::Moment \
    Twitter::API \
    YAML \
    && rm -rf /root/.cpanm /root/.cpm*
