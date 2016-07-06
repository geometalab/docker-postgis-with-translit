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
    libicu-dev \
    debhelper \
    \
    libkakasi2-dev\
    postgresql-server-dev-9.4\
    libicu-dev\
    debhelper\
    git

ENV CODE /code
WORKDIR $CODE
RUN git clone https://github.com/giggls/mapnik-german-l10n.git mapnik-german-l10n

WORKDIR $CODE/mapnik-german-l10n/
RUN git checkout -b old 937424a0ac6dc5e1dc9fa5a77be492b96f45f309

WORKDIR $CODE/mapnik-german-l10n/utf8translit
RUN dpkg-buildpackage -uc -us -b

WORKDIR $CODE/mapnik-german-l10n/kanjitranslit
RUN dpkg-buildpackage -uc -us -b

WORKDIR $CODE/mapnik-german-l10n/
RUN dpkg --install *utf8translit_*.deb
RUN dpkg --install *kanjitranslit_*.deb

RUN chmod a+rx $CODE
