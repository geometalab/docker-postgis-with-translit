FROM mdillon/postgis:10

RUN mkdir -p /docker-entrypoint-initdb.d
COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install\
\
    make \
    cmake \
    g++ \
    git-core\
    subversion\
    build-essential\
    libxml2-dev\
    libgeos-dev \
    libgeos++-dev\
    libpq-dev\
    libboost-dev\
    libboost-system-dev\
    libboost-filesystem-dev\
    libboost-thread-dev\
    libexpat1-dev \
    zlib1g-dev \
    libbz2-dev\
    libproj-dev\
    libtool\
    automake \
    libprotobuf-c0-dev\
    protobuf-c-compiler\
    lua5.2 \
    liblua5.2-0 \
    liblua5.2-dev \
    liblua5.1-0 \
    zip \
    osmctools \
    wget \
    binutils \
    libgeoip1 \
    \
    python-pip \
    python3-pip \
    ipython \
    libicu-dev \
    ipython3 \
    debhelper \
    \
    libkakasi2-dev\
    postgresql-server-dev-9.4\
    libicu-dev\
    debhelper\
    pandoc\
    git

ENV CODE /code
WORKDIR $CODE


# Install dependencies
ENV LIBUTF8PROCVERSION 2.0.2-1
RUN wget -O libutf8proc-dev.deb http://ftp.ch.debian.org/debian/pool/main/u/utf8proc/libutf8proc-dev_${LIBUTF8PROCVERSION}_amd64.deb
RUN wget -O libutf8proc1.deb http://ftp.ch.debian.org/debian/pool/main/u/utf8proc/libutf8proc2_${LIBUTF8PROCVERSION}_amd64.deb
RUN dpkg --install libutf8proc1.deb libutf8proc-dev.deb
RUN rm libutf8proc1.deb libutf8proc-dev.deb

RUN git clone https://github.com/giggls/mapnik-german-l10n.git mapnik-german-l10n \
    && cd mapnik-german-l10n && git checkout v2.2.6 \
    && make && make install && make clean
