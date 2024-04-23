# syntax=docker/dockerfile:1

FROM debian:testing

# --no-install-recommends
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get update && \
    DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y \
    apt-utils apt-transport-https bc build-essential ca-certificates \
    ccache cpio curl dialog file gawk gcc-mipsel-linux-gnu git golang-go \
    libncurses-dev locales lzop mc rsync ssh sudo u-boot-tools unzip \
    vim wget whiptail

RUN update-ca-certificates

RUN locale-gen --no-purge en_US.UTF-8

RUN useradd -rm -d /home/me -s /bin/bash -g root -G sudo -u 1000 me --no-log-init
RUN echo 'me:me' | chpasswd

USER me

ENV BR2_DL_DIR=/home/me/workspace/downloads
WORKDIR /home/me

