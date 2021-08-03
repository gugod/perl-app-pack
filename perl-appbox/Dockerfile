FROM perl:5.34
RUN curl -fsSL --compressed https://git.io/cpm > /usr/local/bin/cpm && chmod +x /usr/local/bin/cpm
ONBUILD WORKDIR /app
ONBUILD COPY . /app
ONBUILD RUN cpm install --show-build-log-on-failure -g && \
    rm -rf /root/.perl-cpm /root/.cpanm
