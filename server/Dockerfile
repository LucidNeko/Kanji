###################
### Build image ###
###################
FROM python:3.5-slim
MAINTAINER Hamish Rae-Hodgson <hamish.raeh@gmail.com>

# Install packages
RUN sed -i 's#http://deb.debian.org#http://ftp.nz.debian.org#' /etc/apt/sources.list
RUN apt-get update \
    && apt-get install -qyy -o APT::Install-Recommends=false -o APT::Install-Suggests=false \
        build-essential libpq-dev libssl-dev libffi-dev openssl ca-certificates \
        locales \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set locale
RUN echo 'en_NZ.UTF-8 UTF-8' > /etc/locale.gen
ENV LANG en_NZ.UTF-8

ENV PATH /kanji/bin:/virtualenv/bin:$PATH
ENV VIRTUAL_ENV /virtualenv
RUN mkdir /virtualenv
RUN pyvenv /virtualenv
RUN pip install --no-cache-dir --upgrade pip

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt


####################
### Deploy image ###
####################
FROM python:3.5-slim

COPY --from=0 /etc/apt/sources.list /etc/apt/sources.list
COPY --from=0 /etc/locale.gen /etc/locale.gen
RUN apt-get update \
    && apt-get install -qyy -o APT::Install-Recommends=false -o APT::Install-Suggests=false \
        libpq5 libssl1.0.0 libffi6 openssl ca-certificates \
        locales \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set timezone
ENV TZ=Pacific/Auckland
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set locale
RUN locale-gen en_NZ.UTF-8
ENV LANG en_NZ.UTF-8

ENV PATH /kanji/bin:/virtualenv/bin:$PATH
ENV VIRTUAL_ENV /virtualenv
ENV PYTHONPATH /kanji
WORKDIR /kanji

COPY --from=0 /virtualenv /virtualenv/
COPY . .

EXPOSE 80
CMD ["uwsgi", "uwsgi.ini"]
