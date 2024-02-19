# syntax=docker/dockerfile:1

FROM debian:latest

RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get update && \
 DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y --no-install-recommends \
 apt-utils apt-transport-https bc build-essential ca-certificates cpio curl file \
 gcc-mipsel-linux-gnu git locales lzop mc rsync ssh sudo u-boot-tools unzip vim wget whiptail

RUN update-ca-certificates

RUN locale-gen --no-purge en_US.UTF-8

RUN useradd -rm -d /home/me -s /bin/bash -g root -G sudo -u 1000 me --no-log-init
RUN echo 'me:me' | chpasswd

USER me

ENV BR2_DL_DIR=/home/me/workspace/downloads
WORKDIR /home/me

