FROM ubuntu:22.04

## Create a user
## Needto pass the new user name and its password
ARG USER
ARG PASSWORD
RUN apt-get update
RUN apt-get install -y sudo
RUN useradd -G sudo -m ${USER} && \
    echo "${USER}:${PASSWORD}" | chpasswd && \
    echo "${USER} ALL=(ALL) ALL" >> /etc/sudoers

## Install minimal tools
RUN apt-get install wget curl gcc g++ make cmake git language-pack-ja -y

## Set locale to handle Japanese
RUN locale-gen ja_JP.utf8  
ENV LANG ja_JP.utf8 
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.utf8

## Configure shell to use bash
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash
RUN chsh -s /bin/bash ${USER}

## Creata a workspace for the user
USER ${USER}
WORKDIR /home/${USER}
RUN mkdir workspace
RUN mkdir shared

## Create a location in the root for variaous configurations
RUN mkdir configs
RUN echo "alias ll='ls -l'" >> .bash_aliases
RUN echo 'export PS1="\[\e[32;1m\][\u@\h \W]\$ \[\e[0m\]"' > configs/console.config
RUN echo 'source ~/configs/console.config' >> .bashrc

## Mount point of the local disk space and shared directory.
VOLUME workspace
VOLUME shared
ENTRYPOINT [ "/bin/bash" ]
