FROM mdillon/postgis:10

RUN mkdir -p /docker-entrypoint-initdb.d
COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get -y install \
  git \
  debhelper \
  libicu-dev \
  wget \
  libkakasi2-dev \
  pandoc \
   postgresql-server-dev-10 \
  && rm -rf /var/lib/apt/lists/*

ENV CODE /code
WORKDIR $CODE

# Install dependencies
ENV LIBUTF8PROCVERSION 2.0.2-1
RUN wget -O libutf8proc-dev.deb http://ftp.ch.debian.org/debian/pool/main/u/utf8proc/libutf8proc-dev_${LIBUTF8PROCVERSION}_amd64.deb \
  && wget -O libutf8proc1.deb http://ftp.ch.debian.org/debian/pool/main/u/utf8proc/libutf8proc2_${LIBUTF8PROCVERSION}_amd64.deb \
  && dpkg --install libutf8proc1.deb libutf8proc-dev.deb \
  && rm libutf8proc1.deb libutf8proc-dev.deb

RUN git clone https://github.com/giggls/mapnik-german-l10n.git mapnik-german-l10n \
    && cd mapnik-german-l10n && git checkout v2.2.6 \
    && make && make install && make clean
