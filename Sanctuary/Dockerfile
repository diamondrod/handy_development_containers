FROM almalinux:9.0

## Install minimal dependencies
RUN dnf install wget gcc gcc-c++ make cmake glibc-locale-source glibc-langpack-en langpacks-en glibc-langpack-ja langpacks-ja -y

## Create a user
## Needto pass the new user name and its password
ARG USER
ARG PASSWORD
RUN useradd -m ${USER} && \
    echo "${USER}:${PASSWORD}" | chpasswd && \
    echo "${USER} ALL=(ALL) ALL" >> /etc/sudoers

## Set locale to handle Japanese
RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG="ja_JP.UTF-8" \
    LANGUAGE="ja_JP:ja" \
    LC_ALL="ja_JP.UTF-8"

## Creata a workspace for the user
USER ${USER}
WORKDIR /home/${USER}
RUN mkdir workspace
RUN mkdir shared

## Create a location in the root for variaous configurations
RUN mkdir configs
RUN echo "alias ll='ls -l'" >> .bashrc
RUN echo 'export PS1="\[\e[32;1m\][\u@\h \W]\$ \[\e[0m\]"' > configs/console.config
RUN echo 'source ~/configs/console.config' >> .bashrc

## Mount point of the local disk space and shared directory.
VOLUME workspace
VOLUME shared
ENTRYPOINT [ "/bin/bash" ]
