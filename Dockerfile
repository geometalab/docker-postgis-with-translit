FROM geometalab/postgis:9.4

RUN mkdir -p /docker-entrypoint-initdb.d
COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install\
    subversion\
    build-essential\
    postgresql-server-dev-9.4\
    libicu-dev debhelper

ENV CODE /code
WORKDIR $CODE
RUN svn checkout http://svn.openstreetmap.org/applications/rendering/mapnik-german/utf8translit/

WORKDIR $CODE/utf8translit
RUN dpkg-buildpackage -uc -us && \
    dpkg --install ../utf8translit_*.deb

RUN chmod a+rx $CODE
