FROM geometalab/postgis:9.3

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./initdb-activate_translit.sh /docker-entrypoint-initdb.d/activate_translit.sh

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install\
    git\
    build-essential\
    postgresql-server-dev-9.3\
    libicu-dev debhelper

ENV HOME /root
WORKDIR $HOME
RUN git clone https://github.com/woodpeck/openstreetmap-carto-german.git

WORKDIR $HOME/openstreetmap-carto-german/utf8translit
RUN sed --in-place 's/\$\(CXX\) $\(LIBS\) -shared -o \$@ \$</\$\(CXX\) -shared -o \$@ \$< $\(LIBS\)/' Makefile && \
    sed --in-place 's/postgresql-9\.2/postgresql-9.3/' debian/control && \
    dpkg-buildpackage -uc -us && \
    dpkg --install ../utf8translit_*.deb
