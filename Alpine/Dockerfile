FROM alpine:3.24

## Create a user
## Needto pass the new user name and its password

ARG UID
ARG GID
ARG USER
ARG PASSWORD
RUN apk update
RUN apk add --no-cache sudo
RUN addgroup -g ${GID} ${USER} \
    && adduser -u ${UID} -G ${USER} -D ${USER} \
    && echo "${USER}:${PASSWORD}" | chpasswd \
    && echo "${USER} ALL=(ALL) ALL" >> /etc/sudoers

## Install minimal tools
RUN apk add --no-cache wget curl gcc g++ make cmake git mbedtls-dev

## Set locale to handle Japanese
RUN apk add --no-cache tzdata musl-locales musl-locales-lang
ENV LANG=ja_JP.UTF-8
ENV LANGUAGE=ja_JP:ja
ENV LC_ALL=ja_JP.UTF-8

## Creata a workspace for the user
USER ${USER}
ENV USER=${USER}
WORKDIR /home/${USER}
RUN mkdir workspace
RUN mkdir shared

## Create a location in the root for variaous configurations
RUN mkdir config
RUN echo "alias ll='ls -l'" > .ashrc
RUN echo "alias la='ls -A'" >> .ashrc
RUN echo '#### Custom' >> .ashrc
RUN echo 'for file in $(ls -1 ~/config/*.conf)' >> .ashrc
RUN echo 'do' >> .ashrc
RUN echo 'source ${file};' >> .ashrc
RUN echo 'done' >> .ashrc
RUN echo 'export PS1="\[\e[32;1m\][\u@\h:\W]\$ \[\e[0m\]"' > config/console.conf
ENV ENV="/home/${USER}/.ashrc"

## Mount point of the local disk space and shared directory.
VOLUME workspace
VOLUME shared
ENTRYPOINT [ "/bin/sh" ]
