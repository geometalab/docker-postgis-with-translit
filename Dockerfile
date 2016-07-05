FROM geometalab/postgis:9.4

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
    git

ENV CODE /code
WORKDIR $CODE

# Install dependencies
ENV LIBUTF8PROCVERSION 1.3.1-2
RUN wget -O libutf8proc-dev.deb http://ftp.ch.debian.org/debian/pool/main/u/utf8proc/libutf8proc-dev_${LIBUTF8PROCVERSION}_amd64.deb
RUN wget -O libutf8proc1.deb http://ftp.ch.debian.org/debian/pool/main/u/utf8proc/libutf8proc1_${LIBUTF8PROCVERSION}_amd64.deb
RUN dpkg --install libutf8proc1.deb libutf8proc-dev.deb
RUN rm libutf8proc1.deb libutf8proc-dev.deb

RUN apt-get clean && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y pandoc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/giggls/mapnik-german-l10n.git mapnik-german-l10n

WORKDIR $CODE/mapnik-german-l10n

RUN make && make install && make clean
