FROM postgres:latest

# Set timezone
ENV TZ=Pacific/Auckland
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set locale
RUN echo 'ja_JP.UTF-8 UTF-8' > /etc/locale.gen
RUN locale-gen
ENV LANG ja_JP.UTF-8

ENV POSTGRES_INITDB_ARGS="--locale=ja_JP.UTF-8"

COPY ./create-users.sh /docker-entrypoint-initdb.d/
