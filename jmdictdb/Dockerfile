FROM ubuntu:16.04

RUN sed -i '/deb-src/d' /etc/apt/sources.list
RUN sed -i 's/http:\/\/archive.ubuntu.com/http:\/\/nz.archive.ubuntu.com/' /etc/apt/sources.list

RUN apt-get update \
    && apt-get install -qyy -o APT::Install-Recommends=false -o APT::Install-Suggests=false \
    postgresql-client postgresql-server-dev-all \
    python3-venv python3 python3-pip \
    python3-dev build-essential libxml2-dev libxmlsec1-dev python-simpletal \
    apache2 make wget curl vim-tiny \
    locales \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set timezone
ENV TZ=Pacific/Auckland
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set locale
RUN echo 'ja_JP.UTF-8 UTF-8' > /etc/locale.gen
RUN locale-gen
ENV LANG ja_JP.UTF-8

ENV PATH /virtualenv/bin:$PATH
ENV VIRTUAL_ENV /virtualenv
RUN mkdir /virtualenv
RUN python3 -m venv /virtualenv
RUN pip3 install --upgrade pip

COPY requirements.txt .
RUN pip install -r requirements.txt

# TODO: Patch upstream? jmload.py takes -h for host not -r
RUN mkdir /JMDictDB && \
    curl -sS http://edrdg.org/~smg/cgi-bin/hgweb-jmdictdb.cgi/archive/tip.tar.gz | \
    tar zxC /JMDictDB --strip-components 1 && \
    sed --in-place 's/\[-r host\]/[-h host]/g' /JMDictDB/python/jmload.py && \
    sed --in-place 's/^JM_HOST = -r $(HOST)$/JM_HOST = -h $(HOST)/g' /JMDictDB/Makefile
